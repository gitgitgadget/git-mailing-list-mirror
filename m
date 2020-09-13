Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07256C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11EB2151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJhOkkZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgIMOyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgIMOye (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7DC06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so4158258pjd.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VV0ygAU7T8Vex5cQ51HATuBdUJ2ZXwhh1OGO9zE3GYA=;
        b=kJhOkkZjUDiuc8rDy/IGoTor4wS1SkiPJC6SSSwG7cagSL57Yxz7FfDQrnUlwRK96Q
         k/ZbeSu7/EGLSiPJEButkGsh1owGfw6WgzkWa46VaVsPSzoLcNhqCpOGxDCNDECwORRi
         f7CfoZTj0LezmWE+GvY+8rFmuFroM7auq4BX0mQatt9AOOjbWlH6uA3F5lkPj1l0hrBA
         FQNCPbtRoLszkspt0MM06teCGxYwW+sPP349RlBtmW8PDsUbRDzal8UYvwtlxHiPn614
         Y0VVVwW4w39/eCKhja5WjVGuv8oiIJ+ng5iW3DLL0XmRDEO9NF4Fckpv3H0taVjPJFw6
         l9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VV0ygAU7T8Vex5cQ51HATuBdUJ2ZXwhh1OGO9zE3GYA=;
        b=ZpDVKayq2W/pIzV40uBOgScccCjzHLVgrTnTLshoLQWKzvii+REjOVDwvvE/ljBcsZ
         t627x/IT/fKqMht/usS3Eq93jljuYLrk5XyKuSDBLuzRxrYoRLXJS/ifILTBqZ1yVdnX
         u3ht36vdgo4014OVxmInRiCimbWdDrV0L270HQEMvAFVd6yrT1uSvVF7ZTlTs2hdiFH6
         pvDL7wjFCsBslf7SfRQa1qg2WPxWmrF64iHsEoxDHdx1Dl2cSqqYXvS/yFgVMzlrYHip
         bwGX75dT1ncuwUgh5i+eyBkGkbs1U0X8OmeVDFAlQJteoPV70VZj17nhL+QR1bHYHvRF
         ei8g==
X-Gm-Message-State: AOAM531D9J+LtqO1twy2+cBk9yiDvIAo2y2HAGUBW+MQpsdzL9Y3+b3x
        icW1qbj4SQ5C7nZA5rVsJySz9+2/WWpyI/dcjmQ=
X-Google-Smtp-Source: ABdhPJx4u5TribDdwIWmLv6q9Ng2piY/SwVcZCBN9boC1B/vaCNr+EwaVY5EJp4OmmNYxV7v6KM02A==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr10639133pjr.82.1600008869512;
        Sun, 13 Sep 2020 07:54:29 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:28 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 1/7] remote: add reflog check for "force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:07 +0530
Message-Id: <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a check to verify if the remote-tracking ref of the local branch is
reachable from one of its "reflog" entries; `set_ref_status_for_push`
updated to add a reject reason and disallow the forced push if the
check fails.

When a local branch that is based on a remote ref, has been rewound and
is to be force pushed on the remote, "apply_push_force_if_includes()"
runs a check that ensure any updates to remote-tracking refs that may
have happened (by push from another repository) in-between the time of
the last checkout, and right before the time of push by rejecting the
forced update.

The struct "ref" has three new bit-fields:
  * if_includes: Set when we have to run the new check on the ref.
  * is_tracking: Set when the remote ref was marked as "use_tracking"
                 or "use_tracking_for_rest" by compare-and-swap.
  * unreachable: Set if the ref is unreachable from any of the "reflog"
                 entries of its local counterpart.

When "--force-with-includes" is used along with "--force-with-lease",
the check is run only for refs marked as "is_tracking".

The enum "status" updated to include "REF_STATUS_REJECT_REMOTE_UPDATED"
to imply that the ref failed the check.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 remote.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 remote.h |  14 +++++-
 2 files changed, 141 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 420150837b..e4b2d85a6f 100644
--- a/remote.c
+++ b/remote.c
@@ -1484,6 +1484,36 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				force_ref_update = 1;
 		}
 
