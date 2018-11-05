Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A461F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbeKFEm2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40080 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbeKFEm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so9118091lji.7
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qatiNl8QKaG3lkfKpQoM3l0J9ZHS5LyX7vBRzqHhuSw=;
        b=I/SV8cqkFD5XGz8MoKAw91pDLnBwMaz29du0kdRbxGS/1PAYM7cJb+uAZncD+XcrKg
         LNRJfGdgv6RKrXN8jHqKnIBFDPhvOm4mbA3r1TBLE3fWP2xTrw6AeFK7h1MzJHRskP1v
         pEfhTfaA6MCTuHMc1oWv56qw5frK7CLM5IvXIoDyIM3ZXhntosvp7Hb49W28PUQNwJrJ
         RY2KNlQKKkJTgZz6KDLQr/0dqrwonfVZjdVWMne0H0wT33ptyB5vryM6kWzr4eD+vQGZ
         6J51nG+ZCJWuO+f1zHkqZ1WDL4m5cBf5lPX3p0wppKcpi32dBQIpDXH9nlzcOSF5toUf
         5mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qatiNl8QKaG3lkfKpQoM3l0J9ZHS5LyX7vBRzqHhuSw=;
        b=LitUycdkYJIdSduqQIB+Gi21wUOHJ47f+J70rChVedAdgtgN14/XTjGtFIlQTlzZuf
         xDT/OAS2mJzFl1RUcFuG4bb3/d8d4pWMFmQmjR3sfaq1YXGTycM7ADadhHQqcLdk6jdV
         AwF9gIoxgzvMrbWD6EEairieufKZO0pxFE10ASNCg3o0c9Nb8PEI9p6lIftvSoioh9uG
         +uBCbqF4xeVTqoX7DGu7ZALcWno/738rGwlZy0dTs76mctfw4aKI1WZQqqZWUVimPQw+
         DXyowractZtNKphZlvsFihZ4TWZyZ19Wbk6spwqDIZWWitNzzqW12zKiz80gAmk4aDVA
         uJJA==
X-Gm-Message-State: AGRZ1gJODxuSHfhHVftP36Woo/eWOoJvdSIhdhBJlC6iNZV8o7xKee3y
        RGnhaPlAyXDkK3ULZWSrw9vjm8fY
X-Google-Smtp-Source: AJdET5c68hi6rT7y+R5tYDqt4TTgA9R2WWaHMsEQm9xH3XTYB3vX6d++Gc+q2FJ/GipFCsmqWtjs+w==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr14896348ljj.165.1541445678245;
        Mon, 05 Nov 2018 11:21:18 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:17 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 09/16] remote.c: turn some error() or die() to BUG()
Date:   Mon,  5 Nov 2018 20:20:52 +0100
Message-Id: <20181105192059.20303-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first error, "internal error", is clearly a BUG(). The second two
are meant to catch calls with invalid parameters and should never
happen outside the test suite.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 81f4f01b00..257630ff21 100644
--- a/remote.c
+++ b/remote.c
@@ -620,7 +620,7 @@ static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 			 * FETCH_HEAD_IGNORE entries always appear at
 			 * the end of the list.
 			 */
-			die(_("Internal error"));
+			BUG("Internal error");
 		}
 	}
 	free(ref2->peer_ref);
@@ -707,7 +707,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
-		error("query_refspecs_multiple: need either src or dst");
+		BUG("query_refspecs_multiple: need either src or dst");
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
@@ -735,7 +735,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
-		return error("query_refspecs: need either src or dst");
+		BUG("query_refspecs: need either src or dst");
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
-- 
2.19.1.1005.gac84295441

