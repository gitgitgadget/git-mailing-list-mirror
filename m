Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C678B20248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCMMYy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMMYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id t18so1780365wrx.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enjYaU1zpsXUNt4e8onIwdPIJfgd/af7DIrD0b2/eHk=;
        b=MdsJsBbmKhY7NfZCt6K5YaGf5xvBeW4/UftEq6iBNPXq9fA6F5lnl5nB18DcTc+Tlc
         YzXTCHpxXQKdbnTFNo3aSDyrilFSUKxj1CH/OvH5wj39kyAo6R7uR/2tY3wG9JLujIpz
         9aQLF2NyUdRMkpf2L/cQWVPtTN7lgrufbMI+gYloWvaVBbX1iXazM6Be4DEPWV5WDCFT
         X4LQPA/mz9P1T0NJDFbcJkGTpPYHn69zYnDV7OkwWumYBvv+1qR14DBN0p5tpFkEa7pZ
         7wrDZi+CeQjP5sAZM4zA1IFknP29AG4XtuDB79HO3Ua3ooaVQzem6cHuGVj0tkzRBSNt
         OGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enjYaU1zpsXUNt4e8onIwdPIJfgd/af7DIrD0b2/eHk=;
        b=uMD1e3tRHBStOnlZ01Vzac3VPSBixPXr7yhFNcdPoCTjoEtgHKr9NlMc1GACqQJNGe
         dYf/t4XHFDhgwf3zpgAqiODjd7AObMi2VelCPtbmOo209DM6Gs3oYBP9lCsBG78LrZoE
         ms6dXLcPDVEsebo7LvfGbSsPvcWgi98ES/iITry3wORz3u5YwaQOU3H4LEWhHR06DtHx
         M3fEgfZmtPfQnkijYEo1LlSKfZl3nC9wVUhqbcr00q27QuB1m3HDVy4xm22eTC4+FR5a
         OZIj7zbKFNaiNQeutIyw/XCCOX8HlWsfxQlEKRdyX6njnLLHzR8phE7Jap+HLGc9EF6v
         Llow==
X-Gm-Message-State: APjAAAUkkpC2PMpKMQ7mSELeT95WrcaMrGns285CitjuBvmea+DiUjVW
        I5NI5kyg1dCNvWJkOrL+kzkT7I9M
X-Google-Smtp-Source: APXvYqxVgwS6O4PQYML3e8A6fyrb8KNywVRTFUHgR9faAAuZ8QoUiAuv4Dz1C2MOD+tI5F1WhVRlEA==
X-Received: by 2002:a5d:5410:: with SMTP id g16mr26719049wrv.214.1552479890633;
        Wed, 13 Mar 2019 05:24:50 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/11] git p4 test: clean up the p4d cleanup functions
Date:   Wed, 13 Mar 2019 13:24:16 +0100
Message-Id: <20190313122419.2210-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Confusingly, the 'git p4' tests used two cleanup functions:

  - 'kill_p4d' was run in the last test before 'test_done', and it not
    only killed 'p4d', but it killed the watchdog process, and cleaned
    up after 'p4d' as well by removing all directories used by the P4
    daemon and client.

    This cleanup is not necessary right before 'test_done', because
    the whole trash directory is about to get removed anyway, but it
    is necessary in 't9801-git-p4-branch.sh', which uses 'kill_p4d' to
    stop 'p4d' before re-starting it in the middle of the test script.

  - 'cleanup' was run in the trap on EXIT, and it killed 'p4d', but,
    it didn't kill the watchdog process, and, contrarily to its name,
    didn't perform any cleanup whatsoever.

Make it clearer what's going on by renaming and simplifying the
cleanup functions, so in the end we'll have:

  - 'stop_p4d_and_watchdog' replaces 'cleanup' as it will try to live
    up to its name and stop both the 'p4d' and the watchdog processes,
    and as the sole function registered with 'test_atexit' it will be
    responsible for no leaving any stray processes behind after 'git p4'
    tests were finished or interrupted.

  - 'stop_and_cleanup_p4d' replaces 'kill_p4d' as it will stop 'p4d'
    (and the watchdog) and remove all directories used by the P4
    daemon and cliean, so it can be used mid-script to stop and then
    re-start 'p4d'.

