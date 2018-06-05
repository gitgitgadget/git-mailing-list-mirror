Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528DB1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeFER7i (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:59:38 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:54064 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeFERwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:07 -0400
Received: by mail-yb0-f202.google.com with SMTP id i3-v6so2445828ybp.20
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=flzHSwaXiolpmAAu7YcUJ+uGBvpAB8eVri6wi4lzA9w=;
        b=giDJI/SXpVaSQObQB0Q5xcnITpSzASFC0EKoSA09PvPD5j9DGN+/o5Sgjo2q13Tss7
         dM6H1I5rCqlJY3RmjV13aR6zaNi1+1nykfSsZIKAj9MoHvEgf+zsGouiN6p0yaDlXjGE
         JeMXOt9TYqeqsQEbWQft2Kqx+IRdAd5wCdMTdMTc7JBJ/8CuVTNfwXCfVZy6BFdGVq9C
         O5zrSjeZcLzTzGVlebJDOtlD4UULgICfNbLygQc9gQ47rdA/RP/kutg+Rk2XkX0IHtJ4
         bajTp36x58vT/XPNaRB0+S1JMAkkNClal1MezBUNFYcbWJs0QtFfyog2ZECK5DeOSj8S
         DQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=flzHSwaXiolpmAAu7YcUJ+uGBvpAB8eVri6wi4lzA9w=;
        b=hMhd7H8Yhl7uulK+23lKAms/SWRrENIEJdHucGl/OreIHX/l/y7XsI/6Xh/Bb5W+Hb
         Bwt/QL3FYbQPyq0onqA/+EG0xbL3b3pZY2qAEmyXPISXA7hX1MuIuEJCwgZn0wqV2+km
         734GMU8x/+U7cHJOuPpV/AD6NwT2VNh7ttf3mNDrLv4N9D2pXkGy0eyaEZPX2bD/Rc6M
         PqhBNd3cvdv4RuZ8dL0yFukD/ddaTQJG9b4ZVCYyu6uiETxL4hfRPPcEo78DDeO6AD32
         maGHMH5C78coX/RfHF80qFc3FuKC4CnV4U6YSxrIa7KhuQnxALPQtfCwBsWsqGqntior
         qmeA==
X-Gm-Message-State: ALKqPweY4a6zTCWeoSzkZm5pHvaD371YuQyeaUKQu+Zrk5ZFIUAPO5Eb
        dIeJiozcaomINjE44sTmKRtGkTUwigRL9o9x0XNwU0w2b2t1w+6TeYRM99dkSjISdR6P/qz7/Ow
        sLGzillbAZAzD/0H/5dBN96tDETaTJWcHzE5AHUHqDnDdOC7jg+EtGj3aqg==
X-Google-Smtp-Source: ADUXVKL3OFLFrrWJ/D4YuWHXG4GLFx0ABM2sLsFg1QaERcPy4CUNZ9QHy5y7GrTGyipPQCV1cPcUUv41c7o=
MIME-Version: 1.0
X-Received: by 2002:a81:9dd8:: with SMTP id u207-v6mr7320481ywg.194.1528221126604;
 Tue, 05 Jun 2018 10:52:06 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:41 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180605175144.4225-6-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 5/8] fetch: refactor fetch_refs into two functions
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the fetch_refs function into a function that does the fetching
of refs and another function that stores them.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 545635448..ee8b87c78 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -967,10 +967,16 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
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
@@ -1116,7 +1122,8 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_refs(transport, ref_map);
+	if (!fetch_refs(transport, ref_map))
+		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1165,7 +1172,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map)) {
+	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
-- 
2.17.1.1185.g55be947832-goog

