Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662031F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeENV7H (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:59:07 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:49583 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeENV5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:30 -0400
Received: by mail-yw0-f201.google.com with SMTP id l1-v6so5799244ywm.16
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3pnknpfaFV35rEp4jc4iU1eX7nHXf8sbGOwy/ToelFg=;
        b=WgIvLYkFkj8yMyS9nDL6Sgic5tnW1Nl2WP319/HrJRdcAyXNIZE4gpQSx49oYv0a0Y
         5PA3uXF+tvQ9M6PBaligdD/FJRdp0OhWP8ZYmTuPHsQiqKkt5v67lUGY0gQsd323JrEC
         57xpogeLaHRFO0e0DF6tihNmry0roImkXAFkosW/FuN2vev7b7gZzOJ2NwC3UHrbClo9
         l4BiftLcCgGklmbUbzzcNgwfpz1QA/xdyQGW58L5Z83QJlrY5rIblnGbZ52i8cij74Gs
         L3qG3d/kWEBIBoSipYZ97DWkGtv1sM9d81jl5IBJQ2TBmPvn6HtGRjGWMfUzhsVf7b2F
         A8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3pnknpfaFV35rEp4jc4iU1eX7nHXf8sbGOwy/ToelFg=;
        b=KTvkHEPmIJRg7oyPzBGyyrR4bVafIj3+1C/jjSaJz9wulIbKWsd17r9qg/a8WrsEan
         CZEu/qgou19pA83cqr1z0m+TAB79RL+f1aEih58P3C8FqEP0eaRsDGn6msK90ZNTQ85f
         h7frUAczXSPFe4VAYRqpdKpns11/Ubjhg12Q6WwqZ33PAidGKlOrpxFW5RspPTpKQ0dT
         32IfJ6tFJizv25REf5SYvWFcJ76g7aHz69T0+RIWRkavhChixA9gh1vhP6mxzvOVc7UA
         neL32g7JXuj/P6SRs/KkGp1w0Uwn0ibcZprU0jh4cX0l7RpzjoByJFQW5gvfx62+eUG8
         RzKA==
X-Gm-Message-State: ALKqPwdC0OUAtx7izauyi4U7ssJyOFnpkSlwDR7nhLxYJJBTPuYP3Yk2
        W10+1vyXH/UJPReH2It9plev14ZjNA53Pp1FU8UUU/jnS1Xqo+paE/zipl9cMsQyyQCBwrr16rU
        bymHfBVirWSneLXEzPPVicQ49d4Do/I7gjmLm25ZZCgBYmUXrFdyfkb4tjA==
X-Google-Smtp-Source: AB8JxZrUbXgCiSoQy6vMecueSzVmCKltMHoF6x2eUF5uWvFnlOWf7bm+ybdM6wVTAB067GAKR1P4ayfpg6I=
MIME-Version: 1.0
X-Received: by 2002:a81:4ecf:: with SMTP id c198-v6mr3434530ywb.33.1526335049747;
 Mon, 14 May 2018 14:57:29 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:12 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-22-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 21/35] fetch: convert prune_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'prune_refs()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 86a7f103f..eebeebfd8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -959,11 +959,11 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
-static int prune_refs(struct refspec_item *refs, int ref_count, struct ref *ref_map,
-		const char *raw_url)
+static int prune_refs(struct refspec *rs, struct ref *ref_map,
+		      const char *raw_url)
 {
 	int url_len, i, result = 0;
-	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
+	struct ref *ref, *stale_refs = get_stale_heads(rs->items, rs->nr, ref_map);
 	char *url;
 	int summary_width = transport_summary_width(stale_refs);
 	const char *dangling_msg = dry_run
@@ -1158,10 +1158,9 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			prune_refs(rs->items, rs->nr, ref_map, transport->url);
+			prune_refs(rs, ref_map, transport->url);
 		} else {
-			prune_refs(transport->remote->fetch.items,
-				   transport->remote->fetch.nr,
+			prune_refs(&transport->remote->fetch,
 				   ref_map,
 				   transport->url);
 		}
-- 
2.17.0.441.gb46fe60e1d-goog

