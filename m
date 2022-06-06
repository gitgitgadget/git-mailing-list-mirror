Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE542C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 23:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiFFXzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiFFXzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 19:55:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F062FD
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 16:55:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b9-20020a656689000000b003f672946300so7630269pgw.16
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rOnI6UMJ9Bfvu2ciXRNHB2m+D82MwziGxjBUbzAA690=;
        b=J6SYAS/6m+qPtbq3FPn/jJUpjENW4Mpo3S2itfqHSARt4pCiJa4z69UD7yCzf9eKjW
         H4RLcUQMFeE696YxMqt4061zkcH4xk7wFy7E3YucclNr2b+zvD6xZChwIOK7L/MQ0vq4
         QpyiEzvhcJNLSeZ3vrOHFdITAMncSuDZkE9UaAL0IO9LaGm1U5HqUYRa5KOgoZvJhLqF
         Osk9+NNk4FeRC480qBvfmx7EOBqviurHKXPVrSPGz3RJdfn4LcgZix7ylEIYRtJzZyYj
         rNygZIN9gtQodzYtBDiawFLd7rD7Q1GdJjh3zlDB2/yLL6pj4o+Axmd/PYmksuuzsOpd
         cTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rOnI6UMJ9Bfvu2ciXRNHB2m+D82MwziGxjBUbzAA690=;
        b=IK60CIuEByWHVK3SAYUJdR2wCBkKyEaZYWh99UIds/t5K/DCow5tersoLkKSDYRmni
         qygzgz2lx9aFONj7ptjjB+FSiIXfX3qpFzyoekzVanYYHfPIl+MCsluH9LNnLDPnvpIk
         feZ4dwyH3cY5psoPl5kdh/bY+CR7YvqS4D3XZkFP/GzRDLJ9Iv+I475iPsztYTTpR3+C
         ZFNnkm/acmkfN1OuPir4kPdoe0BZAtJxk2uYDQzEzuOesizdCH1hww7Vqhd5ZdEeDzIn
         jW45Z8AqXO83WTVO5kRoHaLzOCqI0QJKVPtSq8Fnqxpi/TzIRFuo7TKHbJJvdfRyKnHk
         lWDw==
X-Gm-Message-State: AOAM531JX89M0k+HKU3QUGuCSdf+aAW9txV7NnYz3OdYNT9BvuJbeEia
        lJNZsCjf+VWjhUS/E5m5XcJ7AZHX9lVWQnZ5iHSlg1lw1G/ZjSVHeuV+2ffFZlAFyTuYwUc0Wjr
        VGFhQrtG2KCRCUB1htPcOQ44cUmlYRH4WZHa1r5wmiwZBhYUlrNvCuH2xygUeAtRshw==
X-Google-Smtp-Source: ABdhPJy22f/0qpqcoNqzLtpyg+uD2tzZFOkVeW1Z4ZEMUeWNnkZVbw54gv7Wh9luRxDIw/nR/N8Y16Hy55bYlqM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:3907:b0:1e8:57f9:dadb with SMTP
 id ob7-20020a17090b390700b001e857f9dadbmr15550892pjb.137.1654559720318; Mon,
 06 Jun 2022 16:55:20 -0700 (PDT)
Date:   Mon,  6 Jun 2022 23:54:49 +0000
Message-Id: <20220606235449.2890858-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     chooglen@google.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to do a non-fast-forward merge in a project with
conflicts in the submodules, the merge fails and git prints the
following error:

Failed to merge submodule <submodules>
CONFLICT (submodule):Merge conflict in <submodule>
Automatic merge failed; fix conflicts and then commit the result.

Git is left in a conflicted state, which requires the user to:
 1. abort the merge
 2. merge submodules
 3. merge superproject
These steps are non-obvious for newer submodule users to figure out
based on the error message and neither `git submodule status` nor `git
status` provide any useful pointers. 

