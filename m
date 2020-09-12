Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B1C43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC00120855
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA3PbqQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgILPFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgILPFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 11:05:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B60C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 08:05:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d16so2317990pll.13
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUeg1X2gxFoptvFCVSDeHXSVkSz+4Fi/+0iaXgrfBc8=;
        b=CA3PbqQrWUcQO4itd60FruiGGaia/JbGRnO2dYoYNFE2NfrCeX47/JXBBD4kzon82V
         RHfv+7MmAIzp2EIjoH05m7zOSrZsTBMkJYSG0wm7VKBpRk1E7VBADzHnCAUNK2dueCIF
         pTO9EA18v/WNKs9MCGmBj7RXbeK3VlNFCc09VZNRDaxHR/zCEfPm9zLFy+mJKOlxXoqA
         ohNXvdeY0SDR6e+MMtnz5JrNGYIZAr/hz42iqN48lEK0nbhRF+NNNLvuKyk/F3YoVv1Y
         H6M5tcD5x2e1Ol/8NJaP+QsNfBcxaLeV8Fe5avk2qjNl163p87SpjwFX8ky1VLy/BDjU
         /dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUeg1X2gxFoptvFCVSDeHXSVkSz+4Fi/+0iaXgrfBc8=;
        b=nWsByRlnNRgDl+QCfC8NST87mooNWxoSI6gOni0WSPz97Vl1aJFJSHP8gwHD0hmnWo
         ClN2sD/k6U07ruvC2gOZY8IhMEhe8HN0QNjlMs/85mdoqzY8KP+DYdslBLTKPGVb15JR
         37ANdcSgftktEK6CZcrVxQNhKfYc1YIpeueO3ANe8tL7pebwen+HFfD0TeUxOY6lUdHW
         5iak3uCBlnSdwrNplx9vZge4ziNJzmggZAyDr27NpcbOTYxt7N367Y+ifofbcjYkGRi4
         kmaRzn2K0g+cjgMtxJQh3+AqEFVFTEZqWNeYWiam2FHtvGYGSglXoGJWdL8YCEMORErQ
         eBiQ==
X-Gm-Message-State: AOAM5311f1cvUmiF7ETco7oGTpV6DvpuGWu3RMjM5z02wOn+AmFRVX4l
        XkXs/QXkMpkZ6qLh62gAbonFSJNKZwNtYw==
X-Google-Smtp-Source: ABdhPJyfpMqsQdmoxVm3WHVtLC+un5qffs1RSPI5RcGdgnlXsdK5KjHkUzAhNzMsaVUmjim6ECaPhA==
X-Received: by 2002:a17:902:9b8e:b029:d0:89f3:28c8 with SMTP id y14-20020a1709029b8eb02900d089f328c8mr7000337plp.4.1599923115647;
        Sat, 12 Sep 2020 08:05:15 -0700 (PDT)
Received: from localhost.localdomain ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id q24sm5479196pfs.206.2020.09.12.08.05.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 08:05:14 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v2 1/2] push: add "--[no-]force-if-includes"
Date:   Sat, 12 Sep 2020 20:34:58 +0530
Message-Id: <20200912150459.8282-2-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: `--force-if-includes` to `git-push` where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref on which a local branch has based on (for a rewrite), is reachable
from at least one of the `reflog` entries of the local branch about
to be updated by force on the remote.

This option can also be used with `--force-with-lease` in setups
where the remote-tracking refs of the repository are implicitly
updated in the background.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with `--force-with-lease[=<refname>[:expect]]` without specifying the
"<refname>" or "<expect>" values, can cause the update that happened
in-between the checkout and forced push to be lost.

