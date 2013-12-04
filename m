From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 09/11] remote prune: allow --prune=<pattern> options
Date: Wed,  4 Dec 2013 06:44:48 +0100
Message-ID: <1386135890-13954-10-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5OO-00085T-80
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab3LDFw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:52:56 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43889 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754028Ab3LDFwz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:55 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-e4-529ec17dc560
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C6.3D.18966.D71CE925; Wed,  4 Dec 2013 00:45:33 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAE016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:32 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqFt7cF6QQfsfZYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5Y/Hc+a8ER54qNq8+yNjC+
	M+ti5OSQEDCRmLughwXCFpO4cG89WxcjF4eQwGVGiad3njFDOOeZJKYcWsMKUsUmoCuxqKeZ
	CcQWERCXeHt8JnsXIwcHs0CExKG3JSBhYQEnidPbDjKD2CwCqhLTbt5kBCnhFXCV2HhYCmKX
	gkTnmv+MIDYnULijdwkzSImQgIvEvbNOExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3S
	NdLLzSzRS00p3cQICRPeHYz/18kcYhTgYFTi4U3gnBckxJpYVlyZe4hRkoNJSZS3fjtQiC8p
	P6UyI7E4I76oNCe1+BCjBAezkgivTRlQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1
	ILUIJivDwaEkwfv2AFCjYFFqempFWmZOCUKaiYMTRHCBbOAB2vAKpJC3uCAxtzgzHaLoFKOi
	lDjvGZCEAEgiozQPbgAsol8xigP9I8x7GKSKB5gM4LpfAQ1mAhps/moWyOCSRISUVANjrYHp
	uf0euo//mjubnTyg/XyLT96TyM5HFTLVFyPq1oope7UXV3eGFx9XfTH1Kd9GIfnr8xIZHilt
	fGjnfFrkLt/8ianskXMWqJ+79SJiSdRk1/tLd13M40lmX3p5157+GzJlc/OeP10ca7rvQ5FA
	qdPxZyGcHhqbBHM3svPl+/26c2fr5PtXlViKMxINtZiLihMBOV/HFsMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238760>

Allow "--prune=<pattern>" options to be provided to "git remote prune"
to specify which reference namespaces should be pruned.  "--prune"
without an argument and "--no-prune" are disallowed here as they make
no sense.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-remote.txt |  5 +++-
 builtin/remote.c             | 67 +++++++++++++++++++++++++++++++-------------
 t/t5505-remote.sh            | 15 ++++++++++
 3 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 02e50a9..9cbc986 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
-'git remote prune' [-n | --dry-run] <name>...
+'git remote prune' [-n | --dry-run] [--prune=<pattern>] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --no-prune | --prune[=<pattern>]...]
 				       [(<group> | <remote>)...]
 
@@ -157,6 +157,9 @@ These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
 +
