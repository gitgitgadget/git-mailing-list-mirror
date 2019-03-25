Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD0A20248
	for <e@80x24.org>; Mon, 25 Mar 2019 10:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfCYKjD (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 06:39:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38367 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfCYKjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so8429479wmf.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juvZecVdmRjI3K+Iym2xOTyM7Zcaid80j7UuL47zD0g=;
        b=CgzFIQTCFv9nz1Kzcj/m8K0nMDbv6vfb3omA0xCFcLT0nBXzGNG/ow9SyLHwOzEiHl
         q69Bdi58toKSL59B1k7iBck79gIkZ0upoFv8XIreKvDWu3kZzl3QNP2Cfg4MXTtbOU9l
         1QGwiqh5NcOIAe81D0waJx7nlukgdrNzWVp4rtTr/fmx52VgLHZCqwBYOMhcXvNraeR/
         FJihtf2TdjXkS1ArR/lPv6Dndcbmqzmte58SuBp5Kws7kysbSmS6n1JX1xbQfo8umnem
         PVW4eR+83tEztSJBFKEf1v1zhFig1MI66knIzCt+38RG9Fj+qJKUIfZdfS1s0y9+5jO6
         EP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juvZecVdmRjI3K+Iym2xOTyM7Zcaid80j7UuL47zD0g=;
        b=mH7d+HL4ipgNMbyfQw7fUGj4ald3JEemwGWHsoVWRgmRngKWeBnGIO4FBlKU+rMMbn
         I0HU+CARjXJbJZAnJYKfAWxw2vt8SjVQ0O16pKoo9QXeisKghbq4huQGCFbAs+1btDbV
         Ivyp9mgmtZCnPjlorSZ5zO1AdfvYuFPviS4PyMTf+wbnjY1CZEGYEAHn/N32OJKs9y8i
         WCsUE+21KR/TnoX2ng8o7kejMMrxUkCOdZua3eK4RBMPb803qAu8IiwnoFNURaAl18M3
         ddFRG8KoIbJArCDtJgswvN9befbbOwcdIt/93MfKwSzZOfkitRbItbmXHWalSzwdSIse
         kfXA==
X-Gm-Message-State: APjAAAW3DHUkiZgBsR9nJBq22y1ufUqlGpG9kCeLcHXeuhZh9O93iUSB
        QFTQ3n8CGi+RIjXtT048yUmcDys4QBY=
X-Google-Smtp-Source: APXvYqy6caLiMFaFjL/R6doeZHXejslR0Lua7klxMCkb5+k7cP9PgRj+AnNtqu6KngbiA/c95mfDuQ==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr3461773wmd.30.1553510340817;
        Mon, 25 Mar 2019 03:39:00 -0700 (PDT)
Received: from localhost.localdomain (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id q2sm23247292wrd.46.2019.03.25.03.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:39:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] progress: assemble percentage and counters in a strbuf before printing
Date:   Mon, 25 Mar 2019 11:38:42 +0100
Message-Id: <20190325103844.26749-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190325103844.26749-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following patches in this series want to handle the progress bar's
title and changing parts (i.e. the counter and the optional percentage
and throughput combined) differently.

To prepare for those changes assemble the changing parts in a separate
strbuf before printing.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/progress.c b/progress.c
index b57c0dae16..390d2487ca 100644
--- a/progress.c
+++ b/progress.c
@@ -36,6 +36,7 @@ struct progress {
 	unsigned delay;
 	struct throughput *throughput;
 	uint64_t start_ns;
+	struct strbuf counters_sb;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -80,7 +81,9 @@ static int is_foreground_fd(int fd)
 
 static void display(struct progress *progress, uint64_t n, const char *done)
 {
-	const char *eol, *tp;
+	const char *tp;
+	struct strbuf *counters_sb = &progress->counters_sb;
+	int update = 0;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -93,25 +96,31 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
-	eol = done ? done : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
-				progress->title, percent,
-				(uintmax_t)n, (uintmax_t)progress->total,
-				tp, eol);
-			fflush(stderr);
-			progress_update = 0;
-			return;
+
+			strbuf_reset(counters_sb);
+			strbuf_addf(counters_sb,
+				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
+				    (uintmax_t)n, (uintmax_t)progress->total,
+				    tp);
+			update = 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %"PRIuMAX"%s%s",
-			progress->title, (uintmax_t)n, tp, eol);
+		strbuf_reset(counters_sb);
+		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
+		update = 1;
+	}
+
+	if (update) {
+		const char *eol = done ? done : "   \r";
+
+		fprintf(stderr, "%s: %s%s", progress->title, counters_sb->buf,
+			eol);
 		fflush(stderr);
 		progress_update = 0;
-		return;
 	}
 
 	return;
@@ -213,6 +222,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
+	strbuf_init(&progress->counters_sb, 0);
 	set_progress_signal();
 	return progress;
 }
@@ -256,6 +266,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		free(buf);
 	}
 	clear_progress_signal();
+	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
 	free(progress->throughput);
-- 
2.21.0.539.g07239c3a71.dirty

