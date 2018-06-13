Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E021F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935867AbeFMVjr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:47 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:44215 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935845AbeFMVjm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:42 -0400
Received: by mail-qt0-f201.google.com with SMTP id n10-v6so2939252qtp.11
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=v6KqKVGtO3eRaiT5YFpe/qvERYWd7/kbwm2vskVZqP0=;
        b=gMb8ZPcTz8v/PL0QzuDuVjjPw+/tgYXBHN45pRfonxlGsoNwAcSXXht7T8XXaPZkDf
         ozRZ2SC7MWAY31sJK9DVI7DoY605oidR8EAcclsAU9Vj4mjYqr9Wkn77ZIup+UJT/PQe
         b3IULhBb1OWZAsVGYNQgsoQI3awJ8fY24jriN+FHK+0/Y4+0RWdcLvCNsx0x2QjyEqSm
         EPx5ts8jeFAT13VNzeROVy6cTNdyxxbCAxiPMuDVMUx+dcbR+SxTN4MsEx9j7NfYTjAG
         aV5kanmoxHndHn6UiAlmKlUswEedNL0cw6n48QQRY869g1rX5n9MZWjFvT+uDtoN91PG
         5hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=v6KqKVGtO3eRaiT5YFpe/qvERYWd7/kbwm2vskVZqP0=;
        b=nQlIPLzVCxANnGJYsN6HYAtObEhPAUWD2/uJPc7GplGU83Ry+hDQSHwG9RSIkOZFjt
         /7o91gcfu+wkckpInyOk3WIWxhpmDRAgTs8VrdKBIipNowIiVUy1N8Bz3B7BHlBWKRAT
         zft//0nagtGc9YJ+QlpDg2gFp3PPpkSOEPSaXJTgctn9FC3pL1Xm15L3BNELuZ3xNRk7
         9ULZV8QLMGYbKVhJoV6wSdo/8D+kBs0NLwXv6kdWrv87h8ZX789JiKwHRN89A9DDSG2d
         NzfjOSWQ8WMzgwwrsfEyk4c86LlyYM25ZCdOxduDIAh8GQcdedpJqSQQGx8uCO51/0rL
         7KmQ==
X-Gm-Message-State: APt69E0EFsribiYqMTkgfjgZPgHObgSCg7QkCeoVvuZwAvD0fBjPDct9
        p9lf1IeYUi4qn+Qti+zku0FytJAyi5b5Wgj041hJO8zyuf/JxPlpIX/x6tw9RWrNxZHMsOHZzZ2
        KZyzFTv5vLPFWduNF5z20wbQTO1L0fgGemVKuVHOuBPZFVn4F8q7M8B5zbQ==
X-Google-Smtp-Source: ADUXVKKJ1Or/c1xSasQQbeZ9KEOzIVJqMo3ai2p6aU6m0UOAuG2mItoGZpvKlyHoljh4ndmPQ5dKqZHLlTU=
MIME-Version: 1.0
X-Received: by 2002:a0c:9809:: with SMTP id c9-v6mr3464728qvd.48.1528925981406;
 Wed, 13 Jun 2018 14:39:41 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:22 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180613213925.10560-6-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 5/8] fetch: refactor fetch_refs into two functions
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
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
2.18.0.rc1.242.g61856ae69a-goog

