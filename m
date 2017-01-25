Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202341F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbdAYWDi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:38 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33885 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdAYWDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:33 -0500
Received: by mail-pf0-f176.google.com with SMTP id e4so60771468pfg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=duxflppJH1RBZ4EweHJ8MiqEYoPN1WRsrLSeIP4b054=;
        b=RoeShfWjnsPoH1XLgB0QWTs0hRsNKVBG2ti4rMG+Y4ChhwQAgTamkSzdvZdK/ar8I9
         aFdjBL8T5IFNfLGIr12FQgvVOigWkhsIVhoE3tz5Zn4Q3BeZZdHHHxaz/QSqnEmtQxRy
         qhHJyMD6tIV7smGoITgelCUTQ2vy2+SHP+zLHNQo8Hm6oXsMquKP8a4bP4mjbLXHkqST
         721H/9gvhF51s4UAAeCRnGQrkt0CS0bKhw9EhZ4keM2iYDWtMDfGLiJIGByB1Gl4hsbT
         CiSYagtCXeJcRQPe6lGsK9bL8Rco94KPj61TNu1u9qu9bgTyPwgvaO2GwHXQCwQLsHvr
         JEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=duxflppJH1RBZ4EweHJ8MiqEYoPN1WRsrLSeIP4b054=;
        b=O8+q7JHG6nGSrraYPWyVSsMJEDdyJnRRdZ+cTCSUiiR4FTkNKihuS6Qy2fk7zKJ8pM
         SPXC2GuhRoFPlKD5k4vA+t6MbrDjGhGgTiCNUt6BoQwW0IRy6jSg6hHMLvrjJ6AMx5zf
         JwznkgrO011rqtx3lrXptwi6U8DRVuT7yPTSlusLx2jxFNPGD+SX8AxVaeZasO1fzbLs
         RDl8z5uqAIKKm0AuVbBBG8nef2i+z3aWaANzMlBWwDWl7EBY1mBGYOg4A71LuM6QI/Bp
         iDFUxC+T7+pM8VJoNBupDVzL+kaohq1bMuPKTpJEOL1tP/Zihau9juFlBnCgvKDnOR3U
         QSog==
X-Gm-Message-State: AIkVDXL24t/Iag4TTkp2F7qVw/tQN4fbs+qZ3McBar6ciixOoeWQHOYG69HFLwsNn4aBjqBG
X-Received: by 10.84.192.107 with SMTP id b98mr6888538pld.160.1485381802332;
        Wed, 25 Jan 2017 14:03:22 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:21 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 05/14] fetch: refactor fetch_refs into two functions
Date:   Wed, 25 Jan 2017 14:02:58 -0800
Message-Id: <17158edf664fc85ae52da66e3de9210a2a645f14.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the fetch_refs function into a function that does the fetching
of refs and another function that stores them. This prepares for a
future patch where some processing may be done between those tasks.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c71d5eb9b..43e35c494 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -918,10 +918,16 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	int ret = quickfetch(ref_map);
 	if (ret)
 		ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
-		ret |= store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+	if (ret)
+		transport_unlock_pack(transport);
+	return ret;
+}
+
+static int consume_refs(struct transport *transport, struct ref *ref_map)
+{
+	int ret = store_updated_refs(transport->url,
+				     transport->remote->name,
+				     ref_map);
 	transport_unlock_pack(transport);
 	return ret;
 }
@@ -1062,7 +1068,8 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_refs(transport, ref_map);
+	if (!fetch_refs(transport, ref_map))
+		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1115,7 +1122,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map)) {
+	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
-- 
2.11.0.483.g087da7b7c-goog

