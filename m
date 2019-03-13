Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A0920248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCMMYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39730 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMMYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id p8so1767701wrq.6
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUjWSk4Jd1J4luLr16M//tgKX9cw+tUuZTIZ90t/hlQ=;
        b=JIf8lbxUB0cIdr5RcOE9ICa+Dv2ntFkK/w1UNM+ej8pBk4v4M7GuIhOTOI0f0c3T9a
         TkrMKjejyBGzy6vxcc4b/3JWQhrjB2r2mdoqmQNyAWGNxrHXHCARfDUKla7h55ymuZN0
         6/qNjvtu1pV29VWgHY3jcP6ajeFa3StNiHP+TN8hkW+oqgmsJU0mnHavUqXQ513FYgPK
         yQ5n4ilX/hWR9HpckD9ZFQKLzA5K1jbkDenR4WVWB6CdlWwXj0jJpgA1ITADlpi/aXjp
         8s58DBj68Cn7cupIefGgL0RG782rahUxU33qtwckbCfUYDl64CX4wZxI4D5JPkTBjeqS
         yb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUjWSk4Jd1J4luLr16M//tgKX9cw+tUuZTIZ90t/hlQ=;
        b=Lujm6gg5iSFcgxq0KQRLO9Kxx3zXE0A0DlBH62W+cIcrrpyhS/c9ssVdarjg9wjQ1j
         X6F8IOkLTaWI17THtZJRm4neR0UgLDYmPea62WbGT2ANB+oQy3NP4l1QuXj1mO1Lf+nR
         jLxAF4+5z/qPnZFTHlS2hWHmjAPUbFX5jqDx36BP4rI2LKHcsW+mw3Hj2V7CrgaNER83
         wC6a3tPemAy6WQLTz6KnaRd7r63nXfyVuEQdbW/8RebsxAvJsuJh7ukY8fKRLnoWJlIc
         AP3HHixt3mkMMQzRkPqBNmhLsj4MUAYqabKo7r09nePdjO0/SmzO4xbvftSIEcZnHN5w
         x3rA==
X-Gm-Message-State: APjAAAUWeVgnXNeVBPcseLn0oCJKLCv790cC8squagDLyOCVs76jciAp
        YrdiaCMYwryDoAXtksGPPvK/tZhA
X-Google-Smtp-Source: APXvYqzlH1e6/g6WspXsV/mWAf3EQEtDaTuEMiEsPLDt5URxXTMY7Pk98QtLWPQ5plof/vx0i3gIwg==
X-Received: by 2002:a5d:4d4e:: with SMTP id a14mr17492475wru.324.1552479880412;
        Wed, 13 Mar 2019 05:24:40 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/11] test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'
Date:   Wed, 13 Mar 2019 13:24:09 +0100
Message-Id: <20190313122419.2210-2-szeder.dev@gmail.com>
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

When a test script run with 'dash' and '--verbose-log -x' is
interrupted by ctrl-C, SIGTERM, or closing the terminal window, then
most of the time the registered EXIT trap actions are not executed.
This is an annoying issue with tests involving daemons, because they
should run cleanup commands to kill those daemon processes in the trap
on EXIT, but since these cleanup commands are not executed, the
daemons are left alive and keep their port open, thus interfering with
subsequent execution of the same test script.

