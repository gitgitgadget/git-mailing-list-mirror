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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CABC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852EC61964
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhCaKFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhCaKFv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 06:05:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB22C06174A
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:05:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so857368wmj.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T0xjrZujx9SUCLKrBQ0Q0tNcS3+AJRic7R9alexEAb0=;
        b=DGBy6vFKeLsKjRLEE2cuJgt2NFwj1FSvQgXZQx8EqAIaSSj878eHWL5YXejQtStc1U
         WIewzdSKhpLlyOyn0tj0snxvBB1SDpiULLVrjljQGu6HRB1F/fN5H99BN7B1H4pjG0B8
         bwEz7HRKbnzskNPnbtFWId2VXBQYh6S1C8sb5gkCul9IadPm1Gue6zU4B6eHbv2srSFQ
         VRlFw4tEVINtavzvKa2AEQuYz5eoH39jRdDHYHROZFSUU63f0UMN1LWcjRztKuz1E2t2
         /3BvmJ7jk+tvOTe546ai5+ruY9aTCjn/GaB0FhzqdOa+OwnXRMsOMV3/9rakEhtb7xhl
         AH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T0xjrZujx9SUCLKrBQ0Q0tNcS3+AJRic7R9alexEAb0=;
        b=rpdkHESWAhK86jWmnDcHLwXH+2SdQsvfcSQK9Wu+1YXvi2PHDccn1JKt36ReqcbdUQ
         Zlv2A+gUCl4nXyKe5ryW5E9SWtw4/7XzMcvQ9E1sQSqjnRmjGYeul3EhRIs6HOkiguNm
         mHTOkX8aHRdbYKLjb9wv4W1UhAbN25XDjusPeym8NCqYvNFx3I2FjQ/u+dBr5ImB0yk8
         JTbuYYEK+EfqmYOCliX2+EY12d8RUcvjTlUUzkPlWvGH8x+iYOVkTnKbZiGmoCvDcgWH
         vh7qHoNRYAP3oF7imOkdeY3wSegV2QjN5JD0Nzkqw0T1Cn7Y7N4FIvessmr9PjXFTvAO
         wdDQ==
X-Gm-Message-State: AOAM531P+hE4KlAcJ+DHMvnMwoKYjwZBZQU8d8FkNAzzvuoyR9xwIS9/
        lkmC1S4+WOnvUnY6ZvTvn+1+aSORcaA=
X-Google-Smtp-Source: ABdhPJyg90SxfkRFQOXuYFx1bnvmfxF4/KLLsoG/BjFHciVSqd5gbUqpRTsWKbkRsbfQz2Pb7bSC/Q==
X-Received: by 2002:a1c:8010:: with SMTP id b16mr2491061wmd.49.1617185149893;
        Wed, 31 Mar 2021 03:05:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm3536291wrx.59.2021.03.31.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 03:05:49 -0700 (PDT)
Message-Id: <4c59cab53a0d9bb7c9cccfaf5544ae5c904bb2ba.1617185147.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
        <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Mar 2021 10:05:46 +0000
Subject: [PATCH v5 1/2] [GSOC] run-command: add shell_no_implicit_args option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use subprocess to run a shell-script, if we have any
args, git will add extra $@ to the end of the shell-script,
This can pass positional parameters correctly, But if we just
want to use some of these passed parameters, git will still
add an extra "$@", which contains all positional parameters we
passed. This does not meet our expectations.

E.g. our shell-script is:
"echo \"\$1\""
and pass $1 "abc", git will change our script to:
"echo \"\$1\" \"$@\""

The positional parameters we entered will be printed
repeatedly. So let add a new `shell_no_implicit_args`
to `struct child_process`, which can suppress the
joining of $@ if `shell_no_implicit_args` is set to 1,
this will allow us to use only few of positional args
in multi-parameter shell script, instead of using all
of them.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 run-command.c | 8 ++++----
 run-command.h | 1 +
 trailer.c     | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index be6bc128cd9d..a2cf6177f522 100644
--- a/run-command.c
+++ b/run-command.c
@@ -264,7 +264,7 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
-static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
+static const char **prepare_shell_cmd(struct strvec *out, const char **argv, int shell_no_implicit_args)
 {
 	if (!argv[0])
 		BUG("shell command is empty");
@@ -281,7 +281,7 @@ static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 		 * If we have no extra arguments, we do not even need to
 		 * bother with the "$@" magic.
 		 */
-		if (!argv[1])
+		if (!argv[1] || shell_no_implicit_args)
 			strvec_push(out, argv[0]);
 		else
 			strvec_pushf(out, "%s \"$@\"", argv[0]);
@@ -416,7 +416,7 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 	if (cmd->git_cmd) {
 		prepare_git_cmd(out, cmd->argv);
 	} else if (cmd->use_shell) {
-		prepare_shell_cmd(out, cmd->argv);
+		prepare_shell_cmd(out, cmd->argv, cmd->shell_no_implicit_args);
 	} else {
 		strvec_pushv(out, cmd->argv);
 	}
@@ -929,7 +929,7 @@ int start_command(struct child_process *cmd)
 	if (cmd->git_cmd)
 		cmd->argv = prepare_git_cmd(&nargv, cmd->argv);
 	else if (cmd->use_shell)
-		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv);
+		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv, cmd->shell_no_implicit_args);
 
 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, (char**) cmd->env,
 			cmd->dir, fhin, fhout, fherr);
diff --git a/run-command.h b/run-command.h
index d08414a92e73..9597c987c5bb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -133,6 +133,7 @@ struct child_process {
 	 * argv[1], etc, do not need to be shell-quoted.
 	 */
 	unsigned use_shell:1;
+	unsigned shell_no_implicit_args:1;
 
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
diff --git a/trailer.c b/trailer.c
index be4e9726421c..35dd0f4c8512 100644
--- a/trailer.c
+++ b/trailer.c
@@ -231,6 +231,7 @@ static char *apply_command(const char *command, const char *arg)
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
+	cp.shell_no_implicit_args = 1;
 
 	if (capture_command(&cp, &buf, 1024)) {
 		error(_("running trailer command '%s' failed"), cmd.buf);
-- 
gitgitgadget

