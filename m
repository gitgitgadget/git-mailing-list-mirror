Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6828C1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966479AbeF0Wal (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:30:41 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:43149 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966421AbeF0Wah (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:30:37 -0400
Received: by mail-ua0-f201.google.com with SMTP id v17-v6so1037830ual.10
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NUQnRLO+bVRauTOp8HIaWoIliEAQgF0LV6d37s7DdbE=;
        b=UlEt9UvZGM7KgCX6rvt7wCqsSTEDjjc/80SMhnzc/zeHGMgZl5Rfdl2AlyxApGY9G3
         CambOk9NkuuPvHhFJ/wAU8uBjTUT79LeyiP06nMKkybBT2iUD4LYwzgIopWPWB1l0Va7
         WJRRfIh/BwbABYBFCNHCzdX9qYZ3vBwEgYAGske2HPf5GBmjr3Dfn5htMxv5b2R1lt/u
         9IxMUTjlEjZhl3opCYlr3faII5dr3uTBwZAuc5s9PCjlaOT6vNXLk3PyVeI/Lreje6xR
         hoMfr+UMGKpRBkk0BdoiJpjcaLd1+28PAvNvHAyucCxd8wHQGRKcLjEih+OU0uUlruXG
         /Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NUQnRLO+bVRauTOp8HIaWoIliEAQgF0LV6d37s7DdbE=;
        b=Wm1qwcErJYGLz4+tewLvanz0MXTy84jP0tWeYT5E4XSlUjYK7xJQkjXX4ekCWZHecH
         1IdecifWei+JUZ0L1+1/k4+z8hDym8IQ48Xxlqt+okeEIeMsO14Psd0RKNPWYtxO+Sf2
         Cto/SKIKnzvlGNsH2ozzvbMqWfsdOHyQCXh6//5oVOrC+nN0H4AagafOxH9D3XQWA7qh
         w2RH9i0iUd4EJofL860SZh35CBvZweWO1ewxZV/9rQjYFUnyVE83LZp80H8E7IPA8Z27
         sMLmjlW6agzjm7hPL2A2JAIhu1UMVDB82GGScBrnl87QYjPLX8CoZXH64e5k6cijU+BS
         cUcw==
X-Gm-Message-State: APt69E2IwRRVsNYh+sngmWMc/gVh4Z7QksGh8dEJHnBM+NazW73gGibf
        K/VjPJQwHDLflvkVURyHTMgW/oa3vtCwLVaEcGeLBb0WynMY4T3JYx52lyy84TP2WPWY7vx/SAR
        WXqgQQJycpY6exiRHsBeKctSGUw7+H25QKY6vDKgNzVnBGGkB1o4cyC1YTw==
X-Google-Smtp-Source: AAOMgpeh461HZMyi4kVvizTdjUd74xExTAmrsWEuAQaUX4MMYoQWRranShH1MxKlE+BwW7nQXNdG1rBNc5M=
MIME-Version: 1.0
X-Received: by 2002:a1f:cf41:: with SMTP id f62-v6mr3445132vkg.29.1530138636266;
 Wed, 27 Jun 2018 15:30:36 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:30:19 -0700
In-Reply-To: <20180627223023.49659-1-bmwill@google.com>
Message-Id: <20180627223023.49659-5-bmwill@google.com>
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v6 4/8] fetch: refactor the population of peer ref OIDs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Populate peer ref OIDs in get_ref_map instead of do_fetch. Besides
tightening scopes of variables in the code, this also prepares for
get_ref_map being able to be called multiple times within do_fetch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..545635448 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -351,6 +351,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	const struct ref *remote_refs;
 
 	if (rs->nr)
@@ -458,7 +459,23 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
-	return ref_remove_duplicates(ref_map);
+	ref_map = ref_remove_duplicates(ref_map);
+
+	for_each_ref(add_existing, &existing_refs);
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref) {
+			struct string_list_item *peer_item =
+				string_list_lookup(&existing_refs,
+						   rm->peer_ref->name);
+			if (peer_item) {
+				struct object_id *old_oid = peer_item->util;
+				oidcpy(&rm->peer_ref->old_oid, old_oid);
+			}
+		}
+	}
+	string_list_clear(&existing_refs, 1);
+
+	return ref_map;
 }
 
 #define STORE_REF_ERROR_OTHER 1
@@ -1110,14 +1127,10 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
-	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 
-	for_each_ref(add_existing, &existing_refs);
-
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
 			tags = TAGS_SET;
@@ -1136,18 +1149,6 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref) {
-			struct string_list_item *peer_item =
-				string_list_lookup(&existing_refs,
-						   rm->peer_ref->name);
-			if (peer_item) {
-				struct object_id *old_oid = peer_item->util;
-				oidcpy(&rm->peer_ref->old_oid, old_oid);
-			}
-		}
-	}
-
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1183,7 +1184,6 @@ static int do_fetch(struct transport *transport,
 	}
 
  cleanup:
-	string_list_clear(&existing_refs, 1);
 	return retcode;
 }
 
-- 
2.18.0.399.gad0ab374a1-goog

