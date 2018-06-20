Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB251F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933628AbeFTVcy (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:32:54 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:53441 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933482AbeFTVcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:32:51 -0400
Received: by mail-yb0-f202.google.com with SMTP id w6-v6so574883ybm.20
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/h24oyuxM2V8NCPhp+lH9L8hKy+56c2asvXItV85aEE=;
        b=PjuRTXloRQgQGAgM4E29M4QXM4eC7Dncj4844pa2IQD25AbAz3mWgiD5HsLoDkqk/q
         Nclm6WMl3lOzNFDQ4/kdXtFUuvR1VqJVyEarPV46GW8WG/5mQCLAz7FknejWLVltxpba
         QgnMgWjlSaX5fQtmRo+QQIQqNqWsD9Lzcn3UhFq4f5Azws6qDrTdQxz3I/vw4zGtsNpz
         dk92+1mlNfJ8Hj9AyOvEfbJcNp9ofo3ntd3huq40x9jfBVx5uP2NLng2DotuLBL2lglA
         Zz3n9vrBIPM4VcSZX8tlDJYF48zg5eT1fIUbC93f33/0jzJpMx2GA6PAdfF43gbLmKfF
         Tzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/h24oyuxM2V8NCPhp+lH9L8hKy+56c2asvXItV85aEE=;
        b=koNPCIeUxjQpqrDPn9QkETVJEciph75XRru0F6pSxBEJ6PN6KiCbH8CEORkSqiZ9JS
         di5eD5SH2+792E5dTWnA2c6pkkOGj04VuNQJKFSv8+L2RxU4Wh71dxPZvSWO+yv3HQny
         Y0ta4+QdWlSBo/sg30OAYsY89/IuGcjamWH24/EUTg98884aOVAmTGIyuwieVBGUDsu3
         jZXIB/cXWzW/I73NnkTecX5T6ooiY1ZZZnX5Am2yd2RDb2OBNLFvOUyyOPOygcIwOJTl
         zYAA9Bilr+Fk9nQgxPE6FWSiCUngphKCt11zrIANi1Ka5gr68YHO/Q58G/mfS8mrPWJX
         5H2g==
X-Gm-Message-State: APt69E2SRrMoEXR4q2qKQnvThy2FCr/UcZnKo6O2Q3Y3PkMm5rc5etoO
        HKm84+lP1cPIyOgxhyY9PKo9RahFXwO+irRoGwbvhNPZlfcmtf+sj+6hqZ8kgpQhvRjdW9OK/Tg
        BN/7Yc93WVuMfBPsvrl9uGDjnTms9iPEj8s/L+paJMOsymhOGsTxmbkn+lg==
X-Google-Smtp-Source: ADUXVKLzDfRMXu7hLcKpn4PX6cCci4kyF7J7/LCuB2hRwmHx6KpbqRKJD//dnot1pxFXkIN3y6qz+RKDJIk=
MIME-Version: 1.0
X-Received: by 2002:a0d:e9c7:: with SMTP id s190-v6mr7117836ywe.108.1529530371144;
 Wed, 20 Jun 2018 14:32:51 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:32:31 -0700
In-Reply-To: <20180620213235.10952-1-bmwill@google.com>
Message-Id: <20180620213235.10952-5-bmwill@google.com>
References: <20180613213925.10560-1-bmwill@google.com> <20180620213235.10952-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 4/8] fetch: refactor the population of peer ref OIDs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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
2.18.0.rc1.244.gcf134e6275-goog

