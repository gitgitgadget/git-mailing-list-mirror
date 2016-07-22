Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E60203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 15:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbcGVPtN (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 11:49:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33093 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbcGVPtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 11:49:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so6705001wme.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 08:49:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZwhAq/6xN/tKTq0g95EzhJ1UNhZsRh7rugi7LK5Vp8=;
        b=UulJgRq7IRWxTpbfxTuNKi5YHGqWNWKNM7bkI946Erqk9Op1mbhoyfEHPjwe0/ITuL
         9qrrc8i27/jLR2Cz4mztA7nSAw8D5xIPOzrYEbVTf6omDg5GVCAPib0xBLvCd5cQGmqn
         wxYB/8bpBISv5ZcJfg0lPk8lkdSST4ybDUZJXfRI38wxbXMKse5KYjyuSjqsXKHiYARF
         3HXVvgPCFb++ur8005Evw4zkJjxUM3FAbY04//1QjkR3iBSKkSOwsafKZHNN/PZ84I0B
         vGDwLnBX43HHTf3PvQWbifT+gu+H1w+ktYhpS+ke8lQbwyQzmRXiX3DnVbvSR82MYlcN
         0tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZwhAq/6xN/tKTq0g95EzhJ1UNhZsRh7rugi7LK5Vp8=;
        b=Hr6tD1I/MG+movK4VfBy29ChcBvwgVlkAbZmDsdsF/+y261mGxzq0Eh6obNv+mwSNb
         Xpcm5dOCA9+D51PgPA5TvuQRHR8BUNyc0vzi7q/Kj5xJJhAc6x+gvm+EwDwatHSiIGn9
         +4AFC4LlCB7mj2T2XPdwsjERIwQJIboKGaV39qBZ6cZGDpWZPsvWWoCT2+P5cLvp86B0
         iPfekC9RKLsY9IdTjP6sLdgMz9MvQylbqeYnBKEpSIP1P4agjOnocZyJU7ycgzVTpjkg
         DtGoZ3A6B4/JZy71v2+aud8hLcIjfkwXHPAHsoestN/vLEVrvsJq4w9PtaysO/rkKTn+
         oVbw==
X-Gm-Message-State: AEkoouuRxAntxxTXjiNTcQxN2P6XXWHItlAC9q4GetFc9gIIPL1wVYDwexv9YkU7BoPUUw==
X-Received: by 10.194.234.135 with SMTP id ue7mr1590871wjc.49.1469202550777;
        Fri, 22 Jul 2016 08:49:10 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e10sm1507963wjc.21.2016.07.22.08.49.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jul 2016 08:49:09 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	peff@peff.net, jnareb@gmail.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 1/3] convert: quote filter names in error messages
Date:	Fri, 22 Jul 2016 17:48:58 +0200
Message-Id: <20160722154900.19477-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160722154900.19477-1-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter with spaces (e.g. `filter.sh foo`) are hard to read in
error messages. Quote them to improve the readability.

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
2.9.0

