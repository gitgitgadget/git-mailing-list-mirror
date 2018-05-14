Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58E51F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeENV5g (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:36 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:41736 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbeENV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:32 -0400
Received: by mail-it0-f74.google.com with SMTP id m12-v6so16903548ita.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/HsM4qyqquJVsW9BCPkYc1b9JHUCbv0/LesdLTm6EKo=;
        b=NO3qBn4A7VTGQ3pXOoSyQZqgobLe0h/JrI7DRPqkw5VWJvDFaauavmIQc5t1BlRb9V
         wFisnfKWpj1f9owbE28gHyF8CFg8uUkH0PK75Wc7AVAygcDa6YQYTw2qjvV4jfxgFENI
         1d/vBOeU5GoqdwiOYek4q1RAhBeigBafNBcn4n1Gv9V13biX73s72EpSKit+gNiu9nvs
         h/Yz36EGSd3tlVTQ9bVCxvZZNrpx8/2mgLUn6X5oGiVF8jef0bkCDP4bof8ksgW9UwZE
         bkI8Vh6oaSW4NdexzWakCPbpSQUDG/QwLHnYXIOLp4rTFxQXqaJzwctes0kSK/CeiPn9
         L/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/HsM4qyqquJVsW9BCPkYc1b9JHUCbv0/LesdLTm6EKo=;
        b=iEYt3lBgKMVe5coYIKYvKSXP8erf7//0VibPahTh8URDynfnNqRZQv19NElXAkpw4o
         5tJRZqghCzvQ9+/cZM6WmyHPMu2nZ1oR3Mha0QpsOv1mLjtRuPshX0Cb29UkHSoMqovS
         Y10EQZNCsqWsHPJzPr2H1e0JgtdDZ4472Z5DasgmEMgk8X6S99VuHT9o9SrdlhXhhGyt
         lC8xCWVIR8C5SciWPUjih6M+RlzfX9fFZQAyjPHOEZrH95HvLAGE3aAAJjtMLzetpi0H
         6O7Agk4EQQDkuu9afGxq+7ju8/XVZrY6BNzGJVVcgGxcNhNUaCy7Jl9VEgTM42y/TtOx
         oNdQ==
X-Gm-Message-State: ALKqPweYPLRc4hS3CrGddDF6SKjuWky8AIO4yq1ku5HnKa+8/EKAoGpl
        Ai1BseQNuVpdEv2YfPlMysqdeV4/Mwez6PjKvqHzrUgi8agD3Lprw7Um/FbXgl4I/S8d+pzkLMg
        +nX6y5zk0B5k8cOITXGbQ9iQEiHgJ1lF43PXbjNm4ClRxFVLzkabcljEu3A==
X-Google-Smtp-Source: AB8JxZrBEQkVfalqgfKMWBOqbag+yhn9ZQATSVn3KlU4GP0+SON9VVltD6lTNqJpnBsu7kEeIAGOjr2hCqY=
MIME-Version: 1.0
X-Received: by 2002:a24:6883:: with SMTP id v125-v6mr13607824itb.49.1526335052175;
 Mon, 14 May 2018 14:57:32 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:13 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-23-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 22/35] remote: convert get_stale_heads to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'get_stale_heads()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c  |  2 +-
 builtin/remote.c |  3 +--
 remote.c         | 18 +++++++++---------
 remote.h         |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eebeebfd8..af7064dce 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -963,7 +963,7 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
 		      const char *raw_url)
 {
 	int url_len, i, result = 0;
-	struct ref *ref, *stale_refs = get_stale_heads(rs->items, rs->nr, ref_map);
+	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	char *url;
 	int summary_width = transport_summary_width(stale_refs);
 	const char *dangling_msg = dry_run
diff --git a/builtin/remote.c b/builtin/remote.c
index 94dfcb78b..b8e66589f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -347,8 +347,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs = get_stale_heads(states->remote->fetch.items,
-				     states->remote->fetch.nr, fetch_map);
+	stale_refs = get_stale_heads(&states->remote->fetch, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index db1e4edb7..f2e97c545 100644
--- a/remote.c
+++ b/remote.c
@@ -707,7 +707,9 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
-static void query_refspecs_multiple(struct refspec_item *refs, int ref_count, struct refspec_item *query, struct string_list *results)
+static void query_refspecs_multiple(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results)
 {
 	int i;
 	int find_src = !query->src;
@@ -715,8 +717,8 @@ static void query_refspecs_multiple(struct refspec_item *refs, int ref_count, st
 	if (find_src && !query->dst)
 		error("query_refspecs_multiple: need either src or dst");
 
-	for (i = 0; i < ref_count; i++) {
-		struct refspec_item *refspec = &refs[i];
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 		const char *needle = find_src ? query->dst : query->src;
@@ -2077,8 +2079,7 @@ struct ref *guess_remote_head(const struct ref *head,
 struct stale_heads_info {
 	struct string_list *ref_names;
 	struct ref **stale_refs_tail;
-	struct refspec_item *refs;
-	int ref_count;
+	struct refspec *rs;
 };
 
 static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
@@ -2091,7 +2092,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = (char *)refname;
 
-	query_refspecs_multiple(info->refs, info->ref_count, &query, &matches);
+	query_refspecs_multiple(info->rs, &query, &matches);
 	if (matches.nr == 0)
 		goto clean_exit; /* No matches */
 
@@ -2119,7 +2120,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref *fetch_map)
+struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
@@ -2127,8 +2128,7 @@ struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref
 
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
-	info.refs = refs;
-	info.ref_count = ref_count;
+	info.rs = rs;
 	for (ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
 	string_list_sort(&ref_names);
diff --git a/remote.h b/remote.h
index e7d00fe2a..5ac7536f5 100644
--- a/remote.h
+++ b/remote.h
@@ -267,7 +267,7 @@ struct ref *guess_remote_head(const struct ref *head,
 			      int all);
 
 /* Return refs which no longer exist on remote */
-struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref *fetch_map);
+struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
 
 /*
  * Compare-and-swap
-- 
2.17.0.441.gb46fe60e1d-goog

