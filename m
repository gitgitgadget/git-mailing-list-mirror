Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64AD2098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756171AbcJPXUs (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:20:48 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33439 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754974AbcJPXUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:20:46 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so8539536pac.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrzgIBvtvrHCvICiQYnRQrYeRbiyutEjyFUkgwqd5sI=;
        b=YtHWyvwUmXG5XEcY97U1PXBIlT6qyjpTSOGnltTIqYaclgFIVsIm6V2uCrAsBpDo9e
         6cCZbfPCmDF/lVD3uUHePsKMVZ6qRiTozeyhs0duPYOrzNpoMq7Yd4OB/mQCd18fHpOV
         5IR0LrfbGKBMRYAaNHw2BBsYmcfRucXC1Px9JMlDiFAywkW/VnOf6OcDgj5VfrZVA13n
         vx0jYnvoWvioZZ4rApH9MRE1SNSALJEji7OZgYucsxSoSwBneO7JBcM55XSf7WaUvutk
         9EHA9HDIBNiB7nMOPr+K5ItXmEKvhuGIdMJq2I24DDXscYV6FBQaIVROSifzFQmls6dU
         Z0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrzgIBvtvrHCvICiQYnRQrYeRbiyutEjyFUkgwqd5sI=;
        b=O1gZzr2LQvFrjywx23RkgW0JyZg6QOuz665jVN5T+2KtPVWd8w1HCqJbaDG2BneAyH
         gIf5eoU5ut4xyNTvNSqhA+Hrddexievcy8pjayDctWWA07Z+wzCTnYk+dXgdc+6KzvdG
         0lyGD2p/YiWeQjXyMDw1zjAvg3NxzkMykuE5CCIEZ4KHFr8ErnSGGbDJXIwMMvxzsa7Y
         LSATVfjqL84aswjoimI33PT7o3lTyN6SxMlCTVHOMGfupYEim9RD084ziH2UNq+DAIxr
         p8PWD/sHEls48uRuRxFsEOsbsDL7idMmjhNcCFwosKjgBxZBF0Pb+7HqbSHbgJmEfcti
         SKEw==
X-Gm-Message-State: AA6/9Rlp/1t7bSfkt06mo3+Ffvq81sTCH7MxodxubWmm5yc00KYHupYbOY5OFpgprTEcIg==
X-Received: by 10.66.21.137 with SMTP id v9mr28334721pae.100.1476660045125;
        Sun, 16 Oct 2016 16:20:45 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.20.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:20:44 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 01/14] convert: quote filter names in error messages
Date:   Sun, 16 Oct 2016 16:20:25 -0700
Message-Id: <20161016232038.84951-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard
to read in error messages. Quote them to improve the readability.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 077f5e6..986c239 100644
--- a/convert.c
+++ b/convert.c
@@ -412,7 +412,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	child_process.out = out;
 
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", params->cmd);
+		return error("cannot fork to run external filter '%s'", params->cmd);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -430,13 +430,13 @@ static int filter_buffer_or_fd(int in, int out, void *data)
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
@@ -477,15 +477,15 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
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
2.10.0

