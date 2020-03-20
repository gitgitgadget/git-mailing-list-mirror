Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB9C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D38420724
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOUx+xWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCTWAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:00:50 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38950 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCTWAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:00:50 -0400
Received: by mail-pf1-f202.google.com with SMTP id x189so5691484pfd.6
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NS3h/GW/BEqp9fedrrCjey57TmBwKQMpReJ5dID2LG8=;
        b=KOUx+xWWn3zLBEzWgKkebylChJGYcaqirvFTxA5mP8C34drLrbN8bedO/zFgQl+7uy
         gIKUNADJJqTH+XZ7IToFBMoBEHQ5z7OxoccsfPrC+yLly+mKS3Qv1DrqXb2+lRMDy5PS
         UVo2ujU/Cv4dV63oSN/RdNWh0Y8hjLgnqUgyfZbRAP96rgBr/gat/69B8vyiOo0Umtew
         7SsFIbgqYiAWZs2aR1OS7Iz+Ydv8hFKWxez/alqEq2Z5RoXJc5WXD5bC6yZuwwlBUW4z
         ePCaqlhLo3jH7F2b8coZhSZ7LGJmgHviLbdgNTlK75sS4CL9BZpoKButuNJFwsjdyanL
         383g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NS3h/GW/BEqp9fedrrCjey57TmBwKQMpReJ5dID2LG8=;
        b=IU0oXGwrQrhoJs5q3yPtA1mvmAKzC5GPsTLQnPRBWdvfd34K3ipx5b9TGcjs9tO/OK
         JEAT76pI+sgS+qG4XmJV6lfKK7ownw8p+gSrtUabR51TXdKZq74F7WYOnYZkMU9lwJlm
         TyE+PZlacZq0qvODXTvSPIZNPS7Ke25tHpMR9n4135blDTnp5hcKngBZvik9JYcIsQfQ
         TKRFEk9LPk9acC/tVOSYlg3aJIMW6Z2C1+ou4QRb4krXiiXA4kOLM11u2VvE1JAHMdvG
         BWzCjymOIbuy6ff2HP1/+zikcsBChSpIzxMhRxWnKNs4YOYBX+/wLF+ujUJJxS/zTIvf
         2Mhg==
X-Gm-Message-State: ANhLgQ37A3Cia2WaNtXhckEyrikzzjnJImV9r/77+7I26sPC6BHuJ0R3
        7xTTqrxvcTxvxKcJyva4T1LRJf5/Q0si+ljRcHHdmaBg/A8JNjnhdjcfVJp+ssv/BNT0c25eBhk
        NtiqdmWWc5glgMGan5hWxhvZPwB74pdgHO6gSuRqIHogKl6eWIddRVlvPo8qEQ7F3ufC2cHKstK
        r7
X-Google-Smtp-Source: ADFU+vt92e39Tf46NDF6kmNl0n02tDIx56x/mzwzHb9lNOZ7icWMZAHBbmQcA659wd0ImH6oOH5TXdFZ9uYSXbtea7Q5
X-Received: by 2002:a63:d311:: with SMTP id b17mr10301123pgg.407.1584741648443;
 Fri, 20 Mar 2020 15:00:48 -0700 (PDT)
Date:   Fri, 20 Mar 2020 15:00:45 -0700
Message-Id: <20200320220045.258462-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] connected: always use partial clone optimization
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With 50033772d5 ("connected: verify promisor-ness of partial clone",
2020-01-30), the fast path (checking promisor packs) in
check_connected() now passes a subset of the slow path (rev-list) - if
all objects to be checked are found in promisor packs, both the fast
path and the slow path will pass; otherwise, the fast path will
definitely not pass. This means that we can always attempt the fast path
whenever we need to do the slow path.

The fast path is currently guarded by a flag; therefore, remove that
flag. Also, make the fast path fallback to the slow path - if the fast
path fails, the failing OID and all remaining OIDs will be passed to
rev-list.

