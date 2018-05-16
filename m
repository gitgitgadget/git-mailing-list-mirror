Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709DC1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeEPW7e (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:34 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:47953 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeEPW73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:29 -0400
Received: by mail-ua0-f201.google.com with SMTP id 100-v6so2240580uac.14
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ddhjZPkH0aEYLu53Ttk11jbIAz28pxWXtj6uj60VAtM=;
        b=B63Q7pN1XNQOKQAYoJv9nsOE752yiOpOYQsjqVXXAEkmAYvZ3O7xYYNDFXLOgE2xZQ
         rz7VEaIyVb5K+2vNHVWumRurAw0sQ0qau/8KxhfKTp3LQMOtnPcruFMLgkAKveIRaMLN
         d1MRx6DMZBeGrcLRDdPjolwFPMo66bl83n08YgOWACEWFEy9qhk7x8KU/wrE0rHcpfS4
         eM0tPnvfl+c7ziCeuIiqvM+K/Y8MwncWrL9nNv+5NRlZfYsMdshVZIFeP59RJ+aN/MpZ
         1Zcck4UzofPwr2wxCWmj0RxF4fICibDKz+pRXLGPN6KfMjL3sz/ZyfQ1943wiiKAAer2
         USdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ddhjZPkH0aEYLu53Ttk11jbIAz28pxWXtj6uj60VAtM=;
        b=tGzCHORz2Htl5ImUCAw6WO7oSXBiWb/JHeNQz5IY38hsjJbVkrCmVpxI9SFCvAqEtz
         qAM94RFcZL1FyEXOI301HODI9ap/Ytc/4pJPDJSHtOK3DN6L9nN+HGpL4N6rWAq+54aL
         WoNDNGlzPkwY48tq8bo6z70LLg2kupZQczZzIT0d9+BI3P2gwc1HopqxAnnE9q5TTe7g
         tKPSjjOnZnFgAXEfOdKZK44pOqNEc/YXTCucPQgWLRJcs64VC6Ji/vlROUGobkOdKLlm
         Lx/95gUjZl+KxDidVSdjTr0XDVyqxcYhUMZzbk+2nwlv75CU3f4a1j3UF5kvlGDcsIy/
         Cp7A==
X-Gm-Message-State: ALKqPwfQFFZi8RfOJQ0C70IBZZXLR4WIlJS+OEkLfN/KJvhLsHL+P7yH
        1x5q+odzEFVh//UEj/v0fw2Gh0ONIm3wr9WuvqthwsAu9TLRQX4FUvaNm5ddV/xkW9Y8PYE5o8u
        m+8UPeyZoTAb7JjjgD0Wy8j3u27o4LZKnMGvt8UbgaX36Q9YWdhiZXTfLGw==
X-Google-Smtp-Source: AB8JxZrPeYp/62Z2/MlVk+eVw320CxUvdqH7NlMt6oOFh44Gxm5CSdgxZCJx6/0nBK4oG6GmMvlCrAP7bOQ=
MIME-Version: 1.0
X-Received: by 2002:a9f:3253:: with SMTP id y19-v6mr2379391uad.73.1526511568376;
 Wed, 16 May 2018 15:59:28 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:08 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-22-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 21/36] fetch: convert get_ref_map to take a struct refspec
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

Convert 'get_ref_map()' to take a 'struct refspec' as a parameter
instead of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ec54b1dfe..836eb7545 100644
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