+With `--prune=<pattern>`, only prune references whose names match
+pattern.  This option can be used multiple times.
++
 With `--dry-run` option, report what branches will be pruned, but do not
 actually prune them.
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 6aab923..e1d43e2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
-	N_("git remote prune [-n | --dry-run] <name>"),
+	N_("git remote prune [-n | --dry-run] [--prune=<pattern>] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune[=<pattern>] | --no-prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
@@ -326,10 +326,12 @@ struct ref_states {
 	int queried;
 };
 
-static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
+static int get_ref_states(const struct ref *remote_refs,
+			  struct ref_states *states,
+			  struct prune_option *prune_option)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
-	struct ref *ref, *stale_refs;
+	struct ref *ref;
 	int i;
 
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
@@ -346,15 +348,20 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs = get_stale_heads(states->remote->fetch,
-				     states->remote->fetch_refspec_nr,
-				     fetch_map, NULL);
-	for (ref = stale_refs; ref; ref = ref->next) {
-		struct string_list_item *item =
-			string_list_append(&states->stale, abbrev_branch(ref->name));
-		item->util = xstrdup(ref->name);
+	if (prune_option->prune) {
+		struct ref *stale_refs =
+			get_stale_heads(states->remote->fetch,
+					states->remote->fetch_refspec_nr,
+					fetch_map,
+					&prune_option->prune_patterns);
+
+		for (ref = stale_refs; ref; ref = ref->next) {
+			struct string_list_item *item =
+				string_list_append(&states->stale, abbrev_branch(ref->name));
+			item->util = xstrdup(ref->name);
+		}
+		free_refs(stale_refs);
 	}
-	free_refs(stale_refs);
 	free_refs(fetch_map);
 
 	sort_string_list(&states->new);
@@ -878,8 +885,9 @@ static int append_ref_to_tracked_list(const char *refname,
 }
 
 static int get_remote_ref_states(const char *name,
-				 struct ref_states *states,
-				 int query)
+				 struct ref_states *states, int query,
+				 struct prune_option *prune_option,
+				 int default_prune)
 {
 	struct transport *transport;
 	const struct ref *remote_refs;
@@ -897,8 +905,19 @@ static int get_remote_ref_states(const char *name,
 		transport_disconnect(transport);
 
 		states->queried = 1;
-		if (query & GET_REF_STATES)
-			get_ref_states(remote_refs, states);
+		if (query & GET_REF_STATES) {
+			struct prune_option remote_prune_option =
+				PRUNE_OPTION_INIT;
+
+			remote_prune_option.prune = prune_option->prune;
+			string_list_append_list(&remote_prune_option.prune_patterns,
+						&prune_option->prune_patterns);
+			prune_option_fill(states->remote,
+					  &remote_prune_option,
+					  default_prune);
+			get_ref_states(remote_refs, states, &remote_prune_option);
+			prune_option_clear(&remote_prune_option);
+		}
 		if (query & GET_HEAD_NAMES)
 			get_head_names(remote_refs, states);
 		if (query & GET_PUSH_REF_STATES)
@@ -1144,6 +1163,7 @@ static int show_all(void)
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0, query_flag = 0;
+	struct prune_option prune_option = PRUNE_OPTION_INIT;
 	struct option options[] = {
 		OPT_BOOL('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
@@ -1152,6 +1172,7 @@ static int show(int argc, const char **argv)
 	struct string_list info_list = STRING_LIST_INIT_NODUP;
 	struct show_info info;
 
+	prune_option.prune = 1;
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
 			     0);
 
@@ -1170,7 +1191,7 @@ static int show(int argc, const char **argv)
 		const char **url;
 		int url_nr;
 
-		get_remote_ref_states(*argv, &states, query_flag);
+		get_remote_ref_states(*argv, &states, query_flag, &prune_option, 1);
 
 		printf_ln(_("* remote %s"), *argv);
 		printf_ln(_("  Fetch URL: %s"), states.remote->url_nr > 0 ?
@@ -1268,7 +1289,7 @@ static int set_head(int argc, const char **argv)
 	} else if (opt_a && !opt_d && argc == 1) {
 		struct ref_states states;
 		memset(&states, 0, sizeof(states));
-		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
+		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES, NULL, 0);
 		if (!states.heads.nr)
 			result |= error(_("Cannot determine remote HEAD"));
 		else if (states.heads.nr > 1) {
@@ -1303,7 +1324,8 @@ static int set_head(int argc, const char **argv)
 	return result;
 }
 
-static int prune_remote(const char *remote, int dry_run)
+static int prune_remote(const char *remote, int dry_run,
+			struct prune_option *prune_option)
 {
 	int result = 0, i;
 	struct ref_states states;
@@ -1312,7 +1334,7 @@ static int prune_remote(const char *remote, int dry_run)
 		: _(" %s has become dangling!");
 
 	memset(&states, 0, sizeof(states));
-	get_remote_ref_states(remote, &states, GET_REF_STATES);
+	get_remote_ref_states(remote, &states, GET_REF_STATES, prune_option, 1);
 
 	if (states.stale.nr) {
 		printf_ln(_("Pruning %s"), remote);
@@ -1344,11 +1366,16 @@ static int prune_remote(const char *remote, int dry_run)
 static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
+	struct prune_option prune_option = PRUNE_OPTION_INIT;
 	struct option options[] = {
+		{ OPTION_CALLBACK, 0, "prune", &prune_option, N_("pattern"),
+		  N_("prune only references whose names match pattern"),
+		  PARSE_OPT_NONEG, prune_option_parse },
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT_END()
 	};
 
+	prune_option.prune = 1;
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_prune_usage,
 			     0);
 
@@ -1356,7 +1383,7 @@ static int prune(int argc, const char **argv)
 		usage_with_options(builtin_remote_prune_usage, options);
 
 	for (; argc; argc--, argv++)
-		result |= prune_remote(*argv, dry_run);
+		result |= prune_remote(*argv, dry_run, &prune_option);
 
 	return result;
 }
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0dffe47..e156174 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -243,6 +243,21 @@ test_expect_success 'prune' '
 	)
 '
 
+test_expect_success 'prune with --prune' '
+	git clone one prune-prune &&
+	(
+		cd prune-prune &&
+		git update-ref refs/remotes/origin/branch1 master &&
+		git update-ref refs/remotes/origin/branch2 master &&
+
+		test_must_fail git remote prune --prune origin &&
+		test_must_fail git remote prune --no-prune origin &&
+		git remote prune --prune="refs/remotes/*1" origin &&
+		test_must_fail git rev-parse origin/branch1 &&
+		git rev-parse origin/branch2
+	)
+'
+
 test_expect_success 'set-head --delete' '
 	(
 		cd test &&
-- 
1.8.4.3
