Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E75C43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0342098B
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekqrhY7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgISRDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED3C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fa1so4907165pjb.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzSHLb4CKNb05TuOYmEBd55NvHKGunNhCApL/uJOszM=;
        b=ekqrhY7m9r0lyt4HmrA1XI0/35gJDxVSYhFix8JOhmBIiWFFHA/IbPWTvGFab2p7gC
         nQMjed/sfmK9t7HxVzjyE9EctzhW/wDQUOOju26KRrBLA0H58ZLlB/kJ3ziNJM84/k7y
         Z+TdrjmxkcB7zQ1RMH9ua0MbNrz+egZIoz3YY89E5pf/RjU7qoNM3cH8UAuKJ3VvJwFY
         NLa83Abx36Q5glzYSbXFrslhwnqUoJT0Y3JjnrXnu9HKZqE3IySjId2d6nbLylmLnz96
         r5EXpRBmQ0QshVpSnbyMw1z5HnEvZHAQ5jfktZ3hautJ7HwApAUrm8LRxsNh7zRznvT1
         oAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzSHLb4CKNb05TuOYmEBd55NvHKGunNhCApL/uJOszM=;
        b=O7MwG7zZM58bPMZeu+lJoYLjBh0xahDPTtFi8Zo2Hdgb0Duhm20vfbg88LZlB9UrgX
         WVHcscckOtnL0NoOAJ1VooMNlSoyomKlvDg4K6YfmAypz+IqNv//HlObL4wSCVvHy5yO
         fNWXCTcB1B6qiyo/4UIm15vZ3brTbWIevdYV3wh2tBvkH4IfTkijy9wUoIeDLZ8EYkv4
         JX5zSwGR/2Dwcsbdfwj7bJut2vc+bGHxZzfZkkA1bDT8oVNfbgdZ4QSG55udQh0guxeH
         T4SonQExjlK5qyhrsATmG/viXnZohiDSCmPQUbvyPvB0qduVXR+C2wWat9ygsahRz0UF
         ohZQ==
X-Gm-Message-State: AOAM532OREFOaCMMTG04O9jckPsJRTTDyu08pywLiUO2MmSTzoRvpIux
        jzfJRhtn3xezK5o75Q0FBRxjhz3n4mUrn3ge
X-Google-Smtp-Source: ABdhPJx3iPdRUmQo8JbnoLEq49WuspH/9kS8i+o+TxnjqPLjOk9NnctsBfW3Yb2OR2zacPBlmad6kg==
X-Received: by 2002:a17:90a:8a04:: with SMTP id w4mr17888064pjn.72.1600535025078;
        Sat, 19 Sep 2020 10:03:45 -0700 (PDT)
Received: from localhost.localdomain ([104.200.132.172])
        by smtp.gmail.com with ESMTPSA id 25sm1510140pgo.34.2020.09.19.10.03.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:03:44 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
Date:   Sat, 19 Sep 2020 22:33:14 +0530
Message-Id: <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a check to verify if the remote-tracking ref of the local branch
is reachable from one of its "reflog" entries.

When a local branch that is based on a remote ref, has been rewound
and is to be force pushed on the remote, "--force-if-includes" runs
a check that ensures any updates to remote-tracking refs that may have
happened (by push from another repository) in-between the time of the
last checkout, and right before the time of push, have been integrated
locally before allowing a forced updated.

A new field "use_force_if_includes" has been added to "push_cas_option",
which is set to "1" when "--force-if-includes" is specified as an
argument in the command line or set as a configuration option.

