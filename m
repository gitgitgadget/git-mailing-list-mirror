Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C879C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiKQRbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 12:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbiKQRbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 12:31:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53879E08
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 09:31:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j15so4446360wrq.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c6wHJjTdyBrK56g2gAk5mYVw0IeWsLIgR0Hl32tr2B4=;
        b=k78X05Kflv1yvx6rFxIdkvfyl6fxVyl0XStWOUacHvv07nExTtfSxOT4tcu/2H/VtW
         my955JOFA7eDRO97Zlq4yRAPCs/tBfgb0VOvbFxe2GxXSsUtz3f/W2BSbVWQUtQzuouk
         P0IVmqz4ixM/LExw7tYjJsYXdfGc7puKEsoIsVyOshJfVhKK686DkajZH5mUEjsIajut
         jxuBa0GA33mDGdpTsZqlp04Yex33+Y/fXMd3kzVG02TU0Gqye1rrQzmMo7eKAIpk9qpP
         0oXm+sVbcd1FRMDYLLryj/L2wOdSk902RzFJ19G55EhTxsraCtRDEyUwx0m/73OOmlYJ
         IkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6wHJjTdyBrK56g2gAk5mYVw0IeWsLIgR0Hl32tr2B4=;
        b=y0S35M72LLx/u+xgO3k5wLZF9X57DF6WgJx1w1clg/8q0NDYovJIK8UvUZy+n5ZHCx
         XqC/em21Ua2TWxW1jAqEF/5TxvQjPRrJ5xxxNqhPzCBTYo8hTmNnjuu0wUuK/s6rNHgl
         ZsajuhVzEQHfjD+Rf3TlKzkDZ3GugH6ccNQr9n2IOT3I+of8Z3R6g9FbNpR+y6vuXqsp
         7pgeNgMQLQual1M7xqHWLfVvTeQP3k0XVQwFaI00HO+5aMrLZD4xOUBk2wZZTZGQZpzh
         uAHN1RgYz6YkGjRwv4Y6DKVgW20VxUJZyuTAZf59BtjpcuoDRhunQA5x7+e8aOUxvcUd
         qx2Q==
X-Gm-Message-State: ANoB5pkxBJJxZZUiTw9nTCiz4Qc/kDoQu2UJb7QFgH3nSrDz25dAjnaq
        3AB7pVUjHn/L/hsnfiDdo1bNVc/JSmA=
X-Google-Smtp-Source: AA0mqf4jU21fmhLoEPwb5hn2zwHPc9diQsOLrDDzD+25nMY+KHgg4tTOfIie7ZXqPtCeHWXPpL68tg==
X-Received: by 2002:a5d:5968:0:b0:236:7005:7e4f with SMTP id e40-20020a5d5968000000b0023670057e4fmr2251158wri.337.1668706276398;
        Thu, 17 Nov 2022 09:31:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc7ce000000b003a6125562e1sm1778999wmk.46.2022.11.17.09.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:31:15 -0800 (PST)
Message-Id: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Nov 2022 17:31:13 +0000
Subject: [PATCH] object-file: use real paths when adding alternates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When adding an alternate ODB, we check if the alternate has the same
path as the object dir, and if so, we do nothing. However, that
comparison does not resolve symlinks. This makes it possible to add the
object dir as an alternate, which may result in bad behavior. For
example, it can trick "git repack -a -l -d" (possibly run by "git gc")
into thinking that all packs come from an alternate and delete all
objects.

	rm -rf test &&
	git clone https://github.com/git/git test &&
	(
	cd test &&
	ln -s objects .git/alt-objects &&
	# -c repack.updateserverinfo=false silences a warning about not
	# being able to update "info/refs", it isn't needed to show the
	# bad behavior
	GIT_ALTERNATE_OBJECT_DIRECTORIES=".git/alt-objects" git \
		-c repack.updateserverinfo=false repack -a -l -d  &&
	# It's broken!
	git status
	# Because there are no more objects!
	ls .git/objects/pack
	)

Fix this by resolving symlinks before comparing the alternate and object
dir.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    object-file: use real paths when adding alternates
    
    Here's a bug that got uncovered because of some oddities in how "repo"
    [1] manages its object directories. With some tracing, I'm quite certain
    that the mechanism is that the packs are treated as non-local, but I
    don't understand "git repack" extremely well, so e.g. the test I added
    seems pretty crude.
    
    [1] https://gerrit.googlesource.com/git-repo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1382%2Fchooglen%2Fobject-file%2Fcheck-alternate-real-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1382/chooglen/object-file/check-alternate-real-path-v1
Pull-Request: https://github.com/git/git/pull/1382

 object-file.c     | 17 ++++++++++++-----
 t/t7700-repack.sh | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/object-file.c b/object-file.c
index 957790098fa..f901dd272d1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -455,14 +455,16 @@ static int alt_odb_usable(struct raw_object_store *o,
 			  struct strbuf *path,
 			  const char *normalized_objdir, khiter_t *pos)
 {
+	int ret = 0;
 	int r;
+	struct strbuf real_path = STRBUF_INIT;
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path->buf);
-		return 0;
+		goto cleanup;
 	}
 
 	/*
@@ -478,11 +480,16 @@ static int alt_odb_usable(struct raw_object_store *o,
 		assert(r == 1); /* never used */
 		kh_value(o->odb_by_path, p) = o->odb;
 	}
-	if (fspatheq(path->buf, normalized_objdir))
-		return 0;
+
+	strbuf_realpath(&real_path, path->buf, 1);
+	if (fspatheq(real_path.buf, normalized_objdir))
+		goto cleanup;
 	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
 	/* r: 0 = exists, 1 = never used, 2 = deleted */
-	return r == 0 ? 0 : 1;
+	ret = r == 0 ? 0 : 1;
+ cleanup:
+	strbuf_release(&real_path);
+	return ret;
 }
 
 /*
@@ -596,7 +603,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
+	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die(_("unable to normalize object directory: %s"),
 		    objdirbuf.buf);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5be483bf887..ce1954d0977 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -90,6 +90,24 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	test_has_duplicate_object false
 '
 
+test_expect_success '--local keeps packs when alternate is objectdir ' '
+	git init alt_symlink &&
+	(
+		cd alt_symlink &&
+		git init &&
+		echo content >file4 &&
+		git add file4 &&
+		git commit -m commit_file4 &&
+		git repack -a &&
+		ls .git/objects/pack/*.pack >../expect &&
+		ln -s objects .git/alt_objects &&
+		echo "$(pwd)/.git/alt_objects" >.git/objects/info/alternates &&
+		git repack -a -d -l &&
+		ls .git/objects/pack/*.pack >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'packed obs in alt ODB are repacked even when local repo is packless' '
 	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
