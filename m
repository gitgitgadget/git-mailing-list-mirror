Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A7E20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdIMVzP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:15 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:45321 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdIMVzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:08 -0400
Received: by mail-pg0-f50.google.com with SMTP id 188so2800448pgb.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GACxGgMAEATnnJ2KWxU98IT7j0IkgfFqVWGjmDiJOh0=;
        b=huRKSGemYo1cmDuX8sx9gok0y3yhQm9gejzkzn9e+pReJkHfMrpuzTMm5yLyc13YRF
         slk0Qo+Nq3j3nM/an2BgSps0pCyMKnAHhv/8fsmysYRTt/1gNZ27GMLRqba563kvvQGN
         lxbLLQQL2OnRvD7UvfNDAH/wWRmK40MGZVJCbpDYO6GfShP1p6GbbXWTU/5B7hul6WZU
         s5at8E8jXTQNuiRrAr0wHfGWjF5cFrr4cU5srN9J2qJMIOkAE8HOdBNpHWy+kNuIChhH
         dudzhs3CotoyjCUdqO7K+sJ5AdxQhEUrZZdvmSo4f3gD8AMGGroFnlZKZuAI/7eovYao
         eAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GACxGgMAEATnnJ2KWxU98IT7j0IkgfFqVWGjmDiJOh0=;
        b=a87w75T/M4qFUigAEvkN8UFdbh+NArFjq0Rl7zt+eWrxeCpbqNd3X7URKgsgsXVOHg
         VtvMAq5D44cBonsQ78VI3O8ngq+Wzpb5047NLsNZXDINDnupO6S3LtQPBx+VhrlkfRem
         2GIMHrWxXI0Ggfu9sKlWIiRx2vwJNBMdohrsQ76Ndkfy8M8GI+tpdRHksp0Hj/lwivfC
         UkMr8gz5h3suOmQ8T85EQMN7URAYhdzcZoebb1G/pk/ERu0HkyfRM3ddV7UyYfP+Skl5
         lmdMOSCHLzWEoIaLWXAV3UAiBr8wpCqkurNIcy04bJ/UTDiQeQiJGMS45GLDhDYdfdjP
         /G+A==
X-Gm-Message-State: AHPjjUhnZ7x7UPnGBNlfQ0QUDH/N25hFDcev3JfhTbwLtxhlQEPDMqV1
        /nMg+ovyfI1QMAEuDBNQlQ==
X-Google-Smtp-Source: ADKCNb5wdiuYeXQZ1s2qR3B5FPTgnq0Vo6x/ZgeFXlM2x2SrNezoWTbT4sWX10robb4ah/8jK9CB/Q==
X-Received: by 10.101.89.11 with SMTP id f11mr19545169pgu.393.1505339707536;
        Wed, 13 Sep 2017 14:55:07 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 5/8] connect: teach client to recognize v1 server response
Date:   Wed, 13 Sep 2017 14:54:45 -0700
Message-Id: <20170913215448.84674-6-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach a client to recognize that a server understands protocol v1 by
looking at the first pkt-line the server sends in response.  This is
done by looking for the response "version 1" send by upload-pack or
receive-pack.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/connect.c b/connect.c
index 49b28b83b..2702e1f2e 100644
--- a/connect.c
+++ b/connect.c
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "transport.h"
+#include "protocol.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -142,6 +143,27 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		if (len < 0)
 			die_initial_contact(saw_response);
 
+		/* Only check for version information on first response */
+		if (!saw_response) {
+			switch (determine_protocol_version_client(buffer)) {
+			case protocol_v1:
+				/*
+				 * First pkt-line contained the version string.
+				 * Continue on to process the ref advertisement.
+				 */
+				continue;
+			case protocol_v0:
+				/*
+				 * Server is speaking protocol v0 and sent a
+				 * ref so we need to process it.
+				 */
+				break;
+			default:
+				die("server is speaking an unknown protocol");
+				break;
+			}
+		}
+
 		if (!len)
 			break;
 
-- 
2.14.1.690.gbb1197296e-goog

