From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] Add and use a function skip_prefix_if_present()
Date: Wed,  5 Feb 2014 07:25:15 +0100
Message-ID: <1391581517-8586-2-git-send-email-mhagger@alum.mit.edu>
References: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
Cc: "Kent R. Spillner" <kspillner@acm.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 07:33:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAw33-00075s-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 07:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaBEGdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 01:33:00 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52670 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381AbaBEGc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 01:32:59 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2014 01:32:59 EST
X-AuditID: 12074414-b7fb46d000002a4d-36-52f1d975d418
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 89.D5.10829.579D1F25; Wed,  5 Feb 2014 01:25:57 -0500 (EST)
Received: from michael.fritz.box (p57A24DEA.dip0.t-ipconnect.de [87.162.77.234])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s156POxv019775
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Feb 2014 01:25:55 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqFt682OQwcwTghZdV7qZLBp6rzBb
	PNjxk8ni9or5zBbdU94yOrB6XL7i7fH3/Qcmj52z7rJ7XLyk7PF5k1wAaxS3TVJiSVlwZnqe
	vl0Cd0bjjPPsBf0GFUu7L7M2MPaqdzFyckgImEic2/KUEcIWk7hwbz1bFyMXh5DAZUaJi3Nb
	mCCc40wSexa0MYNUsQnoSizqaWYCsUUE1CQmth1iASliFjjNKPFx4i9WkISwgIvE/AeNbCA2
	i4CqxIqv98DivALOEj1T57NBrFOQaFm2ix3E5gSq//v7JpgtBFQze/4h9gmMvAsYGVYxyiXm
	lObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihASVyA7GIyflDjEKcDAq8fB2iH4MEmJN
	LCuuzD3EKMnBpCTKW38DKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN7EbKMebklhZlVqUD5OS
	5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJME7CWSoYFFqempFWmZOCUKaiYMTZDiXlEhx
	al5KalFiaUlGPCg64ouB8QGS4gHau/k6yN7igsRcoChE6ylGXY5Laz/9YRRiycvPS5US550L
	skMApCijNA9uBSyFvGIUB/pYmNcQpIoHmH7gJr0CWsIEtGSd63uQJSWJCCmpBkbPfzGet3Um
	WT7wf/1GXIU5+nj/PP6wmzmGH2dOTVTyCjR4dObPysJ1Er1c+3+r7GELkNtpULRbdH15xfFV
	vO4BE7ddzf1nfS/J9+su3dcHPzlURq2UldN2eWCvZegXEfJGMvd5htVv44maFw8o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241597>

Most of the calls to skip_prefix_defval() had equal first and third
arguments, with the effect of skipping the prefix if present, but
otherwise returning the original string.  So define a new function
that does exactly that.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/checkout.c    | 4 ++--
 builtin/fast-export.c | 2 +-
 builtin/merge.c       | 2 +-
 builtin/show-branch.c | 6 +++---
 git-compat-util.h     | 5 +++++
 git.c                 | 2 +-
 notes.c               | 4 ++--
 refs.c                | 2 +-
 wt-status.c           | 4 ++--
 9 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6531ed4..84682f1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1151,8 +1151,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die (_("--track needs a branch name"));
-		argv0 = skip_prefix_defval(argv0, "refs/", argv0);
-		argv0 = skip_prefix_defval(argv0, "remotes/", argv0);
+		argv0 = skip_prefix_if_present(argv0, "refs/");
+		argv0 = skip_prefix_if_present(argv0, "remotes/");
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die (_("Missing branch name; try -b"));
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index cd0a302..c87c7ea 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -476,7 +476,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		}
 	}
 
-	name = skip_prefix_defval(name, "refs/tags/", name);
+	name = skip_prefix_if_present(name, "refs/tags/");
 	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
 	       name, tagged_mark,
 	       (int)(tagger_end - tagger), tagger,
