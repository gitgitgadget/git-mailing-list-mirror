Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9BE1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbdCFKIS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 05:08:18 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34111 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753280AbdCFKHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 05:07:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id u132so4807476wmg.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hEcZKUnfj0sYMJXvw9GlJFbxi94hNTxSIM1j1tcd1TY=;
        b=GNRAio+g8XFc7e8mo3L6Cs3DpHvRCxhnKJ5grxl82t3SeqGhacy4NkNWIM1oShR7Ow
         r8p5lKN+udMHq2LgsMVoZcw3goRpB/j3jROf4+HSKud6qEJL/OgrIokwPOZp1F1sP8VF
         PxdGzjiqMQvaWl3nXQ9tESUoGgOXGVP/wHE3wnEe0A0TCDNjoDKWTtxzBJ+dgLOl0Jfa
         XEWv1SzOFB8ku6Yc1S/FPnLYP+DVW1AwZU+4bufk0UVQiKAFO0A9pY08yXy9gDvS/pSi
         dwPMX7c3pcxSCB0K5+xq/u6uNr7QXMOdORTckx8CUxRx5lDdMDslc+EtXMpEGBthdf4Y
         k0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hEcZKUnfj0sYMJXvw9GlJFbxi94hNTxSIM1j1tcd1TY=;
        b=aylcqBZM6Lt5KdaZAo3McLUgwbsbj3nGqSypNZ88BA/1RH5QdZRm/eWydyT1kdvXDh
         LZ/8aCOGlXSM0w/mqV6Kzbke8Npn6wiG44Y25oMG0WzLV99mdj+m4l0GdC99Sc+2hbJT
         N2QOjVCy8G4zslgYWo8Lrju6TZ7O4dkv1fxC6RJ0doZMZHUNXa0j0Fe1oJ1up4MNDpD3
         4w6y2M28IlaHXmp3kpm7KJZtRoEaJhhbHqmr2DNevTNR1dDIfnOEDsKhOU2WBuyZjEN6
         3ptfRt3CrTraeLTDmRoewYZ4Ulh5V2WxLJ7++7eNeoVOBLcf7ofuCO1qU+VQyj4UfAnH
         5MYg==
X-Gm-Message-State: AMke39mixcrApsD1IXOSlDv0suLJN5YBf4ij0WosgKhZNN6GYsZjoV/XYM0N3Q5KSf0aiA==
X-Received: by 10.28.35.66 with SMTP id j63mr3455396wmj.84.1488793343938;
        Mon, 06 Mar 2017 01:42:23 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:23 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 05/22] read-cache: add and then use tweak_split_index()
Date:   Mon,  6 Mar 2017 10:41:46 +0100
Message-Id: <20170306094203.28250-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will make us use the split-index feature or not depending
on the value of the "core.splitIndex" config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 9054369dd0..99bc274b8d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1558,10 +1558,27 @@ static void tweak_untracked_cache(struct index_state *istate)
 	}
 }
 
+static void tweak_split_index(struct index_state *istate)
+{
+	switch (git_config_get_split_index()) {
+	case -1: /* unset: do nothing */
+		break;
+	case 0: /* false */
+		remove_split_index(istate);
+		break;
+	case 1: /* true */
+		add_split_index(istate);
+		break;
+	default: /* unknown value: do nothing */
+		break;
+	}
+}
+
 static void post_read_index_from(struct index_state *istate)
 {
 	check_ce_order(istate);
 	tweak_untracked_cache(istate);
+	tweak_split_index(istate);
 }
 
 /* remember to discard_cache() before reading a different cache! */
-- 
2.12.0.206.g74921e51d6.dirty

