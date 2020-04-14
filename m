Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ECCC2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C822072D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq6kRIwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437669AbgDNJcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437663AbgDNJcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 05:32:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A0C0A3BDC
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:32:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t16so627722plo.7
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEv5A2mAE/aimDjsayWVyzZLCGC3q2anvP46IfXez7Q=;
        b=nq6kRIwQ3pw7++cuo7DlkuqgyNLBHV+WD+km1E6AxajRbuABd+YWfM5+cUEgmzdr4g
         DtRbIZTtwNs+Gem9GYKKKOLq2p3H6Db1rQoqCphtDWp35o5f38GSE150ciAVp+HGV58J
         oi8mHMXodK8Vet9MiMpeSdHq2mP0Fw1iYxeD2j1bWKD0r005hpd5qmEr5eu1Cnai6U39
         XpbfPf+lvLcFSW6T+jBMo6MeJbKjSM8gBoCE7fPCivAtW/HBGjNVEOx57DZd6lf+xdmq
         yE1LBc5qkgSOfP2FPGAZBPgH4SihE4i8uZfGOjzy3kWfgeq1fP2xKtDjEb5eMWgSnTXc
         PhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEv5A2mAE/aimDjsayWVyzZLCGC3q2anvP46IfXez7Q=;
        b=stWP/tRlwRbRCIwDDGOrBFC32y+6dTgMH6rOjr+N4BM3yqA3Ibf6EV25js9nTsDwj/
         FNC9T8Vd5vu72tgo+siKsemFQCcJIEZO7OLvn2NAXq2zd+TgNddqcTZk5a6lgCYv2O3K
         1Y5QNAcEjr//WYtditHr/5fXnPdG/G8Y0gGnNeZ+dsWX7DVHfJvVT50Xqdx5SgnDcKv8
         4jtXkbt1Pw+AKEcVnZbp0Z11wLvSlDvMWLT/GNPCEPpNhUNkfQTgjXp2LRM7Sx9k1+pq
         rJ9q3FaMEKPGoPAz6GmrjDE4KjXJSFZes3Se+YwmFnjxMtGq2QCjp2NaEnkH6y6GejFE
         xWPA==
X-Gm-Message-State: AGi0PuZzyvbHiVHUrfeLqsLFZN9ayh66qkR8z1c69AMRIT/eq6/mbORU
        V0ncOJXjaSPATjYZyh8/M3rIPEck
X-Google-Smtp-Source: APiQypLg301XatsbLBcXBU0836Y1HJxkwhvc9IP/NR1OoS8+n9sTzWU1yz+z92n/2pIH5mTVk5+fOA==
X-Received: by 2002:a17:90a:a40b:: with SMTP id y11mr27966386pjp.130.1586856725977;
        Tue, 14 Apr 2020 02:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id mu15sm11881506pjb.30.2020.04.14.02.32.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 02:32:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
Date:   Tue, 14 Apr 2020 16:31:55 +0700
Message-Id: <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.485.g518673e55f
In-Reply-To: <cover.1586856398.git.congdanhqx@gmail.com>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net> <cover.1586856398.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c          | 18 ++++++++++++++++++
 t/t0006-date.sh |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/date.c b/date.c
index 2f37397beb..e02d8e191a 100644
--- a/date.c
+++ b/date.c
@@ -666,6 +666,24 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		n++;
 	} while (isdigit(date[n]));
 
+	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
+	if (n == 8) {
+		tm->tm_year = num / 10000 - 1900;
+		tm->tm_mon = (num % 10000) / 100 - 1;
+		tm->tm_mday = num % 100;
+		return n;
+	}
+
+	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
+	if (n == 6) {
+		tm->tm_hour = num / 10000;
+		tm->tm_min = (num % 10000) / 100;
+		tm->tm_sec = num % 100;
+		if (*end == '.' && isdigit(end[1]))
+			strtoul(end + 1, &end, 10);
+		return end - date;
+	}
+
 	/* Four-digit year or a timezone? */
 	if (n == 4) {
 		if (num <= 1400 && *offset == -1) {
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 05c914a200..eeb11070a6 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -81,6 +81,9 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
+check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
+check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
 check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
-- 
2.26.0.485.g518673e55f

