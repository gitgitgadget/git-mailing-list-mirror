Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41679C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085F964EAA
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBBCBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBBCBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:01:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E0C061786
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:00:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f16so959766wmq.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ec3f6zIT7nOWbhavyCPsZ3Nxte53qd0Za4tnsOwsilE=;
        b=H/5vILjlDysClDB3ccWKcdNZJrWNfiRk4lFr/Mb/sVTW2MJE/jDNJwk22c27711Ylc
         8G/XlHlMzvMMsB0m7q9Yvam0wGY8XvcQUQU0AXv0SmKbULZzue2Umz3wKbhLJi9N2267
         7y/gbAGrBV/QojSa26r3mU5yQgAsltAPiFFv7ojknw8dYl2nmNDTlCky4+PfcsFidjTv
         xjBdTgBFkPMQjaCmJ3fv1NfScLtipJ3zbX1UskbFXCopJv9n3FcK54Yucg9wF03FMYM/
         vUn3FUsuRmBkw/Kv7cwviW4mohqsTfpb0p3OU0gwPAa2E/jV5ojVEiD5U2ZBgNlxi/tH
         DGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ec3f6zIT7nOWbhavyCPsZ3Nxte53qd0Za4tnsOwsilE=;
        b=cpzV562hUfIHO+TOQQe+IYuchAX6dn6REKGEaBecA7LYFm+6wFkp1TWhwuiCYRem93
         2LfT2mbs36RyWmPOaAqMak05OIyaQwZOlm6k7Jutt9/OdTOqNgdRtRyaSrA2bwPsGFEp
         JDJ6gnVf9C19a0bPuFjVZdOiZ5FJwPrOvfvabjOElfnhpM8TfLh+08odbT2dOgQIEwqj
         eU/GMCQRykkoBQjAR7df5MBW4IgAeqPxXjYZLAvYn007j8mrQabsyBkllrBX0pk6Rhn7
         9QbOwRtpvXTTfDDDvvXqa5HJ8CI2OJwT2t+NLAjr8eE+OpDbW9ztslzZxNgLoUCFuH2E
         5H9Q==
X-Gm-Message-State: AOAM533T0pyzNK7n19li3ofXxXkYnUafBgNY/nh6PI5Jdz9ZBxFw/CBr
        KzOtKw60yxn1OTGaQsyjQ/+4fKJt30CG/g==
X-Google-Smtp-Source: ABdhPJzMDL2V1F92fa7RpBWlgtc5m3Vz2kcliNimJmXox0cToKy8HYjpES3JK210g9Mtabgq8wIa3A==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr1323701wma.141.1612231212620;
        Mon, 01 Feb 2021 18:00:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y24sm986175wmi.47.2021.02.01.18.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:00:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP/PATCH v2 5/5] WIP pager: respect exit code of pager over SIGPIPE
Date:   Tue,  2 Feb 2021 03:00:01 +0100
Message-Id: <20210202020001.31601-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201144921.8664-1-avarab@gmail.com>
References: <20210201144921.8664-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed on-list starting with [1] I don't think this patch makes
sense, but this "passes tests", at least on Debian with glibc, and is
food for thought for those who like the approach of git not
propagating the pager-induced SIGPIPE in git's own exit code.

The exit() here in wait_for_pager_atexit() isn't portable though[2],
we could probably use _exit(1) instead, but then we're going to
abruptly put a stop to further atexit handler processing. We're far
from the only one, tempfile.c, run-command.c, gc.c etc. all rely on
it, and that's just the git.git code.

If we drop the "if (code)" condition we can see that our pager exit
code will override the exit code of other commands in t7006-pager.sh,
causing numerous tests to fail. Of course if we don't do that all
tests pass.

But that experiment suggests regressions introduced here that we just
don't have good test coverage for. I.e. we're running code before the
atexit() here which expects to exit() with a given status code, and
we're clobbering it with ours because the pager also happened to fail
as we were exiting.

So a real implementation of this would, I think, have to at least:

 A. Refactor all use of atexit() to use some git-specific registry,
    hard assert somehow that we're never going to have atexit() by
    anything else (a library we use might call it).

 B. Because we used some atexit() wrapper API we'd know if we were in
    the last atexit() handler, which would need to re-evaluate the
    decision about the "real" exit code.

 C. We could not call exit() anywhere, but would have to make a
    git_exit() wrapper. We'd then assign the desired exit code to a
    global variable, and then only override our "real" non-zero exit
    code with the pager's non-zero, in cases where the pager also
    failed.

 D. I haven't found whether calling _exit() in the atexit() handler
    even has defined behavior, but in any case using it would
    short-circuit the documented program exit behavior defined in the
    C standard, of which calling atexit() handlers is just the first
    step.

1. https://lore.kernel.org/git/8735yhq3lc.fsf@evledraar.gmail.com/
2. https://pubs.opengroup.org/onlinepubs/009695399/functions/exit.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pager.c          | 10 ++++++++--
 t/t7006-pager.sh |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 3d37dd7adaa..2e743bc0b1e 100644
--- a/pager.c
+++ b/pager.c
@@ -20,18 +20,24 @@ static void close_pager_fds(void)
 
 static void wait_for_pager_atexit(void)
 {
+	int code;
 	fflush(stdout);
 	fflush(stderr);
 	close_pager_fds();
-	finish_command(&pager_process);
+	code = finish_command(&pager_process);
+	if (code)
+		exit(code);
 }
 
 static void wait_for_pager_signal(int signo)
 {
+	int code;
 	close_pager_fds();
-	finish_command_in_signal(&pager_process);
+	code = finish_command_in_signal(&pager_process);
 	sigchain_pop(signo);
 	raise(signo);
+	if (signo == SIGPIPE)
+		exit(code);
 }
 
 static int core_pager_config(const char *var, const char *value, void *data)
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435e..69997fa48f2 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -703,7 +703,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
+test_expect_success TTY 'git respects pager non-zero exit without SIGPIPE' '
 	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager "wc >pager-used; exit 1" &&
 	GIT_TRACE2="$(pwd)/trace.normal" &&
@@ -713,7 +713,7 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	if test_have_prereq !MINGW
 	then
 		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-		test "$OUT" -eq 0
+		test "$OUT" -eq 1
 	else
 		test_terminal git log
 	fi &&
@@ -724,7 +724,7 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
+test_expect_success TTY 'git respects nonexisting pager without SIGPIPE' '
 	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager "wc >pager-used; does-not-exist" &&
 	GIT_TRACE2="$(pwd)/trace.normal" &&
@@ -734,7 +734,7 @@ test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
 	if test_have_prereq !MINGW
 	then
 		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-		test "$OUT" -eq 0
+		test "$OUT" -eq 127
 	else
 		test_terminal git log
 	fi &&
-- 
2.30.0.284.gd98b1dd5eaa7

