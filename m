Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB1620A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeLKFqM (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:46:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36564 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLKFqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:46:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so856941wmj.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=Aq4kIC8LD7MR9bU63eoEfet5Y0nF5j5t6orIb/3gQM4=;
        b=N9Jn+/XtYM/cMqN9P1Sx6pvuv72Sq7owxj9dct58mpSNrXQHSQbuVam2WK7QygPbD3
         vUDLG3H68VRpIXO0/pDLJ+SH6LCko7laSDrOzVv54gLHfrDG5LwsbasEDJDHZG1URRBk
         YOvpV5DC9ePYd4bJ8P9zpMcHkJMNKSy3EnfKE2HO3YqFHIjmQgpxZyHpwITTViJP1hIm
         Y3kMi5DniPKsgqmSJ5btzgWVyGIDPfWp3gMxXt9JEgDhbmQp0v2qQIv/N5lVB+/SmWDd
         8VkruNwghSXk/fZ0KSfmzya1WLXnLAsgWZIRDGZQ4Exa8PpzJdSborMCp0GLee1IDbS7
         /alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=Aq4kIC8LD7MR9bU63eoEfet5Y0nF5j5t6orIb/3gQM4=;
        b=U+MKKQGAywLpQEv2P8XXVkszjvn5TdlO10+sgLUzmHdDVL8kafUsxt1egOVrMNEHDF
         glhOfpdlhZHMX5NqT/FHva0WLr/4UjukLvR5wp/7sB17TH/wa2vkBLJ7aAVye7yKsfed
         i+XgMG2L/sktEasapO6gFH9dOdN/b8w3ltsbwN6he7fyQuzbeSoOD7QI7zDxUiXSIpkO
         TsFYMRKsTOW2d1w67c0LaJyZjUK0iSeixZ1DaPgCxcqjnvdeAzGQGNbBSr5bLoCpmVJJ
         A7T4wI+O3C7V7zEIfwpJOBoC3r76bOPqS6z5iGxeQD8QSU6DsVw/ODK2acLQERaqhcBP
         pyUw==
X-Gm-Message-State: AA+aEWatIGXFAz9Pou4UGdy9jscnLt95lmVvOiU4aicWlZuSbm33nRgD
        uQACGwqD+bwXAaKHSjWV5xOKPwhGeoM=
X-Google-Smtp-Source: AFSGD/UkIoiPBRcO5jb+bqsbTLv8k2h4Ie8Q5/Xl8GksMw+HiQYBirhpUCERsvoWKfb+MMfl5wRmkw==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr881853wmb.127.1544507168967;
        Mon, 10 Dec 2018 21:46:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x12sm791790wmc.37.2018.12.10.21.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 21:46:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, John Passaro <john.a.passaro@gmail.com>
Subject: [PATCH] run-command: report exec failure
Date:   Tue, 11 Dec 2018 14:46:07 +0900
Message-ID: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 321fd823 ("run-command: mark path lookup errors with ENOENT",
2018-10-24), we rewrote the logic to execute a command by looking
in the directories on $PATH; as a side effect, a request to run a
command that is not found on $PATH is noticed even before a child
process is forked to execute it.

We however stopped to report an exec failure in such a case by
mistake.  Add a logic to report the error unless silent-exec-failure
is requested, to match the original code.

Reported-by: John Passaro <john.a.passaro@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Strictly speaking, the failure that is diagnosed by the spawned
   child is reported with die() and prefixed with "failure:"; I am
   adding error_errno(), so this will be reported with "error:"
   prefix, which is a slight change in behaviour, but I am guessing
   that this should be OK.

 run-command.c          | 2 ++
 t/t0061-run-command.sh | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index d679cc267c..e2bc18a083 100644
--- a/run-command.c
+++ b/run-command.c
@@ -728,6 +728,8 @@ int start_command(struct child_process *cmd)
 	if (prepare_cmd(&argv, cmd) < 0) {
 		failed_errno = errno;
 		cmd->pid = -1;
+		if (!cmd->silent_exec_failure)
+			error_errno("cannot run %s", cmd->argv[0]);
 		goto end_of_spawn;
 	}
 
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index cf932c8514..9c83d44d9c 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -13,11 +13,13 @@ cat >hello-script <<-EOF
 EOF
 
 test_expect_success 'start_command reports ENOENT (slash)' '
-	test-tool run-command start-command-ENOENT ./does-not-exist
+	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
+	test_i18ngrep "cannot run" err
 '
 
 test_expect_success 'start_command reports ENOENT (no slash)' '
-	test-tool run-command start-command-ENOENT does-not-exist
+	test-tool run-command start-command-ENOENT does-not-exist 2>err &&
+	test_i18ngrep "cannot run" err
 '
 
 test_expect_success 'run_command can run a command' '
@@ -33,7 +35,8 @@ test_expect_success 'run_command is restricted to PATH' '
 	write_script should-not-run <<-\EOF &&
 	echo yikes
 	EOF
-	test_must_fail test-tool run-command run-command should-not-run
+	test_must_fail test-tool run-command run-command should-not-run 2>err &&
+	test_i18ngrep "cannot run" err
 '
 
 test_expect_success !MINGW 'run_command can run a script without a #! line' '
-- 
2.20.0

