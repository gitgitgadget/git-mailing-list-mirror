Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B6ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIPVAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIPVAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 17:00:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5364932EF0
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:00:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n23-20020a17090a091700b00202a51cc78bso901266pjn.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2CS3Q6mw95aAT46vryIAAf5fTU0xmLQMfMzyPeuuZvU=;
        b=LueSVL+yHpbe7tgx240KdxshlsLsM8VDCZy++F6piU88u9SS45dnsb/dJYGggPlkEO
         hhhJ+qYs7IdQiOCqFOpzwIrNy+Ez0wwz40JQAu3siRRB7hrQBVxmv8mqckNiToxCnhwj
         I8wdbG2tivw2PdIeeeGPXtQ2UQ9FKtFJ8n2+BcWANDlaYGhglQHrDvoTPV+wE0fq11ZM
         0mjRe0ws3zwIoel9GM0NQxcA14po0LCYFQoml1XgoHhu+tpuPOMfQVxu6TDqK4U3AtHJ
         e7bD+9/P+PLwXLYwFv7xs2qUPaYIC7AP5WvjBWtIeR/Z+Z0+EVFQthP+2GMyaQprh5d7
         DfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2CS3Q6mw95aAT46vryIAAf5fTU0xmLQMfMzyPeuuZvU=;
        b=OoMOMQIGFPTAxWw/u9kI17fKP9Wsy4TvbWphzlUjugT5D2RsIBz1sLdXh3PElhzsq7
         wFmjhdK4YWpqs1f+XAaF9OMaC2cwtXGOgr/L0fbbA3F7kBwV6inLJnlX7Tw0IEGplQ6a
         4WtwwM9NT4st/o+YRACZMwsZaFpgVm5aJ6rUcRMNXTL/ZWMOUROioLLTMiXqTf/yB/KP
         H83vj1tZWO1oxARrD2v9laS0wfWRgmtjYD/QBiCmzjlAb3iCRIBI4+6vzGHmtvdCrdiw
         fR6Ss3SfrU3QWVe3ZteGch8ehdVir2LciT1nyHdKbkeDnLEkkjuKNDgtggw5YUzHYdhd
         5HnA==
X-Gm-Message-State: ACrzQf1NPftcaoQKvMwfZ0n02bqLsYfIL01hFecN3pNALYRTcOgBuSFi
        Ntc7R5q11CLpM7jwdBhc5hRBjOi0CJhdPA==
X-Google-Smtp-Source: AMsMyM7RMtlraG98RhB8P5G5sw/tfMhIEB2wYM3XolgXNt1bU+EDhBWFaSvyu9A1fazRGt8wvWsKrQ==
X-Received: by 2002:a17:90b:38cc:b0:202:e0e8:e802 with SMTP id nn12-20020a17090b38cc00b00202e0e8e802mr7442358pjb.121.1663362008147;
        Fri, 16 Sep 2022 14:00:08 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e81:25b3:3dbb:95ec:385b:406f])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a3d0900b002002fb120d7sm1961568pjc.8.2022.09.16.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 14:00:07 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 2/3] cat-file: add mailmap support to -s option
Date:   Sat, 17 Sep 2022 02:29:45 +0530
Message-Id: <20220916205946.178925-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0.3.g53c2677cac
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using `git cat-file --use-mailmap` with `-s` option, like the following is
allowed:

 git cat-file --use-mailmap -s <commit/tag object sha>

The current implementation will return the same object size irrespective
of the mailmap option, which is not as useful as it could be. When we
use the mailmap mechanism to replace the idents, the size of the object
can change and `-s` option would be more useful if it shows the size of
the changed object. This patch implements that.

Mentored-by: Christian Couder's avatarChristian Couder <christian.couder@gmail.com>
Mentored-by: John Cai's avatarJohn Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  4 +++-
 builtin/cat-file.c             | 13 +++++++++++++
 t/t4203-mailmap.sh             | 10 ++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 5792f21a72..708d094db4 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -45,7 +45,9 @@ OPTIONS
 
 -s::
 	Instead of the content, show the object size identified by
-	`<object>`.
+	`<object>`. If used with `--use-mailmap` option, will show the
+	size of updated object after replacing idents using the mailmap
+	mechanism.
 
 -e::
 	Exit with zero status if `<object>` exists and is a valid
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4..9942b93867 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
+
+		if (use_mailmap) {
+			oi.typep = &type;
+			oi.contentp = (void**)&buf;
+		}
+
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
+
+		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		ret = 0;
 		goto cleanup;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index cd1cab3e54..59513e7c57 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1022,4 +1022,14 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	echo "220" >expect &&
+	git cat-file --use-mailmap -s HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.0.rc0.3.g53c2677cac

