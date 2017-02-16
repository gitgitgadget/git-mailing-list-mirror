Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30ECB20136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbdBPL3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:29:55 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35536 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbdBPL3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:29:49 -0500
Received: by mail-lf0-f65.google.com with SMTP id v186so1219603lfa.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1l4fbACmQupg/uC51Inmw90I/h37SnV3aOVoZkBOOM=;
        b=ED2SglVoBO8l+MFCNS0NUB1IucBNlGurpuvlKS0eNdywEMQRcPKwTIVwav94MyIKjW
         3WKbW+GY6t/FSHUbiUmewVS070B1V3StkWLSKiXVA8uRKrhSaHAUkyirCJXR9uG9Ued2
         Bh34Y800Qg6L3rxyxTAAVS7uoo1JwLNEgK5aU3UuzuFRXllUhx1Xky01N/K6ykZ/oPZ3
         /B8DFfub8aVjTLbM8erV4G70WO9meKqQ/uhx49YKx8czrtcjd6YQHFjYCu5yXzYHPN8v
         xzUDNJ6r0ogHKewg8Lz8sgJgXWY/Vm4+WZoMCdDVMH5BMaUZ05nmxe22WRvY3L3y26lX
         Xwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O1l4fbACmQupg/uC51Inmw90I/h37SnV3aOVoZkBOOM=;
        b=sk/jp52++oxZ1+UaXsPRRcWNPe1dhWcP9czdrf6zHPQM9niLV2+SAxsRrzBLQDDGXb
         ybFgvd9MwMnL+dJyaw9BICHVGQaGBM2rkqPeR6AXYUi67X0Tm1Gy6ED2SJZgZWhOJ1ax
         llD/2ID1jh3YM2aHV26A0DcdKVhsL5diWz+j2zfB+lVkG4GMezNmRU4DTcCZ10GABzd6
         vCzz02Spb+978AMYVXV8tl16ZdbZDhub6PJ0A3B1Uwi496Fr4ej609vKbMqIkTmxw0A5
         kI7pRzh7bF9Td6wJw1hhuqYZ29dvewsjMo+Mxj65X0sR1Ni8KLIdd+fdlGQeSwsK3+ec
         kadg==
X-Gm-Message-State: AMke39maOlKJC1Bb/jjJI8uCjpuhKPaptGSvFn8BksDL3/Hlaov+yt0cGWBZRr1JT0gSlQ==
X-Received: by 10.46.22.18 with SMTP id w18mr539128ljd.86.1487244588299;
        Thu, 16 Feb 2017 03:29:48 -0800 (PST)
Received: from localhost.localdomain ([193.106.40.78])
        by smtp.gmail.com with ESMTPSA id v3sm1641430ljd.65.2017.02.16.03.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:29:47 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH 3/3] stop_progress_msg: convert xsnprintf to git_psprintf
Date:   Thu, 16 Feb 2017 14:28:29 +0300
Message-Id: <20170216112829.18079-4-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace local safe string buffer allocation by git_psprintf.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 progress.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 76a88c573..989d65504 100644
--- a/progress.c
+++ b/progress.c
@@ -243,21 +243,18 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char buf[128], *bufp;
-		size_t len = strlen(msg) + 5;
+		char *bufp;
 		struct throughput *tp = progress->throughput;
 
-		bufp = (len < sizeof(buf)) ? buf : xmallocz(len);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		xsnprintf(bufp, len + 1, ", %s.\n", msg);
+		bufp = git_psprintf(", %s.\n", msg);
 		display(progress, progress->last_value, bufp);
-		if (buf != bufp)
-			free(bufp);
+		free(bufp);
 	}
 	clear_progress_signal();
 	if (progress->throughput)
-- 
2.11.1

