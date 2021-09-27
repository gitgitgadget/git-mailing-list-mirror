Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1DEC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7256D6113D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhI0AzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhI0AzE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:55:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77043C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d21so47128633wra.12
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dg6GYy6HbBWn0USRl6X59Z+OS9auLjx9r0A8/hv+zp4=;
        b=n1Pq33ch4Ok8+aJqu/Yu0JnscS2P7E1ReMLdcX+ykC4gSAGPrx0rgFu8aIPfWYhk+9
         fN0/akq3+gpgdS6vBiTqhsIbY26wmF5L2du859IEU9fVCLbPP14n6a7WbeoHKyEhT/li
         FbP9zWIqeRwVG6kDanGWPb088lmkZKhkNmTgTpw6LBhX+dyQDJibxdntDkzw9/XnAgJ4
         1G+yohcaDB2OR4Yg3jqhr8D6+HG8flmuTkOj4IndDHW6QrhMjmOVPWwjgVjiMSprQ8Gk
         u9DSLbMZq8nPHmd3voZtQaY3ThRnqFwDrX81yBRFDvF4sMBVQuljYDy3UfFHqtJzVEJC
         gnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dg6GYy6HbBWn0USRl6X59Z+OS9auLjx9r0A8/hv+zp4=;
        b=rSVR4gTqkvUZGL9ZetcbPL/+1THTpO2IuGMUMj5gAJI5Q+aM05xYgkpXMML/BykM70
         ny2oLVJEmLkOX8pFYITawjimG+/seCBWTESeV6p+lOWaZt2elPI0lqo571hQAQsGGmHA
         0nMkLsH3+BLiHw1Y/rQfgyS4baaiceyoaHMxggWvKWi3wAvh6u2q0wRhri7mqwjEnZ3h
         530+hojvnlWrvvJ/Wg5uvwYmkhQE+KlOeVBkAuumgo+19r7olKOUkslKjM9R4dHhE2hz
         XksXosBa4WZeU8b6ViAv2jRegolVieOy+1OcYXdRrPE1v0rg0GWJfkLmPSsh+y7gCfBN
         OZFg==
X-Gm-Message-State: AOAM532kc14AXQnBLRqM3rEvXmeOWqc9hoTo7Tr+skmYETq33ei6WdGY
        So0POjsWICTgovj9sQVvlw5SGktkuT1j+g==
X-Google-Smtp-Source: ABdhPJwZdznAJB4OExjWWbuOCfu7XVzGHXuhDMuL1DwLfSkzFpZ2gy4CW7rJL7ti8+sAtTbVyGeOGg==
X-Received: by 2002:a5d:6292:: with SMTP id k18mr24737639wru.110.1632704005906;
        Sun, 26 Sep 2021 17:53:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm14749745wrq.78.2021.09.26.17.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:53:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] builtin/remote.c: add and use a REF_STATES_INIT
Date:   Mon, 27 Sep 2021 02:53:19 +0200
Message-Id: <patch-5.6-1c34c00feb5-20210927T004920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a new REF_STATES_INIT designated initializer instead of assigning
to the "strdup_strings" member of the previously memzero()'d version
of this struct.

The pattern of assigning to "strdup_strings" dates back to
211c89682ee (Make git-remote a builtin, 2008-02-29) (when it was
"strdup_paths"), i.e. long before we used anything like our current
established *_INIT patterns consistently.

Then in e61e0cc6b70 (builtin-remote: teach show to display remote
HEAD, 2009-02-25) and e5dcbfd9ab7 (builtin-remote: new show output
style for push refspecs, 2009-02-25) we added some more of these.

As it turns out we only initialized this struct three times, all the
other uses were of pointers to those initialized structs. So let's
initialize it in those three places, skip the memset(), and pass those
structs down appropriately.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/remote.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f88e6ce9de..160dd954f74 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -344,6 +344,14 @@ struct ref_states {
 	int queried;
 };
 
+#define REF_STATES_INIT { \
+	.new_refs = STRING_LIST_INIT_DUP, \
+	.stale = STRING_LIST_INIT_DUP, \
+	.tracked = STRING_LIST_INIT_DUP, \
+	.heads = STRING_LIST_INIT_DUP, \
+	.push = STRING_LIST_INIT_DUP, \
+}
+
 static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
@@ -355,9 +363,6 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch.raw[i]);
 
-	states->new_refs.strdup_strings = 1;
-	states->tracked.strdup_strings = 1;
-	states->stale.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
 		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
@@ -406,7 +411,6 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 	match_push_refs(local_refs, &push_map, &remote->push, MATCH_REFS_NONE);
 
-	states->push.strdup_strings = 1;
 	for (ref = push_map; ref; ref = ref->next) {
 		struct string_list_item *item;
 		struct push_info *info;
@@ -449,7 +453,6 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	if (remote->mirror)
 		return 0;
 
-	states->push.strdup_strings = 1;
 	if (!remote->push.nr) {
 		item = string_list_append(&states->push, _("(matching)"));
 		info = item->util = xcalloc(1, sizeof(struct push_info));
@@ -483,7 +486,6 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	refspec.force = 0;
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/*";
-	states->heads.strdup_strings = 1;
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -1212,7 +1214,7 @@ static int show(int argc, const char **argv)
 		OPT_BOOL('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
 	};
-	struct ref_states states;
+	struct ref_states states = REF_STATES_INIT;
 	struct string_list info_list = STRING_LIST_INIT_NODUP;
 	struct show_info info;
 
@@ -1225,7 +1227,6 @@ static int show(int argc, const char **argv)
 	if (!no_query)
 		query_flag = (GET_REF_STATES | GET_HEAD_NAMES | GET_PUSH_REF_STATES);
 
-	memset(&states, 0, sizeof(states));
 	memset(&info, 0, sizeof(info));
 	info.states = &states;
 	info.list = &info_list;
@@ -1334,8 +1335,7 @@ static int set_head(int argc, const char **argv)
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
 	} else if (opt_a && !opt_d && argc == 1) {
-		struct ref_states states;
-		memset(&states, 0, sizeof(states));
+		struct ref_states states = REF_STATES_INIT;
 		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
 			result |= error(_("Cannot determine remote HEAD"));
@@ -1374,14 +1374,13 @@ static int set_head(int argc, const char **argv)
 static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0;
-	struct ref_states states;
+	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
 
-	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
 	if (!states.stale.nr) {
-- 
2.33.0.1316.gb2e9b3ba3ae

