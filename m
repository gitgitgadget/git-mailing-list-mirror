Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A8BC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C7E23119
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uljIqRxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgI0OSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0OSh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 10:18:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD8C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:18:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bd2so1970242plb.7
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiTYFESZLm3rwuDtOg/ZOZs44ZuJUMouC38SNRedA6E=;
        b=uljIqRxxtbsXkDLua73HCmrqss77ws/wZSH2V06csrefR0PZdAMB7jNhm1RLpDViAM
         qz9HXXEqP4GtgbJ5/sM6Ssqg9/dDU24DAlaFNUmgBlDu4dirWDRkC0BS/zPpVgQ3XgQX
         z+pZnVnLs6kpmq64dAHLBgmvHwbnoeu1eiVQt9Xb22HnWQT/mOlCnDevfaOvkTSOEZjV
         fJWWJNriEvRZAzN5sG9hnJDbCuJIW/LqVdbc2//7nDXquirimseRxu7zI6wGdtOwQrPV
         TOP0RuNhLg2nOoKc0248bPF4o+d4n13cCZVWeVROZSETvOBQ6s8yeMOaRnkY0D3NyAQY
         kh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiTYFESZLm3rwuDtOg/ZOZs44ZuJUMouC38SNRedA6E=;
        b=KFkaYEjJ6jg1Pe2VWNS8r6bKoMPgWOBScZdryMR2MNN/OUrGuQbRSZp+zPTc0G4lga
         9UF260VSUF1tB93gCmxA2lvpzKmJ2D+iJ+r1Gpcngk5wli57sL9TbiOxbZjZfrU9PjRk
         HXYleIs+kL/9u3T5ISvQtK7HfH8fTcuoowYnerV89hW4AC9Qsj50J3DobDPUCLLLMWbO
         Pdboi3WVS1QzorrCMDhRSLYsaO7D62B8KoTkhfjEYr8oqDLgef4355hZ0J/qcVpwUTgo
         TVBO1h+7y4oYKr4XFMUWAyO71aBqu5I3/gx3gxitNqPZxwUaN7WVWE1sgEFLktF6sac5
         EBCQ==
X-Gm-Message-State: AOAM531bDC4UzqQbZ2eXbjinieS/UQXCesK+KYkBimksAHoQnRwpnKKE
        R9bZrvPc7LxYoTytHTX1FOzJhJ8r03ldWa8o
X-Google-Smtp-Source: ABdhPJyfhANWwWiN2MeSigYYJshSetjWOGMlLgsw2JbzV43UHn+C0FY+QH4X7gny0q5u2VC1Qt7+uQ==
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id x12-20020a170902ea8cb02900d28abdc8demr106806plb.21.1601216316565;
        Sun, 27 Sep 2020 07:18:36 -0700 (PDT)
Received: from localhost.localdomain ([124.123.106.216])
        by smtp.gmail.com with ESMTPSA id d17sm8377799pfq.157.2020.09.27.07.18.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 07:18:36 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v8 1/3] push: add reflog check for "--force-if-includes"
Date:   Sun, 27 Sep 2020 19:47:45 +0530
Message-Id: <20200927141747.78047-2-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a check to verify if the remote-tracking ref of the local branch
is reachable from one of its "reflog" entries.

The check iterates through the local ref's reflog to see if there
is an entry for the remote-tracking ref and collecting any commits
that are seen, into a list; the iteration stops if an entry in the
reflog matches the remote ref or if the entry timestamp is older
the latest entry of the remote ref's "reflog". If there wasn't an
entry found for the remote ref, "in_merge_bases_many()" is called
to check if it is reachable from the list of collected commits.

When a local branch that is based on a remote ref, has been rewound
and is to be force pushed on the remote, "--force-if-includes" runs
a check that ensures any updates to the remote-tracking ref that may
have happened (by push from another repository) in-between the time
of the last update to the local branch (via "git-pull", for instance)
and right before the time of push, have been integrated locally
before allowing a forced update.

