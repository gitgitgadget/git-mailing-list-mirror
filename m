Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF8F1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757291AbcLQO4L (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:11 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36662 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757113AbcLQO4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:09 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so18022335wjb.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FsxNvw74ZrpvEx3Wlttc2UQCKSJcAo+eOf1n6lLxlGA=;
        b=E2jhd5U1NjcSO9+zPFKGKKd9gVQs4OXAg/DN81/HeBB9HRX5RzTnr7v8EQAd+ilfOV
         02IUIeqxU+NuN5H3nx24Entu3PflBlwqOFFS12yoCf6pKTZQQ+QymqPMkaAkS6EVxXga
         5/b1WjWCfH4jbh274C+9A/VLG17PmT7CGFfJAi1CK47j7ISQoO1rF55ubDyfFrA1PUKt
         Vqc+xP8PeltulbHIg7dJUU3QxpUnsfCC91iGqpTil23ntgnMRsIPNMPAnWlG9FU7Kj/C
         92e4LgzsgqDhLYnvv65YshCJyZT9WLedBwOeUnioF0oftuU26AXxiobpry1VrgZJ3+4V
         xbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FsxNvw74ZrpvEx3Wlttc2UQCKSJcAo+eOf1n6lLxlGA=;
        b=GM5BNATkjO4U0Xc9ASKF0yzXYjpB+OXdtNxOwrvX6Zix5hOMXkitF7WoL4wKTpUfw7
         J/byxcyIXGe5O1ATja4oNCAYJyBQ/1SXbFueDNPn46AxrH0DJyDvyLtgVKdqkntJgwcn
         ctZZLg/ur3lU+hUOinCp4z94UjllbT3QGU+pv4gJTos5nLijWKcai62jdu6J8VXdfL2/
         eM4UIxxM0eJAwaFmvmtAxYEN4CvZZzfv0jjE7u4ZwQjtMx6d1dVfyYKt697fgW1O5E+L
         qVM+BE8k16hnOEigsEdhwmv5eKdgAiPRDe6eh8DXoTzsIaBf42bDuBqITM9/bTnGeg3k
         Ykng==
X-Gm-Message-State: AIkVDXK00b67feF0iLUhETG79KHLHsiO/VbND7iYzGkNwokDnZzVST0pR9xl+H31oaP10w==
X-Received: by 10.194.113.2 with SMTP id iu2mr8159252wjb.32.1481986567595;
        Sat, 17 Dec 2016 06:56:07 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:06 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 04/21] read-cache: add and then use tweak_split_index()
Date:   Sat, 17 Dec 2016 15:55:30 +0100
Message-Id: <20161217145547.11748-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
index db5d910642..79aae6bd20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1569,10 +1569,27 @@ static void tweak_untracked_cache(struct index_state *istate)
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
2.11.0.49.g2414764.dirty