Specifying `--force-with-includes` with `--force-with-lease` as an
ancillary argument at the time of push, ensures that any new updates
to the remote-tracking refs are integrated locally before allowing a
forced update. This behavior can enabled by default if the configuration
option `push.forceIfIncludesWithLease` is set to `true`.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 Documentation/config/advice.txt   |   4 +
 Documentation/config/push.txt     |   8 ++
 Documentation/git-push.txt        |  22 +++++
 advice.c                          |   3 +
 advice.h                          |   2 +
 builtin/push.c                    |  27 +++++-
 builtin/send-pack.c               |  13 ++-
 remote.c                          | 129 ++++++++++++++++++++++++---
 remote.h                          |  14 ++-
 send-pack.c                       |   1 +
 t/t5533-push-cas.sh               |  53 ++++++++++++
 t/t5549-push-force-if-includes.sh | 139 ++++++++++++++++++++++++++++++
 transport-helper.c                |   5 ++
 transport.c                       |  24 +++++-
 transport.h                       |  12 +--
 15 files changed, 434 insertions(+), 22 deletions(-)
 create mode 100755 t/t5549-push-force-if-includes.sh

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index bdd37c3eaa..f48aed49e8 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -41,6 +41,10 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
+	pushRefNeedsUpdate::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when its remote-tracking ref has updates that we
+		do not have locally.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index f5e5b38c68..1b4948faa0 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -114,3 +114,11 @@ push.recurseSubmodules::
 	specifying '--recurse-submodules=check|on-demand|no'.
 	If not set, 'no' is used by default, unless 'submodule.recurse' is
 	set (in which case a 'true' value means 'on-demand').
+
+push.forceIfIncludesWithLease::
+	If set to `true`, adds `--force-if-includes` as an ancillary argument
+	to `--force-with-lease[=<refname>[:<expect>]]`, when "<refname>" or
+	"<expect>" values are unspecified at the time of push.
++
+Note: Specifying `--no-force-if-includes` to linkgit:git-push[1] as an
+argument during the time of push does _not_ override this configuration.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3b8053447e..199c601bd4 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -320,6 +320,15 @@ seen and are willing to overwrite, then rewrite history, and finally
 force push changes to `master` if the remote version is still at
 `base`, regardless of what your local `remotes/origin/master` has been
 updated to in the background.
++
+Alternatively, specifying `--force-if-includes` an an ancillary option along
+with `--force-with-lease[=<refname>[:expect]]` (when "<refname>" or "<expect>"
+values are unspecified) at the time of `push` will verify if updates from
+the remote-tracking refs that may have been implicitly updated in the
+background (via linkgit:git-fetch[1], and the like) are integrated locally
+before allowing a forced update. This behavior can be enabled by default if
+the configuration option `push.forceIfIncludesWithLease` to `true`
+in linkgit:git-config[1].
 
 -f::
 --force::
@@ -341,6 +350,19 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
+--[no-]force-if-includes::
+	Force an update only if the tip of the remote-tracking ref
+	has been integrated locally.
++
+This option verifies if the tip of the remote-tracking ref on which
+a local branch has based on (for a rewrite), is reachable from at
+least one of the `reflog` entries of the local branch about to be
+updated by force on the remote. The check ensures that any updates
+from the remote have been incorporated locally by rejecting a push
+if that is not the case.
++
+Specifying `--no-force-if-includes` disables this behavior.
+
 --repo=<repository>::
 	This option is equivalent to the <repository> argument. If both
 	are specified, the command-line argument takes precedence.
diff --git a/advice.c b/advice.c
index f0a3d32d20..164742305f 100644
--- a/advice.c
+++ b/advice.c
@@ -11,6 +11,7 @@ int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
 int advice_push_needs_force = 1;
 int advice_push_unqualified_ref_name = 1;
+int advice_push_ref_needs_update = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_status_ahead_behind_warning = 1;
@@ -72,6 +73,7 @@ static struct {
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
 	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
+	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
@@ -116,6 +118,7 @@ static struct {
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
 	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
 	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
 
 	/* make this an alias for backward compatibility */
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
diff --git a/advice.h b/advice.h
index 16f2c11642..bc2432980a 100644
--- a/advice.h
+++ b/advice.h
@@ -11,6 +11,7 @@ extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
 extern int advice_push_unqualified_ref_name;
+extern int advice_push_ref_needs_update;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_status_ahead_behind_warning;
@@ -60,6 +61,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_PUSH_UPDATE_REJECTED,
+	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_RESET_QUIET_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
diff --git a/builtin/push.c b/builtin/push.c
index bc94078e72..7fb07eb38e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -300,6 +300,12 @@ static const char message_advice_ref_needs_force[] =
 	   "or update a remote ref to make it point at a non-commit object,\n"
 	   "without using the '--force' option.\n");
 
+static const char message_advice_ref_needs_update[] =
+	N_("Updates were rejected because the tip of the remote-tracking\n"
+	   "branch has been updated since the last checkout. You may want\n"
+	   "to integrate those changes locally (e.g., 'git rebase ...')\n"
+	   "before forcing an update.\n");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_update_rejected)
@@ -335,6 +341,13 @@ static void advise_ref_needs_force(void)
 	advise(_(message_advice_ref_needs_force));
 }
 
