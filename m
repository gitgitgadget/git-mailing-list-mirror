Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C9F1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeENV7R (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:59:17 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:42900 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeENV51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:27 -0400
Received: by mail-vk0-f73.google.com with SMTP id g76-v6so17198976vki.9
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Ddj/8QXEmPDOxr8d9YC4WIXAtIFlfV2Yr6yGV9pgUHU=;
        b=exiK6CSpEf4+BcnCb1bKqTzesT7W/y0U18jFT2SLOJ8TBJVQGbvv4R1XElCjbS+Vjw
         mZMjR2pG2C4wdv2WmyZfjBC9EVHkHe5kS5pWsiT6ZwXxUyzOaTYogawmBIiok1yDnijb
         LXE2y11GGz5k6nWPR1DAZsKEli0l3ZHYd1GTZzUfsWVfFfMs//Vu+cvABA3X2pNoXP27
         seMcml2d3Zf9U1NCpwhKNATIt7jqkDeoudPD5MmVvE+zLqF8+a0sQCewe+9oDJnxl3gh
         cgbHRiQtCpmBbjBW/gICCwSMhJjqLYhYgCBdv2/V0NRfTH4WkFe7d12Se7P/7t6sxO7V
         sclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Ddj/8QXEmPDOxr8d9YC4WIXAtIFlfV2Yr6yGV9pgUHU=;
        b=ObUMtF412Z7pmwp4kTNt08bWL5jEFjcQFvNhe6ZY7RK6y/6YV9JprkH/qCyRhsXXAD
         sQscpYNXbXj8MKfUoPiPKKGPGBLh8clscBKFKCj67SuacinMxYz51tzne7ikgItXOmGX
         RS/r0jFkjXKAhKjBFBoBX3kmUyQ+JW6NgFTdsVIxSQL8ddCNjXs3Xe21L4IJGA0R1jMR
         49HGPTl/cM+IviHw0B3S0up22y29RRN3m50ViO4dPz75fmT5RFI4fFK0wE90NbU67pmu
         DKMQ78lx0C8OTgkU4vDlk5bvnxPrHr7m26WOlOBX2zl2xXkNLxE7cqJmr1VymBG0TrTc
         oWkw==
X-Gm-Message-State: ALKqPweht2biBQoGxdA3vcJE/ttyEEG3OvpYAb/Ukf1TFfdyB40Kn0Kq
        MXqARJD3r1NR+C/AgvkfePDbZ0JIGhYpEAQZTfzJpLrOC0WZU+CHsriM1LMN/GIu9U5tE9GZ9qx
        hdg8yv9+wj967PEdOf+lfhmdfqfrM9ktgRmIqEdZYT3mdN+fRhzCIF9Vqcg==
X-Google-Smtp-Source: AB8JxZr7zFhshau1VLRUtOaQIXvunFxfOdGnIiPHNFmbuRcJPYgBbuDG5jEBln8cOY7ck+j1QPxZha0PXQI=
MIME-Version: 1.0
X-Received: by 2002:ab0:4fed:: with SMTP id t45-v6mr12728670uah.36.1526335047147;
 Mon, 14 May 2018 14:57:27 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:11 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-21-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 20/35] fetch: convert get_ref_map to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'get_ref_map()' to take a 'struct refspec' as a parameter
instead of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 733feb19c..86a7f103f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -337,7 +337,7 @@ static void find_non_local_tags(struct transport *transport,
 }
 
 static struct ref *get_ref_map(struct transport *transport,
-			       struct refspec_item *refspecs, int refspec_count,
+			       struct refspec *rs,
 			       int tags, int *autotags)
 {
 	int i;
@@ -351,15 +351,16 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs;
 
-	for (i = 0; i < refspec_count; i++) {
-		if (!refspecs[i].exact_sha1) {
-			const char *glob = strchr(refspecs[i].src, '*');
+	for (i = 0; i < rs->nr; i++) {
+		const struct refspec_item *item = &rs->items[i];
+		if (!item->exact_sha1) {
+			const char *glob = strchr(item->src, '*');
 			if (glob)
 				argv_array_pushf(&ref_prefixes, "%.*s",
-						 (int)(glob - refspecs[i].src),
-						 refspecs[i].src);
+						 (int)(glob - item->src),
+						 item->src);
 			else
-				expand_ref_prefix(&ref_prefixes, refspecs[i].src);
+				expand_ref_prefix(&ref_prefixes, item->src);
 		}
 	}
 
@@ -367,13 +368,12 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	argv_array_clear(&ref_prefixes);
 
-	if (refspec_count) {
-		struct refspec_item *fetch_refspec;
-		int fetch_refspec_nr;
+	if (rs->nr) {
+		struct refspec *fetch_refspec;
 
-		for (i = 0; i < refspec_count; i++) {
-			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
-			if (refspecs[i].dst && refspecs[i].dst[0])
+		for (i = 0; i < rs->nr; i++) {
+			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
+			if (rs->items[i].dst && rs->items[i].dst[0])
 				*autotags = 1;
 		}
 		/* Merge everything on the command line (but not --tags) */
@@ -400,16 +400,13 @@ static struct ref *get_ref_map(struct transport *transport,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr) {
-			fetch_refspec = refmap.items;
-			fetch_refspec_nr = refmap.nr;
-		} else {
-			fetch_refspec = transport->remote->fetch.items;
-			fetch_refspec_nr = transport->remote->fetch.nr;
-		}
+		if (refmap.nr)
+			fetch_refspec = &refmap;
+		else
+			fetch_refspec = &transport->remote->fetch;
 
-		for (i = 0; i < fetch_refspec_nr; i++)
-			get_fetch_map(ref_map, &fetch_refspec[i], &oref_tail, 1);
+		for (i = 0; i < fetch_refspec->nr; i++)
+			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
@@ -1136,7 +1133,7 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	ref_map = get_ref_map(transport, rs->items, rs->nr, tags, &autotags);
+	ref_map = get_ref_map(transport, rs, tags, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-- 
2.17.0.441.gb46fe60e1d-goog

