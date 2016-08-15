Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD16F1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbcHOSk2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:40:28 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34609 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcHOSk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:40:27 -0400
Received: by mail-pf0-f176.google.com with SMTP id p64so19193395pfb.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 11:40:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ixCMFHi/wTruRf82pQUqo5DAwLV4+vsvE/MIfxrik2s=;
        b=mGJeB1ZjokHPy/ukqRnchtY1oKouSbYSQU1rnBjWlSXUUCwRzT62P8SmJjbDPAZmgj
         XqdTT4ASzKPv8PQ2G0Dp9izeKo0+2sv+6DEhiGXpZZd/K7aDOydrB8o8ZOBQ5dOsq0l8
         jOuMJI0WZ+jDNZIqbV7n365DQoSvMJDyEMX3pyZFGHxvB/OgsbZc3QxFiJYjJFiplNJh
         c9Szw9cuOXZHDQ8knFp1HysflQI1oNu+5Uh+dfMOZ+U8ZAR7d+kQjDgBQ6nF6xhhh7Dp
         OIAz25CnMrETmXsI8Ow2ogaS5RGjB/1thg9xY5ydhSMD4p9lKO5QloM/t6G5txvTAuCv
         lupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ixCMFHi/wTruRf82pQUqo5DAwLV4+vsvE/MIfxrik2s=;
        b=TdrwtxliCeo0P4y0puSOwkAb33q63Smpi3uDyotqdOzs8mQHZXpXgKtjwI1+GIetqC
         mmDpVEGRlrEttLa9ZAsTbz67lU8+H1OSARTOXGBH6eiOs/JybzMdg1Ad7W0PwAMtHRwH
         ShWqyHXNL2ajFJob1DCO/ZAkChNMBdGQApiBcvhbTgzbKOz1nkKaBYPh0oFIcKAdhoN7
         Xttj6PE5s9506icusKRGHAh1QhZSUNkYvmGptHNjKgjFytatzyurrnB+iGabDTglHYko
         W9C6jf4V2pMyQxpAGSyPjdDJ2esihs672J87K+Z2cBLOWRI3lkigOEmOzdlSiYqxRroG
         rSdg==
X-Gm-Message-State: AEkooutboYDMxAdZcko7BaH5Al5xwLVrAPb/tzo6tUgErJcVTqKGON2qGFsGrNsx3wcA5z8Z
X-Received: by 10.98.111.133 with SMTP id k127mr55901106pfc.90.1471286426869;
        Mon, 15 Aug 2016 11:40:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id w64sm33120379pfb.93.2016.08.15.11.40.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 11:40:26 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	jrnieder@gmail.com, peff@peff.net,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] advice: preset advice preferences to -1
Date:	Mon, 15 Aug 2016 11:40:20 -0700
Message-Id: <20160815184021.12396-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the next patch we want to make a distinction if a the advice was
requested explicitly or is set implicit. To do that we need to have
different values for the default and a value that is set explicitly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 advice.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/advice.c b/advice.c
index b84ae49..56b70b6 100644
--- a/advice.c
+++ b/advice.c
@@ -1,20 +1,20 @@
 #include "cache.h"
 
-int advice_push_update_rejected = 1;
-int advice_push_non_ff_current = 1;
-int advice_push_non_ff_matching = 1;
-int advice_push_already_exists = 1;
-int advice_push_fetch_first = 1;
-int advice_push_needs_force = 1;
-int advice_status_hints = 1;
-int advice_status_u_option = 1;
-int advice_commit_before_merge = 1;
-int advice_resolve_conflict = 1;
-int advice_implicit_identity = 1;
-int advice_detached_head = 1;
-int advice_set_upstream_failure = 1;
-int advice_object_name_warning = 1;
-int advice_rm_hints = 1;
+int advice_push_update_rejected = -1;
+int advice_push_non_ff_current = -1;
+int advice_push_non_ff_matching = -1;
+int advice_push_already_exists = -1;
+int advice_push_fetch_first = -1;
+int advice_push_needs_force = -1;
+int advice_status_hints = -1;
+int advice_status_u_option = -1;
+int advice_commit_before_merge = -1;
+int advice_resolve_conflict = -1;
+int advice_implicit_identity = -1;
+int advice_detached_head = -1;
+int advice_set_upstream_failure = -1;
+int advice_object_name_warning = -1;
+int advice_rm_hints = -1;
 
 static struct {
 	const char *name;
-- 
2.9.2.730.g525ad04.dirty