Update error message to the following when attempting to do a
non-fast-forward merge in a project with conflicts in the submodules.
The error message is based off of what would happen when `merge
--recurse-submodules` is eventually supported

Failed to merge submodule <submodule>
CONFLICT (submodule): Merge conflict in <submodule>
Automatic merge failed; recursive merging with submodules is currently
not supported. To manually merge, the following steps are recommended:
 - abort the current merge
 - merge submodules individually
 - merge superproject

I considered automatically aborting the merge if git detects the merge
failed because of a submodule conflict, however, doing so causes a
significant amount of tests in `t7610-mergetool.sh` (and some other test
scripts as well) to fail, suggesting users have come to expect this
state and have their workarounds with `git mergetool`

Signed-off-by: Calvin Wan <calvinwan@google.com>

---
 builtin/merge.c            | 12 +++++++++++-
 merge-ort.c                |  4 +++-
 merge-recursive.c          |  4 +++-
 merge-recursive.h          |  1 +
 t/t6437-submodule-merge.sh |  5 ++++-
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee..39f5ee66d6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -88,6 +88,7 @@ static const char *sign_commit;
 static int autostash;
 static int no_verify;
 static char *into_name;
+static int submodule_conflict = 0;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  NO_TRIVIAL },
@@ -757,6 +758,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		else
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
+		if (o.submodule_conflict)
+			submodule_conflict = 1;
 		if (clean < 0)
 			exit(128);
 		if (write_locked_index(&the_index, &lock,
@@ -973,7 +976,14 @@ static int suggest_conflicts(void)
 	strbuf_release(&msgbuf);
 	fclose(fp);
 	repo_rerere(the_repository, allow_rerere_auto);
-	printf(_("Automatic merge failed; "
+	if (submodule_conflict)
+		printf(_("Automatic merge failed; recursive merging with submodules is currently\n"
+			"not supported. To manually merge, the following steps are recommended:\n"
+			" - abort the current merge\n"
+			" - merge submodules individually\n"
+			" - merge superproject\n"));
+	else
+		printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
 }
diff --git a/merge-ort.c b/merge-ort.c
index 0d3f42592f..205d6658bc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3866,8 +3866,10 @@ static void process_entry(struct merge_options *opt,
 			const char *reason = _("content");
 			if (ci->filemask == 6)
 				reason = _("add/add");
-			if (S_ISGITLINK(merged_file.mode))
+			if (S_ISGITLINK(merged_file.mode)) {
 				reason = _("submodule");
+				opt->submodule_conflict = 1;
+			}
 			path_msg(opt, path, 0,
 				 _("CONFLICT (%s): Merge conflict in %s"),
 				 reason, path);
diff --git a/merge-recursive.c b/merge-recursive.c
index fd1bbde061..535b8cc758 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3149,8 +3149,10 @@ static int handle_content_merge(struct merge_file_info *mfi,
 	}
 
 	if (!mfi->clean) {
-		if (S_ISGITLINK(mfi->blob.mode))
+		if (S_ISGITLINK(mfi->blob.mode)) {
 			reason = _("submodule");
+			opt->submodule_conflict = 1;
+		}
 		output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (ci && !df_conflict_remains)
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c2..6fd31644ad 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -51,6 +51,7 @@ struct merge_options {
 
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
+	unsigned submodule_conflict : 1;
 };
 
 void init_merge_options(struct merge_options *opt, struct repository *repo);
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 178413c22f..bfcc81cd06 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -141,6 +141,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
 		test_must_fail git merge c 2> actual
 	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
+	 test_i18ngrep "recursive merging with submodules is currently" actual &&
 	 git reset --hard)
 '
 
@@ -167,6 +168,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
+	test_i18ngrep "recursive merging with submodules is currently" actual &&
 	git reset --hard)
 '
 
@@ -205,7 +207,8 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f)
+	test_must_fail git merge f >actual &&
+	test_i18ngrep "recursive merging with submodules is currently" actual)
 '
 
 

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
2.36.1.255.ge46751e96f-goog

