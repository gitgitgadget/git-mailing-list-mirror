Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C981F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbeFTVc5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:32:57 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51862 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeFTVcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:32:54 -0400
Received: by mail-ua0-f202.google.com with SMTP id f7-v6so337732uam.18
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6EAfL1tgHk5AJRxEbqHukSAazmTJw583Oi/25iVg5QA=;
        b=dVVp1A8JGI/K+0v+hotruy/lDV5825rr2QoZ79r7QCfSYteur5p5CfO2bfm0Tl0Jub
         ww1ahye9g4scSAbFxb4jJov22d5SCtjSjLk2koEiN9uSZoMnNec962F6yDk6GzeBSBqK
         uMzXQ/9+8/gVfxO5IbYbzuYa8j4J34xUSSLLomVysrizX3zx3dMUdTcwJS+N7+goZgcd
         Ms+OCHyoXAV+nq09Q0zWhDrG8uCyi1++oDDFGIIXJRTTk+iE1c+uVVijQvMazKa9gUV9
         3rQq5i+1OGhdHrVz5YJvlMJE2P1DG4jEZyNFCMYikVnP28iyveJMmmnIwtIsOQZ+WHRL
         +d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6EAfL1tgHk5AJRxEbqHukSAazmTJw583Oi/25iVg5QA=;
        b=OUNErZAYhJ6yNUZ3ZmwOg2wRbsGzJghkH7n8g/8B67T8gVJVeGLo9Q6DoF++aSDAky
         RCGvWRVQW/uBm5v/AejNAN6OxkE0NBVpfemdCpHPFhK8cBLgaHk/edmI5OsfYMhxIm5d
         dytJ5/kIGVCab1DVjct8QJ4o+ZfJfmpAzTneQGnhQL5Xc13A4CuPMi652UfIk8uQKhfQ
         SRdHBA2X6EqKk0WWV/6HIOeJlEck+LI3FtaE7Ce8cIj2s1twURL0wOuS2c5HcD2h1oxz
         Qe7yRMctap0OBU77v8YNKbjgVap4FlcfIiZltnQpQeJSV/Ob94Pm9CZVlmS3ZL4NhRN4
         uTcA==
X-Gm-Message-State: APt69E2/zvnLrwRqTc/HdLEMkDUP+lDw2lBXPYqSPmSeYMulIUXM+zgh
        P9kgRy8rMWW7Y6zHO2MdHJBFYOj0YheeJ5zi0o/1A/Xq/c0Yd176kZa/U3/x1iS+3xktrevCrKz
        b9P0M3O/6DpNICfO/NSOfutFI25wEZ7nmwCorI2CnFaLMXxpn0FhJvBxqdw==
X-Google-Smtp-Source: ADUXVKLNMH6VYBoYS1F+z+Y2jOPZj5iSyh+9/tiss0u/UvqHxExxYhWGZMNdWhSD0r9OdVbt88SOqRtlQXY=
MIME-Version: 1.0
X-Received: by 2002:a1f:1d4:: with SMTP id 203-v6mr9987728vkb.101.1529530373394;
 Wed, 20 Jun 2018 14:32:53 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:32:32 -0700
In-Reply-To: <20180620213235.10952-1-bmwill@google.com>
Message-Id: <20180620213235.10952-6-bmwill@google.com>
References: <20180613213925.10560-1-bmwill@google.com> <20180620213235.10952-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 5/8] fetch: refactor fetch_refs into two functions
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
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
2.18.0.rc1.244.gcf134e6275-goog

