Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E59C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8622C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdbNrWLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHGV6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGV6u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:58:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC4C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:58:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so2424666qtm.10
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qD/KMzXnMPYcPFAhYELz+gUWQUtCdooaXdQIHfYjOs=;
        b=rdbNrWLcUy0wfPkSdPXJjl6h1rytOZtsAEhx7Uy1YWxUvYsenPGrGdOf+wyfUrOTaS
         CD/LBbqF4Sw6kwtzTKxK0jk8H77m+pFK1DuZXwETc5ngmEfgzWQAkgDD0sOTTtmGRnum
         DIcjqOLOt14JuoJQ7UBUcQCz7iFobElN2nioM1vz+WD/rnlH7TGFw6agNU7in8t+umhU
         re4cMMMsEeJ+NcXs9ZG1AKVRfybIC7p1aGUC/E9aBh0x9wg7vDKeRvxTfqrPe8Ko8hu7
         Uenehs9xa4W47Z0KP9a6TSVPZjn5w9cwP9fYpr9sKHdr5mfZHb471FdzlrCt7FzmOgp/
         xa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qD/KMzXnMPYcPFAhYELz+gUWQUtCdooaXdQIHfYjOs=;
        b=HAlsQL/kMNRDYEmLNwEkjGyaXnewW274QpD8i8/Xtt8wWH0bdqBo+7mu/rAlvLnbw/
         kT9drafuwXOpgXL0UweK8MrMLS8drhQ8eWE6wf1arPW6/SyKAa0kc5eXCU00mSUPccUn
         kYIxJvNNXlgaPe/fwNnKfnNPHI/x/wpwoLtREK0ilufTEYrVbYuBQBkP6pTSoB97TlWI
         VRoFbq3J5M4xacyutHz/i0W4BzzkHuqd8Yq+cXEMIk8GptFLStzkyCrQwy3wFxSnGO9A
         qZl3v2x0/7NszkERF4XH/ev0BTiWTCWPLHLsbPz/RQVZWdQkL0mILY7uNmOX9ZuwmDVz
         WLwQ==
X-Gm-Message-State: AOAM5315kPske2hRlqkhHv2N0FG5UYGpNNLHm9qPM+FPsgPX6adB6JxC
        RSa6U2Dv0rRw3arGQXrE5I2aBbeB6Ak=
X-Google-Smtp-Source: ABdhPJxPWTQ/0kOlOV46eJgInBQfS1L7wIMc0zgWogBlZPaH7c1rgFI/c7R3rmFSbVOB6zOvBpZjmA==
X-Received: by 2002:aed:30c5:: with SMTP id 63mr16317185qtf.286.1596837529139;
        Fri, 07 Aug 2020 14:58:49 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id 84sm7141579qkl.11.2020.08.07.14.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 14:58:48 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v5 3/5] cmd_bisect__helper: defer parsing no-checkout flag
Date:   Fri,  7 Aug 2020 17:58:36 -0400
Message-Id: <20200807215838.19571-4-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200807215838.19571-1-alipman88@gmail.com>
References: <20200804220113.5909-1-alipman88@gmail.com>
 <20200807215838.19571-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_bisect__helper() is intended as a temporary shim layer serving as an
interface for git-bisect.sh. This function and git-bisect.sh should
eventually be replaced by a C implementation, cmd_bisect(), serving as
an entrypoint for all "git bisect ..." shell commands: cmd_bisect() will
only parse the first token following "git bisect", and dispatch the
remaining args to the appropriate function ["bisect_start()",
"bisect_next()", etc.].

Thus, cmd_bisect__helper() should not be responsible for parsing flags
like --no-checkout. Instead, let the --no-checkout flag remain in the
argv array, so it may be evaluated alongside the other options already
parsed by bisect_start().

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 bisect.c                 |  3 ++-
 bisect.h                 |  4 +---
 builtin/bisect--helper.c | 14 ++++++--------
 git-bisect.sh            |  2 +-
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index a11fdb1473..950ff6f533 100644
--- a/bisect.c
+++ b/bisect.c
@@ -989,7 +989,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -997,6 +997,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
+	int no_checkout = ref_exists("BISECT_HEAD");
 	int first_parent_only = 0; /* TODO: pass --first-parent flag from git bisect start */
 
 	read_bisect_terms(&term_bad, &term_good);
diff --git a/bisect.h b/bisect.h
index a63af0505f..7f30b94db3 100644
--- a/bisect.h
+++ b/bisect.h
@@ -58,9 +58,7 @@ enum bisect_error {
 	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
-enum bisect_error bisect_next_all(struct repository *r,
-		    const char *prefix,
-		    int no_checkout);
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
 
 int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 73f9324ad7..95a15b918f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -18,7 +18,7 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
+	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
@@ -420,9 +420,9 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
-static int bisect_start(struct bisect_terms *terms, int no_checkout,
-			const char **argv, int argc)
+static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 {
+	int no_checkout = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int flags, pathspec_pos, res = 0;
 	struct string_list revs = STRING_LIST_INIT_DUP;
@@ -631,7 +631,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_TERMS,
 		BISECT_START
 	} cmdmode = 0;
-	int no_checkout = 0, res = 0, nolog = 0;
+	int res = 0, nolog = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -653,8 +653,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
-		OPT_BOOL(0, "no-checkout", &no_checkout,
-			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -670,7 +668,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix, no_checkout);
+		res = bisect_next_all(the_repository, prefix);
 		break;
 	case WRITE_TERMS:
 		if (argc != 2)
@@ -712,7 +710,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_START:
 		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, no_checkout, argv, argc);
+		res = bisect_start(&terms, argv, argc);
 		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
diff --git a/git-bisect.sh b/git-bisect.sh
index f03fbb18f0..c7580e51a0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -153,7 +153,7 @@ bisect_next() {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(git rev-parse --verify -q BISECT_HEAD > /dev/null && echo --no-checkout)
+	git bisect--helper --next-all
 	res=$?
 
 	# Check if we should exit because bisection is finished
-- 
2.24.3 (Apple Git-128)