The cause of this issue is the subtle combination of several factors
(bear with me, or skip over the indented part):

  - Even when the test script is interrupted, the cleanup commands are
    not run in the trap on INT, TERM, or HUP, but in the trap on EXIT
    after the trap on the signals invokes 'exit' [1].

  - According to POSIX [2]:

      "The environment in which the shell executes a trap on EXIT
      shall be identical to the environment immediately after the last
      command executed before the trap on EXIT was taken."

    Pertinent to the issue at hand is that all open file descriptors
    and the state of '-x' tracing should be preserved.  All shells
    I've tried [3] preserve '-x'.  Unfortunately, however:

      - 'dash' doesn't conform to this when it comes to open file
        descriptors: even when standard output and/or error are
        redirected somewhere when 'exit' is invoked, anything written
        to them in the trap on EXIT goes to the script's original
        stdout and stderr [4].

        We can't dismiss this with a simple "it doesn't conform to
        POSIX, so we don't care", because 'dash' is the default
        /bin/sh in some of the more popular Linux distros.

      - As far as I can tell, POSIX doesn't explicitly say anything
        about the environment of trap actions for various signals.

        In practice it seems that most shells behave sensibly and
        preserve both open file descriptors and the state of '-x'
        tracing for the traps on INT, TERM, and HUP, including even
        'dash'.  The exceptions are 'mksh' and 'lksh': they do
        preserve '-x', but not the open file descriptors.

  - When a test script run with '-x' tracing enabled is interrupted,
    then it's very likely that the signal arrives mid-test, i.e.:

      - while '-x' tracing is enabled, and, consequently, our trap
        actions on INT, TERM, HUP, and EXIT will produce trace output
        as well.

      - while standard output and error are redirected to a log file,
        to the test script's original standard output and error, or to
        /dev/null, depending on whether the test script was run with
        '--verbose-log', '-v', or neither.  According to the above, we
        can't rely on these redirections still be in effect when
        running the traps on INT, TERM, HUP, and/or EXIT.

  - When a test script is run with '--verbose-log', then the test
    script is re-executed with its standard output and error piped
    into 'tee', in order to send the "regular" non-verbose test's
    output both to the terminal and to the log file.  When the test is
    interrupted, then the signal interrupts the downstream 'tee' as
    well.

Putting these together, when a test script run with 'dash' and
'--verbose-log -x' is interrupted, then 'dash' tries to write the
trace output from the EXIT trap to the script's original standard
error, but it very likely can't, because the 'tee' downstream of the
pipe is interrupted as well.  This causes the shell running the test
script to die because of SIGPIPE, without running any of the commands
in the EXIT trap.

Disable '-x' tracing in the trap on INT, TERM, and HUP to avoid this
issue, as it disables tracing in the chained trap on EXIT as well.
Wrap it in a '{ ... } 2>/dev/null' block, so the trace of the command
disabling the tracing doesn't go to standard error either [5].

Note that it's not only '-x' tracing that can be problematic, but any
shell builtin, e.g. 'echo', that writes to standard output or error in
the trap on EXIT, while a test running with 'dash' and '--verbose-log'
(even without '-x') is interrupted.  As far as I can tell, this is not
an issue at the moment:

 - The cleanup commands to stop the credential-helper, Apache, or
   'p4d' don't use any such shell builtins.

 - stop_git_daemon() does use 'say' and 'error', both wrappers around
   'echo', but it redirects 'say' to fd 3, i.e. to the log file, and
   while 'error' does write to standard output, it comes only after
   the daemon was killed.

 - The non-builtin commands that actually stop the daemons ('kill',
   'apache2 -k stop', 'git credential-cache exit') are silent, so they
   won't get SIGPIPE before finishing their job.

[1] The trap on EXIT must run cleanup commands, because we want to
    stop any daemons when a test script run with '--immediate' fails
    and exits early with error.  By chaining up the trap on signals to
    the trap on EXIT we can deal with cleanup commands a bit simpler,
    because the tests involving daemons only have to set a single
    trap.

[2] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap

[3] The shells I tried: dash, Bash, ksh, ksh93, mksh, lksh, yash,
    BusyBox sh, FreeBSD /bin/sh, NetBSD /bin/sh.

[4] $ cat trap-output.sh
    #!/bin/sh
    trap "echo output; echo error >&2" EXIT
    { exit; } >OUT 2>ERR
    $ dash ./trap-output.sh
    output
    error
    $ wc -c OUT ERR
    0 OUT
    0 ERR

    On a related note, 'ksh', 'ksh93', and BusyBox sh don't conform to
    the specs in this respect, either.

[5] This '{ set +x; } 2>/dev/null' trick won't help those shells that
    show trace output for any redirections and don't preserve open
    file descriptors for the trap on INT, TERM and HUP.  The only such
    shells I'm aware of are 'mksh' and 'lksh'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8665b0a9b6..db3875d1e4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -631,7 +631,10 @@ die () {
 
 GIT_EXIT_OK=
 trap 'die' EXIT
-trap 'exit $?' INT TERM HUP
+# Disable '-x' tracing, because with some shells, notably dash, it
+# prevents running the cleanup commands when a test script run with
+# '--verbose-log -x' is interrupted.
+trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 
 # The user-facing functions are loaded from a separate file so that
 # test_perf subshells can have them too
-- 
2.21.0.499.g4d310c7a8e.dirty