If the new option is passed without specifying "--force-with-lease",
or specified along with "--force-with-lease=<refname>:<expect>" it
is a "no-op".

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 builtin/send-pack.c |   5 ++
 remote.c            | 188 ++++++++++++++++++++++++++++++++++++++++++--
 remote.h            |  12 ++-
 send-pack.c         |   1 +
 transport-helper.c  |   5 ++
 transport.c         |   6 ++
 6 files changed, 209 insertions(+), 8 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7af148d733..516cba7336 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -71,6 +71,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "stale info";
 			break;
 
+		case REF_STATUS_REJECT_REMOTE_UPDATED:
+			res = "error";
+			msg = "remote ref updated since checkout";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
diff --git a/remote.c b/remote.c
index eafc14cbe7..4781680409 100644
--- a/remote.c
+++ b/remote.c
@@ -1471,12 +1471,23 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 * with the remote-tracking branch to find the value
 		 * to expect, but we did not have such a tracking
 		 * branch.
+		 *
+		 * If the tip of the remote-tracking ref is unreachable
+		 * from any reflog entry of its local ref indicating a
+		 * possible update since checkout; reject the push.
 		 */
 		if (ref->expect_old_sha1) {
 			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
+			else if (ref->check_reachable && ref->unreachable)
+				reject_reason =
+					REF_STATUS_REJECT_REMOTE_UPDATED;
 			else
-				/* If the ref isn't stale then force the update. */
+				/*
+				 * If the ref isn't stale, and is reachable
+				 * from from one of the reflog entries of
+				 * the local branch, force the update.
+				 */
 				force_ref_update = 1;
 		}
 
