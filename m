Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F7220987
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756285AbcJWJ1U (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36719 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754826AbcJWJ1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id f193so5232264wmg.3
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtaYhUIjcUmDAUUbuksm2jydR+joorNXST3QOfAOUEc=;
        b=F91oSLcxMASphnx3TQhie2+iUgRXvf3dmQT/0bR9bYb3X6vqIjS8bdbQTLSuvNjTIN
         bK79njm1+O2urCefrPETJpmsiiPMdUwfx0+WwVl460lALlhht63ryy+by9BPB7AObcZS
         0b4Yz/6CH+MFOTBnp3Hq6Yrrji4t8sRtX2uXGtIuouKWN86rCvcoT5mHg3huSGNvoLqO
         MjsQM0MU1RJaC9ZiOyH9oFp6Ib2nN624hYkTjBNTaMqxI+nTH9GiS2DACtU5MjUDbMYv
         itg6WIPanv4Z0iRKXGXqgkpTrYIJebcMLYce8iCQNc3tkQL3h4wL+fwkLp1S4Rzk/Ly7
         cg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtaYhUIjcUmDAUUbuksm2jydR+joorNXST3QOfAOUEc=;
        b=jdDqAoXeSEHVF5fRz+UAXZtpcob3zdAdaYxptSEzU5k1cF3COLQ+llg3Br6uMCuo2u
         O8nkZWV3ZL0ScMHcGmh7Z0QlFrnQM417aHfWOhq5DuozDEdl9rNC2hLvy/olXbuUhLlH
         DM6AWLXiS0c0QGDB7yeUz5nFE4Pgt8UavYvx0lBNGii0/KROZXyUiszMsevv2AynolzT
         65JST3CMMO1NBRzzQK0q/UDWHHmwQSuiV1UguBczibopXqTNpV0BvEIXC81Yr1uX4/Zx
         Z1CevZp2KGZg1OaJGt8Yog7FFQdoIHP3SF6Z3TFVl4XdsFlfm5ofUwL7f+hKi2kiLtfD
         WT7Q==
X-Gm-Message-State: AA6/9RmySjAyidknQim525iT+v/zdZFPalwfd7FjIZCYldbKyJrXF0nmKxNJqDR9T18urQ==
X-Received: by 10.28.154.77 with SMTP id c74mr16847869wme.23.1477214834289;
        Sun, 23 Oct 2016 02:27:14 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 04/19] read-cache: add and then use tweak_split_index()
Date:   Sun, 23 Oct 2016 11:26:33 +0200
Message-Id: <20161023092648.12086-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
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
index 38d67fa..bb53823 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1562,10 +1562,27 @@ static void tweak_untracked_cache(struct index_state *istate)
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
2.10.1.462.g7e1e03a

