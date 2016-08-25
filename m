Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D801F859
	for <e@80x24.org>; Thu, 25 Aug 2016 12:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757520AbcHYMTU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 08:19:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35842 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754049AbcHYMTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 08:19:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so7154833wmf.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2iQKCt2Zpya/LFK9OCZVoIyF3QQ2XMFUaLD4ngOXLY=;
        b=cHLbzgg8eruIUMJYb/WStd402NydPveoBL+aSG5r8hssnyOM1tDK8lgjE89HEtcx9S
         t0KNE/zd1V5LMcdRQC9z6Wxl6vgvN2RFuopFlpU4mz9gmiAOQOwAiJYIBEjwdO7s7P+B
         Kv99EXU0lJa04i+hdxiG2UQoN4Uzp+dW+5tHCqmdieOAFWDLNzOWRHZM/fnNvuaqsH72
         KL6lYjGZXnxkEqH8E1cP2yebxpROZnnT3AKEDrUo5qTJPmkY5DeucRaguZwA1A5QmZs+
         p/Mh/Xo2Z77LFpAYUV0lCAXpzIoD7+3CDMf5Ju/CZAnaVG+zCzzl5f4ijJQxwY2RU6Yn
         TbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2iQKCt2Zpya/LFK9OCZVoIyF3QQ2XMFUaLD4ngOXLY=;
        b=kd/S1AiGOYehmH9huUrD2A3ygN0LOakGjHj38n+9k7wkTa1nbkNfMhIu3Eyx/3+w9P
         2UNNYNFX43Ab7DCpgIM6NjNTJ8+Mcnps5hp/vmYm2NLg/Ke95juht9AgCpA1zy2lnGAT
         VF8GpD2htsRuZDxO59ByT4HakuB51Sp5SqnXSFT8LPaG6m0NwdvSfil8tQoZGilHIhT7
         cjt6+bkR+o+nXR5gOta4+4quhPUqX7mtntDGoSo2/zmgvv+6tND6y4mRPytWFo19ZJ0G
         RCNlNLUFAmWpW3tdkWwO3VElqNiq9CVqpMe2Oxn1I1rKKHo/KkR30YJIceXawdlcB9Vm
         a8jQ==
X-Gm-Message-State: AEkoouuFPrE6xKzDwG7FLcFg9RoMzUB9EQftwXNFJ39GaP8D7gUVW9rzCI13Vm+wcdPclQ==
X-Received: by 10.28.174.11 with SMTP id x11mr30684652wme.41.1472123287740;
        Thu, 25 Aug 2016 04:08:07 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:07 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 08/13] convert: quote filter names in error messages
Date:   Thu, 25 Aug 2016 13:07:47 +0200
Message-Id: <20160825110752.31581-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard to
read in error messages. Quote them to improve the readability.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index b1614bf..522e2c5 100644
--- a/convert.c
+++ b/convert.c
@@ -397,7 +397,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	child_process.out = out;
 
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", params->cmd);
+		return error("cannot fork to run external filter '%s'", params->cmd);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -415,13 +415,13 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
-		error("cannot feed the input to external filter %s", params->cmd);
+		error("cannot feed the input to external filter '%s'", params->cmd);
 
 	sigchain_pop(SIGPIPE);
 
 	status = finish_command(&child_process);
 	if (status)
-		error("external filter %s failed %d", params->cmd, status);
+		error("external filter '%s' failed %d", params->cmd, status);
 
 	strbuf_release(&cmd);
 	return (write_err || status);
@@ -462,15 +462,15 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 		return 0;	/* error was already reported */
 
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
-		error("read from external filter %s failed", cmd);
+		error("read from external filter '%s' failed", cmd);
 		ret = 0;
 	}
 	if (close(async.out)) {
-		error("read from external filter %s failed", cmd);
+		error("read from external filter '%s' failed", cmd);
 		ret = 0;
 	}
 	if (finish_async(&async)) {
-		error("external filter %s failed", cmd);
+		error("external filter '%s' failed", cmd);
 		ret = 0;
 	}
 
-- 
2.9.2

