Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7D41F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdB0SCS (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:18 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35467 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f195.google.com with SMTP id q39so11341622wrb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9z9hG8SVjwWWwMJdGmfWMtQcJZkcXVoxbqRzjZfyRBU=;
        b=QwJXEkeyd3p58UDvBR91eDckFZupzu4W7xrI8/6wztu+WTAgw3bdv3sWad7Y9NWO28
         6/HsWOWCBRZo+yfeI1wYPoZpeNTPB2lHKTXl+m9XL8TaIrF7mEhRmFwkvWC3QM3t9kHD
         NqwpflI0k0Xy7MrFlZ5Glg2S8mzp0OTsecsMVzmDQSzPlQuI4tgM/aApBPhqOaL90eOn
         K+70sbJruINOR2QX8sJdaoVMYKoi/2QPv77Zk+5vxwd7+h3g+GvjEeRS9JVvktVBLNcl
         f0Ebm/1OhAsXjoOCuv9LdEmR4R8UB5MuGS823It+6qOFNI9/ywFyVaax6vocoNtiI8iM
         XgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9z9hG8SVjwWWwMJdGmfWMtQcJZkcXVoxbqRzjZfyRBU=;
        b=BCwJKExJx/Ki+aCXPkbCfzAtiF3mZiHzNxfcOv2sJP2c/zGXuoh9iLIj893gJuLipz
         X6GcwPp8W3rNHFxwRFCmik1Nr2XloWgH9Cr5ReLIRid1RCmXHg4dCMhcwOw0o2GZmch0
         SDU/OcnsUmPjaMKRBjTL09TWmmcvej46utJFg6d80OrARM/0Bm8IhsN5SGxCA7fJ97uH
         xVs/3jkKTtgO5PzcNbITf7daVFZMLaF0DVYu4QVaXu6xJBMohMuCPAC/EA/ygWLo2As8
         qG4Uyp3m8H0pwNiofzy5Lsdw1cSbVWqHvMA0juMFogEyyHaEq5OX3Ayd96X8BV9DgnAr
         Izgg==
X-Gm-Message-State: AMke39mtMq9sb2Z79YQDFfVzM6rEx26FvqhvONaMwR/GEhZl1dQXrYJm248tWT16eiU5CQ==
X-Received: by 10.223.131.103 with SMTP id 94mr15439669wrd.115.1488218444110;
        Mon, 27 Feb 2017 10:00:44 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:43 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/22] read-cache: add and then use tweak_split_index()
Date:   Mon, 27 Feb 2017 19:00:02 +0100
Message-Id: <20170227180019.18666-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
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
2.12.0.22.g0672473d40