+static void advise_ref_needs_update(void)
+{
+	if (!advice_push_ref_needs_update || !advice_push_update_rejected)
+		return;
+	advise(_(message_advice_ref_needs_update));
+}
+
 static int push_with_options(struct transport *transport, struct refspec *rs,
 			     int flags)
 {
@@ -384,8 +397,9 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		advise_ref_fetch_first();
 	} else if (reject_reasons & REJECT_NEEDS_FORCE) {
 		advise_ref_needs_force();
+	} else if (reject_reasons & REJECT_REF_NEEDS_UPDATE) {
+		advise_ref_needs_update();
 	}
-
 	return 1;
 }
 
@@ -520,8 +534,14 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		if (!v)
 			return config_error_nonbool(k);
 		return color_parse(v, push_colors[slot]);
-	}
+	} else if (!strcmp(k, "push.forceifincludeswithlease")) {
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_FORCE_IF_INCLUDES;
+		else
+			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
 
+		return 0;
+	}
 	return git_default_config(k, v, NULL);
 }
 
@@ -551,6 +571,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 			       N_("require old value of ref to be at this value"),
 			       PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option),
+		OPT_BIT(0, "force-if-includes", &flags,
+			N_("require remote updates to be integrated locally"),
+			TRANSPORT_PUSH_FORCE_IF_INCLUDES),
 		OPT_CALLBACK(0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
 			     N_("control recursive pushing of submodules"), option_parse_recurse_submodules),
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2b9610f121..ee5d7af00c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -69,6 +69,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "stale info";
 			break;
 
+		case REF_STATUS_REJECT_REMOTE_UPDATED:
+			res = "error";
+			msg = "remote updated since checkout";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
@@ -155,6 +160,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
 	struct packet_reader reader;
+	unsigned int force_if_inc;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbose),
@@ -179,6 +185,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option),
+		OPT_BOOL(0, "force-if-includes", &force_if_inc,
+			 N_("require remote updates to be integrated locally")),
 		OPT_END()
 	};
 
@@ -278,7 +286,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		return -1;
 
 	if (!is_empty_cas(&cas))
-		apply_push_cas(&cas, remote, remote_refs);
+		apply_push_cas(&cas, remote, remote_refs, force_if_inc);
+
+	if (is_empty_cas(&cas) && force_if_inc)
+		run_local_reflog_check(remote_refs);
 
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
diff --git a/remote.c b/remote.c
index 420150837b..71af6d3073 100644
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
@@ -2272,11 +2302,76 @@ static int remote_tracking(struct remote *remote, const char *refname,
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
+ * Check for reachability of a remote-tracking ref in its local
+ * ref's reflog entries.
+ */
+void check_reflog_for_ref(struct ref *r_ref)
+{
+	struct ref *l_ref = get_local_ref(r_ref->name);
+	struct object_id r_oid;
+
+	r_ref->if_includes = 1;
+	if (l_ref && !read_ref(l_ref->name, &r_oid))
+		r_ref->unreachable = !ref_reachable_from_reflog(&r_ref->old_oid,
+								&r_oid,
+								l_ref->name);
+}
+
 static void apply_cas(struct push_cas_option *cas,
 		      struct remote *remote,
-		      struct ref *ref)
+		      struct ref *ref,
+		      int if_includes)
 {
-	int i;
+	int i, check_reflog = 0;
 
 	/* Find an explicit --<option>=<name>[:<value>] entry */
 	for (i = 0; i < cas->nr; i++) {
@@ -2288,23 +2383,37 @@ static void apply_cas(struct push_cas_option *cas,
 			oidcpy(&ref->old_oid_expect, &entry->expect);
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			oidclr(&ref->old_oid_expect);
-		return;
+		else
+			check_reflog = 1;
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
+			check_reflog = 1;
+	}
 
-	ref->expect_old_sha1 = 1;
-	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-		oidclr(&ref->old_oid_expect);
+	if (if_includes && check_reflog)
+		check_reflog_for_ref(ref);
 }
 
 void apply_push_cas(struct push_cas_option *cas,
 		    struct remote *remote,
-		    struct ref *remote_refs)
+		    struct ref *remote_refs,
+		    int if_includes)
+{
+	struct ref *ref;
+	for (ref = remote_refs; ref; ref = ref->next)
+		apply_cas(cas, remote, ref, if_includes);
+}
+
+void run_local_reflog_check(struct ref *remote_refs)
 {
 	struct ref *ref;
 	for (ref = remote_refs; ref; ref = ref->next)
-		apply_cas(cas, remote, ref);
+		check_reflog_for_ref(ref);
 }
