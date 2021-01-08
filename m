Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA994C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D67238E8
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbhAHQ3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAHQ3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 11:29:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7043C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 08:28:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a12so9551295wrv.8
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 08:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KXFglIRWMK2Yr2XprfXJRhmOVwdiZdtWrCGz3gdCgXc=;
        b=Gb3BKYrsMLKIObDgfuVOKApnvCgxyZqnMFy9sh77MOnSzV0m4y8Yoo1zTVy7PRnqSz
         ykP/SEpfEAk9cXtd6je+r/+WmTFrbPFM8LuFATfFNelzSxAhMtmLxsvNa4t3d2KUOFtO
         Giev/+cshw6Nuu7q1M9yyo7zAwnKzkIowNYrLAw1+kDAuf52jn1ukdDInJYFY2XoXcbj
         nNITrhGgAtoCfIdW6UMi3VL8iztj4LgUerB0SQWwehPx9UxuVGiSN1nQI0LB5a/sOilB
         V69kcSXPoi9otKycED8m45XrRHoDXZNQA2cJaN0axcrBlE+6Hhd9J1E/0E0CwZFMzD9F
         C3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KXFglIRWMK2Yr2XprfXJRhmOVwdiZdtWrCGz3gdCgXc=;
        b=PjJDjZNJq+hPu0urdy8zjzHj7Jr9UC4AcG19cbpi4SB9wJDNbrVLttO9/L0kSnaaAr
         CyRcmeFc/8IqxIfs3aNNqFPrfzy42NDc0K8oTIo+NSJ3y8oNsG5lOn6L3JS2b0rxt4J7
         W0kwJZJ5tHqp3/NWtZEi2FHVtfh8SkwWTFw2JW4st1sU5hXLwVJiaRfgqxhyQVP8KwE3
         QwjOQNmBe3vYN9FcFScNF1ygmIIRYkv7G0+T/GNeVZyT5ESyn8QnXw5eKx7mQ1kWCIQy
         TlAq+VyM6vSd0eNpTeTk39J/SQEzLu5l6q0AJefSDnPraG333FmJVT7flaYzabdEx5mo
         h/Tw==
X-Gm-Message-State: AOAM531J9QRcTdMkextKtDiJFlGwi5Fxx3IT7IORAJQtFBwA5jzmqgWO
        kUcWGDCg+7sHJ26pgHz7l5nknbiQWUY=
X-Google-Smtp-Source: ABdhPJy6Kk1Ih85H5CUCufVBE5jzyGrwzLOAl2lMH9GGNJqxt1OPjud9VgQAThN6KPqaFqIsr9/K9g==
X-Received: by 2002:adf:94e1:: with SMTP id 88mr4396216wrr.341.1610123300260;
        Fri, 08 Jan 2021 08:28:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 125sm13052869wmc.27.2021.01.08.08.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 08:28:19 -0800 (PST)
Message-Id: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
In-Reply-To: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
References: <pull.818.git.1608337339246.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 16:28:18 +0000
Subject: [PATCH v2] rebase -i: do leave commit message intact in fixup! chains
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
    
    Changes since v1:
    
     * The fix now works even if commit.cleanup = commit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-818%2Fdscho%2Fautosquash-without-scissors-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-818/dscho/autosquash-without-scissors-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/818

