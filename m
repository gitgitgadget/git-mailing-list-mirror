Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01FAC433E1
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51E222B45
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKkKXSLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgHDWBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgHDWB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:01:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD8C061757
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:01:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so26300938qtq.8
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5Es3QrVp5S44OB7wFFcCjvWFqu4E1AXZNuENo39h8Y=;
        b=BKkKXSLyX/0vd8BisqUn0Nwm8WhvpEBoJ6N6EcAlVhjSBpmXWBy/UzBtiw7qtsyhx7
         hnrmrTCN8Zll03wc+WGSKkKTRvycj7/5SlCvJzdnfZNJDfSBXU/JbrchZvYtLNAwOnu9
         jy0cACgaH+PB1Hx1Dcm44aK9m1AIcXMad2Opqvvck7zHkqYCKsKpug5mlUyWi2NBOpZC
         85a8kxHLKGcrE8LobYEx6siutopWc8dKv7bQEijw6Cfy1FU0jtvKpzLhN8IyaVRCPLzX
         AF5e+dDquu0Kze6Ip8cxcF3WzLly52j0wKoVP0p10LynsaWSR6GeMokcuOITN8HaFc5e
         1GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5Es3QrVp5S44OB7wFFcCjvWFqu4E1AXZNuENo39h8Y=;
        b=cWa+3PqlGAeCvBUjH97Fqp0OoH7Dc+vxEyqmVVeP1eOzGD7GtDjxIxYQDLS/1mCB/7
         yhsVPYLrmxQ1PxnsDecLYdve0idYj7noFnDsUFT7z5lu/UrhTUyhcsAGHaNkWnBpuTmX
         vIpfCK3qgiCTGPTlGhFUyqWOYQbEUY2eZP4fXCMF7/nhicybmLMrpPro7MURdPooXSoE
         HrfEGatEM7ml1+bbbhOQfwE0z7EDRlLHwKY80pYe+gswDT8rRD1lqgo4r0ZrBvVtQwVZ
         jDQpAGtQI/tfaA9v/9XG6Dyo3sL1IOk+W5/IhrE5XqIQ3LZCVivUEKKtQL7TDnU4YlsB
         8AXg==
X-Gm-Message-State: AOAM53305Wg4QT09oq9nd8+ltVqWrKM5X3Ob7HI7GJGINncjT94U48oy
        vWycN+ZhVzSdUjUFZ9e6xwPTGvV7p9VukA==
X-Google-Smtp-Source: ABdhPJwkjo9oMuRiH7Xy9FRKRQynbc/cg/RpJIpHpuEMWc/Vlv+uuvSI9P0++9eWLXk8XoJGce3X/A==
X-Received: by 2002:ac8:6d2f:: with SMTP id r15mr170583qtu.281.1596578484534;
        Tue, 04 Aug 2020 15:01:24 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n33sm231724qtd.43.2020.08.04.15.01.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 15:01:23 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 4/5] bisect: introduce first-parent flag
Date:   Tue,  4 Aug 2020 18:01:12 -0400
Message-Id: <20200804220113.5909-5-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com>
References: <20200801175840.1877-1-alipman88@gmail.com>
 <20200804220113.5909-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upon seeing a merge commit when bisecting, this option may be used to
follow only the first parent.

In detecting regressions introduced through the merging of a branch, the
merge commit will be identified as introduction of the bug and its
ancestors will be ignored.

This option is particularly useful in avoiding false positives when a
merged branch contained broken or non-buildable commits, but the merge
itself was OK.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/git-bisect.txt | 13 ++++++++++++-
 bisect.c                     |  5 ++++-
 builtin/bisect--helper.c     |  9 ++++++++-
 t/t6030-bisect-porcelain.sh  | 18 ++++++++++++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7586c5a843..0e993e4587 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
-		  [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
+		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
  git bisect terms [--term-good | --term-bad]
@@ -365,6 +365,17 @@ does not require a checked out tree.
 +
 If the repository is bare, `--no-checkout` is assumed.
 
+--first-parent::
++
+Follow only the first parent commit upon seeing a merge commit.
++
+In detecting regressions introduced through the merging of a branch, the merge
+commit will be identified as introduction of the bug and its ancestors will be
+ignored.
++
+This option is particularly useful in avoiding false positives when a merged
+branch contained broken or non-buildable commits, but the merge itself was OK.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index 950ff6f533..bc4241b51f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -15,6 +15,7 @@
 #include "commit-slab.h"
 #include "commit-reach.h"
 #include "object-store.h"
+#include "dir.h"
 
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
@@ -460,6 +461,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct argv_array *array)
@@ -998,7 +1000,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	struct object_id *bisect_rev;
 	char *steps_msg;
 	int no_checkout = ref_exists("BISECT_HEAD");
-	int first_parent_only = 0; /* TODO: pass --first-parent flag from git bisect start */
+	int first_parent_only = file_exists(git_path_bisect_first_parent());
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -1142,6 +1144,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_names());
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
+	unlink_or_warn(git_path_bisect_first_parent());
 	/* Cleanup head-name if it got left by an old version of git-bisect */
 	unlink_or_warn(git_path_head_name());
 	/*
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 95a15b918f..a055147f19 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -16,6 +16,7 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all"),
@@ -27,7 +28,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
-					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	NULL
 };
 
@@ -423,6 +424,7 @@ static int bisect_append_log_quoted(const char **argv)
 static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int no_checkout = 0;
+	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int flags, pathspec_pos, res = 0;
 	struct string_list revs = STRING_LIST_INIT_DUP;
@@ -452,6 +454,8 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 			break;
 		} else if (!strcmp(arg, "--no-checkout")) {
 			no_checkout = 1;
+		} else if (!strcmp(arg, "--first-parent")) {
+			first_parent_only = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -576,6 +580,9 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 	 */
 	write_file(git_path_bisect_start(), "%s\n", start_head.buf);
 
+	if (first_parent_only)
+		write_file(git_path_bisect_first_parent(), "\n");
+
 	if (no_checkout) {
 		if (get_oid(start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a66c4b89bc..b886529e59 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -448,6 +448,24 @@ test_expect_success 'many merge bases creation' '
 	grep "$SIDE_HASH5" merge_bases.txt
 '
 
+# We want to automatically find the merge that
+# added "line" into hello.
+test_expect_success '"git bisect run --first-parent" simple case' '
+	git rev-list --first-parent $B_HASH ^$HASH4 >first_parent_chain.txt &&
+	write_script test_script.sh <<-\EOF &&
+	grep $(git rev-parse HEAD) first_parent_chain.txt || exit -1
+	! grep line hello >/dev/null
+	EOF
+	git bisect start --first-parent &&
+	test_path_is_file ".git/BISECT_FIRST_PARENT" &&
+	git bisect good $HASH4 &&
+	git bisect bad $B_HASH &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$B_HASH is the first bad commit" my_bisect_log.txt &&
+	git bisect reset &&
+	test_path_is_missing .git/BISECT_FIRST_PARENT
+'
+
 test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
-- 
2.24.3 (Apple Git-128)

