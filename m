Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F187920970
	for <e@80x24.org>; Thu, 13 Apr 2017 10:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdDMKbu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 06:31:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32774 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdDMKbt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 06:31:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so11701023wmb.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyj+16Q+GA5lbafqa9EpP5iwbE5/2C74or2q/Ni/McY=;
        b=gcqIntWIo4BN5UMp/B7OIzxHR/jrgklk9qs493cYDNbrAlXNuG/pISIXnGdw3bTIq2
         vOvSN4F/ut2mp2+ma9VP2BDEmsRW3ghDsqwqgllGjpWcTGq20vSNa6R6Ec02pCzT98rS
         jNhz9/nLB7KEplVPa7FizsJyA10o1apZhja+vvDU31Sf+kAzIoomKOpv6ITnRk2+ePEk
         tTQwAw+4pcOZJAWvb+s1CNhDPmBknPHKEIojC1Vy9wU91EB5QKwzbXvCyDwC4fbayQzy
         6NCxkQODuL+3y/5AO9hY1LlXb7lKFdn4URsi/LTEC+oo2NexjB0vaJYzafAlSGa0KvvY
         XVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyj+16Q+GA5lbafqa9EpP5iwbE5/2C74or2q/Ni/McY=;
        b=E/AAxwUwgfGe3zTsMcTG0RWLKhS7FsbforHvrddKfu7z0x/AGj4j1OpukNwJMFrHCg
         lF4gJ67IJ1QMxwycUuiYuhODqybBgAqe2kRTd1dytKM19Kddd/VPTz/W9bEjMosrcPNy
         WxmWu2y1cfGbVfj98zL9jv1xIjjbU7rGPF9cp2M85mzo9gLVg8M6dEPG7nEjnFdRIvoc
         2YvCONovzIc84UtATpsuvp753EYcLxqIB7R6iSGuQeekDnKjUbPqQZaCfvH/fjolioVO
         3dzFRja8VsgwoXqb0l1TojWJtrY0zkHzEoouBdCD+bOHPFuU4AZGftsNl5V/Alfl3C/y
         S/tA==
X-Gm-Message-State: AN3rC/7xQPMsnhHpgnFfR/IxuBNDk1xj8STTvaF/O5gvIi9+xe3/kttW
        EorqCGPtWUWlQw==
X-Received: by 10.28.126.193 with SMTP id z184mr22288927wmc.26.1492079507865;
        Thu, 13 Apr 2017 03:31:47 -0700 (PDT)
Received: from localhost.localdomain (x590e36e4.dyn.telefonica.de. [89.14.54.228])
        by smtp.gmail.com with ESMTPSA id p101sm2724200wrb.64.2017.04.13.03.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 03:31:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2.1] t6500: wait for detached auto gc at the end of the test script
Date:   Thu, 13 Apr 2017 12:31:38 +0200
Message-Id: <20170413103138.12717-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <20170412220717.7357-1-szeder.dev@gmail.com>
References: <20170412220717.7357-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last test in 't6500-gc', 'background auto gc does not run if
gc.log is present and recent but does if it is old', added in
a831c06a2 (gc: ignore old gc.log files, 2017-02-10), may sporadically
trigger an error message from the test harness:

  rm: cannot remove 'trash directory.t6500-gc/.git/objects': Directory not empty

The test in question ends with executing an auto gc in the backround,
which occasionally takes so long that it's still running when
'test_done' is about to remove the trash directory.  This 'rm -rf
$trash' in the foreground might race with the detached auto gc to
create and delete files and directories, and gc might (re-)create a
path that 'rm' already visited and removed, triggering the above error
message when 'rm' attempts to remove its parent directory.

Commit bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01)
fixed the same problem in a different test script by simply
disallowing background gc.  Unfortunately, what worked there is not
applicable here, because the purpose of this test is to check the
behavior of a detached auto gc.

Make sure that the test doesn't continue before the gc is finished in
the background with a clever bit of shell trickery:

  - Open fd 9 in the shell, to be inherited by the background gc
    process, because our daemonize() only closes the standard fds 0,
    1 and 2.
  - Duplicate this fd 9 to stdout.
  - Read 'git gc's stdout, and thus fd 9, through a command
    substitution.  We don't actually care about gc's output, but this
    construct has two useful properties:
  - This read blocks until stdout or fd 9 are open.  While stdout is
    closed after the main gc process creates the background process
    and exits, fd 9 remains open until the backround process exits.
  - The variable assignment from the command substitution gets its
    exit status from the command executed within the command
    substitution, i.e. a failing main gc process will cause the test
    to fail.

Note, that this fd trickery doesn't work on Windows, because due to
MSYS limitations the git process only inherits the standard fds 0, 1
and 2 from the shell.  Luckily, it doesn't matter in this case,
because on Windows daemonize() is basically a noop, thus 'git gc
--auto' always runs in the foreground.

And since we can now continue the test reliably after the detached gc
finished, check that there is only a single packfile left at the end,
i.e. that the detached gc actually did what it was supposed to do.
Also add a comment at the end of the test script to warn developers of
future tests about this issue of long running detached gc processes.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Updated subject line, but otherwise the same as v2.

 t/t6500-gc.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 08de2e8ab..cc7acd101 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,6 +67,16 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+run_and_wait_for_auto_gc () {
+	# We read stdout from gc for the side effect of waiting until the
+	# background gc process exits, closing its fd 9.  Furthermore, the
+	# variable assignment from a command substitution preserves the
+	# exit status of the main gc process.
+	# Note: this fd trickery doesn't work on Windows, but there is no
+	# need to, because on Win the auto gc always runs in the foreground.
+	doesnt_matter=$(git gc --auto 9>&1)
+}
+
 test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
 	test_commit foo &&
 	test_commit bar &&
@@ -80,7 +90,13 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test-chmtime =-345600 .git/gc.log &&
 	test_must_fail git gc --auto &&
 	test_config gc.logexpiry 2.days &&
-	git gc --auto
+	run_and_wait_for_auto_gc &&
+	ls .git/objects/pack/pack-*.pack >packs &&
+	test_line_count = 1 packs
 '
 
+# DO NOT leave a detached auto gc process running near the end of the
+# test script: it can run long enough in the background to racily
+# interfere with the cleanup in 'test_done'.
+
 test_done
-- 
2.12.2.613.g9c5b79913

