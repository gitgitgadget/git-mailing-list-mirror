Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC5C433E4
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642F22076D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfGZtUM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRECH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgHREB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:01:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0FC061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:58 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k12so12083343pfu.19
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7kwDGmF+PzWiqEmYDOFO62Dh/L031HUwJTUuZ7F64qc=;
        b=JfGZtUM0z7AXBDo9gwtqGyGrv6q2iI+X1oMe+boid1SSgphODFXuH1US7OIIIBkRfZ
         juHY3dcZYGwzQQUn+Jc7gyMkkgGmQTeF3Kdh2Rn5/HuiFZCTYxNlx0q7nL1OmQu6wQ06
         drit59d2GS3DxzcS+EmT7PdrPBJe82JRfNFTb/x5zj1Q7dSuoNI7Y/YkQz5ZxWSppohl
         bu6l6GP8argQeMLmxU13MISFGp1oAAtstwSdh4tOyMiSQ0q174tGLbUAgT7JoWDo47Gf
         nQx3000fFcEqhnOCO8PfA5rprCBtYRrRDRCMzuijDycKMQJGNLxmakh0fv2WDy0n0Nwn
         lcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7kwDGmF+PzWiqEmYDOFO62Dh/L031HUwJTUuZ7F64qc=;
        b=ttgRcflnKGd2TALEsjzl5U/Qlr9VaVrlXrBthaXwz/k0BOJy6q5qwglNBM8wQN5YNG
         BET4e7HxoY/lLN7GDSiM3E8PdzScZK8rtaRXe96P0fzkPjRE9BiQ42a/j77s8/2tkuAq
         Dche6OTeoUaFdZQXjUmksXVYFswkIWolAhmYlv0fFpYV+HYUMUKf3STRTPbLrzWIMGE5
         q0kaVGI4wA1eo++sOzeDy4JPA5E8zRoKu5eEChBjHmtfzL2fv7uSdNSJw3g4jxO6wOXG
         R7b3kQgp54jFm8yzkWF2IXS5JkMotdGEYy+l6C8SaHK3O8qwsRSjC9WzB1I4lHLI/QLe
         sEEA==
X-Gm-Message-State: AOAM530Vn/yo39nA9gPfOueFeyJz0XtnDHMs8xeyv9MfAeDaWWSw6b1E
        rBID9AP6wcz3kpt+qFO1x/a377IFJ3c41QIFXx4PAJ5xItPfWW0Ble579FWx2kBnBE5mw/yhxgz
        PMqJBL82oxcIzUz2l/bgr2p9PC5U8brghHwCJPfByTWs9lAjRGu/kUEO9kEaEBtiJgdItQ5DuB8
        Ht
X-Google-Smtp-Source: ABdhPJzIiHsU1MjukbvYGtOA2pcg6NgZA9roZdGDutRQ7+aYm3ASOLOkEOWzcESFi7Zw7aOYhvd0IJP4yUG144QO1mWL
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr15405927pjo.74.1597723318130;
 Mon, 17 Aug 2020 21:01:58 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:35 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com>
Message-Id: <f56c24dd1b05081b9c66e87746a67e12394ef012.1597722942.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597722941.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 5/7] fetch-pack: do not lazy-fetch during ref iteration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to determine negotiation tips, "fetch-pack" iterates over all
refs and dereferences all annotated tags found. This causes the
existence of targets of refs and annotated tags to be checked. Avoiding
this is especially important when we use "git fetch" (which invokes
"fetch-pack") to perform lazy fetches in a partial clone because a
target of such a ref or annotated tag may need to be itself lazy-fetched
(and otherwise causing an infinite loop).

Therefore, teach "fetch-pack" not to lazy fetch whenever iterating over
refs. This is done by using the raw form of ref iteration and by
dereferencing tags ourselves.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c             | 79 ++++++++++++++++++++++------------------
 t/t5616-partial-clone.sh | 20 ++++++++++
 2 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 80fb3bd899..707bbc31fd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -108,24 +108,48 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