diff --git a/remote.h b/remote.h
index 5e3ea5a26d..c4a648ed6d 100644
--- a/remote.h
+++ b/remote.h
@@ -104,7 +104,9 @@ struct ref {
 		forced_update:1,
 		expect_old_sha1:1,
 		exact_oid:1,
-		deletion:1;
+		deletion:1,
+		if_includes:1, /* For "--force-if-includes". */
+		unreachable:1; /* Used by "if_includes". */
 
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
@@ -344,6 +347,13 @@ struct push_cas_option {
 int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 
 int is_empty_cas(const struct push_cas_option *);
-void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
+void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *, int);
+
+/*
+ * Check if the remote-tracking ref was updated (since checkout)
+ * implicitly in the background and verify that changes from the
+ * updated tip have been integrated locally, before pushing.
+ */
+void run_local_reflog_check(struct ref*);
 
 #endif
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
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 0b0eb1d025..dee422acaa 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -256,4 +256,57 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
 	)
 '
 
+test_expect_success 'background updates of REMOTE can be mitigated with "--force-if-includes"' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git push origin master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		test_must_fail git push --force-with-lease --force-if-includes origin
+	)
+'
+
+test_expect_success 'background updates of REMOTE can be mitigated with "push.forceIfIncludesWithLease"' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git push origin master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		git config --local push.forceIfIncludesWithLease true &&
+		test_must_fail git push --force-with-lease origin
+	)
+'
+
 test_done
diff --git a/t/t5549-push-force-if-includes.sh b/t/t5549-push-force-if-includes.sh
new file mode 100755
index 0000000000..2e2ca79266
--- /dev/null
+++ b/t/t5549-push-force-if-includes.sh
@@ -0,0 +1,139 @@
+test_description='Test push "--force-if-includes" forced update safety.'
+
+. ./test-lib.sh
+
+setup_src_dup_dst () {
+	rm -fr src dup dst &&
+	git init --bare dst &&
+	git clone --no-local dst src &&
+	git clone --no-local dst dup
+	(
+		cd src &&
+		test_commit A &&
+		git push
+	) &&
+	(
+		cd dup &&
+		git fetch &&
+		git merge origin/master &&
+		test_commit B &&
+		git switch -c branch master~1 &&
+		test_commit C &&
+		test_commit D &&
+		git push --all
+	) &&
+	(
+		cd src &&
+		git switch master &&
+		git fetch --all &&
+		git branch branch --track origin/branch &&
+		git rebase origin/master
+	) &&
+	(
+		cd dup &&
+		git switch master &&
+		test_commit E &&
+		git switch branch &&
+		test_commit F &&
+		git push origin --all
+	)
+}
+
+test_expect_success 'reject push if remote changes are not integrated locally (protected, all refs)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/master >expect.branch &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit H &&
+		git switch master &&
+		test_commit I &&
+		git fetch --all &&
+		test_must_fail git push --force-if-includes --all
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	git ls-remote dst refs/heads/master >actual.branch &&
+	test_cmp expect.master actual.master &&
+	test_cmp expect.branch actual.branch
+'
+
+test_expect_success 'reject push if remote changes are not integrated locally (protected, specific ref)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit H &&
+		git switch master &&
+		test_commit I &&
+		git fetch --all &&
+		test_must_fail git push --force-if-includes origin master
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	test_cmp expect.master actual.master
+'
+
+test_expect_success 'allow force push if "--force" is specified' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit H &&
+		git switch master &&
+		test_commit I &&
+		git fetch --all &&
+		git push --force --force-if-includes origin --all 2>err &&
+		grep "forced update" err
+	)
+'
+
+test_expect_success 'allow force push if "--delete" is specified' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit H &&
+		git switch master &&
+		test_commit I &&
+		git fetch --all &&
+		git push --delete --force-if-includes origin branch 2>err &&
+		grep "deleted" err
+	)
+'
+
+test_expect_success 'honor specified refspecs (force)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit H &&
+		git switch master &&
+		test_commit I &&
+		git fetch --all &&
+		git push --force-if-includes origin +branch 2>err &&
+		grep "forced update" err
+	)
+'
+
+test_expect_success 'honor specified refspecs (delete)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit H &&
+		git switch master &&
+		test_commit I &&
+		git fetch --all &&
+		git push --force-if-includes origin :branch 2>err &&
+		grep "deleted" err
+	)
+'
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index c52c99d829..6fd74c2c65 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -779,6 +779,10 @@ static int push_update_ref_status(struct strbuf *buf,
 			status = REF_STATUS_REJECT_STALE;
 			FREE_AND_NULL(msg);
 		}
