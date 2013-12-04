From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 11/11] remote: allow prune patterns to be configured
Date: Wed,  4 Dec 2013 06:44:50 +0100
Message-ID: <1386135890-13954-12-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5HT-0003XK-2P
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab3LDFpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:45:43 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44237 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752025Ab3LDFpg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:45:36 -0500
X-AuditID: 1207440f-b7f306d000006d99-9a-529ec17ff6f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id CF.AB.28057.F71CE925; Wed,  4 Dec 2013 00:45:35 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAG016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:35 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqFt/cF6Qwdp+U4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5on7iDsaA/oaL9ZgdrA+NS
	vy5GTg4JAROJ86t/M0LYYhIX7q1n62Lk4hASuMwocbHlGzOEc55JYvX6eawgVWwCuhKLepqZ
	QGwRAXGJt8dnsncxcnAwC0RIHHpbAmIKCzhJHD5cAFLBIqAq0de9hxnE5hVwldgy6QorxC4F
	ic41/8H2cgLFO3qXMIO0Cgm4SNw76zSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0T
	vdzMEr3UlNJNjJAw4d/B2LVe5hCjAAejEg9vAue8ICHWxLLiytxDjJIcTEqivPXbgUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeG3KgHK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQleqwNAjYJFqempFWmZOSUIaSYOThDBBbKBB2iDKUghb3FBYm5xZjpE0SlGRSlx
	XjGQhABIIqM0D24ALKJfMYoD/SPM6wlSxQNMBnDdr4AGMwENNn81C2RwSSJCSqqBcce3+9UG
	/E3+fxa15zjKKm74xfnDcukZRr2E9Qlht27G5m+YKxmWaHU/g2PHE45pi4219Eya68MXSzy/
	6/B4vWjxD7kzf3kcwgT3RYpvZmDX+rBr6T39BRr/YvNj165am/DwvMzL/lKZm5L1yxwMVryR
	CtC8L7U7QdbvvPOz7AjteuUjp4R6lFiKMxINtZiLihMB7MPcZsMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238753>

Add two new configuration settings,

    fetch.pruneRef
    remote.<name>.pruneRef

