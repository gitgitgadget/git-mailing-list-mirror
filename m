Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418BFC433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1996A20709
	for <git@archiver.kernel.org>; Sat, 16 May 2020 05:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFPsMpNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgEPFeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 01:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPFeU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 01:34:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D90C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 22:34:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l73so4699980pjb.1
        for <git@vger.kernel.org>; Fri, 15 May 2020 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P34tLToD6G6G/OOtyWuj1gjt0ljAyIZIscKt/g8rzfs=;
        b=cFPsMpNH+8PS0wkd1L+xCHSs6ZT5ebz3XSThUeponEAV+PLj/4Naxw+p6EdWI6kkBN
         feedAFF8014bSmjP84ua/iU2Gx808b1Ke3XBl1zTN2v4oDz+VnM9xs8tz8xZk0pBYxH4
         2vDJe/9+B8umXApzJwF5DHmgTvgxAfkABMt4/OGiRmWMZ6TjQnhEKsLClsgNa0Sltu3f
         P5U34X9TUnbLKMOcDn/w6qVbCiHqVQRb6SdcOFI7Mdy2OZm1h6ovwAwMWLVsp7JgeheP
         Y+EvXaWxE8/rU07ek2iNzev+6S4OEhp3aQWcOvBRSuPM93ciLfg8yvvP6f1WInE04pGw
         9DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P34tLToD6G6G/OOtyWuj1gjt0ljAyIZIscKt/g8rzfs=;
        b=TYFe9xzXao6/5qeakESmzKh/jZUeOR11KrDbEF4Cd7s6OSB9zcNvvwcaRyyqshj9NF
         21ugAfcfi5yB6GpiOtuRxux7k/X9FVVzY/iuQiol4PiuvggrtCaJotqHp85StkyBUXMI
         FjAiYAZZGuLvNiC1Jqp0zfuMWErQi1lyLTdYSOLls/60FpZ/cRIkO7bZGBDAkzyl54Jw
         QqTls5ONwooKp+fOBoC3kPl9eYfST5qTUYSOKV+j79Ps6+eton/wzscg+xeu5iIvRWgJ
         qNS3kohde+JFxD04tdE8hNNGpBBE0gLKncrFtl2CMGHOp/OObiK7LcYGzbMYnmrX7rKk
         wesw==
X-Gm-Message-State: AOAM532PEwtkLOp8Ldm51ziye9vuGWccVkFM5WzntaivhSB/sSzXl/0T
        RuQkdam5NnDK6zKWQNgFF3gd8Pe9WGk=
X-Google-Smtp-Source: ABdhPJzNU4Fgg66b50DFsolW9a9qt7zLWu+3lnVHDjdvPR8dAejw3s0rffMPPeGETLU/XCt6eB4vcA==
X-Received: by 2002:a17:90b:1482:: with SMTP id js2mr3467940pjb.54.1589607259347;
        Fri, 15 May 2020 22:34:19 -0700 (PDT)
Received: from localhost.localdomain (157-131-202-152.fiber.dynamic.sonic.net. [157.131.202.152])
        by smtp.gmail.com with ESMTPSA id 25sm2885763pjk.50.2020.05.15.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 22:34:18 -0700 (PDT)
From:   Greg Price <gnprice@gmail.com>
To:     git@vger.kernel.org
Cc:     757402@bugs.debian.org, debian-hppa@lists.debian.org,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH] tests: skip small-stack tests on hppa architecture
Date:   Fri, 15 May 2020 22:33:38 -0700
Message-Id: <619484ae49dc71d8e9885390f78cdc25a87d8cc4.1589607218.git.gnprice@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On hppa these tests crash because the allocated stack space is too
small, even after it was doubled in b9a190789 (and the data size
doubled to match) to make it work on powerpc.  For this arch just
skip these tests, which is enough to make the whole suite pass.

Fixes: https://bugs.debian.org/757402
Based-on-patch-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Greg Price <gnprice@gmail.com>
---
 t/test-lib.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05..c62961a3e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1467,6 +1467,14 @@ FreeBSD)
 	;;
 esac
 
+# Detect arches where a few things don't work
+uname_m=$(uname -m)
+case $uname_m in
+parisc* | hppa*)
+	test_set_prereq HPPA
+	;;
+esac
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
@@ -1606,16 +1614,16 @@ run_with_limited_cmdline () {
 }
 
 test_lazy_prereq CMDLINE_LIMIT '
-	test_have_prereq !MINGW,!CYGWIN &&
+	test_have_prereq !HPPA,!MINGW,!CYGWIN &&
 	run_with_limited_cmdline true
 '
 
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
 test_lazy_prereq ULIMIT_STACK_SIZE '
-	test_have_prereq !MINGW,!CYGWIN &&
+	test_have_prereq !HPPA,!MINGW,!CYGWIN &&
 	run_with_limited_stack true
 '
 
-- 
2.26.2