+		else if (!strcmp(msg, "remote updated since checkout")) {
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
index 43e24bf1e5..3f9e697cd1 100644
--- a/transport.c
+++ b/transport.c
@@ -567,6 +567,11 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "stale info", porcelain, summary_width);
 		break;
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				 "remote updated since checkout",
+				 porcelain, summary_width);
+		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
@@ -659,6 +664,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			*reject_reasons |= REJECT_FETCH_FIRST;
 		} else if (ref->status == REF_STATUS_REJECT_NEEDS_FORCE) {
 			*reject_reasons |= REJECT_NEEDS_FORCE;
+		} else if (ref->status == REF_STATUS_REJECT_REMOTE_UPDATED) {
+			*reject_reasons |= REJECT_REF_NEEDS_UPDATE;
 		}
 	}
 	free(head);
@@ -1101,6 +1108,7 @@ static int run_pre_push_hook(struct transport *transport,
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
+		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
 		strbuf_reset(&buf);
@@ -1151,6 +1159,8 @@ int transport_push(struct repository *r,
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
 		struct strvec ref_prefixes = STRVEC_INIT;
+		int empty_cas = 1;
+		int if_includes = flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES;
 
 		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
@@ -1178,9 +1188,19 @@ int transport_push(struct repository *r,
 
 		if (transport->smart_options &&
 		    transport->smart_options->cas &&
-		    !is_empty_cas(transport->smart_options->cas))
+		    !is_empty_cas(transport->smart_options->cas)) {
+			empty_cas = 0;
 			apply_push_cas(transport->smart_options->cas,
-				       transport->remote, remote_refs);
+				       transport->remote, remote_refs,
+				       if_includes);
+		}
+
+		/*
+		 * Run the check for all refs when "--force-if-includes"
+		 * is specified without "--force-with-lease".
+		 */
+		if (empty_cas && if_includes)
+			run_local_reflog_check(remote_refs);
 
 		set_ref_status_for_push(remote_refs,
 			flags & TRANSPORT_PUSH_MIRROR,
diff --git a/transport.h b/transport.h
index ca409ea1e4..729bb6979e 100644
--- a/transport.h
+++ b/transport.h
@@ -136,6 +136,7 @@ struct transport {
 #define TRANSPORT_PUSH_ATOMIC			(1<<13)
 #define TRANSPORT_PUSH_OPTIONS			(1<<14)
 #define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)
+#define TRANSPORT_PUSH_FORCE_IF_INCLUDES	(1<<16)
 
 int transport_summary_width(const struct ref *refs);
 
@@ -217,11 +218,12 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
-#define REJECT_NON_FF_HEAD     0x01
-#define REJECT_NON_FF_OTHER    0x02
-#define REJECT_ALREADY_EXISTS  0x04
-#define REJECT_FETCH_FIRST     0x08
-#define REJECT_NEEDS_FORCE     0x10
+#define REJECT_NON_FF_HEAD      0x01
+#define REJECT_NON_FF_OTHER     0x02
+#define REJECT_ALREADY_EXISTS   0x04
+#define REJECT_FETCH_FIRST      0x08
+#define REJECT_NEEDS_FORCE      0x10
+#define REJECT_REF_NEEDS_UPDATE 0x20
 
 int transport_push(struct repository *repo,
 		   struct transport *connection,
-- 
2.28.0

