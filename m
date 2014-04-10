From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/9] branch: allow configuring the publish branch
Date: Thu, 10 Apr 2014 14:04:40 -0500
Message-ID: <1397156686-31349-4-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKRR-0006KR-LL
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbaDJTPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:15:06 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:61018 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161169AbaDJTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:15:04 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so4949610obc.28
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=anz65IHjV6N1ha3+Q/in3bS5oDhc63Ts/piGc6EuI2g=;
        b=ZR9XTDxzeBD5SS50SK4wBzUghxoSrKpNOedx8wkmep9yQBx0L42PmBgyN5vHa/6/b8
         Gogs/ttGpdrR+LKmpZ9xLCIzyeOgCjgQeGZctHOkWiI6t9GdUe9faVRoQgQzFeLqbnCx
         yS0OkhH2kQzdsZb2fBxdMzW+mjlnqgBpX7Tg7bbDJLPRBJ9YbXY2hP4r0fYHjsdVoxgW
         61CWs1tiR0I5Y2JiEqDizSqO2oO+i8fQcvYEd4g2SeKDYLKgZcGgrnTzKj9QrAmkbEhg
         +0EXqKyAlowzzx/Zrwt8Ikr5SMZzJHRvz76L0CAzvhZxW5OTCj+nNrUOC4xY20jpKpw8
         Bvow==
X-Received: by 10.182.117.195 with SMTP id kg3mr15181599obb.17.1397157303000;
        Thu, 10 Apr 2014 12:15:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id tz6sm8368265obc.10.2014.04.10.12.14.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:15:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246041>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-branch.txt | 11 +++++++++
 branch.c                     | 43 +++++++++++++++++++++++++++++++++
 branch.h                     |  2 ++
 builtin/branch.c             | 57 ++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..914fd62 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,7 +14,9 @@ SYNOPSIS
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
+'git branch' (--set-publish-to=<publish> | -p <publish>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
+'git branch' --unset-publish [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -191,6 +193,15 @@ start-point is either a local or remote-tracking branch.
 	Remove the upstream information for <branchname>. If no branch
 	is specified it defaults to the current branch.
 
+-p <publish>::
+--set-publish-to=<publish>::
+	Set up <branchname>'s publish tracking information. If no
+	<branchname> is specified, then it defaults to the current branch.
+
+--unset-publish::
+	Remove the publish information for <branchname>. If no branch
+	is specified it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/branch.c b/branch.c
index 723a36b..6f4fe7f 100644
--- a/branch.c
+++ b/branch.c
@@ -144,6 +144,49 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
+void install_branch_publish(const char *name, const char *remote, const char *remote_ref)
+{
+	struct strbuf key = STRBUF_INIT;
+
+	if (!remote && !strcmp(name, remote_ref + 11) && !prefixcmp(remote_ref, "refs/heads")) {
+		warning(_("Not setting branch %s as its own publish branch."), name);
+		return;
+	}
+
+	strbuf_addf(&key, "branch.%s.pushremote", name);
+	git_config_set(key.buf, remote ? remote : ".");
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.push", name);
+	git_config_set(key.buf, remote_ref);
+
+	strbuf_release(&key);
+}
+
+int setup_publish(const char *name, const char *ref)
+{
+	struct tracking tracking;
+	const char *remote, *remote_ref;
+
+	memset(&tracking, 0, sizeof(tracking));
+	tracking.spec.dst = (char*)ref;
+	if (for_each_remote(find_tracked_branch, &tracking))
+		return 1;
+
+	if (tracking.matches > 1)
+		return error(_("Not tracking: ambiguous information for ref %s"),
+				ref);
+
+	remote = tracking.remote;
+	remote_ref = tracking.src ? tracking.src : ref;
+
+	install_branch_publish(name, remote, remote_ref);
+
+	free(tracking.src);
+
+	return 0;
+}
+
 struct branch_desc_cb {
 	const char *config_name;
 	const char *value;
diff --git a/branch.h b/branch.h
index 64173ab..c9b6aa9 100644
--- a/branch.h
+++ b/branch.h
@@ -51,5 +51,7 @@ extern void install_branch_config(int flag, const char *local, const char *origi
  * Read branch description
  */
 extern int read_branch_desc(struct strbuf *, const char *branch_name);
+extern int setup_publish(const char *name, const char *ref);
+extern void install_branch_publish(const char *name, const char *remote, const char *remote_ref);
 
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..17773d7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -793,8 +793,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
-	const char *new_upstream = NULL;
+	int quiet = 0, unset_upstream = 0, unset_publish = 0;
+	const char *new_upstream = NULL, *publish = NULL;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -809,7 +809,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
+		OPT_STRING('p', "set-publish-to", &publish, "publish", "change the publish info"),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
+		OPT_BOOL(0, "unset-publish", &unset_publish, "Unset the publish info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
 			REF_REMOTE_BRANCH),
@@ -878,14 +880,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !edit_description && !new_upstream && !publish &&
+	    !unset_upstream && !unset_publish && argc == 0)
 		list = 1;
 
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!new_upstream +
-	    list + unset_upstream > 1)
+	if (!!delete + !!rename + !!force_create + !!new_upstream + !!publish +
+	    list + unset_upstream + unset_publish > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -990,6 +993,50 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
+	} else if (publish) {
+		struct branch *branch = branch_get(argv[0]);
+		char *real_ref = NULL;
+		unsigned char sha1[20];
+
+		if (argc > 1)
+			die(_("too many branches to set new publish branch"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not set publish branch of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
+		if (!ref_exists(branch->refname))
+			die(_("branch '%s' does not exist"), branch->name);
+
+		if (dwim_ref(publish, strlen(publish), sha1, &real_ref) != 1 ||
+				setup_publish(branch->name, real_ref))
+			die(_("Cannot setup publish branch to '%s'."), publish);
+	} else if (unset_publish) {
+		struct branch *branch = branch_get(argv[0]);
+		struct strbuf buf = STRBUF_INIT;
+
+		if (argc > 1)
+			die(_("too many branches to unset publish branch"));
+
+		if (!branch) {
+			if (!argc || !strcmp(argv[0], "HEAD"))
+				die(_("could not unset publish branch of HEAD when "
+				      "it does not point to any branch."));
+			die(_("no such branch '%s'"), argv[0]);
+		}
+
+		if (!branch->push_name)
+			die(_("Branch '%s' has no publish information"), branch->name);
+
+		strbuf_addf(&buf, "branch.%s.pushremote", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.push", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
 		int branch_existed = 0, remote_tracking = 0;
-- 
1.9.1+fc1
