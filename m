Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BF51F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeAEU24 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:56 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44375 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeAEU2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:54 -0500
Received: by mail-io0-f195.google.com with SMTP id k18so6968473ioc.11
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0r/w+16m+ZZrfwWOmGe4TWy3+jnd4j6Y8YWJdiOSShA=;
        b=WkRxLb+e80sRSAeaPbjfcgJaKol49TF9ze9V1GJYERtvbIhlJsdcih+icd75AYY3nI
         ggPfZELkLP/JVFfkH1aNtjVjB4UzjdNZUi/eY+MgVweu5KryG6IaIy/zTEzjiKcnX4s4
         CvewJt57JqCsYRilpm9Xxtp+/x84Xv7/P7mpS4O8R2y/15lzoQJqe0jj4QJn1WBZ1Fsj
         vSqUur/jue5s0lGXX1WdNwht2GPtzMA2zOFEOLZgCPsoCJUEUZdKWIorYN0F6rNC24vc
         diDPuuIXLJkXgRF8xWzeuk3+bftwavGO/Xguow/AVBspj9npJWdvsGeTN8biGLDg0Vm/
         NBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0r/w+16m+ZZrfwWOmGe4TWy3+jnd4j6Y8YWJdiOSShA=;
        b=mhOkvDSNl9krRhW5DCvq8vjp5sNfKVCEdeLiA93k6tAwXjDPBSiCOgO3ieGky88pEZ
         Dnw6RVn0EEsGYRCGuyCfRkoPSTn5FnumnNQbkb1UMy2rIAtu7F0P8bShH4xkGRVuyQmX
         KqnARv0PqeVrZ9gN0jAjRpcqAGdVmKvxxi8OlCU6EpSl0y9Ry22VhE9demOK5a1IB0rZ
         7EPabHSkemYAULGxZpJiw3ny6Hg4BEFFG3T3kJ6HHxnJJtd1dDx6j0zzkaxJYUriv2b+
         byXcQXcKCrdbH7UbPai1M7+Lt0CisuK6X2Zcv1BF2LPCZ0E2ZLTbUSY0VRGevn1OdTmt
         iLAg==
X-Gm-Message-State: AKwxytcNpM6u7Md2UxgqmoDy8gF60rfNnuucBB5HSLpFnkjen2mzdvJ6
        GYshvRrxvEMurovTxWjGi1/Cz/9E
X-Google-Smtp-Source: ACJfBouRNYyF3L66HZzA1oxa2NtvFP/nVqgMaqIWdgBBMNqkrdrQg3PRXmK1iT1cxWei6qQwJySWVw==
X-Received: by 10.107.147.134 with SMTP id v128mr4396366iod.240.1515184133479;
        Fri, 05 Jan 2018 12:28:53 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:53 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 26/31] merge-recursive: avoid clobbering untracked files with directory renames
Date:   Fri,  5 Jan 2018 12:27:06 -0800
Message-Id: <20180105202711.24311-27-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 42 +++++++++++++++++++++++++++++++++++--
 t/t6043-merge-rename-directories.sh |  6 +++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cdf8588c7..e77d2b043 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1138,6 +1138,26 @@ static int conflict_rename_dir(struct merge_options *o,
 {
 	const struct diff_filespec *dest = pair->two;
 
+	if (!o->call_depth && would_lose_untracked(dest->path)) {
+		char *alt_path = unique_path(o, dest->path, rename_branch);
+
+		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
+			       "writing to %s instead."),
+		       dest->path, alt_path);
+		/*
+		 * Write the file in worktree at alt_path, but not in the
+		 * index.  Instead, write to dest->path for the index but
+		 * only at the higher appropriate stage.
+		 */
+		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
+			return -1;
+		free(alt_path);
+		return update_stages(o, dest->path, NULL,
+				     rename_branch == o->branch1 ? dest : NULL,
+				     rename_branch == o->branch1 ? NULL : dest);
+	}
+
+	/* Update dest->path both in index and in worktree */
 	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
 		return -1;
 	return 0;
@@ -1156,7 +1176,8 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(path, !o->call_depth, 0)) {
+	if (dir_in_way(path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(path))) {
 		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
@@ -1282,6 +1303,12 @@ static int handle_file(struct merge_options *o,
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
+		} else if (!o->call_depth &&
+			   would_lose_untracked(rename->path)) {
+			dst_name = unique_path(o, rename->path, cur_branch);
+			output(o, 1, _("Refusing to lose untracked file at %s; "
+				       "adding as %s instead"),
+			       rename->path, dst_name);
 		}
 	}
 	if ((ret = update_file(o, 0, &rename->oid, rename->mode, dst_name)))
@@ -1407,7 +1434,18 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		if (would_lose_untracked(path))
+			/*
+			 * Only way we get here is if both renames were from
+			 * a directory rename AND user had an untracked file
+			 * at the location where both files end up after the
+			 * two directory renames.  See testcase 10d of t6043.
+			 */
+			output(o, 1, _("Refusing to lose untracked file at "
+				       "%s, even though it's in the way."),
+			       path);
+		else
+			remove_file(o, 0, path, 0);
 		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
 		if (!ret)
 			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index aa8f79638..c1082d625 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2968,7 +2968,7 @@ test_expect_success '10b-setup: Overwrite untracked with dir rename + delete' '
 	)
 '
 
-test_expect_failure '10b-check: Overwrite untracked with dir rename + delete' '
+test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
 	(
 		cd 10b &&
 
@@ -3046,7 +3046,7 @@ test_expect_success '10c-setup: Overwrite untracked with dir rename/rename(1to2)
 	)
 '
 
-test_expect_failure '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
+test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
 	(
 		cd 10c &&
 
@@ -3121,7 +3121,7 @@ test_expect_success '10d-setup: Delete untracked with dir rename/rename(2to1)' '
 	)
 '
 
-test_expect_failure '10d-check: Delete untracked with dir rename/rename(2to1)' '
+test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 	(
 		cd 10d &&
 
-- 
2.14.2