Note that while 'cleanup' sent a single SIGKILL to 'p4d', 'kill_p4d'
was quite brutal, as it first sent SIGTERM to the daemon repeatedly,
either until its pid disappeared or until a given timeout was up, and
then it sent SIGKILL repeatedly, for good measure.  This is overkill
(pardon the pun): a single SIGKILL should be able to take down any
process in a sensible state, and if a process were to somehow end up
stuck in the dreaded uninterruptible sleep state then even repeated
SIGKILLs won't bring immediate help.  So ditch all the repeated
SIGTERM/SIGKILL parts, and use a single SIGKILL to stop 'p4d', and
make sure that there are no races between asynchron signal delivery
and subsequent restart of 'p4d' by waiting for it to die.

With this change the 'retry_until_fail' helper has no callers left,
remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-p4.sh          | 36 ++++++++++--------------------------
 t/t9801-git-p4-branch.sh |  4 ++--
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 958e33b77e..b5cb5075c2 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -67,12 +67,8 @@ cli="$TRASH_DIRECTORY/cli"
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
-# Sometimes "prove" seems to hang on exit because p4d is still running
-cleanup () {
-	if test -f "$pidfile"
-	then
-		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
-	fi
+stop_p4d_and_watchdog () {
+	kill -9 $p4d_pid $watchdog_pid
 }
 
 # git p4 submit generates a temp file, which will
@@ -87,7 +83,7 @@ start_p4d () {
 	# Don't register and then run the same atexit handlers several times.
 	if test -z "$registered_stop_p4d_atexit_handler"
 	then
-		test_atexit 'kill_p4d; cleanup'
+		test_atexit 'stop_p4d_and_watchdog'
 		registered_stop_p4d_atexit_handler=AlreadyDone
 	fi
 
@@ -100,6 +96,7 @@ start_p4d () {
 			echo $! >"$pidfile"
 		}
 	) &&
+	p4d_pid=$(cat "$pidfile")
 
 	# This gives p4d a long time to start up, as it can be
 	# quite slow depending on the machine.  Set this environment
@@ -107,14 +104,13 @@ start_p4d () {
 	# an automated test setup.  If the p4d process dies, that
 	# will be caught with the "kill -0" check below.
 	i=${P4D_START_PATIENCE:-300}
-	pid=$(cat "$pidfile")
 
 	timeout=$(($(time_in_seconds) + $P4D_TIMEOUT))
 	while true
 	do
 		if test $(time_in_seconds) -gt $timeout
 		then
-			kill -9 $pid
+			kill -9 $p4d_pid
 			exit 1
 		fi
 		sleep 1
@@ -131,7 +127,7 @@ start_p4d () {
 			break
 		fi
 		# fail if p4d died
-		kill -0 $pid 2>/dev/null || break
+		kill -0 $p4d_pid 2>/dev/null || break
 		echo waiting for p4d to start
 		sleep 1
 		i=$(( $i - 1 ))
@@ -178,22 +174,10 @@ retry_until_success () {
 	done
 }
 
-retry_until_fail () {
-	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
-	until ! "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
-	do
-		sleep 1
-	done
-}
-
-kill_p4d () {
-	pid=$(cat "$pidfile")
-	retry_until_fail kill $pid
-	retry_until_fail kill -9 $pid
-	# complain if it would not die
-	test_must_fail kill $pid >/dev/null 2>&1 &&
-	rm -rf "$db" "$cli" "$pidfile" &&
-	retry_until_fail kill -9 $watchdog_pid
+stop_and_cleanup_p4d () {
+	kill -9 $p4d_pid $watchdog_pid
+	wait $p4d_pid
+	rm -rf "$db" "$cli" "$pidfile"
 }
 
 cleanup_git () {
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 50013132c8..38d6b9043b 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -151,7 +151,7 @@ test_expect_success 'import depot, branch detection, branchList branch definitio
 '
 
 test_expect_success 'restart p4d' '
-	kill_p4d &&
+	stop_and_cleanup_p4d &&
 	start_p4d
 '
 
@@ -505,7 +505,7 @@ test_expect_success 'use-client-spec detect-branches skips files in branches' '
 '
 
 test_expect_success 'restart p4d' '
-	kill_p4d &&
+	stop_and_cleanup_p4d &&
 	start_p4d
 '
 
-- 
2.21.0.499.g4d310c7a8e.dirty