@@ -2251,12 +2262,13 @@ int is_empty_cas(const struct push_cas_option *cas)
 
 /*
  * Look at remote.fetch refspec and see if we have a remote
- * tracking branch for the refname there.  Fill its current
- * value in sha1[].
+ * tracking branch for the refname there. Fill the name of
+ * the remote-tracking branch in *dst_refname, and the name
+ * of the commit object at its tip in oid[].
  * If we cannot do so, return negative to signal an error.
  */
 static int remote_tracking(struct remote *remote, const char *refname,
-			   struct object_id *oid)
+			   struct object_id *oid, char **dst_refname)
 {
 	char *dst;
 
@@ -2265,9 +2277,154 @@ static int remote_tracking(struct remote *remote, const char *refname,
 		return -1; /* no tracking ref for refname at remote */
 	if (read_ref(dst, oid))
 		return -1; /* we know what the tracking ref is but we cannot read it */
+
+	*dst_refname = dst;
+	return 0;
+}
+
+/*
+ * The struct "reflog_commit_list" and related helper functions
+ * for list manipulation are used for collecting commits into a
+ * list during reflog traversals in "check_and_collect_until()".
+ */
+struct reflog_commit_list {
+	struct commit **items;
+	size_t nr, alloc;
+};
+
+/* Append a commit to the list. */
+static void append_commit(struct reflog_commit_list *list,
+			  struct commit *commit)
+{
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+	list->items[list->nr++] = commit;
+}
+
+/* Free and reset the list. */
+static void free_reflog_commit_list(struct reflog_commit_list *list)
+{
+	FREE_AND_NULL(list->items);
+	list->nr = list->alloc = 0;
+}
+
+struct check_and_collect_until_cb_data {
+	struct commit *remote_commit;
+	struct reflog_commit_list *local_commits;
+	timestamp_t remote_reflog_timestamp;
+};
+
+/* Get the timestamp of the latest entry. */
+static int peek_reflog(struct object_id *o_oid, struct object_id *n_oid,
+		       const char *ident, timestamp_t timestamp,
+		       int tz, const char *message, void *cb_data)
+{
+	timestamp_t *ts = cb_data;
+	*ts = timestamp;
+	return 1;
+}
+
+static int check_and_collect_until(struct object_id *o_oid,
+				   struct object_id *n_oid,
+				   const char *ident, timestamp_t timestamp,
+				   int tz, const char *message, void *cb_data)
+{
+	struct commit *commit;
+	struct check_and_collect_until_cb_data *cb = cb_data;
+
+	/* An entry was found. */
+	if (oideq(n_oid, &cb->remote_commit->object.oid))
+		return 1;
+
+	if ((commit = lookup_commit_reference(the_repository, n_oid)))
+		append_commit(cb->local_commits, commit);
+
+	/*
+	 * If the reflog entry timestamp is older than the remote ref's
+	 * latest reflog entry, there is no need to check or collect
+	 * entries older than this one.
+	 */
+	if (timestamp < cb->remote_reflog_timestamp)
+		return -1;
+
 	return 0;
 }
 
+#define MERGE_BASES_BATCH_SIZE 8
+
+/*
+ * Iterate through the reflog of the local ref to check if there is an entry
+ * for the given remote-tracking ref; runs until the timestamp of an entry is
+ * older than latest timestamp of remote-tracking ref's reflog. Any commits
+ * are that seen along the way are collected into a list to check if the
+ * remote-tracking ref is reachable from any of them.
+ */
+static int is_reachable_in_reflog(const char *local, const struct ref *remote)
+{
+	timestamp_t date;
+	struct commit *commit;
+	struct commit **chunk;
+	struct check_and_collect_until_cb_data cb;
+	struct reflog_commit_list list = { NULL, 0, 0 };
+	size_t size = 0;
+	int ret = 0;
+
+	commit = lookup_commit_reference(the_repository, &remote->old_oid);
+	if (!commit)
+		goto cleanup_return;
+
+	/*
+	 * Get the timestamp from the latest entry
+	 * of the remote-tracking ref's reflog.
+	 */
+	for_each_reflog_ent_reverse(remote->tracking_ref, peek_reflog, &date);
+
+	cb.remote_commit = commit;
+	cb.local_commits = &list;
+	cb.remote_reflog_timestamp = date;
+	ret = for_each_reflog_ent_reverse(local, check_and_collect_until, &cb);
+
+	/* We found an entry in the reflog. */
+	if (ret > 0)
+		goto cleanup_return;
+
+	/*
+	 * Check if the remote commit is reachable from any
+	 * of the commits in the collected list, in batches.
+	 */
+	for (chunk = list.items; chunk < list.items + list.nr; chunk += size) {
+		size = list.items + list.nr - chunk;
+
+		/*
+		 * If the number of remaining entries is more than
+		 * the batch size, clamp the number of items passed
+		 * to the maximum batch size.
+		 */
+		if (MERGE_BASES_BATCH_SIZE < size)
+			size = MERGE_BASES_BATCH_SIZE;
+
+		if ((ret = in_merge_bases_many(commit, size, chunk)))
+			break;
+	}
+
+cleanup_return:
+	free_reflog_commit_list(&list);
+	return ret;
+}
+
+/*
+ * Check for reachability of a remote-tracking
+ * ref in the reflog entries of its local ref.
+ */
+static void check_if_includes_upstream(struct ref *remote)
+{
+	struct ref *local = get_local_ref(remote->name);
+	if (!local)
+		return;
+
+	if (is_reachable_in_reflog(local->name, remote) <= 0)
+		remote->unreachable = 1;
+}
+
 static void apply_cas(struct push_cas_option *cas,
 		      struct remote *remote,
 		      struct ref *ref)
@@ -2282,8 +2439,12 @@ static void apply_cas(struct push_cas_option *cas,
 		ref->expect_old_sha1 = 1;
 		if (!entry->use_tracking)
 			oidcpy(&ref->old_oid_expect, &entry->expect);
-		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
+		else if (remote_tracking(remote, ref->name,
+					 &ref->old_oid_expect,
+					 &ref->tracking_ref))
 			oidclr(&ref->old_oid_expect);
+		else
+			ref->check_reachable = cas->use_force_if_includes;
 		return;
 	}
 
@@ -2292,8 +2453,12 @@ static void apply_cas(struct push_cas_option *cas,
 		return;
 
 	ref->expect_old_sha1 = 1;
-	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
+	if (remote_tracking(remote, ref->name,
+			    &ref->old_oid_expect,
+			    &ref->tracking_ref))
 		oidclr(&ref->old_oid_expect);
+	else
+		ref->check_reachable = cas->use_force_if_includes;
 }
 
 void apply_push_cas(struct push_cas_option *cas,
@@ -2301,6 +2466,15 @@ void apply_push_cas(struct push_cas_option *cas,
 		    struct ref *remote_refs)
 {
 	struct ref *ref;
-	for (ref = remote_refs; ref; ref = ref->next)
+	for (ref = remote_refs; ref; ref = ref->next) {
 		apply_cas(cas, remote, ref);
+
+		/*
+		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
+		 * mode, and if "--force-if-includes" was specified, run
+		 * the check.
+		 */
+		if (ref->check_reachable)
+			check_if_includes_upstream(ref);
+	}
 }
diff --git a/remote.h b/remote.h
index eb62a47044..2d5391d281 100644
--- a/remote.h
+++ b/remote.h
@@ -107,12 +107,20 @@ struct ref {
 	struct object_id new_oid;
 	struct object_id old_oid_expect; /* used by expect-old */
 	char *symref;
+	char *tracking_ref;
 	unsigned int
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
 		exact_oid:1,
-		deletion:1;
+		deletion:1,
+		/* Need to check if local reflog reaches the remote tip. */
+		check_reachable:1,
+		/*
+		 * Store the result of the check enabled by "check_reachable";
+		 * implies the local reflog does not reach the remote tip.
+		 */
+		unreachable:1;
 
 	enum {
 		REF_NOT_MATCHED = 0, /* initial value */
@@ -142,6 +150,7 @@ struct ref {
 		REF_STATUS_REJECT_NEEDS_FORCE,
 		REF_STATUS_REJECT_STALE,
 		REF_STATUS_REJECT_SHALLOW,
+		REF_STATUS_REJECT_REMOTE_UPDATED,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
@@ -341,6 +350,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
 
 struct push_cas_option {
 	unsigned use_tracking_for_rest:1;
+	unsigned use_force_if_includes:1;
 	struct push_cas {
 		struct object_id expect;
 		unsigned use_tracking:1;
diff --git a/send-pack.c b/send-pack.c
index c9698070fc..eb4a44270b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -299,6 +299,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_FETCH_FIRST:
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
diff --git a/transport-helper.c b/transport-helper.c
index b573b6c730..6157de30c7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -827,6 +827,10 @@ static int push_update_ref_status(struct strbuf *buf,
 			status = REF_STATUS_REJECT_STALE;
 			FREE_AND_NULL(msg);
 		}
+		else if (!strcmp(msg, "remote ref updated since checkout")) {
+			status = REF_STATUS_REJECT_REMOTE_UPDATED;
+			FREE_AND_NULL(msg);
+		}
 		else if (!strcmp(msg, "forced update")) {
 			forced = 1;
 			FREE_AND_NULL(msg);
@@ -967,6 +971,7 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
+		case REF_STATUS_REJECT_REMOTE_UPDATED:
 			if (atomic) {
 				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
diff --git a/transport.c b/transport.c
index ffe2115845..65fcd22b20 100644
--- a/transport.c
+++ b/transport.c
@@ -633,6 +633,11 @@ static int print_one_push_report(struct ref *ref, const char *dest, int count,
 				 "stale info",
 				 report, porcelain, summary_width);
 		break;
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				 "remote ref updated since checkout",
+				 report, porcelain, summary_width);
+		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
@@ -1185,6 +1190,7 @@ static int run_pre_push_hook(struct transport *transport,
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
+		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
 		strbuf_reset(&buf);
-- 
2.28.0