+		/*
+		 * If the tip of the remote-tracking ref is unreachable
+		 * from any reflog entry of its local ref indicating a
+		 * possible update since checkout; reject the push.
+		 *
+		 * There is no need to check for reachability, if the
+		 * ref is marked for deletion.
+		 */
+		if (ref->if_includes && !ref->deletion) {
+			/*
+			 * If `force_ref_update' was previously set by
+			 * "compare-and-swap", and we have to run this
+			 * check, reset it back to the original value
+			 * and update it depending on the status of this
+			 * check.
+			 */
+			force_ref_update = ref->force || force_update;
+
+			if (ref->unreachable)
+				reject_reason =
+					REF_STATUS_REJECT_REMOTE_UPDATED;
+			else
+				/*
+				 * If updates from the remote-tracking ref
+				 * have been integrated locally; force the
+				 * update.
+				 */
+				force_ref_update = 1;
+		}
+
 		/*
 		 * If the update isn't already rejected then check
 		 * the usual "must fast-forward" rules.
@@ -2272,11 +2302,74 @@ static int remote_tracking(struct remote *remote, const char *refname,
 	return 0;
 }
 
+static int ref_reachable(struct object_id *o_oid, struct object_id *n_oid,
+			 const char *ident, timestamp_t timestamp, int tz,
+			 const char *message, void *cb_data)
+{
+	int ret = 0;
+	struct object_id *r_oid = cb_data;
+
+	ret = oideq(n_oid, r_oid);
+	if (!ret) {
+		struct commit *loc = lookup_commit_reference(the_repository,
+							     n_oid);
+		struct commit *rem = lookup_commit_reference(the_repository,
+							     r_oid);
+		ret = (loc && rem) ? in_merge_bases(rem, loc) : 0;
+	}
+
+	return ret;
+}
+
+/*
+ * Iterate through the reflog of a local branch and check
+ * if the tip of the remote-tracking branch is reachable
+ * from one of the entries.
+ */
+static int ref_reachable_from_reflog(const struct object_id *r_oid,
+				     const struct object_id *l_oid,
+				     const char *local_ref_name)
+{
+	int ret = 0;
+	struct commit *r_commit, *l_commit;
+
+	l_commit = lookup_commit_reference(the_repository, l_oid);
+	r_commit = lookup_commit_reference(the_repository, r_oid);
+
+	/*
+	 * If the remote-tracking ref is an ancestor of the local
+	 * ref (a merge, for instance) there is no need to iterate
+	 * through the reflog entries to ensure reachability; it
+	 * can be skipped to return early instead.
+	 */
+	ret = (r_commit && l_commit) ? in_merge_bases(r_commit, l_commit) : 0;
+	if (!ret)
+		ret = for_each_reflog_ent_reverse(local_ref_name, ref_reachable,
+						  (struct object_id *)r_oid);
+
+	return ret;
+}
+
+/*
+ * Check for reachability of a remote-tracking
+ * ref in the reflog entries of its local ref.
+ */
+void check_reflog_for_ref(struct ref *r_ref)
+{
+	struct object_id r_oid;
+	struct ref *l_ref = get_local_ref(r_ref->name);
+
+	if (r_ref->if_includes && l_ref && !read_ref(l_ref->name, &r_oid))
+		r_ref->unreachable = !ref_reachable_from_reflog(&r_ref->old_oid,
+								&r_oid,
+								l_ref->name);
+}
+
 static void apply_cas(struct push_cas_option *cas,
 		      struct remote *remote,
 		      struct ref *ref)
 {
-	int i;
+	int i, is_tracking = 0;
 
 	/* Find an explicit --<option>=<name>[:<value>] entry */
 	for (i = 0; i < cas->nr; i++) {
@@ -2288,16 +2381,26 @@ static void apply_cas(struct push_cas_option *cas,
 			oidcpy(&ref->old_oid_expect, &entry->expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			oidclr(&ref->old_oid_expect);
-		return;
+		else
+			is_tracking = 1;
+		break;
 	}
 
 	/* Are we using "--<option>" to cover all? */
-	if (!cas->use_tracking_for_rest)
-		return;
+	if (cas->use_tracking_for_rest) {
+		ref->expect_old_sha1 = 1;
+		if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
+			oidclr(&ref->old_oid_expect);
+		else
+			is_tracking = 1;
+	}
+
+	/*
+	 * Mark this ref to be checked if "--force-if-includes" is
+	 * specified as an argument along with "compare-and-swap".
+	 */
+	ref->is_tracking = is_tracking;
 
-	ref->expect_old_sha1 = 1;
-	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-		oidclr(&ref->old_oid_expect);
 }
 
 void apply_push_cas(struct push_cas_option *cas,
@@ -2308,3 +2411,21 @@ void apply_push_cas(struct push_cas_option *cas,
 	for (ref = remote_refs; ref; ref = ref->next)
 		apply_cas(cas, remote, ref);
 }
+
+void apply_push_force_if_includes(struct ref *remote_refs, int used_with_cas)
+{
+	struct ref *ref;
+	for (ref = remote_refs; ref; ref = ref->next) {
+		/*
+		 * If "compare-and-swap" is used along with option, run the
+		 * check on refs that have been marked to do so. Otherwise,
+		 * all refs will be checked.
+		 */
+		if (used_with_cas)
+			ref->if_includes = ref->is_tracking;
+		else
+			ref->if_includes = 1;
+
+		check_reflog_for_ref(ref);
+	}
+}
diff --git a/remote.h b/remote.h
index 5e3ea5a26d..1618ba892b 100644
--- a/remote.h
+++ b/remote.h
@@ -104,7 +104,10 @@ struct ref {
 		forced_update:1,
 		expect_old_sha1:1,
 		exact_oid:1,
-		deletion:1;
+		deletion:1,
+		if_includes:1, /* If "--force-with-includes" was specified.  */
+		is_tracking:1, /* If "use_tracking[_for_rest]" is set (CAS). */
+		unreachable:1; /* For "if_includes"; unreachable in reflog.  */
 
 	enum {
 		REF_NOT_MATCHED = 0, /* initial value */
@@ -134,6 +137,7 @@ struct ref {
 		REF_STATUS_REJECT_NEEDS_FORCE,
 		REF_STATUS_REJECT_STALE,
 		REF_STATUS_REJECT_SHALLOW,
+		REF_STATUS_REJECT_REMOTE_UPDATED,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
@@ -346,4 +350,12 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+/*
+ * Runs when "--force-if-includes" is specified.
+ * Checks if the remote-tracking ref was updated (since checkout)
+ * implicitly in the background and verify that changes from the
+ * updated tip have been integrated locally, before pushing.
+ */
+void apply_push_force_if_includes(struct ref*, int);
+
 #endif
-- 
2.28.0

