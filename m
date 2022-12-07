Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E70C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLGOdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLGOde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:33:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABBE48418
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:33:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so1181588wmh.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OXlDlwhzxpA9jI8dIxZWVrGAGBk8dUpBMpFhcQgGYyQ=;
        b=oEXvFnEc3MvMDM7iT7tklAcpxs4UhcYPSlHtWEigoMfLShETsWEd7WHH6zXDadoJHX
         b3M6IhBuUPgfnxaERH/VAOpr+4hRpm7trIY3sIICAJQOCfM38RNlRn3h2Z6lXYxYqOaz
         dEHcDOtnX8/CuMQsfTG3mctzsAiW/pNy1c5NEoBKoB2cy4pPOu0RHSErP8ROMgRjyBAC
         nDufDnM+NTCC4iq3CvJnQxaTqz8/JyQ001BwMN+u5sxiPBLwDYE2xwAP8gYpP/QPCOFq
         +lL47/Cw9mnt/KCDxmSUXKUPW+ekkAxjXIpjbPl7HRYc1sxc+/Ilzlco8/AqHACsxmyE
         BegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXlDlwhzxpA9jI8dIxZWVrGAGBk8dUpBMpFhcQgGYyQ=;
        b=yjZYoRxwIkFqJAOs0HmuHNSKtjis4PbnN2C1cmVliCx4Yg0G3XkoyKwdmwJZZ6FmAD
         OEuDbXOTFYpahuFkQ2M91Woj4xRwCR1ufb4TVRiWoZMOG3G4IxQ2aASW0I9ed+1NG2fc
         fDOifDrVsZ81xfulVgjV3LSiM2PHl1Um3ZqnLqtaLddxNp0xGS7Y6PfMAolgeuNRtURV
         ilVYoeWgzBv3GRToFmj2KhlYyaeCEl46YWRG4/MNH5j+HD8hnULeP84gSP3+Ubes1/a+
         HV0ltS7D7POdzSXX1u1rYA/e71J/e63nveTAKiPzKUFtlVi7G2B0FuexzPlHDebXp7ri
         +MVg==
X-Gm-Message-State: ANoB5plfRzJygp/GK3iL2jAEmI1jo7hVatn0hSGhfd0a30hvZmvMDNK4
        jllW5U04VhBUjvLnpVzeESOcmitXRoI=
X-Google-Smtp-Source: AA0mqf71mIkH0m38lNWYwUHGWBZ9U1c5B8y38t8/rhG5c61RWc0TekSF4C0IQ3lgcKTjGUk70H0t3w==
X-Received: by 2002:a05:600c:3c87:b0:3d0:58bb:9fa3 with SMTP id bg7-20020a05600c3c8700b003d058bb9fa3mr33489114wmb.39.1670423611469;
        Wed, 07 Dec 2022 06:33:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b00242442c8ebdsm14748944wrw.111.2022.12.07.06.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:32:16 -0800 (PST)
Message-Id: <pull.1438.git.1670423522572.gitgitgadget@gmail.com>
From:   "David Caro via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 14:32:02 +0000
Subject: [PATCH] commit: add signoff optional dedup/no-dedup modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Caro <me@dcaro.es>, David Caro <me@dcaro.es>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Caro <me@dcaro.es>

This allows selecting if you want your Signed-off-by: trailer
deduplicated or not.

Signed-off-by: David Caro <me@dcaro.es>
---
    commit: allow passing dedup/no-dedup mode to --signoff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1438%2Fdavid-caro%2Favoid_sob_duplication-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1438/david-caro/avoid_sob_duplication-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1438

 Documentation/git-commit.txt          |  2 +-
 Documentation/signoff-option.txt      | 14 +++++-
 builtin/commit.c                      | 19 +++++---
 t/t7501-commit-basic-functionality.sh | 69 +++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 225c6c9f2e5..7edf1ec4554 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
+'git commit' [-a | --interactive | --patch] [-s[<mode>]] [-v] [-u<mode>] [--amend]
 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
