From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Mon, 28 Apr 2008 11:32:18 -0400
Message-ID: <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
 <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 <65b938da49b447129297d4dbf20191be52d16670.1209391614.git.bonzini@gnu.org>
 <d941a7a16cb7d5529b22a47f1dc7b986ba66ee56.1209391615.git.bonzini@gnu.org>
 <b5b9b866e5f942d024831d528ae599e3e6ce31da.1209391615.git.bonzini@gnu.org>
 <22f5914b1ffff814fa2387ff5cb762e0099aaa6b.1209391615.git.bonzini@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:34:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMm-0004Kp-Nr
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935750AbYD1Pc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935743AbYD1Pc6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:58 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60621 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935590AbYD1Pcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:36 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004fH-Tz; Mon, 28 Apr 2008 11:32:19 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <22f5914b1ffff814fa2387ff5cb762e0099aaa6b.1209391615.git.bonzini@gnu.org>
In-Reply-To: <cover.1209391614.git.bonzini@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80542>

This patch parallels what a previous patch did to "git push".
It makes "git fetch" with no repository argument similar to
"git remote update" with no default group set.  Of course,
"git fetch" with no arguments honors skipDefaultUpdate too.

The patch also modifies the existing tests so that they do not execute
git-fetch without arguments.  In the case of t5515, tests that executed
git-fetch without arguments are removed completely.  A new test is
added to t5510 that tests the new operation mode.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-fetch.txt               |    7 ++
 builtin-fetch.c                           |  109 ++++++++++++++++-------------
 t/t5510-fetch.sh                          |   19 +++++-
 t/t5515-fetch-merge-logic.sh              |    8 +--
 t/t5515/fetch.br-branches-default         |    8 --
 t/t5515/fetch.br-branches-default-merge   |    9 ---
 t/t5515/fetch.br-branches-default-octopus |   10 ---
 t/t5515/fetch.br-branches-one             |    8 --
 t/t5515/fetch.br-branches-one-merge       |    9 ---
 t/t5515/fetch.br-branches-one-octopus     |    9 ---
 t/t5515/fetch.br-config-explicit          |   11 ---
 t/t5515/fetch.br-config-explicit-merge    |   11 ---
 t/t5515/fetch.br-config-explicit-octopus  |   11 ---
 t/t5515/fetch.br-config-glob              |   11 ---
 t/t5515/fetch.br-config-glob-merge        |   11 ---
 t/t5515/fetch.br-config-glob-octopus      |   11 ---
 t/t5515/fetch.br-remote-explicit          |   11 ---
 t/t5515/fetch.br-remote-explicit-merge    |   11 ---
 t/t5515/fetch.br-remote-explicit-octopus  |   11 ---
 t/t5515/fetch.br-remote-glob              |   11 ---
 t/t5515/fetch.br-remote-glob-merge        |   11 ---
 t/t5515/fetch.br-remote-glob-octopus      |   11 ---
 t/t5515/fetch.br-unconfig                 |   11 ---
 t/t5515/fetch.master                      |   11 ---
 t/t5515/refs.br-branches-default          |   12 ---
 t/t5515/refs.br-branches-default-merge    |   12 ---
 t/t5515/refs.br-branches-default-octopus  |   12 ---
 t/t5515/refs.br-branches-one              |   12 ---
 t/t5515/refs.br-branches-one-merge        |   12 ---
 t/t5515/refs.br-branches-one-octopus      |   12 ---
 t/t5515/refs.br-config-explicit           |   15 ----
 t/t5515/refs.br-config-explicit-merge     |   15 ----
 t/t5515/refs.br-config-explicit-octopus   |   15 ----
 t/t5515/refs.br-config-glob               |   15 ----
 t/t5515/refs.br-config-glob-merge         |   15 ----
 t/t5515/refs.br-config-glob-octopus       |   15 ----
 t/t5515/refs.br-remote-explicit           |   15 ----
 t/t5515/refs.br-remote-explicit-merge     |   15 ----
 t/t5515/refs.br-remote-explicit-octopus   |   15 ----
 t/t5515/refs.br-remote-glob               |   15 ----
 t/t5515/refs.br-remote-glob-merge         |   15 ----
 t/t5515/refs.br-remote-glob-octopus       |   15 ----
 t/t5515/refs.br-unconfig                  |   11 ---
 t/t5515/refs.master                       |   11 ---
 44 files changed, 88 insertions(+), 536 deletions(-)
 delete mode 100644 t/t5515/fetch.br-branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default-merge
 delete mode 100644 t/t5515/fetch.br-branches-default-octopus
 delete mode 100644 t/t5515/fetch.br-branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one-merge
 delete mode 100644 t/t5515/fetch.br-branches-one-octopus
 delete mode 100644 t/t5515/fetch.br-config-explicit
 delete mode 100644 t/t5515/fetch.br-config-explicit-merge
 delete mode 100644 t/t5515/fetch.br-config-explicit-octopus
 delete mode 100644 t/t5515/fetch.br-config-glob
 delete mode 100644 t/t5515/fetch.br-config-glob-merge
 delete mode 100644 t/t5515/fetch.br-config-glob-octopus
 delete mode 100644 t/t5515/fetch.br-remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit-merge
 delete mode 100644 t/t5515/fetch.br-remote-explicit-octopus
 delete mode 100644 t/t5515/fetch.br-remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob-merge
 delete mode 100644 t/t5515/fetch.br-remote-glob-octopus
 delete mode 100644 t/t5515/fetch.br-unconfig
 delete mode 100644 t/t5515/fetch.master
 delete mode 100644 t/t5515/refs.br-branches-default
 delete mode 100644 t/t5515/refs.br-branches-default-merge
 delete mode 100644 t/t5515/refs.br-branches-default-octopus
 delete mode 100644 t/t5515/refs.br-branches-one
 delete mode 100644 t/t5515/refs.br-branches-one-merge
 delete mode 100644 t/t5515/refs.br-branches-one-octopus
 delete mode 100644 t/t5515/refs.br-config-explicit
 delete mode 100644 t/t5515/refs.br-config-explicit-merge
 delete mode 100644 t/t5515/refs.br-config-explicit-octopus
 delete mode 100644 t/t5515/refs.br-config-glob
 delete mode 100644 t/t5515/refs.br-config-glob-merge
 delete mode 100644 t/t5515/refs.br-config-glob-octopus
 delete mode 100644 t/t5515/refs.br-remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit-merge
 delete mode 100644 t/t5515/refs.br-remote-explicit-octopus
 delete mode 100644 t/t5515/refs.br-remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob-merge
 delete mode 100644 t/t5515/refs.br-remote-glob-octopus
 delete mode 100644 t/t5515/refs.br-unconfig
 delete mode 100644 t/t5515/refs.master

	The patch is a little more complicated than necessary because
	some global variables were shadowed by locals.  That's a useful
	cleanup of its own.

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d982f96..f212d89 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -31,6 +31,13 @@ branches you are not interested in, you will not get them.
 
 OPTIONS
 -------
