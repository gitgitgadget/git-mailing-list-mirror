Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D5D1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeCNSdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:07 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:41015 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeCNSdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:02 -0400
Received: by mail-yw0-f201.google.com with SMTP id q40so4767995ywa.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=08SwcEMrvkIVtzdtJtJ5eqfC7p6M1sTGWXKj07Fg41g=;
        b=foa/Tq/qsNgzR3eD32x16rTFwaRLb6GET1QfD+E/oyvAqwq1fzFwCvMpG0QpAMAriJ
         7S3UMZS49/DpKIynuCzbS5fEpIVF5Bu80pBn6YOLREEsYUc8DlnEC4e9pjrDGDWGPv1r
         8aBRGDoFtTn1cUVzmLIBR0AMvt97tMQDM4MORiDwtjch1BHZCG+IEFJriP5Dexu0fTx4
         dRXY7apJc8BRwsAIRxQMz0tl3Il6n25QBk5HR2TCM/PfcF0hCr708b4kUXf8/X1IFZEu
         3B3BDBW3L4hOBF3byMUNbh6bTtkUrN4oiRFj4V3B5W9iolrl8l1amRc483qn4KuBhGZC
         Oozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=08SwcEMrvkIVtzdtJtJ5eqfC7p6M1sTGWXKj07Fg41g=;
        b=KadfBZFYQt9sYK6umcC11gv5ci9auGoyiXSwWqBJvPqsFH5THzfg41GbWqeCBMmBmp
         2hRatcgx47DH0PTEg9U4ezfQqOdmzq8tivyvYLC30Zrxxtkdv8zggDm5q36bILGBP0Ul
         0GiLhlnGpZ0yk+MkFKvzhFQiX0vDmM9jHRxDCGDCNoA0J5tJZekdOoazFXjEC/gseEXS
         Wa0kQuhoEK0yM8vWJFN/WwPhrcXERSkU4JOI14KG65B/8tTd4mTXdq7qDlgWxzGIZA8a
         UygF+bmEhEiYFYL0LttDnJorTAuNIyi+zoAY+7QZhLYNOwH2t7Dkyfw6C6Pg+lHg48jf
         rpSw==
X-Gm-Message-State: AElRT7GhuDe3C23THQjA18wS3rk7ve7oP14IGdYGMhKI8N91WYp7fki5
        qkH8r66u/1wMBGvRALtgaZ126VZvCWi5gUSyTkzcaL4Hc4ZR747/em5BRRHwG72L+7EgWQ7v1io
        WGpEZpLQI2Z4f3YU42DdI1CdxquVo7qAUZg+Bl/AtTE5tqts+tZRXj58wrA==
X-Google-Smtp-Source: AG47ELsdkuw34o122eLA00qEX2UcRcFGVmPiWQxwdNv43+r7WYhnu8NEHM0CIvFAIaQBEZCCghMOj0wZ5wo=
MIME-Version: 1.0
X-Received: by 10.129.50.148 with SMTP id y142mr2574521ywy.235.1521052381302;
 Wed, 14 Mar 2018 11:33:01 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:56 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-20-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 19/35] push: pass ref prefixes when pushing
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

Construct a list of ref prefixes to be passed to 'get_refs_list()' from
the refspec to be used during the push.  This list of ref prefixes will
be used to allow the server to filter the ref advertisement when
communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 3f130518d2..57bdbb59bc 100644
--- a/transport.c
+++ b/transport.c
@@ -1028,11 +1028,38 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
+		struct refspec *tmp_rs;
+		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
+		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
+		tmp_rs = parse_push_refspec(refspec_nr, refspec);
+		for (i = 0; i < refspec_nr; i++) {
+			const char *prefix = NULL;
+
+			if (tmp_rs[i].dst)
+				prefix = tmp_rs[i].dst;
+			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
+				prefix = tmp_rs[i].src;
+
+			if (prefix) {
+				const char *glob = strchr(prefix, '*');
+				if (glob)
+					argv_array_pushf(&ref_prefixes, "%.*s",
+							 (int)(glob - prefix),
+							 prefix);
+				else
+					expand_ref_prefix(&ref_prefixes, prefix);
+			}
+		}
+
+		remote_refs = transport->vtable->get_refs_list(transport, 1,
+							       &ref_prefixes);
+
+		argv_array_clear(&ref_prefixes);
+		free_refspec(refspec_nr, tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.16.2.804.g6dcf76e118-goog

