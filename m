Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4F7C2BBCF
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203522313B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbgLRFwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgLRFww (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FECC0611C5
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c5so806727wrp.6
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VUY37MnFlwBe6Um2ozB7acPDc0llZSH/yK3nPGAp9yw=;
        b=jsToQkWuL8J/jA8+wCE82UiA62aFhhNcHTaE5aEgdZmOSEZQI09mkAu1l/kkYsN9pW
         OJKoh5lo6jhbaxZ+66I1KzBSjWscHLBC71dfMkXhYxSHzALB/qTfQiC4RILB3nICG8ZV
         ALHE27rByvSak1vA4sSypdzJbWEL3BNwviJKUNEIyuWulbY95ePLMSSsEk2kt85ZeHiH
         xqLirp4HVT78YBr9eIg5L37XkyE4aKvn0JcKWT6oLcrhfTeWg6eEH7gpuULoG/YUAE+L
         upfYVgOxIR4ulf0hX+OPLiQATjI/E7DnuVEoLyM5AEz+/LiMBwgfStbeipcg4XL8f6bA
         07Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VUY37MnFlwBe6Um2ozB7acPDc0llZSH/yK3nPGAp9yw=;
        b=JVeKBML0U8h0aMJkaHlyIz+5+IqYuWG3A9zNSxDoly5bFQ5MDyERwhXuoRqrG9gXXC
         PIwBm9Zon128VyGusUSo4Oamu3R2zzPbZPM8oQMNZgzRPEz0luQrJnIL7mdMrLoHOjUJ
         FVXE2W0PJtMcBG0v80IeQrT0aMvWMO+InUqt1gRMlShDTBIhlbQmYsu7Tf57Ub5mUOzz
         uQjLO8PS9558tLGybAlqhmRjHURvtNnSb5iNMGRS6WtDIzTmndzbiwd4/jjdS1268dBo
         1jK+fKIzDozMn01gsN5m0DcHXIBIKhJqpbxtDsS+JTuv7tYBUTmutkiNzpES9VzBG7mY
         Izow==
X-Gm-Message-State: AOAM533TsR3UuFryQsmuPoLUTrUlAyetqG18yqayBgNUyVc6DjXTG6Sd
        LrzGo7dCVjB7goaemQYU4ptZtX8dWrE=
X-Google-Smtp-Source: ABdhPJzq47HG17XwkflvCHjcLS7HZI+pM1x+GhxkHnbbYjYQkw/Ya/B0ZhOcHqkse8maFgKWLunB2A==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr2371841wrn.190.1608270695213;
        Thu, 17 Dec 2020 21:51:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm10337315wml.34.2020.12.17.21.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:34 -0800 (PST)
Message-Id: <4696f6c2d95e5080486cf6775ed0fccee59f150e.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:24 +0000
Subject: [PATCH 07/10] merge-ort: copy and adapt merge_submodule() from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Take merge_submodule() from merge-recursive.c and make slight
adjustments, predominantly around deferring output using path_msg()
instead of using merge-recursive's output() and show() functions.
There's also a fix for recursive cases (when call_depth > 0) and a
slight change to argument order for find_first_merges().

find_first_merges() and format_commit() are left unimplemented for
now, but will be added by subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index a59adb42aa6..2dfab1858fc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -26,6 +26,7 @@
 #include "ll-merge.h"
 #include "object-store.h"
 #include "strmap.h"
+#include "submodule.h"
 #include "tree.h"
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
@@ -323,6 +324,13 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static void format_commit(struct strbuf *sb,
+			  int indent,
+			  struct commit *commit)
+{
+	die("Not yet implemented.");
+}
+
 __attribute__((format (printf, 4, 5)))
 static void path_msg(struct merge_options *opt,
 		     const char *path,
@@ -632,6 +640,15 @@ static int collect_merge_info(struct merge_options *opt,
 
 /*** Function Grouping: functions related to threeway content merges ***/
 
+static int find_first_merges(struct repository *repo,
+			     const char *path,
+			     struct commit *a,
+			     struct commit *b,
+			     struct object_array *result)
+{
+	die("Not yet implemented.");
+}
+
 static int merge_submodule(struct merge_options *opt,
 			   const char *path,
 			   const struct object_id *o,
@@ -639,7 +656,114 @@ static int merge_submodule(struct merge_options *opt,
 			   const struct object_id *b,
 			   struct object_id *result)
 {
-	die("Not yet implemented.");
+	struct commit *commit_o, *commit_a, *commit_b;
+	int parent_count;
+	struct object_array merges;
+	struct strbuf sb = STRBUF_INIT;
+
+	int i;
+	int search = !opt->priv->call_depth;
+
+	/* store fallback answer in result in case we fail */
+	oidcpy(result, opt->priv->call_depth ? o : a);
+
+	/* we can not handle deletion conflicts */
+	if (is_null_oid(o))
+		return 0;
+	if (is_null_oid(a))
+		return 0;
+	if (is_null_oid(b))
+		return 0;
+
+	if (add_submodule_odb(path)) {
+		path_msg(opt, path, 0,
+			 _("Failed to merge submodule %s (not checked out)"),
+			 path);
+		return 0;
+	}
+
+	if (!(commit_o = lookup_commit_reference(opt->repo, o)) ||
+	    !(commit_a = lookup_commit_reference(opt->repo, a)) ||
+	    !(commit_b = lookup_commit_reference(opt->repo, b))) {
+		path_msg(opt, path, 0,
+			 _("Failed to merge submodule %s (commits not present)"),
+			 path);
+		return 0;
+	}
+
+	/* check whether both changes are forward */
+	if (!in_merge_bases(commit_o, commit_a) ||
+	    !in_merge_bases(commit_o, commit_b)) {
+		path_msg(opt, path, 0,
+			 _("Failed to merge submodule %s "
+			   "(commits don't follow merge-base)"),
+			 path);
+		return 0;
+	}
+
+	/* Case #1: a is contained in b or vice versa */
+	if (in_merge_bases(commit_a, commit_b)) {
+		oidcpy(result, b);
+		path_msg(opt, path, 1,
+			 _("Note: Fast-forwarding submodule %s to %s"),
+			 path, oid_to_hex(b));
+		return 1;
+	}
+	if (in_merge_bases(commit_b, commit_a)) {
+		oidcpy(result, a);
+		path_msg(opt, path, 1,
+			 _("Note: Fast-forwarding submodule %s to %s"),
+			 path, oid_to_hex(a));
+		return 1;
+	}
+
+	/*
+	 * Case #2: There are one or more merges that contain a and b in
+	 * the submodule. If there is only one, then present it as a
+	 * suggestion to the user, but leave it marked unmerged so the
+	 * user needs to confirm the resolution.
+	 */
+
+	/* Skip the search if makes no sense to the calling context.  */
+	if (!search)
+		return 0;
+
+	/* find commit which merges them */
+	parent_count = find_first_merges(opt->repo, path, commit_a, commit_b,
+					 &merges);
+	switch (parent_count) {
+	case 0:
+		path_msg(opt, path, 0, _("Failed to merge submodule %s"), path);
+		break;
+
+	case 1:
+		format_commit(&sb, 4,
+			      (struct commit *)merges.objects[0].item);
+		path_msg(opt, path, 0,
+			 _("Failed to merge submodule %s, but a possible merge "
+			   "resolution exists:\n%s\n"),
+			 path, sb.buf);
+		path_msg(opt, path, 1,
+			 _("If this is correct simply add it to the index "
+			   "for example\n"
+			   "by using:\n\n"
+			   "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
+			   "which will accept this suggestion.\n"),
+			 oid_to_hex(&merges.objects[0].item->oid), path);
+		strbuf_release(&sb);
+		break;
+	default:
+		for (i = 0; i < merges.nr; i++)
+			format_commit(&sb, 4,
+				      (struct commit *)merges.objects[i].item);
+		path_msg(opt, path, 0,
+			 _("Failed to merge submodule %s, but multiple "
+			   "possible merges exist:\n%s"), path, sb.buf);
+		strbuf_release(&sb);
+	}
+
+	object_array_clear(&merges);
+	return 0;
 }
 
 static int merge_3way(struct merge_options *opt,
-- 
gitgitgadget

