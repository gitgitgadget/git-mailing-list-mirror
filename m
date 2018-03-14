Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9787C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeCNSdC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:02 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:46615 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCNSc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:59 -0400
Received: by mail-qk0-f202.google.com with SMTP id v68so2700517qki.13
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5Ud7YE9bjhoZ+yIAi8MGxgUhxRuWfAfXX6ZykoFlZyY=;
        b=I57Hy88Yd1PMR0O1iA2LIGvIZwuuI1T56mDXTHBpcHztR4lXeMifbJ5LrnEbW5g08h
         GGAR//fUw9iGZxxDQYN3GokXC1K0Ic08O/bO0BOS9ZVVK8xTSCBP8YuLLPv1pHYtKHDI
         k1B3qQ5z4Wq/Ib4Sf/9WKVLaLcudbi5SXHjN5T4UGgcnzIq+sRy2zXlSx9XHR9WUiQhh
         HVR+3CEyI1PxZujUVuZwSt7d+hlU6+qMROtceFOLOzTpmJR9BD9CsGgoRMlmlc91ltbC
         caP2EX9AoF8tPdQQ6SqkjaJZ7DzbwKC/GFK+8bfimu33Ohs+eUZ8jLQrbIzKp7BYP/OB
         r7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5Ud7YE9bjhoZ+yIAi8MGxgUhxRuWfAfXX6ZykoFlZyY=;
        b=hPQ6yzamlZj+sBDEIv20NSAgjMA5zEmoybrwHak6L9rlpwnJPcnqoSk7GlYi/lFDal
         nH4m8gPbS48RiNl3wELc2ob4CdJFCrCPycHqpjidF3hHfzawI6F7BGbF/UHH97s9r994
         RKGy93KbiyqYscswJ1zOb2eoH4c5qKWFNdQV6r++k6Wewf2uPlHTRNWycm9rBGDFpf/s
         vsQZOj/pQGjnYZ18lJrNIaZJS8+bx17sS2CHVteQVL3oxbaM6LwmW3G4SKTbxjiAyHxG
         xshkkVam6Navah9gs3uCV2+9zVkywnawue1qpHfCGAnM1Gr/mCU1aBi5L1Gr2Lbszlal
         JZcw==
X-Gm-Message-State: AElRT7GZ6mmGf5pUfvzvEbTvLjrjqe9Epx1Wdv1YOijACszx5NbbVaG3
        4nWm1D7d5074EXt0WytyoJ4HsDD/0tfsY1CT6CfRB2t1QQtJnklXHbP1yw9AIA0Hh0+B/4B49pj
        JuNr0H4CZAgiI71FoAfTDuEgIJl9wp22dxH01zbOU8gczjBL+9HVYCy3pyw==
X-Google-Smtp-Source: AG47ELtvc07pzG/S8G1twhEbAJOeBkrdjxPWXjZxkFFxlOk+6dLxRu3MIgFKz8LyFgHUsqQ7gunRmP5b6VI=
MIME-Version: 1.0
X-Received: by 10.200.17.20 with SMTP id c20mr3743349qtj.55.1521052379026;
 Wed, 14 Mar 2018 11:32:59 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:55 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-19-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 18/35] fetch: pass ref prefixes when fetching
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

Construct a list of ref prefixes to be passed to
'transport_get_remote_refs()' from the refspec to be used during the
fetch.  This list of ref prefixes will be used to allow the server to
filter the ref advertisement when communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 850382f559..8258bbf950 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -332,11 +332,28 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
+	const struct ref *remote_refs;
+
+	for (i = 0; i < refspec_count; i++) {
+		if (!refspecs[i].exact_sha1) {
+			const char *glob = strchr(refspecs[i].src, '*');
+			if (glob)
+				argv_array_pushf(&ref_prefixes, "%.*s",
+						 (int)(glob - refspecs[i].src),
+						 refspecs[i].src);
+			else
+				expand_ref_prefix(&ref_prefixes, refspecs[i].src);
+		}
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+
+	argv_array_clear(&ref_prefixes);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
-- 
2.16.2.804.g6dcf76e118-goog