via which prune patterns (i.e., the equivalent of --prune=<pattern>)
can be configured globally or for particular remotes.  The default
remains the same, namely "*".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/config.txt        | 28 ++++++++++++++-----
 Documentation/fetch-options.txt |  7 +++++
 Documentation/git-remote.txt    | 13 +++++----
 remote.c                        | 47 +++++++++++++++++++++-----------
 remote.h                        |  1 +
 t/t5505-remote.sh               | 60 +++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh                | 13 +++++++++
 7 files changed, 143 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a405806..5a2118e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1069,6 +1069,14 @@ fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`.
 
+fetch.pruneRef::
+	Glob pattern matching the names of local references that are
+	subject to pruning when "git fetch --prune" or "git remote
+	prune" is run for this remote.  See the `--prune=<pattern>`
+	option to the linkgit:git-fetch[1] command for more
+	information.  This setting may be overridden for particular
+	remotes via remote.<name>.pruneRef.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
@@ -2047,6 +2055,20 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prune::
+	When set to true, fetching from this remote by default will
+	also remove any remote-tracking references that no longer
+	exist on the remote (as if the `--prune` option were given on
+	the command line).  Overrides `fetch.prune` settings, if any.
+	See also `remote.<name>.pruneRef`.
+
+remote.<name>.pruneRef::
+	Glob pattern matching the names of local references that are
+	subject to pruning when "git fetch --prune" or "git remote
+	prune" is run for this remote.  See the `--prune=<pattern>`
+	option to the linkgit:git-fetch[1] command for more
+	information.  This option overrides `fetch.pruneRef`.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
@@ -2085,12 +2107,6 @@ remote.<name>.vcs::
 	Setting this to a value <vcs> will cause Git to interact with
 	the remote with the git-remote-<vcs> helper.
 
-remote.<name>.prune::
-	When set to true, fetching from this remote by default will also
-	remove any remote-tracking references that no longer exist on the
-	remote (as if the `--prune` option was given on the command line).
-	Overrides `fetch.prune` settings, if any.
-
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 61d3f75..fa2cfdb 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -41,6 +41,7 @@ ifndef::git-pull[]
 
 -p::
 --prune[=<pattern>]::
+--no-prune::
 	After fetching, remove any remote-tracking references that no
 	longer exist on the remote.  Tags are not subject to pruning
 	if they are fetched only because of the default tag
@@ -53,6 +54,12 @@ ifndef::git-pull[]
 If pattern is specified, then it should be a glob pattern, and pruning
 is further restricted to references whose names match the pattern.
 This option can be specified multiple times.
++
+The default for `--prune`/`--no-prune` is taken from the configuration
+settings remote.<name>.prune or fetch.prune, or false if neither of
+these is set.  The default pattern is taken from
+remote.<name>.pruneRef or fetch.pruneRef, or "*" if neither of these
+is set.
 endif::git-pull[]
 
 ifndef::git-pull[]
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index dd48474..4e1f8b2 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -151,17 +151,20 @@ With `--prune`, display stale remote-tracking branches that no longer
 exist on the remote (this is the default).  With `--prune=<pattern>`,
 only report stale references whose names match <pattern> (this option
 can be used multiple times).  With `--no-prune`, do not report stale
-remote-tracking references at all.
+remote-tracking references at all.  See linkgit:git-fetch[1] for more
+information about how pruning patterns can be configured.
 +
 With `-n` option, the remote heads are not queried first with
 `git ls-remote <name>`; cached information is used instead.
 
 'prune'::
 
-Deletes all stale remote-tracking branches under <name>.
-These stale branches have already been removed from the remote repository
-referenced by <name>, but are still locally available in
-"remotes/<name>".
+Delete all stale remote-tracking branches for the specified remote(s).
+Stale remote-tracking branches are those that have already been
+deleted from the remote repository referenced by <name>, but are still
+present in the local repository (typically under
+"refs/remotes/<name>").  See linkgit:git-fetch[1] for more information
+about pruning and how it can be configured.
 +
 With `--prune=<pattern>`, only prune references whose names match
 pattern.  This option can be used multiple times.
diff --git a/remote.c b/remote.c
index 89c9eaa..cc7f8d6 100644
--- a/remote.c
+++ b/remote.c
@@ -79,44 +79,58 @@ int prune_option_parse(const struct option *opt, const char *arg, int unset)
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
-	int *fetch_prune_config = cb;
+	struct prune_option *prune_option = cb;
 
 	if (!strcmp(k, "fetch.prune")) {
-		*fetch_prune_config = git_config_bool(k, v);
+		prune_option->prune = git_config_bool(k, v);
+		return 0;
+	} else if (!strcmp(k, "fetch.pruneref")) {
+		string_list_append(&prune_option->prune_patterns, v);
 		return 0;
 	}
 	return 0;
 }
 
+static struct prune_option global_prune_option = PRUNE_OPTION_INIT;
+static int global_prune_option_read = 0;
+
 void prune_option_fill(struct remote *remote,
 		       struct prune_option *prune_option, int default_prune)
 {
+	if (!global_prune_option_read) {
+		git_config(git_fetch_config, &global_prune_option);
+		global_prune_option_read = 1;
+	}
+
 	if (prune_option->prune < 0) {
 		/*
 		 * The user specified neither --prune nor --no-prune;
 		 * use the configured value of remote.<name>.prune or
 		 * fetch.prune:
 		 */
-		if (remote->prune >= 0) {
+		if (remote->prune >= 0)
 			prune_option->prune = remote->prune;
-		} else {
-			int fetch_prune_config = -1;
-
-			git_config(git_fetch_config, &fetch_prune_config);
-
-			if (fetch_prune_config >= 0)
-				prune_option->prune = fetch_prune_config;
-			else
-				prune_option->prune = default_prune;
-		}
+		else if (global_prune_option.prune >= 0)
+			prune_option->prune = global_prune_option.prune;
+		else
+			prune_option->prune = default_prune;
 	}
 
 	if (prune_option->prune && !prune_option->prune_patterns.nr) {
 		/*
 		 * We want to prune, but no pruning patterns were
-		 * specified on the command line.  Default to "*".
+		 * specified on the command line.  Use the value from
+		 * remote.<name>.pruneRef or fetch.pruneRef if
+		 * available; otherwise, default to "*".
 		 */
-		string_list_append(&prune_option->prune_patterns, "*");
+		if (remote->prune_patterns.nr)
+			string_list_append_list(&prune_option->prune_patterns,
+						&remote->prune_patterns);
+		else if (global_prune_option.prune_patterns.nr)
+			string_list_append_list(&prune_option->prune_patterns,
+						&global_prune_option.prune_patterns);
+		else
+			string_list_append(&prune_option->prune_patterns, "*");
 	}
 }
 
@@ -234,6 +248,7 @@ static struct remote *make_remote(const char *name, int len)
 
 	ret = xcalloc(1, sizeof(struct remote));
 	ret->prune = -1;  /* unspecified */
+	ret->prune_patterns.strdup_strings = 1;
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
 	if (len)
@@ -492,6 +507,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".prune"))
 		remote->prune = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".pruneref"))
+		string_list_append(&remote->prune_patterns, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index a484290..503c5c8 100644
--- a/remote.h
+++ b/remote.h
@@ -44,6 +44,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	struct string_list prune_patterns;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e156174..e6e0abe 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -258,6 +258,36 @@ test_expect_success 'prune with --prune' '
 	)
 '
 
+test_expect_success 'prune with remote pruneRef config' '
+	git clone one prune-remote-config &&
+	(
+		cd prune-remote-config &&
+		# This first setting should not matter:
+		git config fetch.pruneRef "*" &&
+		git config remote.origin.pruneRef "refs/remotes/*1" &&
+		git update-ref refs/remotes/origin/branch1 master &&
+		git update-ref refs/remotes/origin/branch2 master &&
+
+		git remote prune origin &&
+		test_must_fail git rev-parse origin/branch1 &&
+		git rev-parse origin/branch2
+	)
+'
+
+test_expect_success 'prune with global pruneRef config' '
+	git clone one prune-global-config &&
+	(
+		cd prune-global-config &&
+		git config fetch.pruneRef "refs/remotes/*1" &&
+		git update-ref refs/remotes/origin/branch1 master &&
+		git update-ref refs/remotes/origin/branch2 master &&
+
+		git remote prune origin &&
+		test_must_fail git rev-parse origin/branch1 &&
+		git rev-parse origin/branch2
+	)
+'
+
 test_expect_success 'set-head --delete' '
 	(
 		cd test &&
@@ -642,6 +672,36 @@ test_expect_success 'update --prune with argument' '
 	)
 '
 
+test_expect_success 'update --prune with remote pruneRef config' '
+	git clone one update-prune-remote-config &&
+	(
+		cd update-prune-remote-config &&
+		# This first setting should not matter:
+		git config fetch.pruneRef "*" &&
+		git config remote.origin.pruneRef "refs/remotes/*1" &&
+		git update-ref refs/remotes/origin/branch1 master &&
+		git update-ref refs/remotes/origin/branch2 master &&
+
+		git remote update --prune origin &&
+		test_must_fail git rev-parse origin/branch1 &&
+		git rev-parse origin/branch2
+	)
+'
+
+test_expect_success 'update --prune with global pruneRef config' '
+	git clone one update-prune-global-config &&
+	(
+		cd update-prune-global-config &&
+		git config fetch.pruneRef "refs/remotes/*1" &&
+		git update-ref refs/remotes/origin/branch1 master &&
+		git update-ref refs/remotes/origin/branch2 master &&
+
+		git remote update --prune origin &&
+		test_must_fail git rev-parse origin/branch1 &&
+		git rev-parse origin/branch2
+	)
+'
+
 cat >one/expect <<-\EOF
   apis/master
   apis/side
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 42eb21f..c82b929 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -94,6 +94,19 @@ test_expect_success 'fetch --prune on its own works as expected' '
 	test_must_fail git rev-parse origin/extrabranch
 '
 
+test_expect_success 'fetch with pruneRef config' '
+	cd "$D" &&
+	git clone . prune-config &&
+	cd prune-config &&
+	git config remote.origin.pruneRef "refs/remotes/*1" &&
+	git update-ref refs/remotes/origin/branch1 master &&
+	git update-ref refs/remotes/origin/branch2 master &&
+
+	git fetch --prune origin &&
+	test_must_fail git rev-parse origin/branch1 &&
+	git rev-parse origin/branch2
+'
+
 test_expect_success 'fetch --prune with arguments' '
 	cd "$D" &&
 	git clone . prune-args &&
-- 
1.8.4.3