+<repository>::
+        The "remote" repository whose updates are to be
+	fetched.  If no repository is specified, all remotes
+	which do not have the configuration parameter
+	remote.<name>.skipDefaultUpdate set to true will
+	be updated.  (See linkgit:git-config[1])
+
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
diff --git a/builtin-fetch.c b/builtin-fetch.c
index e4486e4..d4aaf67 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -23,11 +23,13 @@ enum {
 };
 
 static int append, force, keep, update_head_ok, verbose, quiet;
-static int tags = TAGS_DEFAULT;
+static int fetch_tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
+static struct refspec *refs;
+static int ref_count = 0;
 
 static struct option builtin_fetch_options[] = {
 	OPT__QUIET(&quiet),
@@ -38,9 +40,9 @@ static struct option builtin_fetch_options[] = {
 		   "path to upload pack on remote end"),
 	OPT_BOOLEAN('f', "force", &force,
 		    "force overwrite of local branch"),
-	OPT_SET_INT('t', "tags", &tags,
+	OPT_SET_INT('t', "tags", &fetch_tags,
 		    "fetch all tags and associated objects", TAGS_SET),
-	OPT_SET_INT('n', NULL, &tags,
+	OPT_SET_INT('n', NULL, &fetch_tags,
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
@@ -523,15 +525,44 @@ static void find_non_local_tags(struct transport *transport,
 	path_list_clear(&new_refs, 0);
 }
 
-static int do_fetch(struct transport *transport,
-		    struct refspec *refs, int ref_count)
+static void set_option(const char *name, const char *value)
+{
+	int r = transport_set_option(transport, name, value);
+	if (r < 0)
+		die("Option \"%s\" value \"%s\" is not valid for %s\n",
+			name, value, transport->url);
+	if (r > 0)
+		warning("Option \"%s\" is ignored for %s\n",
+			name, transport->url);
+}
+
+
+static int do_fetch(struct remote *remote)
 {
 	struct ref *ref_map;
 	struct ref *rm;
-	int autotags = (transport->remote->fetch_tags == 1);
-	if (transport->remote->fetch_tags == 2 && tags != TAGS_UNSET)
+	int autotags = (remote->fetch_tags == 1);
+	int tags = fetch_tags;
+
+	if (!remote->url_nr)
+		die("Where do you want to fetch from today?");
+
+	transport = transport_get(remote, remote->url[0]);
+	assert (transport->url);
+	if (verbose >= 2)
+		transport->verbose = 1;
+	if (quiet)
+		transport->verbose = -1;
+	if (upload_pack)
+		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
+	if (keep)
+		set_option(TRANS_OPT_KEEP, "yes");
+	if (depth)
+		set_option(TRANS_OPT_DEPTH, depth);
+
+	if (remote->fetch_tags == 2 && tags != TAGS_UNSET)
 		tags = TAGS_SET;
-	if (transport->remote->fetch_tags == -1)
+	if (remote->fetch_tags == -1)
 		tags = TAGS_UNSET;
 
 	if (!transport->get_refs_list || !transport->fetch)
@@ -544,6 +575,7 @@ static int do_fetch(struct transport *transport,
 		if (!fp)
 			return error("cannot open %s: %s\n", filename, strerror(errno));
 		fclose(fp);
+		append = 1;
 	}
 
 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
@@ -557,7 +589,7 @@ static int do_fetch(struct transport *transport,
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (fetch_refs(transport, ref_map)) {
 		free_refs(ref_map);
-		return 1;
+		goto error;
 	}
 	free_refs(ref_map);
 
@@ -576,27 +608,26 @@ static int do_fetch(struct transport *transport,
 	}
 
 	transport_disconnect(transport);
-
 	return 0;
+
+error:
+	unlock_pack ();
+	return 1;
 }
 
-static void set_option(const char *name, const char *value)
+static int fetch_one_remote(struct remote *remote, void *unused)
 {
-	int r = transport_set_option(transport, name, value);
-	if (r < 0)
-		die("Option \"%s\" value \"%s\" is not valid for %s\n",
-			name, value, transport->url);
-	if (r > 0)
-		warning("Option \"%s\" is ignored for %s\n",
-			name, transport->url);
+	if (remote->skip_default_update || !remote->url_nr)
+		return 0;
+
+	do_fetch (remote);
 }
 
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
 	int i;
-	static const char **refs = NULL;
-	int ref_nr = 0;
+	static const char **arg_refs = NULL;
 
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
@@ -606,29 +637,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
-	if (argc == 0)
-		remote = remote_get(NULL);
-	else
-		remote = remote_get(argv[0]);
-
-	transport = transport_get(remote, remote->url[0]);
-	if (verbose >= 2)
-		transport->verbose = 1;
-	if (quiet)
-		transport->verbose = -1;
-	if (upload_pack)
-		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
-	if (keep)
-		set_option(TRANS_OPT_KEEP, "yes");
-	if (depth)
-		set_option(TRANS_OPT_DEPTH, depth);
-
-	if (!transport->url)
-		die("Where do you want to fetch from today?");
-
 	if (argc > 1) {
 		int j = 0;
-		refs = xcalloc(argc + 1, sizeof(const char *));
+		arg_refs = xcalloc(argc + 1, sizeof(const char *));
 		for (i = 1; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
 				char *ref;
@@ -640,16 +651,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 				strcat(ref, argv[i]);
 				strcat(ref, ":refs/tags/");
 				strcat(ref, argv[i]);
-				refs[j++] = ref;
+				arg_refs[j++] = ref;
 			} else
-				refs[j++] = argv[i];
+				arg_refs[j++] = argv[i];
 		}
-		refs[j] = NULL;
-		ref_nr = j;
+		arg_refs[j] = NULL;
+		ref_count = j;
 	}
+	refs = parse_fetch_refspec(ref_count, arg_refs);
 
 	signal(SIGINT, unlock_pack_on_signal);
-	atexit(unlock_pack);
-	return do_fetch(transport,
-			parse_fetch_refspec(ref_nr, refs), ref_nr);
+	if (argc == 0)
+		return for_each_remote (fetch_one_remote, NULL);
+	else
+		return do_fetch (remote_get(argv[0]));
 }
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6946557..28da6bd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -45,7 +45,7 @@ test_expect_success "fetch test" '
 	echo >file updated by origin &&
 	git commit -a -m "updated by origin" &&
 	cd two &&
-	git fetch &&
+	git fetch one &&
 	test -f .git/refs/heads/one &&
 	mine=`git rev-parse refs/heads/one` &&
 	his=`cd ../one && git rev-parse refs/heads/master` &&
@@ -55,12 +55,29 @@ test_expect_success "fetch test" '
 test_expect_success "fetch test for-merge" '
 	cd "$D" &&
 	cd three &&
+	git fetch two &&
+	test -f .git/refs/heads/two &&
+	test -f .git/refs/heads/one &&
+	master_in_two=`cd ../two && git rev-parse master` &&
+	one_in_two=`cd ../two && git rev-parse one` &&
+	{
+		echo "$master_in_two	not-for-merge"
+		echo "$one_in_two	"
+	} >expected &&
+	cut -f -2 .git/FETCH_HEAD >actual &&
+	diff expected actual'
+
+test_expect_success "fetch all remotes" '
+	cd "$D" &&
+	cd three &&
 	git fetch &&
 	test -f .git/refs/heads/two &&
 	test -f .git/refs/heads/one &&
+	master_in_origin=`cd .. && git rev-parse master` &&
 	master_in_two=`cd ../two && git rev-parse master` &&
 	one_in_two=`cd ../two && git rev-parse one` &&
 	{
+		echo "$master_in_origin	not-for-merge"
 		echo "$master_in_two	not-for-merge"
 		echo "$one_in_two	"
 	} >expected &&
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 65c3774..8568b4b 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -91,10 +91,7 @@ test_expect_success setup '
 # Merge logic depends on branch properties and Pull: or .fetch lines
 for remote in $remotes ; do
     for branch in "" "-merge" "-octopus" ; do
-cat <<EOF
-br-$remote$branch
-br-$remote$branch $remote
-EOF
+	echo br-$remote$branch $remote
     done
 done > tests
 
@@ -103,7 +100,6 @@ done > tests
 # Use two branches completely unrelated from the arguments,
 # the clone default and one without branch properties
 for branch in master br-unconfig ; do
-    echo $branch
     for remote in $remotes ; do
 	echo $branch $remote
     done
@@ -140,7 +136,7 @@ do
 		{
 			echo "# $cmd"
 			set x $cmd; shift
-			git symbolic-ref HEAD refs/heads/$1 ; shift
+			git symbolic-ref HEAD refs/heads/$1; shift
 			rm -f .git/FETCH_HEAD
 			rm -f .git/refs/heads/*
 			rm -f .git/refs/remotes/rem/*
diff --git a/t/t5515/fetch.br-branches-default b/t/t5515/fetch.br-branches-default
deleted file mode 100644
index 2e0414f..0000000
--- a/t/t5515/fetch.br-branches-default
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
deleted file mode 100644
index ca2cc1d..0000000
--- a/t/t5515/fetch.br-branches-default-merge
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-default-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
deleted file mode 100644
index ec39c54..0000000
--- a/t/t5515/fetch.br-branches-default-octopus
+++ /dev/null
@@ -1,10 +0,0 @@
-# br-branches-default-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one b/t/t5515/fetch.br-branches-one
deleted file mode 100644
index 12ac8d2..0000000
--- a/t/t5515/fetch.br-branches-one
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
deleted file mode 100644
index b4b3b35..0000000
--- a/t/t5515/fetch.br-branches-one-merge
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-one-merge
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-branches-one-octopus
deleted file mode 100644
index 96e3029..0000000
--- a/t/t5515/fetch.br-branches-one-octopus
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-one-octopus
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit b/t/t5515/fetch.br-config-explicit
deleted file mode 100644
index e2fa9c8..0000000
--- a/t/t5515/fetch.br-config-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-config-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge b/t/t5515/fetch.br-config-explicit-merge
deleted file mode 100644
index ec1a723..0000000
--- a/t/t5515/fetch.br-config-explicit-merge
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-config-explicit-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus b/t/t5515/fetch.br-config-explicit-octopus
deleted file mode 100644
index 7011dfc..0000000
--- a/t/t5515/fetch.br-config-explicit-octopus
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-config-explicit-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob b/t/t5515/fetch.br-config-glob
deleted file mode 100644
index e75ec2f..0000000
--- a/t/t5515/fetch.br-config-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-config-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge b/t/t5515/fetch.br-config-glob-merge
deleted file mode 100644
index ce8f739..0000000
--- a/t/t5515/fetch.br-config-glob-merge
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-config-glob-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-config-glob-octopus
deleted file mode 100644
index 938e532..0000000
--- a/t/t5515/fetch.br-config-glob-octopus
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-config-glob-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit b/t/t5515/fetch.br-remote-explicit
deleted file mode 100644
index 83534d2..0000000
--- a/t/t5515/fetch.br-remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-remote-explicit-merge
deleted file mode 100644
index a9064dd..0000000
--- a/t/t5515/fetch.br-remote-explicit-merge
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.br-remote-explicit-octopus
deleted file mode 100644
index ecf020d..0000000
--- a/t/t5515/fetch.br-remote-explicit-octopus
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob b/t/t5515/fetch.br-remote-glob
deleted file mode 100644
index 94e6ad3..0000000
--- a/t/t5515/fetch.br-remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remote-glob-merge
deleted file mode 100644
index 09362e2..0000000
--- a/t/t5515/fetch.br-remote-glob-merge
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
deleted file mode 100644
index b08e046..0000000
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig b/t/t5515/fetch.br-unconfig
deleted file mode 100644
index 65ce6d9..0000000
--- a/t/t5515/fetch.br-unconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-unconfig
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master b/t/t5515/fetch.master
deleted file mode 100644
index 950fd07..0000000
--- a/t/t5515/fetch.master
+++ /dev/null
@@ -1,11 +0,0 @@
-# master
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/refs.br-branches-default b/t/t5515/refs.br-branches-default
deleted file mode 100644
index 21917c1..0000000
--- a/t/t5515/refs.br-branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-merge b/t/t5515/refs.br-branches-default-merge
deleted file mode 100644
index 21917c1..0000000
--- a/t/t5515/refs.br-branches-default-merge
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-octopus b/t/t5515/refs.br-branches-default-octopus
deleted file mode 100644
index 21917c1..0000000
--- a/t/t5515/refs.br-branches-default-octopus
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one b/t/t5515/refs.br-branches-one
deleted file mode 100644
index 8a705a5..0000000
--- a/t/t5515/refs.br-branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-merge b/t/t5515/refs.br-branches-one-merge
deleted file mode 100644
index 8a705a5..0000000
--- a/t/t5515/refs.br-branches-one-merge
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-octopus b/t/t5515/refs.br-branches-one-octopus
deleted file mode 100644
index 8a705a5..0000000
--- a/t/t5515/refs.br-branches-one-octopus
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit b/t/t5515/refs.br-config-explicit
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-config-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit-merge b/t/t5515/refs.br-config-explicit-merge
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-config-explicit-merge
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-explicit-octopus b/t/t5515/refs.br-config-explicit-octopus
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-config-explicit-octopus
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob b/t/t5515/refs.br-config-glob
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-config-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob-merge b/t/t5515/refs.br-config-glob-merge
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-config-glob-merge
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-config-glob-octopus b/t/t5515/refs.br-config-glob-octopus
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-config-glob-octopus
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit b/t/t5515/refs.br-remote-explicit
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-merge b/t/t5515/refs.br-remote-explicit-merge
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-remote-explicit-merge
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-octopus b/t/t5515/refs.br-remote-explicit-octopus
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-remote-explicit-octopus
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob b/t/t5515/refs.br-remote-glob
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-merge b/t/t5515/refs.br-remote-glob-merge
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-remote-glob-merge
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-octopus b/t/t5515/refs.br-remote-glob-octopus
deleted file mode 100644
index 9bbbfd9..0000000
--- a/t/t5515/refs.br-remote-glob-octopus
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig b/t/t5515/refs.br-unconfig
deleted file mode 100644
index 13e4ad2..0000000
--- a/t/t5515/refs.br-unconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master b/t/t5515/refs.master
deleted file mode 100644
index 13e4ad2..0000000
--- a/t/t5515/refs.master
+++ /dev/null
@@ -1,11 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
-- 
1.5.5
