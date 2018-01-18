Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCF21F404
	for <e@80x24.org>; Thu, 18 Jan 2018 10:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755564AbeARKJQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 05:09:16 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38414 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754962AbeARKJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 05:09:13 -0500
Received: by mail-wr0-f194.google.com with SMTP id x1so17757266wrb.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CMDuUcZl2qkIXUjvtDoR5idxox0PaFHge/Q//Wn8Ck=;
        b=Z5ij1qT+owplQCsVT7h7puCMBaF3r6GigagkkXLgegJr0hImMuiySeoXbtd530raZg
         9m1V436a+IYQHoiAFQoSqIUV5slo0ukrtRiFAJtZKdlorllB7u3GgOcprPEN5w0SeNAW
         8MncgWaQOH1/K+GKLSkxDWWqJsyFmG8Ko1Jt9WRANtee+y2K7Uyl1802kc4hKbZOQM/8
         Uzih0b0HdybYsKs4GKcZlp6l3kKfpTgrEENvLfyLtlW0hO58Hyn/SMDUOl1vPNMZNriZ
         JOJhTuwq21Eve6Vrscnu70fDikB7zrOXABfYg3QLscYEE+LkHAKQ+I3uoTaYt9bWOCA8
         Vl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CMDuUcZl2qkIXUjvtDoR5idxox0PaFHge/Q//Wn8Ck=;
        b=pg2bfTcYiF3xjaOxEpoC9/sGhlAQM3hWtyUM4Cw9oLv8MyFrnt0Z3nPsUxLW5omwUh
         9F+W7YWBFSKDC5W4AFU5Jxg4s/VRzf93HAOxrkVoHoKxOxFZ0UBcTIVuy1N1syU+7a7E
         NUNLrSQ1zusGwpX4ZVf3R402RIWIOvJZi2LVwQkRQgGSb2gru7IueOdeGP495GDpv1UB
         a9imU5OOozGO7TTRmBtR+IyX/N4dTjSXl3stlrlxcDdUo8WTp8QQBwFlUmM5silsd/Nu
         iTYVS/3hG3oI2CICaRmSdztY6BprQJdPkHIvYGX5m1zxPxkhuTVl6nWRO7comlHIzlog
         aKyw==
X-Gm-Message-State: AKwxyte0OdRoEjDUXt1hH+LOXJgriuKu1x+tHDxQuVux/6666ExGJgP1
        CU3yKavvlecUA1H49WD/ZwqTBCYm
X-Google-Smtp-Source: ACJfBouqpRC5bE6HEFx8ZEReHsa6QlEumgQcN1fxWqOhICL/kmxUOJ28EHaKpozJqrErdcHr/N04+g==
X-Received: by 10.223.132.68 with SMTP id 62mr4587790wrf.173.1516270152503;
        Thu, 18 Jan 2018 02:09:12 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q7sm6332969wrf.31.2018.01.18.02.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 02:09:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/2] sha1_file: improve sha1_file_name() perfs
Date:   Thu, 18 Jan 2018 11:08:54 +0100
Message-Id: <20180118100854.22467-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.3.g7330290b09
In-Reply-To: <20180118100854.22467-1-chriscool@tuxfamily.org>
References: <20180118100854.22467-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As sha1_file_name() could be performance sensitive, let's
make it faster by using strbuf_addstr() and strbuf_addc()
instead of strbuf_addf().

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

So compared to v2 I just removed the call to strbuf_grow()
and the related computation. 

diff --git a/sha1_file.c b/sha1_file.c
index f66c21b2da..4f7f17a24c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,8 +323,8 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 
 void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addf(buf, "%s/", get_object_directory());
-
+	strbuf_addstr(buf, get_object_directory());
+	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
 
-- 
2.16.0.rc2.3.g7330290b09

