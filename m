Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A801F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeEPW7d (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:33 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:52225 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeEPW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:31 -0400
Received: by mail-it0-f74.google.com with SMTP id n83-v6so5273016itg.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=WvRmU3bhh4ltPfnuKVxk9XPS2h1YvJU6zwTf0oo1sQc=;
        b=bNuHU54KkCMFNxoCYXhzLWOR3KWOoQzNWfwNpteD1JRGnAvKRIOatAXUeciEV1GF6p
         iA7EM5N7Aq1pOW+a5gAifvAmO0C+oua2jAaWGMstGEjbUDpm7oPX6iTH4KfxnjZ7rYud
         s9UrtTkcAPb4uf9xze8vVS7nYiY4DJYqSdQxVZePBoT1L9HitbTxujuAWrltqwAVVDAS
         iYyeZD3RiufxtDfI2BFR62GHIh8m12AqWhXPr+ICJMcNRNClJ8TY3AqqbJQ4aHbW8vpL
         VYaCjGADmAe+RudzocTonHGHcB5+Vrg901IcFdvxJft1Ct6zY8oqJi3Sgb/Ax3jhVpeT
         Q5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=WvRmU3bhh4ltPfnuKVxk9XPS2h1YvJU6zwTf0oo1sQc=;
        b=lNwfMus1Vj0Ha0JK5sW1QAnSHPUDfJ3dE/mt/rlRey6BXHHUGKXxN0CNpRD4n7VE+R
         F9Zj7q6ahLMEU3H4sVBRKadQ8Fz2i9/KWDMmSdzDCTifXFLem2rHJv9f4U79nX6EiR0H
         iSz4aFphAl/izCuOPTh/rgN1Q4YBNZOGxFbp2vR9YcSBHas/IL9Idi29pg26kAP4NqGC
         1m9zWzi1117ofjTamJbAXIvjiHTl+p/hHkguhPHD6WZsc7nTVC5IIGtno/c/JcGRUfD1
         jY/mEeSrzmpsEFlHs65HfXGx/c53+zTIMSNaI+4iKDY8uiUk0C8bAR71dNrvPDxuFMP4
         VFeQ==
X-Gm-Message-State: ALKqPwciUpDTC6gBcfNV/DcBki58U4/QwfT4EpkhMA4Nl1z0ti3xEzG9
        vze+0sz3RTKVUv8WEii2/rXsKEA/8lJoboY5OKxOLEHn6lu0Lym2vJB3fUqXhGrVXwuPyeLga9d
        isJRmLPrzQViqVKBAQsYAdGVHxjY278KuuOUVYCZ4K93op4HSj67YfKQY8w==
X-Google-Smtp-Source: AB8JxZpCSoST1993/X/s+DPryoJMi013OLa0LjsmzSToHVFJ7YpBBJBFyniNXqqKQ0hxvSZCWH0+1MJyTbQ=
MIME-Version: 1.0
X-Received: by 2002:a24:758d:: with SMTP id y135-v6mr199871itc.50.1526511570555;
 Wed, 16 May 2018 15:59:30 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:09 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-23-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 22/36] fetch: convert prune_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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
index 836eb7545..5e46df70c 100644
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

