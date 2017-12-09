Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94CC61F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdLIUk1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45847 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbdLIUkY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so8219228wme.4
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QKlEcvUQHd2Ze20hb6dl3tKdhndJ5iD0QITzDpQE6XE=;
        b=HJl8LJAy87vRuWxb1wBVFIvGZB++NCIygYrI05VLiirynP2CHG5umrydnG8VL7pEOT
         x0H/RUwj3c312QsBu4H9Zs5LaW3aBcDRATqA75BO3mIIKEsZA0ZePHhDA4qqVj6BBg2G
         wmY2vMr5xKnZT4cDiD1tPVUNxvnsl8/x7IVFpL1tEkJi1zRRdpfMMzUpa2F94ZZZS56T
         W+4qdZhxlLEAlIiMr6lhTlekMQpjcde3PrnIUAOX3C3DeV0KVLjfwlYruROxU6N36wT0
         yYaf/AnzdUBiGZhy/+sjkAFIDrL9tuf05oIDxa4GOEmk9Ng/touPJ2E+eURDdwJ+gwjh
         YWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QKlEcvUQHd2Ze20hb6dl3tKdhndJ5iD0QITzDpQE6XE=;
        b=Gg5PTggLIqeyleh5H+kxEluwQabZPyRiPp236RtM3mFq0t3fAz09v5DFl76RcDSOiL
         1iuCBJJpzj1B3qDEKhlLLretJiki5hfJIzA9xt3X39wXOV7mXwWib1zPOSWKFag3FGsr
         bgQaghhfVyOq88H9V7Zem8qoVLaSDwS5Cu1gBBnrpjHuHnzD4ggUZSwYoiEjZr8NPOuv
         CqUeW28dO4GXUt9ZtWESgPvBq5jEsioz+KrF0OKbOgCOJ9SVum2dUXExK+AEUsjZLRWS
         KJHmKAXnSHxeAXgNMZQLFAdMqpFVR808n5yoKDsDamutDfpt7yyh6Aad1m9nrItCPeNQ
         wKHg==
X-Gm-Message-State: AKGB3mKr+nYwn0jYlGwonG+hRA4T1CrHEiuDokzKv8K8xiiSnVbUzZ5X
        +hsg60mtKtrIaffG38XBWQ0xProQ
X-Google-Smtp-Source: AGs4zMbe5Tb9ZYeqjTq4SUtGKASpjP0aAEy8ug8socHtu9g9Ig/+YS63DmUJu6MSYkpGmwFHc8oo6g==
X-Received: by 10.28.2.198 with SMTP id 189mr7188873wmc.69.1512852023472;
        Sat, 09 Dec 2017 12:40:23 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:22 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/7] index-pack: use skip_to_optional_arg()
Date:   Sat,  9 Dec 2017 21:40:08 +0100
Message-Id: <20171209204013.10997-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify index-pack option parsing using
skip_to_optional_arg().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8ec459f522..4c51aec81f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1660,10 +1660,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				from_stdin = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
-			} else if (!strcmp(arg, "--strict")) {
-				strict = 1;
-				do_fsck_object = 1;
-			} else if (skip_prefix(arg, "--strict=", &arg)) {
+			} else if (skip_to_optional_arg(arg, "--strict", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
 				fsck_set_msg_types(&fsck_options, arg);
@@ -1679,10 +1676,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				show_stat = 1;
 				stat_only = 1;
-			} else if (!strcmp(arg, "--keep")) {
-				keep_msg = "";
-			} else if (starts_with(arg, "--keep=")) {
-				keep_msg = arg + 7;
+			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
+				; /* nothing to do */
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
-- 
2.15.1.361.g8b07d831d0

