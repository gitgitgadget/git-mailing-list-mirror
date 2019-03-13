Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207B820248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCMMYz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33545 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCMMYy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id c13so4334639wmb.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dk2xZU6GkAB79sUnMSGa83mNpZWTpyUiIYfRLyPrfs=;
        b=tH6kJO7V3GGBAdFUK4WrpN1UthCsGWF3gtcltGg6jMWe854Uqbe/E4DHbKBWONTjmA
         CBYCidZDKvaFnjWnjVN+AQKe6QyaAOSAqeXuTE4kwNR7lh84YIDFh9qKXZMJ1bW2KMaO
         C9ZjQwEqRnm0czVnASprIhKBSnlkXLk8srCzX/APKlJMIVUYJToVgqrcuP/5vWAJ0x0i
         nFBO5TdR2WGKLh1cBwQR5TnzuxbD+iYKTSKrUMU5uZlK0ENikRfdocLb+rVQaDki4NQR
         NutwPf5qewVAl0O/E3KCMNjlIMzw3sRGk46AeE7s6Md+ZcNC0xXTMES7uUBAN/KR3z1D
         IfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dk2xZU6GkAB79sUnMSGa83mNpZWTpyUiIYfRLyPrfs=;
        b=rMqaNFkX4wlytEXWJWsKxoZyiQwtjcqesVV/MSokpxQe34u+sj52rU29zdA6mA0xyM
         b2gqSlLQSe82NbOnLTeeRCZ6VUcoIm2IjINAln/ok9ToNl/Cw4atggtaxBGc3vJaAKGe
         OHFVI5zm69JqJZ8nVhmZgp9kxrrzsH9zBhDxpm31/Ou3bC5L6sl2Uu1gjMUzyhwFVPE1
         zpgtsgOktQep5U5qF88IoK/gOmI4QWJTLGcngGRcpScXPqdzaPgFFH1OSog2uQEegXiS
         ECDk3EXRdTH1yTD6va50DrMOerkBYIYozRyGg1n4XPA6A4EErlFdmpiG0ZVRPVgCiY+C
         R4NA==
X-Gm-Message-State: APjAAAXIKgxRrqwS4KKq5GVGbhtMuEl3rhcelamIA/SbaACnwNyxcSYu
        HO8nADem24mDhFYhYeZZT6x4rkKh
X-Google-Smtp-Source: APXvYqzpSQlfDRUz0/+CZVfvCZzFcabHBt7EVFyC46YaoT/Pp7QhT0LTa8tNM/G+kmKitfodjf55Zg==
X-Received: by 2002:a05:600c:224f:: with SMTP id a15mr1239688wmm.2.1552479891852;
        Wed, 13 Mar 2019 05:24:51 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/11] git p4 test: simplify timeout handling
Date:   Wed, 13 Mar 2019 13:24:17 +0100
Message-Id: <20190313122419.2210-10-szeder.dev@gmail.com>
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

'lib-git-p4.sh' uses timeouts in a watchdog process to kill a
potentially stuck 'p4d' process and for certain cleanup operation
between tests.  It does so by first computing when the timeout should
expire, and then repeatedly asking for the current time in seconds
until it exceeds the expiration time, and for portability reasons it
uses a one-liner Python script to ask for the current time.

Replace these timeouts with downcounters, which, though not
necessarily shorter, are much simpler, at least in the sense that they
don't execute the Python interpreter every second.

After this change the helper function with that Python one-liner has
no callers left, remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-p4.sh | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index b5cb5075c2..c18f85082f 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -44,15 +44,6 @@ native_path () {
 	echo "$path"
 }
 
-# On Solaris the 'date +%s' function is not supported and therefore we
-# need this replacement.
-# Attention: This function is not safe again against time offset updates
-# at runtime (e.g. via NTP). The 'clock_gettime(CLOCK_MONOTONIC)'
-# function could fix that but it is not in Python until 3.3.
-time_in_seconds () {
-	(cd / && "$PYTHON_PATH" -c 'import time; print(int(time.time()))')
-}
-
 test_set_port P4DPORT
 
 P4PORT=localhost:$P4DPORT
@@ -105,15 +96,16 @@ start_p4d () {
 	# will be caught with the "kill -0" check below.
 	i=${P4D_START_PATIENCE:-300}
 
-	timeout=$(($(time_in_seconds) + $P4D_TIMEOUT))
+	nr_tries_left=$P4D_TIMEOUT
 	while true
 	do
-		if test $(time_in_seconds) -gt $timeout
+		if test $nr_tries_left -eq 0
 		then
 			kill -9 $p4d_pid
 			exit 1
 		fi
 		sleep 1
+		nr_tries_left=$(($nr_tries_left - 1))
 	done &
 	watchdog_pid=$!
 
@@ -167,10 +159,11 @@ p4_add_job () {
 }
 
 retry_until_success () {
-	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
-	until "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
+	nr_tries_left=$RETRY_TIMEOUT
+	until "$@" 2>/dev/null || test $nr_tries_left -eq 0
 	do
 		sleep 1
+		nr_tries_left=$(($nr_tries_left - 1))
 	done
 }
 
-- 
2.21.0.499.g4d310c7a8e.dirty