diff --git a/builtin/merge.c b/builtin/merge.c
index 603f80a..7b01dcf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1109,7 +1109,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 */
 	branch = branch_to_free = resolve_refdup("HEAD", head_sha1, 0, &flag);
 	if (branch)
-		branch = skip_prefix_defval(branch, "refs/heads/", branch);
+		branch = skip_prefix_if_present(branch, "refs/heads/");
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit = NULL;
 	else
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 6078132..f2c3b19 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -284,7 +284,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
 		pretty_str = pretty.buf;
 	}
-	pretty_str = skip_prefix_defval(pretty_str, "[PATCH] ", pretty_str);
+	pretty_str = skip_prefix_if_present(pretty_str, "[PATCH] ");
 
 	if (!no_name) {
 		if (name && name->head_name) {
@@ -478,7 +478,7 @@ static int rev_is_head(const char *head, int headlen, const char *name,
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	head = skip_prefix_defval(head, "refs/heads/", head);
+	head = skip_prefix_if_present(head, "refs/heads/");
 	if (starts_with(name, "refs/heads/"))
 		name += 11;
 	else if (starts_with(name, "heads/"))
@@ -810,7 +810,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head)
-			append_one_rev(skip_prefix_defval(head, "refs/heads/", head));
+			append_one_rev(skip_prefix_if_present(head, "refs/heads/"));
 	}
 
 	if (!ref_name_cnt) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 59265af..cff946c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -368,6 +368,11 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
 	return skip_prefix_defval(str, prefix, NULL);
 }
 
+static inline const char *skip_prefix_if_present(const char *str, const char *prefix)
+{
+	return skip_prefix_defval(str, prefix, str);
+}
+
 static inline int starts_with(const char *str, const char *prefix)
 {
 	return skip_prefix(str, prefix) != NULL;
diff --git a/git.c b/git.c
index 321ae81..f3357d8 100644
--- a/git.c
+++ b/git.c
@@ -579,7 +579,7 @@ int main(int argc, char **av)
 	argc--;
 	handle_options(&argv, &argc, NULL);
 	if (argc > 0) {
-		argv[0] = skip_prefix_defval(argv[0], "--", argv[0]);
+		argv[0] = skip_prefix_if_present(argv[0], "--");
 	} else {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
diff --git a/notes.c b/notes.c
index 31f513b..15c49d8 100644
--- a/notes.c
+++ b/notes.c
@@ -1243,8 +1243,8 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
 			strbuf_addstr(sb, "\nNotes:\n");
 		} else {
-			ref = skip_prefix_defval(ref, "refs/", ref);
-			ref = skip_prefix_defval(ref, "notes/", ref);
+			ref = skip_prefix_if_present(ref, "refs/");
+			ref = skip_prefix_if_present(ref, "notes/");
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
 		}
 	}
diff --git a/refs.c b/refs.c
index 217093f..808985d 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,7 +2318,7 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	const char *name = skip_prefix_defval(r->name, "refs/", r->name);
+	const char *name = skip_prefix_if_present(r->name, "refs/");
 	struct ref_lock *lock = lock_ref_sha1(name, r->sha1);
 
 	if (lock) {
diff --git a/wt-status.c b/wt-status.c
index 185fa81..e7fab5c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1179,8 +1179,8 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	     ((commit = lookup_commit_reference_gently(sha1, 1)) != NULL &&
 	      !hashcmp(cb.nsha1, commit->object.sha1)))) {
 		const char *p;
-		if ((p = skip_prefix_defval(ref, "refs/tags/", ref)) == ref)
-			p = skip_prefix_defval(ref, "refs/remotes/", ref);
+		if (!(p = skip_prefix(ref, "refs/tags/")))
+			p = skip_prefix_if_present(ref, "refs/remotes/");
 		state->detached_from = xstrdup(p);
 	} else
 		state->detached_from =
-- 
1.8.5.3
