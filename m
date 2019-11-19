Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D875B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKSBZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:25:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35143 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKSBZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:25:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so1546503wmo.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 17:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuCeziO/f1akcmXWJhF5L8F+TXjxxLK7gJHYEX7J3nI=;
        b=qAoioEsx98K1O1ZUhPKaGGujgXMl49PS7YeKjh1kEFeSubUFJAtL6oNf9bADne1X9a
         eNhtTwO5E2vGqMleeL+twL8dpPuwk7vcIscllEfXw4tOqNDziGPgb9VimV1KMWE5bl2Y
         qXljJgzN/ARqQMsGsZpivqkzP3znV3FgztxLLmz4CXE2Q6m6SHwX6KcMKofQvSOQaFct
         B0hUCi4BYYgxW1iKvkzGICRDDctyhj4mT/PJpagLPWMZrWOcLh1ZsWv809GZ6teQtYtm
         D2DJyC37vi52WCW9A61CnJTuEEkKQs80E+IWe6DtEH+N4nPf/LejMh8veOthbvQor8q3
         E6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuCeziO/f1akcmXWJhF5L8F+TXjxxLK7gJHYEX7J3nI=;
        b=koPjMi5iY1NABYrH+IlyJjsBgQSP7eUn67KJCCdhpQLXqPRlD8MrsDhaC9M/67Dh7e
         KshuqCvETfyzBiDLYOf6yG5upoHFbAPMAT18I1HaXGK1PdA8V0k1JcO0/VQVp4Nsq8gk
         Dj2oJljVfL6XYzdJmcThCj7ZmQ/2l7pmFS2GcQdNVPMs6CzQ9xXtgfpzueqcyIHda02n
         1mio5jL45HzrX5lKOULpBSUWXtNVwYDu4m1gvsmZFImOHL8KxhR+q4BIARPbCRuUwZ4O
         n0PhLysxFtuoA4a3Gdw1YS0/ucTHg/iZLT2ZyCKZ/oZf/RaVJfc42T7xX7TMSGpogFHr
         gBXA==
X-Gm-Message-State: APjAAAVw43caxubIVNJzpAK+qA5f41bPNnRrzuivHze/6m6gP4xrJgmC
        3XIq4YQGmnBK/BBFp1nTurw=
X-Google-Smtp-Source: APXvYqwGgkhLWDCou8axnt1PGIIfnB/1fTnfFDsr1dsnjr3Y9PsdhpBJO2TG4ULBYPAWWmAqAlLoLg==
X-Received: by 2002:a1c:a9c7:: with SMTP id s190mr2527076wme.92.1574126737190;
        Mon, 18 Nov 2019 17:25:37 -0800 (PST)
Received: from localhost.localdomain (x4d0c3ed7.dyn.telefonica.de. [77.12.62.215])
        by smtp.gmail.com with ESMTPSA id x9sm24534038wru.32.2019.11.18.17.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 17:25:36 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] builtin/unpack-objects.c: show throughput progress
Date:   Tue, 19 Nov 2019 02:25:25 +0100
Message-Id: <20191119012525.10455-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git unpack-objects' shows a progress line only counting the number of
unpacked objects, so if some of the received objects are unusually
large, then that progress might appear to be frozen while processing
such a larger object.  I just stared at a seemingly stuck progress
line for over half a minute, while 'git fetch' was busy receiving a
pack with only a couple of objects (i.e. fewer than
'fetch.unpackLimit'), with one of them being over 80MB.

Display throughput in 'git unpack-objects' progress line, so we show
that something is going on even when receiving and processing a large
object.

Counting the consumed bytes is far away from the place that
counts objects and displays progress, and to pass around the 'struct
progress' instance we would have to modify the signature of five
functions and 14 of their callsites: this is just too much churn, so
let's rather make it file-scope static.

'git index-pack', i.e. the non-unpacking cousin of 'git
unpack-objects' already includes throughput in its progress line, and
it uses a file-scope static 'struct progress' instance as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/unpack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index a87a4bfd2c..9100964667 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -24,6 +24,7 @@ static off_t consumed_bytes;
 static off_t max_input_size;
 static git_hash_ctx ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct progress *progress;
 
 /*
  * When running under --strict mode, objects whose reachability are
@@ -92,6 +93,7 @@ static void use(int bytes)
 	consumed_bytes += bytes;
 	if (max_input_size && consumed_bytes > max_input_size)
 		die(_("pack exceeds maximum allowed size"));
+	display_throughput(progress, consumed_bytes);
 }
 
 static void *get_data(unsigned long size)
@@ -484,7 +486,6 @@ static void unpack_one(unsigned nr)
 static void unpack_all(void)
 {
 	int i;
-	struct progress *progress = NULL;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 
 	nr_objects = ntohl(hdr->hdr_entries);
-- 
2.24.0.388.gde53c094ea

