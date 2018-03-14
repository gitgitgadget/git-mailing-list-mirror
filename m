Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08DC1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeCNSd5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:57 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:44209 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeCNSd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:27 -0400
Received: by mail-vk0-f74.google.com with SMTP id o7so2592115vke.11
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HWf7rp9Kd9JsKEnT01jiv+/+t2DwaLTapU2wnygV5V0=;
        b=XtTiQO4TKwSf7TqE1E221fRC3DQG+PBtrp8C89FIEJFox6e04v6Rsv4okGQndM4MGU
         XqIRz1CynpppARcNkkO/xCfwoJUeJ0ghmkjDgjSaQaUGbd+g167qTLWtHc6WTrekYgWT
         FS6PAtrYXL45YmLBWVqEFojy5eBkKHWyAqXTXft84FLt1Xp0wdAJ8COjUT/8M44RliKx
         BKGKvQ1BIRghWbOO0Aky+VqQnXVsQdirkqndI43nlGVZYJfnF1PoKl1P52WKLTawOBpL
         a5du7MFBdW9GxQdUWsIHY42+AEkAs/6GuDVGUna1XDAgVT+Q8fd6V9zuYX6EqOqKKlpv
         b0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HWf7rp9Kd9JsKEnT01jiv+/+t2DwaLTapU2wnygV5V0=;
        b=Ynx3fwGWJ1Ez3eXFOE9JN4Dl8MKe9AR0vHe77NNhxhNut4SuBz/HCIwKDWErDkoCFR
         S6RjP4trym7+MCPSyA2AqJQBYguQSyvttTEMN2jYNWrlBNvonagJJh23HFgvy5UOfdIV
         wdsqMVEv9FdyANwHFqkBpOfY/Rnd4qSyA1TZj4ll3cVTkgLj++gzoUKZbQjK9+AeToi9
         whEcbtjXfG3h4eotLQRxBPAeNG4eqnZniZpchWV2xqll7RyuDqgK7YLNPzwp7dbzI8FD
         Cp/9IRSvEggvuRGNK8XOLYZQPRu8lgmQ+0fGayuj3etH+X6xwKLKr4GVRjowiYiWoU5l
         tO1Q==
X-Gm-Message-State: AElRT7Gt0sopycdtgy4tp3GFj2f4oci6LDBeTy/RH/WmpItc7DnfXL3G
        glN4XIO8sa2sT2gDBmZXKGmw+2N8deBFlxxjSh6lEuKfapKpqy/CyjBo+FGw5nxa267OQZg5FRY
        TdmCT6BulJoth+wQbiubGqcT5SKnZmerRwMAKv9hc/RhgT1g9BxMdhHdojQ==
X-Google-Smtp-Source: AG47ELu+a2RjYy2uWfkDAN08Y7McHp/89yDnWus8Sc29959pL4ydwPuPUfks3V2WcVITd/fqrKjgwwfyggg=
MIME-Version: 1.0
X-Received: by 10.31.50.133 with SMTP id y127mr2446992vky.93.1521052407020;
 Wed, 14 Mar 2018 11:33:27 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:07 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-31-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 30/35] remote-curl: store the protocol version the server
 responded with
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store the protocol version the server responded with when performing
discovery.  This will be used in a future patch to either change the
'Git-Protocol' header sent in subsequent requests or to determine if a
client needs to fallback to using a different protocol version.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4086aa733b..c540358438 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -171,6 +171,7 @@ struct discovery {
 	size_t len;
 	struct ref *refs;
 	struct oid_array shallow;
+	enum protocol_version version;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -184,7 +185,8 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	heads->version = discover_version(&reader);
+	switch (heads->version) {
 	case protocol_v2:
 		die("support for protocol v2 not implemented yet");
 		break;
-- 
2.16.2.804.g6dcf76e118-goog