The struct "ref" has two new bit-fields:
  - if_includes:
    Set when we have to run the new check on the ref, and the remote
    ref was marked as "use_tracking" or "use_tracking_for_rest" by
    compare-and-swap (if the "the remote tip must be at the expected
    commit" condition is not specified); "apply_push_cas()" has been
    updated to check if this field is set and run the check.

  - unreachable:
    Set if the ref is unreachable from any of the "reflog" entries of
    its local counterpart.

"REF_STATUS_REJECT_REMOTE_UPDATED" has been added to the "status"
enum to imply that the ref failed the check; "case" statements in
"send-pack", "transport" and "transport-helper" have been updated
accordingly to catch this status when set.

When "--force-with-includes" is used along with "--force-with-lease",
the check runs only for refs marked as "if_includes". If the option
is passed without specifying "--force-with-lease", or specified along
with "--force-with-lease=<refname>:<expect>" it is a "no-op".

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 builtin/send-pack.c |  5 +++
 remote.c            | 92 ++++++++++++++++++++++++++++++++++++++++++++-
 remote.h            |  6 ++-
 send-pack.c         |  1 +
 transport-helper.c  |  5 +++
 transport.c         |  6 +++
 6 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2b9610f121..4d76727edb 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -69,6 +69,11 @@ static void print_helper_status(struct ref *ref)
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
index eafc14cbe7..60d681a885 100644
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
+			else if (ref->if_includes && ref->unreachable)
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
 
@@ -2268,6 +2279,70 @@ static int remote_tracking(struct remote *remote, const char *refname,
 	return 0;
 }
 
+/* Checks if the ref exists in the reflog entry. */
+static int reflog_entry_exists(struct object_id *o_oid,
+				  struct object_id *n_oid,
+				  const char *ident, timestamp_t timestamp,
+				  int tz, const char *message, void *cb_data)
+{
+	struct object_id *remote_oid = cb_data;
+	return oideq(n_oid, remote_oid);
+}
+
+/* Checks if the ref is reachable from the reflog entry. */
+static int reflog_entry_reachable(struct object_id *o_oid,
+			       struct object_id *n_oid,
+			       const char *ident, timestamp_t timestamp,
+			       int tz, const char *message, void *cb_data)
+{
+	struct commit *local_commit;
+	struct commit *remote_commit = cb_data;
+
+	local_commit = lookup_commit_reference(the_repository, n_oid);
+	if (local_commit)
+		return in_merge_bases(remote_commit, local_commit);
+
+	return 0;
+}
+
+/*
+ * Iterate through he reflog entries of the local branch to check
+ * if the remote-tracking ref exists in on of the entries; if not,
+ * go through the entries once more, but this time check if the
+ * remote-tracking ref is reachable from any of the entries.
+ */
+static int is_reachable_in_reflog(const char *local_ref_name,
+				  const struct object_id *remote_oid)
+{
+	struct commit *remote_commit;
+
+	if (for_each_reflog_ent_reverse(local_ref_name, reflog_entry_exists,
+					(struct object_id *)remote_oid))
+		return 1;
+
+	remote_commit = lookup_commit_reference(the_repository, remote_oid);
+	if (remote_commit)
+		return for_each_reflog_ent_reverse(local_ref_name,
+						   reflog_entry_reachable,
+						   remote_commit);
+	return 0;
+}
+
+/*
+ * Check for reachability of a remote-tracking
+ * ref in the reflog entries of its local ref.
+ */
+static void check_if_includes_upstream(struct ref *remote_ref)
+{
+	struct ref *local_ref = get_local_ref(remote_ref->name);
+
+	if (!local_ref)
+		return;
+
+	if (!is_reachable_in_reflog(local_ref->name, &remote_ref->old_oid))
+		remote_ref->unreachable = 1;
+}
+
 static void apply_cas(struct push_cas_option *cas,
 		      struct remote *remote,
 		      struct ref *ref)
@@ -2284,6 +2359,8 @@ static void apply_cas(struct push_cas_option *cas,
 			oidcpy(&ref->old_oid_expect, &entry->expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			oidclr(&ref->old_oid_expect);
+		else
+			ref->if_includes = cas->use_force_if_includes;
 		return;
 	}
 
@@ -2294,6 +2371,8 @@ static void apply_cas(struct push_cas_option *cas,
 	ref->expect_old_sha1 = 1;
 	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 		oidclr(&ref->old_oid_expect);
+	else
+		ref->if_includes = cas->use_force_if_includes;
 }
 
 void apply_push_cas(struct push_cas_option *cas,
@@ -2301,6 +2380,15 @@ void apply_push_cas(struct push_cas_option *cas,
 		    struct ref *remote_refs)
 {
 	struct ref *ref;
-	for (ref = remote_refs; ref; ref = ref->next)
+	for (ref = remote_refs; ref; ref = ref->next) {
 		apply_cas(cas, remote, ref);
+
+		/*
+		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
+		 * mode, and if "--foce-if-includes" was specified, run
+		 * the check.
+		 */
+		if (ref->if_includes)
+			check_if_includes_upstream(ref);
+	}
 }
diff --git a/remote.h b/remote.h
index 5e3ea5a26d..38ab8539e2 100644
--- a/remote.h
+++ b/remote.h
@@ -104,7 +104,9 @@ struct ref {
 		forced_update:1,
 		expect_old_sha1:1,
 		exact_oid:1,
-		deletion:1;
+		deletion:1,
+		if_includes:1, /* If "--force-with-includes" was specified. */
+		unreachable:1; /* For "if_includes"; unreachable in reflog. */
 
 	enum {
 		REF_NOT_MATCHED = 0, /* initial value */
@@ -134,6 +136,7 @@ struct ref {
 		REF_STATUS_REJECT_NEEDS_FORCE,
 		REF_STATUS_REJECT_STALE,
 		REF_STATUS_REJECT_SHALLOW,
+		REF_STATUS_REJECT_REMOTE_UPDATED,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
@@ -332,6 +335,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
 
 struct push_cas_option {
 	unsigned use_tracking_for_rest:1;
+	unsigned use_force_if_includes:1;
 	struct push_cas {
 		struct object_id expect;
 		unsigned use_tracking:1;
diff --git a/send-pack.c b/send-pack.c
index 632f1580ca..956306e8e8 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -240,6 +240,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_FETCH_FIRST:
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
diff --git a/transport-helper.c b/transport-helper.c
index c52c99d829..e547e21199 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -779,6 +779,10 @@ static int push_update_ref_status(struct strbuf *buf,
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
@@ -897,6 +901,7 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
+		case REF_STATUS_REJECT_REMOTE_UPDATED:
 			if (atomic) {
 				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
diff --git a/transport.c b/transport.c
index 43e24bf1e5..99fe6233a3 100644
--- a/transport.c
+++ b/transport.c
@@ -567,6 +567,11 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "stale info", porcelain, summary_width);
 		break;
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				 "remote ref updated since checkout",
+				 porcelain, summary_width);
+		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
@@ -1101,6 +1106,7 @@ static int run_pre_push_hook(struct transport *transport,
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
+		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
 		strbuf_reset(&buf);
-- 
2.28.0