Range-diff vs v1:

 1:  bfade3b146f ! 1:  c760d6cd203 rebase -i: do leave commit message intact in fixup! chains
     @@ Commit message
          Since we explicitly read the original commit message from a file in that
          case, there is really no sense in forcing that clean-up.
      
     +    We actually need to actively suppress that clean-up lest a configured
     +    `commit.cleanup` may interfere with what we want to do: leave the commit
     +    message unchanged.
     +
          Reported-by: Vojtěch Knyttl <vojtech@knyt.tl>
     +    Helped-by: Martin Ågren <martin.agren@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## sequencer.c ##
     +@@ sequencer.c: N_("you have staged changes in your working tree\n"
     + #define CLEANUP_MSG (1<<3)
     + #define VERIFY_MSG  (1<<4)
     + #define CREATE_ROOT_COMMIT (1<<5)
     ++#define VERBATIM_MSG (1<<6)
     + 
     + static int run_command_silent_on_success(struct child_process *cmd)
     + {
     +@@ sequencer.c: static int run_git_commit(const char *defmsg,
     + 		strvec_pushl(&cmd.args, "-C", "HEAD", NULL);
     + 	if ((flags & CLEANUP_MSG))
     + 		strvec_push(&cmd.args, "--cleanup=strip");
     ++	if ((flags & VERBATIM_MSG))
     ++		strvec_push(&cmd.args, "--cleanup=verbatim");
     + 	if ((flags & EDIT_MSG))
     + 		strvec_push(&cmd.args, "-e");
     + 	else if (!(flags & CLEANUP_MSG) &&
     +@@ sequencer.c: static int try_to_commit(struct repository *r,
     + 
     + 	if (flags & CLEANUP_MSG)
     + 		cleanup = COMMIT_MSG_CLEANUP_ALL;
     ++	else if (flags & VERBATIM_MSG)
     ++		cleanup = COMMIT_MSG_CLEANUP_NONE;
     + 	else if ((opts->signoff || opts->record_origin) &&
     + 		 !opts->explicit_cleanup)
     + 		cleanup = COMMIT_MSG_CLEANUP_SPACE;
      @@ sequencer.c: static int do_pick_commit(struct repository *r,
     - 		flags |= AMEND_MSG;
       		if (!final_fixup)
       			msg_file = rebase_path_squash_msg();
     --		else if (file_exists(rebase_path_fixup_msg())) {
     + 		else if (file_exists(rebase_path_fixup_msg())) {
      -			flags |= CLEANUP_MSG;
     -+		else if (file_exists(rebase_path_fixup_msg()))
     ++			flags |= VERBATIM_MSG;
       			msg_file = rebase_path_fixup_msg();
     --		} else {
     -+		else {
     + 		} else {
       			const char *dest = git_path_squash_msg(r);
     - 			unlink(dest);
     - 			if (copy_file(dest, rebase_path_squash_msg(), 0666))
      
       ## t/t3415-rebase-autosquash.sh ##
      @@ t/t3415-rebase-autosquash.sh: test_expect_success 'fixup a fixup' '
     @@ t/t3415-rebase-autosquash.sh: test_expect_success 'fixup a fixup' '
      +	oneline="#818" &&
      +	git commit --allow-empty -m "$oneline" &&
      +	git commit --fixup HEAD --allow-empty &&
     -+	git rebase -ki --autosquash HEAD~2 &&
     ++	git -c commit.cleanup=strip rebase -ki --autosquash HEAD~2 &&
      +	test "$oneline" = "$(git show -s --format=%s)"
      +'
      +


 sequencer.c                  | 7 ++++++-
 t/t3415-rebase-autosquash.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a467700..092e7b811f0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -943,6 +943,7 @@ N_("you have staged changes in your working tree\n"
 #define CLEANUP_MSG (1<<3)
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
+#define VERBATIM_MSG (1<<6)
 
 static int run_command_silent_on_success(struct child_process *cmd)
 {
@@ -1012,6 +1013,8 @@ static int run_git_commit(const char *defmsg,
 		strvec_pushl(&cmd.args, "-C", "HEAD", NULL);
 	if ((flags & CLEANUP_MSG))
 		strvec_push(&cmd.args, "--cleanup=strip");
+	if ((flags & VERBATIM_MSG))
+		strvec_push(&cmd.args, "--cleanup=verbatim");
 	if ((flags & EDIT_MSG))
 		strvec_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
@@ -1454,6 +1457,8 @@ static int try_to_commit(struct repository *r,
 
 	if (flags & CLEANUP_MSG)
 		cleanup = COMMIT_MSG_CLEANUP_ALL;
+	else if (flags & VERBATIM_MSG)
+		cleanup = COMMIT_MSG_CLEANUP_NONE;
 	else if ((opts->signoff || opts->record_origin) &&
 		 !opts->explicit_cleanup)
 		cleanup = COMMIT_MSG_CLEANUP_SPACE;
@@ -2002,7 +2007,7 @@ static int do_pick_commit(struct repository *r,
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
