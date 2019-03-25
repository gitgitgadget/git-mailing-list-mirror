Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A7320248
	for <e@80x24.org>; Mon, 25 Mar 2019 10:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfCYKjE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 06:39:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38120 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfCYKjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so2079372wro.5
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caHXomYWdMTxMj4PQvcgr2HLUL8XVZqTOpyaAqXDs94=;
        b=JmnRg5lj82okwDzCoMIQtX9DM31q+d7AMeYWcchEePWa8P0UMbqG6pMdH1Fdyo0sX1
         mQB7iTB7T+Xt93esY4OFuJQCN0y1FiVvp9A2fmlXTLfrEmoaQzS6uzLLZyl+hzYMbHWt
         rPlqWBduI27RqhU/uZkjeAmYeZ/50s3gcCr9r7Yd2mWPOrqm4dfIeoSl8aA8YVcGZ1oQ
         jIL07zWkuZC7n6ee9kHFNHYBgbEzaeIWh+BVOdhilAklc1LTJi/asqOZPpYG71Guud6s
         xHdFgk13bVa0Dy8daxZRP0UC+NWIvk9qCppM1AGH4Xq8vqR9styx+9zR7lNM+uR5evpe
         CGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caHXomYWdMTxMj4PQvcgr2HLUL8XVZqTOpyaAqXDs94=;
        b=NgighAgemAkfGJOm92AZbF2Pwz1KMnnbRElM+NnrAMcok3pw5bBRGZR7Pfsy6DlLEd
         VVmSOpvK93aP9caDsc3AZ66agf6b1guHsePYNCRMKyVL82p/wLcI3RZyxGZ4Xk/PJ4R5
         mOc31ijFZFUVUAY7qWce1MZoikkd5DbrjM2sHJ2ZxvCcwQi7nfS+LCZi6hsviDoTASgB
         M/6S0FMVTLnq/GS2fwxCnoFoz0h6d3ntFqbQDlzZwQJlHwRvd/+AcNZzmXpFL+GnomM9
         ynR2YyuZp6Ik2dcQvYUSCWB8EAa3RYrtqvZleiD49RYmkeliCidsYEGP1Honuuy4RA0Y
         H7lw==
X-Gm-Message-State: APjAAAVlCxffMdoUqGMEBG5YTadcgrOjT8s4iwzEr+hOIZuSE2EfD1P+
        ykE/myxacBMzwsdNiEJ2dlSN5nu3Ipg=
X-Google-Smtp-Source: APXvYqyyx/fP4LDPdXv9ElqlwtPY4rqsUaw1UZ9G1ELpdRf7JY7pJkRZ7jUtuEsWJXmqQkT+JyWqVA==
X-Received: by 2002:adf:e407:: with SMTP id g7mr4658657wrm.47.1553510342104;
        Mon, 25 Mar 2019 03:39:02 -0700 (PDT)
Received: from localhost.localdomain (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id q2sm23247292wrd.46.2019.03.25.03.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:39:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] progress: clear previous progress update dynamically
Date:   Mon, 25 Mar 2019 11:38:43 +0100
Message-Id: <20190325103844.26749-5-szeder.dev@gmail.com>
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

When the progress bar includes throughput, its length can shorten as
the unit of display changes from KiB to MiB.  To cover up remnants of
the previous progress bar when such a change of units happens we
always print three spaces at the end of the progress bar.

Alas, covering only three characters is not quite enough: when both
the total and the throughput happen to change units from KiB to MiB in
the same update, then the progress bar's length is shortened by four
characters:

  Receiving objects:  25% (2901/11603), 772.01 KiB | 733.00 KiB/s
  Receiving objects:  27% (3133/11603), 1.43 MiB | 1.16 MiB/s   s

and a stray 's' is left behind.

So instead of hard-coding the three characters to cover, let's compare
the length of the current progress bar with the previous one, and
cover up as many characters as needed.

Sure, it would be much simpler to just print four spaces instead of
three at the end of the progress bar, but this approach is more
future-proof, and it won't print extra spaces when none are needed,
notably when the progress bar doesn't show throughput and thus never
shrinks.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 390d2487ca..b37a5398c5 100644
--- a/progress.c
+++ b/progress.c
@@ -84,6 +84,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int update = 0;
+	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -115,10 +116,11 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 
 	if (update) {
-		const char *eol = done ? done : "   \r";
-
-		fprintf(stderr, "%s: %s%s", progress->title, counters_sb->buf,
-			eol);
+		const char *eol = done ? done : "\r";
+		int clear_len = counters_sb->len < last_count_len ?
+				last_count_len - counters_sb->len : 0;
+		fprintf(stderr, "%s: %s%-*s", progress->title,
+			counters_sb->buf, clear_len, eol);
 		fflush(stderr);
 		progress_update = 0;
 	}
-- 
2.21.0.539.g07239c3a71.dirty

