Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE5820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeLLSg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 13:36:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbeLLSg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 13:36:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id b14so18710034wru.12
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D7M2GXOXuZwUH8KFasJEOwmz2bzPE+7aCzwr2UFKI1Q=;
        b=Pc/LporCyjyAlrT7YqcrFExIArxsxKZRTdDU6FupYHqxCY4v3hFnKnJpnF4RHhxw93
         BX6wzXpbMJzuqaSsIg9Niwh6RHvz7IXaxIYXuDdrloJYB8H+0ure+mhIM7rOulpy9eU9
         p/kNiNxb+FCqGpCHYrKQYB8FPQboKlyPaTjMk3jbJBoJrWedPtvmHLTWVlCmGQjKc8rz
         +96zKrbLxL1ov7fy07196hRM/3Tc//r+EVVcYS3kNEJPKgQg2Pb9JsFyIVOiMv67fKeb
         8/VMonYrClSnWCiGndc7KnahvxrUz0Pv+nRFFgdsDIw7GFRbJDJ3uj/aZ529VUvEeSmh
         4mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D7M2GXOXuZwUH8KFasJEOwmz2bzPE+7aCzwr2UFKI1Q=;
        b=ANZt50aw4RkhBnCQDRfG7030vnSb6Hc8qWX4ber46ZrKXdAey3vrZZL0KmBQvuht76
         kzWb6YlrO5o5+JPtXAf4fkNYiRCEt1r4UzkySNu8B7HpHLGc9Lz5Ey3jeL0AtpEMJ0IY
         XHfUPZxZJsL9WPs/5UbGLEJT0PRpKJ8pUsN8ixlwsAWUddp7EnzI/6kkDUgjMPyRjB5p
         piHh19vKkb1zf65BEvUjzMOe9p+7wY5oMB/54aL5lSH1u6IPqhOEwyWRhy2Q+Xlb/vT6
         a+bJxxjTMxFO8xJ7fR9wbti3FxEKnxKnMHEFfCFq/oCLFdSN1yxFM5gOMofkr6iGRpqc
         fa7Q==
X-Gm-Message-State: AA+aEWZe9EvbTnJte5XwOrjvKTgBtnpyko/tThQwh4CzeH6Fw+vIUC1r
        P/dGbVgwy57Gl68aaUD0mwWX2CkJ7MM=
X-Google-Smtp-Source: AFSGD/XwLR4QO6eaPLddLqwyExorfBifq1rSu5QSncuIhLbMSzBpK6OG3tl1N84KZjBQ5Gsju0fz5w==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr10647239wrw.311.1544639814224;
        Wed, 12 Dec 2018 10:36:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 14sm5824746wmv.36.2018.12.12.10.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:36:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] run-command: report exec failure
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
        <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Dec 2018 03:36:53 +0900
In-Reply-To: <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Dec 2018 21:50:50 +0900")
Message-ID: <xmqqbm5qioca.fsf_-_@gitster-ct.c.googlers.com>
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

 * This time, tests look for the command name in the message, to
   avoid getting affected by the differences the error is reported
   by two codepaths (Windows codepath uses "spawn" while others say
   "run"), which was pointed out by Dscho.

   I am taking that https://travis-ci.org/git/git/jobs/466908193
   that succeeded on Windows as a sign that this is now OK there.

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
index b9cfc03a53..8a484878ec 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -14,11 +14,13 @@ EOF
 >empty
 
 test_expect_success 'start_command reports ENOENT (slash)' '
-	test-tool run-command start-command-ENOENT ./does-not-exist
+	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
+	test_i18ngrep "\./does-not-exist" err
 '
 
 test_expect_success 'start_command reports ENOENT (no slash)' '
-	test-tool run-command start-command-ENOENT does-not-exist
+	test-tool run-command start-command-ENOENT does-not-exist 2>err &&
+	test_i18ngrep "does-not-exist" err
 '
 
 test_expect_success 'run_command can run a command' '
@@ -34,7 +36,8 @@ test_expect_success 'run_command is restricted to PATH' '
 	write_script should-not-run <<-\EOF &&
 	echo yikes
 	EOF
-	test_must_fail test-tool run-command run-command should-not-run
+	test_must_fail test-tool run-command run-command should-not-run 2>err &&
+	test_i18ngrep "should-not-run" err
 '
 
 test_expect_success !MINGW 'run_command can run a script without a #! line' '
-- 
2.20.0

