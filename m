Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A692BC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516C064E0A
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhA1QRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhA1QRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:17:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85CC061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:16:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c12so5981242wrc.7
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=p/5v50f2sKnYDDGir2Ambtb0CpUTEuR0IySofXCiOoA=;
        b=Aa1fb2EIpX3FNGPXtZOtesNeURfTZt0lJyPZERvZ7+Z5u4YOfhNr1TlpERAEtgLOVM
         SfyTBo/wRvIt+rg5B7EhjZV0mfqz1VPoUSDZu0DHbV4s/8lMPvkhsHPHnDmQUo2oYXPw
         zqWpj8CcijvqRp2GfEuY8HZIouUmZjUhaP0/pqw/i0+PckDBZmzrgaX9fGDptCFRkbI8
         ak5DHJ3e2uba8NtuX1PJJ+2t7q7njpv2UH+emJ3gP3Yw4DOhA+9B7+77NE/0Afp4MvTf
         s40sM1dqoV3WvXQRj9Ylfcbmi+KfN6NLOtOJqsHQoUQqflu5iSnP35hrBvUXCzF0CbOs
         ixPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=p/5v50f2sKnYDDGir2Ambtb0CpUTEuR0IySofXCiOoA=;
        b=lihTifKIGeOxTErCBge55r8wPylBkp4flFvqufgJ4v13I6svWkjivDFPlRbQmjUaaz
         dcRf52ymwLpoK2ZNI239dSf6upuTZHWw2nM+BxiM+vKN3coJiw1hQ+Zpee32ICu4R/nC
         VmTrQN2loCBUYK55KMIeSDOL2KWObTqfiqxIJsH+4eWAsax3AHTMuQY/X4Jq+t65KRy2
         WswSA9KM8dGxi3Sz97c/1WEFYZ5wjZnn06e+ld1Kz1xetHnNuIVtCJo1hw3xzbCHKB3u
         4t7kHHyoOyaWWMtCc7ygLTcfD6vs/wvJ2UUBT5RTygz0OQD/MCOtfgzpJCkwqEvqDcqX
         zlDQ==
X-Gm-Message-State: AOAM5312imWmnN2p80UBN00i+xesbt6kCd7amUgk3G0dGARFCr1oMWeC
        vUGNweISsB87Di85z0xxfKI8S+AzYbg=
X-Google-Smtp-Source: ABdhPJzloQ4lIyBzijxMvGlfxB3phbVq7jEPrZXYWPDPL/2LOBleDney2wepgZsRe1N7o1gnVSvr1Q==
X-Received: by 2002:a5d:524a:: with SMTP id k10mr17254116wrc.394.1611850604746;
        Thu, 28 Jan 2021 08:16:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v22sm6217418wml.2.2021.01.28.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:16:43 -0800 (PST)
Message-Id: <pull.818.v3.git.1611850603359.gitgitgadget@gmail.com>
In-Reply-To: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
References: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 16:16:42 +0000
Subject: [PATCH v3] rebase -i: do leave commit message intact in fixup! chains
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Vojt=C4=9Bch?= Knyttl <vojtech@knyt.tl>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
'squash' commands, 2017-01-02), this developer introduced a change of
behavior by mistake: when encountering a `fixup!` commit (or multiple
`fixup!` commits) without any `squash!` commit thrown in, the final `git
commit` was invoked with `--cleanup=strip`. Prior to that commit, the
commit command had been called without that `--cleanup` option.

Since we explicitly read the original commit message from a file in that
case, there is really no sense in forcing that clean-up.

We actually need to actively suppress that clean-up lest a configured
`commit.cleanup` may interfere with what we want to do: leave the commit
message unchanged.

Reported-by: Vojtěch Knyttl <vojtech@knyt.tl>
Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix bug in interactive rebases where fixup! cleans up the commit message
    
    Original report here:
    https://lore.kernel.org/git/CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt%2BYGw%40mail.gmail.com/t
    
    Changes since v2:
    
     * Added a safeguard so that CLEANUP_MSG and VERBATIM_MSG aren't used
       together by mistake.
     * Changes since v1:
     * The fix now works even if commit.cleanup = commit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-818%2Fdscho%2Fautosquash-without-scissors-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-818/dscho/autosquash-without-scissors-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/818