The main user-visible benefit is the performance of fetch from a partial
clone - specifically, the speedup of the connectivity check done before
the fetch. In particular, a no-op fetch into a partial clone on my
computer was sped up from 7 seconds to 0.01 seconds. This is a
complement to the work in 2df1aa239c ("fetch: forgo full
connectivity check if --filter", 2020-01-30), which is the child of the
aforementioned 50033772d5. In that commit, the connectivity check
*after* the fetch was sped up.

The addition of the fast path might cause performance reductions in
these cases:

 - If a partial clone or a fetch into a partial clone fails, Git will
   fruitlessly run rev-list (it is expected that everything fetched
   would go into promisor packs, so if that didn't happen, it is most
   likely that rev-list will fail too).

 - Any connectivity checks done by receive-pack, in the (in my opinion,
   unlikely) event that a partial clone serves receive-pack.

I think that these cases are rare enough, and the performance reduction
in this case minor enough (additional object DB access), that the
benefit of avoiding a flag outweighs these.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is the second half of the work I did previously [1]. Quoting from
[1]:

> For example, a local fetch was sped up from 6.63s to 3.39s. The bulk of
> the remaining time is spent in yet another connectivity check
> (fetch_refs -> check_exist_and_connected) prior to the fetch - that will
> hopefully be done in a subsequent patch.

This is the subsequent patch. (Note that the timings were done on
another computer, so don't compare the timings from [1] and this patch
directly.)

[1] https://lore.kernel.org/git/be1d6aa4c4fd8868f3682b73c01a92d3830534ad.1578802317.git.jonathantanmy@google.com/
---
 builtin/clone.c | 7 ++-----
 builtin/fetch.c | 7 -------
 connected.c     | 9 +++++++--
 connected.h     | 9 ---------
 4 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c..4b2b14ff61 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -672,8 +672,7 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *branch_top,
 			       const char *msg,
 			       struct transport *transport,
-			       int check_connectivity,
-			       int check_refs_are_promisor_objects_only)
+			       int check_connectivity)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -682,8 +681,6 @@ static void update_remote_refs(const struct ref *refs,
 
 		opt.transport = transport;
 		opt.progress = transport->progress;
-		opt.check_refs_are_promisor_objects_only =
-			!!check_refs_are_promisor_objects_only;
 
 		if (check_connected(iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
@@ -1275,7 +1272,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local, filter_options.choice);
+			   !is_local);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bf6bab80fa..1097e1e512 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -908,13 +908,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!connectivity_checked) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
-		if (filter_options.choice)
-			/*
-			 * Since a filter is specified, objects indirectly
-			 * referenced by refs are allowed to be absent.
-			 */
-			opt.check_refs_are_promisor_objects_only = 1;
-
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
 			rc = error(_("%s did not send all necessary objects\n"), url);
diff --git a/connected.c b/connected.c
index 7e9bd1bc62..846f2e4eef 100644
--- a/connected.c
+++ b/connected.c
@@ -52,7 +52,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_release(&idx_file);
 	}
 
-	if (opt->check_refs_are_promisor_objects_only) {
+	if (has_promisor_remote()) {
 		/*
 		 * For partial clones, we don't want to have to do a regular
 		 * connectivity check because we have to enumerate and exclude
@@ -71,13 +71,18 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 				if (find_pack_entry_one(oid.hash, p))
 					goto promisor_pack_found;
 			}
-			return 1;
+			/*
+			 * Fallback to rev-list with oid and the rest of the
+			 * object IDs provided by fn.
+			 */
+			goto no_promisor_pack_found;
 promisor_pack_found:
 			;
 		} while (!fn(cb_data, &oid));
 		return 0;
 	}
 
+no_promisor_pack_found:
 	if (opt->shallow_file) {
 		argv_array_push(&rev_list.args, "--shallow-file");
 		argv_array_push(&rev_list.args, opt->shallow_file);
diff --git a/connected.h b/connected.h
index eba5c261ba..8d5a6b3ad6 100644
--- a/connected.h
+++ b/connected.h
@@ -46,15 +46,6 @@ struct check_connected_options {
 	 * during a fetch.
 	 */
 	unsigned is_deepening_fetch : 1;
-
-	/*
-	 * If non-zero, only check that the top-level objects referenced by the
-	 * wanted refs (passed in as cb_data) are promisor objects. This is
-	 * useful for partial clones, where enumerating and excluding all
-	 * promisor objects is very slow and the commit-walk itself becomes a
-	 * no-op.
-	 */
-	unsigned check_refs_are_promisor_objects_only : 1;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.25.1.696.g5e7596f4ac-goog