+static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
+					       int mark_tags_complete)
+{
+	enum object_type type;
+	struct object_info info = { .typep = &type };
+
+	while (1) {
+		if (oid_object_info_extended(the_repository, oid, &info,
+					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
+			return NULL;
+		if (type == OBJ_TAG) {
+			struct tag *tag = (struct tag *)
+				parse_object(the_repository, oid);
+
+			if (!tag->tagged)
+				return NULL;
+			if (mark_tags_complete)
+				tag->object.flags |= COMPLETE;
+			oid = &tag->tagged->oid;
+		} else {
+			break;
+		}
+	}
+	if (type == OBJ_COMMIT)
+		return (struct commit *) parse_object(the_repository, oid);
+	return NULL;
+}
+
 static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
-			       const char *refname,
 			       const struct object_id *oid)
 {
-	struct object *o = deref_tag(the_repository,
-				     parse_object(the_repository, oid),
-				     refname, 0);
-
-	if (o && o->type == OBJ_COMMIT)
-		negotiator->add_tip(negotiator, (struct commit *)o);
+	struct commit *c = deref_without_lazy_fetch(oid, 0);
 
+	if (c)
+		negotiator->add_tip(negotiator, c);
 	return 0;
 }
 
 static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
 				   int flag, void *cb_data)
 {
-	return rev_list_insert_ref(cb_data, refname, oid);
+	return rev_list_insert_ref(cb_data, oid);
 }
 
 enum ack_type {
@@ -201,7 +225,7 @@ static void send_request(struct fetch_pack_args *args,
 static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
 					struct object *obj)
 {
-	rev_list_insert_ref(negotiator, NULL, &obj->oid);
+	rev_list_insert_ref(negotiator, &obj->oid);
 }
 
 #define INITIAL_FLUSH 16
@@ -230,13 +254,12 @@ static void mark_tips(struct fetch_negotiator *negotiator,
 	int i;
 
 	if (!negotiation_tips) {
-		for_each_ref(rev_list_insert_ref_oid, negotiator);
+		for_each_rawref(rev_list_insert_ref_oid, negotiator);
 		return;
 	}
 
 	for (i = 0; i < negotiation_tips->nr; i++)
-		rev_list_insert_ref(negotiator, NULL,
-				    &negotiation_tips->oid[i]);
+		rev_list_insert_ref(negotiator, &negotiation_tips->oid[i]);
 	return;
 }
 
@@ -503,21 +526,11 @@ static struct commit_list *complete;
 
 static int mark_complete(const struct object_id *oid)
 {
-	struct object *o = parse_object(the_repository, oid);
-
-	while (o && o->type == OBJ_TAG) {
-		struct tag *t = (struct tag *) o;
-		if (!t->tagged)
-			break; /* broken repository */
-		o->flags |= COMPLETE;
-		o = parse_object(the_repository, &t->tagged->oid);
-	}
-	if (o && o->type == OBJ_COMMIT) {
-		struct commit *commit = (struct commit *)o;
-		if (!(commit->object.flags & COMPLETE)) {
-			commit->object.flags |= COMPLETE;
-			commit_list_insert(commit, &complete);
-		}
+	struct commit *commit = deref_without_lazy_fetch(oid, 1);
+
+	if (commit && !(commit->object.flags & COMPLETE)) {
+		commit->object.flags |= COMPLETE;
+		commit_list_insert(commit, &complete);
 	}
 	return 0;
 }
@@ -702,7 +715,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	 */
 	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
-		for_each_ref(mark_complete_oid, NULL);
+		for_each_rawref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
 		commit_list_sort_by_date(&complete);
 		if (cutoff)
@@ -716,16 +729,12 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	 */
 	trace2_region_enter("fetch-pack", "mark_common_remote_refs", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(the_repository,
-					     lookup_object(the_repository,
-					     &ref->old_oid),
-					     NULL, 0);
+		struct commit *c = deref_without_lazy_fetch(&ref->old_oid, 0);
 
-		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
+		if (!c || !(c->object.flags & COMPLETE))
 			continue;
 
-		negotiator->known_common(negotiator,
-					 (struct commit *)o);
+		negotiator->known_common(negotiator, c);
 	}
 	trace2_region_leave("fetch-pack", "mark_common_remote_refs", NULL);
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8a27452a51..e53492d595 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -384,6 +384,26 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	grep "want $(cat hash)" trace
 '
 
+test_expect_success 'fetch does not lazy-fetch missing targets of its refs' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	test_commit -C server foo &&
+
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	# Make all refs point to nothing by deleting all objects.
+	rm client/.git/objects/pack/* &&
+
+	test_commit -C server bar &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--no-tags --recurse-submodules=no \
+		origin refs/tags/bar &&
+	FOO_HASH=$(git -C server rev-parse foo) &&
+	! grep "want $FOO_HASH" trace
+'
+
 # The following two tests must be in this order. It is important that
 # the srv.bare repository did not have tags during clone, but has tags
 # in the fetch.
-- 
2.28.0.220.ged08abb693-goog