Range-diff vs v2:

 1:  c760d6cd203 ! 1:  8acb9b4562e rebase -i: do leave commit message intact in fixup! chains
     @@ sequencer.c: N_("you have staged changes in your working tree\n"
       
       static int run_command_silent_on_success(struct child_process *cmd)
       {
     +@@ sequencer.c: static int run_git_commit(const char *defmsg,
     + {
     + 	struct child_process cmd = CHILD_PROCESS_INIT;
     + 
     ++	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
     ++		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
     ++
     + 	cmd.git_cmd = 1;
     + 
     + 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
      @@ sequencer.c: static int run_git_commit(const char *defmsg,
       		strvec_pushl(&cmd.args, "-C", "HEAD", NULL);
       	if ((flags & CLEANUP_MSG))
     @@ sequencer.c: static int run_git_commit(const char *defmsg,
       	if ((flags & EDIT_MSG))
       		strvec_push(&cmd.args, "-e");
       	else if (!(flags & CLEANUP_MSG) &&
     +@@ sequencer.c: static int try_to_commit(struct repository *r,
     + 	enum commit_msg_cleanup_mode cleanup;
     + 	int res = 0;
     + 
     ++	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
     ++		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
     ++
     + 	if (parse_head(r, &current_head))
     + 		return -1;
     + 
      @@ sequencer.c: static int try_to_commit(struct repository *r,
       
       	if (flags & CLEANUP_MSG)


 sequencer.c                  | 13 ++++++++++++-
 t/t3415-rebase-autosquash.sh |  8 ++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a467700..264d494a64c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -943,6 +943,7 @@ N_("you have staged changes in your working tree\n"
 #define CLEANUP_MSG (1<<3)
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
+#define VERBATIM_MSG (1<<6)
 
 static int run_command_silent_on_success(struct child_process *cmd)
 {
@@ -979,6 +980,9 @@ static int run_git_commit(const char *defmsg,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
+	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
+		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
+
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
@@ -1012,6 +1016,8 @@ static int run_git_commit(const char *defmsg,
 		strvec_pushl(&cmd.args, "-C", "HEAD", NULL);
 	if ((flags & CLEANUP_MSG))
 		strvec_push(&cmd.args, "--cleanup=strip");
+	if ((flags & VERBATIM_MSG))
+		strvec_push(&cmd.args, "--cleanup=verbatim");
 	if ((flags & EDIT_MSG))
 		strvec_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
@@ -1380,6 +1386,9 @@ static int try_to_commit(struct repository *r,
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
+	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
+		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
+
 	if (parse_head(r, &current_head))
 		return -1;
 
@@ -1454,6 +1463,8 @@ static int try_to_commit(struct repository *r,
 
 	if (flags & CLEANUP_MSG)
 		cleanup = COMMIT_MSG_CLEANUP_ALL;
+	else if (flags & VERBATIM_MSG)
+		cleanup = COMMIT_MSG_CLEANUP_NONE;
 	else if ((opts->signoff || opts->record_origin) &&
 		 !opts->explicit_cleanup)
 		cleanup = COMMIT_MSG_CLEANUP_SPACE;
@@ -2002,7 +2013,7 @@ static int do_pick_commit(struct repository *r,
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
 		else if (file_exists(rebase_path_fixup_msg())) {
-			flags |= CLEANUP_MSG;
+			flags |= VERBATIM_MSG;
 			msg_file = rebase_path_fixup_msg();
 		} else {
 			const char *dest = git_path_squash_msg(r);
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 7bab6000dc7..88040bc4352 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -440,4 +440,12 @@ test_expect_success 'fixup a fixup' '
 	test XZWY = $(git show | tr -cd W-Z)
 '
 
+test_expect_success 'fixup does not clean up commit message' '
+	oneline="#818" &&
+	git commit --allow-empty -m "$oneline" &&
+	git commit --fixup HEAD --allow-empty &&
+	git -c commit.cleanup=strip rebase -ki --autosquash HEAD~2 &&
+	test "$oneline" = "$(git show -s --format=%s)"
+'
+
 test_done

base-commit: ba2aa15129e59f248d8cdd30404bc78b5178f61d
-- 
gitgitgadget