diff --git a/Documentation/signoff-option.txt b/Documentation/signoff-option.txt
index 12aa2333e46..d8b06f1e791 100644
--- a/Documentation/signoff-option.txt
+++ b/Documentation/signoff-option.txt
@@ -1,7 +1,7 @@
 ifdef::git-commit[]
--s::
+-s[<mode>]::
 endif::git-commit[]
---signoff::
+--signoff[=<mode>]::
 --no-signoff::
 	Add a `Signed-off-by` trailer by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project
@@ -16,3 +16,13 @@ endif::git-commit[]
 +
 The --no-signoff option can be used to countermand an earlier --signoff
 option on the command line.
++
+The mode parameter is optional (defaults to no-dedup), and is used to specify
+if it should deduplicate the `Signed-off-by` trailer or not when trying to
+add it to the trailers.
++
+The possible options are:
++
+	- 'no-dedup' - Will add the trailer unless it's already the last line.
+	- 'dedup' - Will not add the trailer if it's already anywhere in the
+	  trailers.
diff --git a/builtin/commit.c b/builtin/commit.c
index 06b1330346f..cd769af5bf0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,7 @@
 #include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	N_("git commit [-a | --interactive | --patch] [-s[<mode>]] [-v] [-u<mode>] [--amend]\n"
 	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
@@ -116,13 +116,13 @@ static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *fixup_commit, *squash_message;
 static const char *fixup_prefix;
-static int all, also, interactive, patch_interactive, only, amend, signoff;
+static int all, also, interactive, patch_interactive, only, amend;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
-static char *sign_commit, *pathspec_from_file;
+static char *sign_commit, *pathspec_from_file, *signoff_arg;
 static struct strvec trailer_args = STRVEC_INIT;
 
 /*
@@ -888,8 +888,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (clean_message_contents)
 		strbuf_stripspace(&sb, 0);
 
-	if (signoff)
-		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
+	if (signoff_arg) {
+		if (!strcmp(signoff_arg, "dedup"))
+			append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 1);
+		else if (!strcmp(signoff_arg, "no-dedup"))
+			append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
+		else
+			die(_("Invalid signoff mode: %s"), signoff_arg);
+	}
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
@@ -1645,7 +1651,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
-		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
+		{ OPTION_STRING, 's', "signoff", &signoff_arg, N_("mode"),
+		  N_("add a Signed-off-by trailer, optional modes: no-dedup, dedup. (Default: no-dedup)"), PARSE_OPT_OPTARG, NULL, (intptr_t) "no-dedup" },
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index fb5417d5e7e..64e710879ab 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -541,6 +541,75 @@ test_expect_success 'signoff not confused by ---' '
 	test_cmp expected actual
 '
 
+test_expect_success 'signoff default mode adds when not last in trailers' '
+	cat >message <<-EOF &&
+		subject
+
+		body
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+		Signed-off-by: A. U. <author@example.com>
+	EOF
+	cat >expected <<-EOF &&
+		subject
+
+		body
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+		Signed-off-by: A. U. <author@example.com>
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git commit --allow-empty --signoff -F message &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'signoff no-dedup mode adds when not last in trailers' '
+	cat >message <<-EOF &&
+		subject
+
+		body
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+		Signed-off-by: A. U. <author@example.com>
+	EOF
+	cat >expected <<-EOF &&
+		subject
+
+		body
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+		Signed-off-by: A. U. <author@example.com>
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git commit --allow-empty --signoff=no-dedup -F message &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'signoff dedup mode does not duplicate when not last in trailers' '
+	cat >message <<-EOF &&
+		subject
+
+		body
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+		Signed-off-by: A. U. <author@example.com>
+	EOF
+	cat >expected <<-EOF &&
+		subject
+
+		body
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+		Signed-off-by: A. U. <author@example.com>
+	EOF
+	git commit --allow-empty --signoff=dedup -F message &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
