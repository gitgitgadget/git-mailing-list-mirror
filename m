Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD0C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F40761247
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhJBUSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhJBUSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:18:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C6C0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:16:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s24so9791670wmh.4
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8quuxDMC5BKxORZufyZqCXD/nmNhEcGfKATVQdKOqfo=;
        b=c7rBpcisnxrWA6+51cLfb6uadQBzy+F1EW+khrVJ3VyLVCE/BXGSOb+3+gVa//rm+9
         dDJzLAN/Fk4jl2nWN/J3ZechNAVp6BQW/xgcnX/UnqVBYWvBs1vc5fM0m+b9uAyuX1Qc
         AcrYbdx2J3ja/LhaJ6WUzbET5QI2pNLmWG1pn3vKjF/Xiah7AL+XhELKqkE0RC2Gp0l1
         9OoIhpQrx5uzn49KkbVdQzHcQi7NTygzZ8VlzdDsZLQOjg6CDbdLDszPGO0xLk/6vujk
         2r0uGMlltIKmg9Ukwr8APdFImZMnujfntNIrQk7Iusl4TWjwSiHV5O9a/GSKipgsFaDU
         zcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8quuxDMC5BKxORZufyZqCXD/nmNhEcGfKATVQdKOqfo=;
        b=gq0JcNgy87nL8BbZWcc258mhYKo6N89iE6peHvq1JYCqG8wY4pHFZw+BRQ9qwI2CSQ
         FdT/xfr8RBRqq66AfeDk5UDWoO5DQxsju8B1YCou6xYzeB5iGrwR0C89+TofoxW0SYaW
         gG8wINOC+YsoZLg2e4tmNYoISzCVPL4Ei6P1ytbIJ7Kpom92MWn+hZ9z0VnCZC/PlgTK
         GflzN9nqm1aN/i2YQgZJ3Yf3kTcbEa/O9qiDClHvfVXuU03AR+85XQssH58k4cX435xW
         3TU7bcco7UNbpRix/M76RLokT+SKsEDWreF+erX2QFeH93QXPSlcd+IBAUybehtUXJ53
         s9EQ==
X-Gm-Message-State: AOAM532Ul5ITw7V4My48GfEUOSRQWagBuvdjozlOsztBicv6Yo7ANU/H
        9bPy0Ppw6gl3p/ZtJY6+3arpIPd7t0eJPg==
X-Google-Smtp-Source: ABdhPJzM3ImuYJd6h/4YfNpoG8ttYWxX7eMPuE6J1Cy663ygwuTlcWxKl/w73G26XWXclaUm4zppnQ==
X-Received: by 2002:a1c:4455:: with SMTP id r82mr7796237wma.100.1633205783140;
        Sat, 02 Oct 2021 13:16:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g2sm9946009wrb.20.2021.10.02.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:16:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/5] builtin/remote.c: add and use a REF_STATES_INIT
Date:   Sat,  2 Oct 2021 22:16:16 +0200
Message-Id: <patch-v4-4.5-41fcb0a45e5-20211002T201434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
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

This would be a behavior change if we had codepaths that relied say on
implicitly having had "new_refs" initialized to STRING_LIST_INIT_NODUP
with the memset(), but only set the "strdup_strings" on some other
struct, but then called string_list_append() on "new_refs". There
isn't any such codepath, all of the late assignments to
"strdup_strings" assigned to those structs that we'd use for those
codepaths.

So just initializing them all up-front makes for easier to understand
code, i.e. in the pre-image it looked as though we had that tricky
edge case, but we didn't.

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
2.33.0.1380.g193143c62ce

