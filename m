Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB4F200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbcLZKWp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33070 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbcLZKWj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:39 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so52473428wmu.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aWAd9NegIriVnoKzgljo0PQJhGnv1Ov7TO9X1snnuXk=;
        b=OkgMQ4mVRl+bAHmbt7DXVZxSSb/chaIOWs7Y+5eL2R4SYpqYf8imJUWjW9U5uODuDK
         iNhwn1pm0xZg2iunxVLDGwa0Pjxkr3GyDPQ8U0fC5DAwUoZYlldGqUeeP2mL6aPIzpFW
         7nAs98S0p8fedKyxYC38vyj4j7w1jQF3KcSm5iPPL8zO6jtGmrTEP7gq9DTvt67DUIvC
         PAY2H4t0WBXIjxeAMeYXB9mxNOaKZ9c5ma1iSYG9RuIffaeKKDueVI9d8WwRvVC6c7g3
         6G4TaubDMjZfQZfn0jiR/6Fa6O7XS5hI1IOpzWdhGI2LwYI7rWTC/12mpqeDyYK3YNPC
         NyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aWAd9NegIriVnoKzgljo0PQJhGnv1Ov7TO9X1snnuXk=;
        b=jy+LgvAmdxXwsIwft95T8JVdLbL/aV0gLHxkmgB5/GOJCkH8CMuk2uYenx7lb+PNlj
         nYULOKieLxTgHIUCWnZyHSFOMJNT1RyppHIiYG+0OlTPZFbLyhCGZ7SgbQzEmuBQS3bu
         Jby0/osmnMESTip4QjbfSGnuiP9RWWGyySrIbP40X50g8t8TvGoAZ789gH5NDYr4c13r
         XMeRup7V1yfxEdxedyK91AHIlfWjNQcyssP8FlwVViKqY/9LBw4hvhHTIzdpj2fhpHB2
         O8KUte67C7mDxU2k2deB60gPChPE/mlNH/fjthJDerWDL5DY/DL17faIwmMr9nwp0jMJ
         h3yQ==
X-Gm-Message-State: AIkVDXK3jN5Qpe2JZmljYpKl48UB+l+uv8qGZVUzgsj4yg8x9sGw88GwEqlzXnrG7khTEA==
X-Received: by 10.28.126.146 with SMTP id z140mr25031189wmc.84.1482747757613;
        Mon, 26 Dec 2016 02:22:37 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:36 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 04/21] read-cache: add and then use tweak_split_index()
Date:   Mon, 26 Dec 2016 11:22:05 +0100
Message-Id: <20161226102222.17150-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
index f92a912dcb..732b7fe611 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1566,10 +1566,27 @@ static void tweak_untracked_cache(struct index_state *istate)
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
2.11.0.209.gda91e66374.dirty

