From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 17/23] builtin-remote: new show output style
Date: Tue, 24 Feb 2009 04:51:05 -0500
Message-ID: <43310a608c096dc40c9d39712a2f36433b783368.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu02-0002Ej-7y
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbZBXJwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbZBXJwD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:03 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998AbZBXJv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:59 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=I738mDeklMR0/b1UbgFEn7rKKcr0jbQXhMPQ6B0937A=;
        b=kdpoGRBovB9A+82Lkwrl3pQy7rPA2v6Tbg5JnAokm/OH0RyO011HgbwWcknJABv6za
         RzLg8zeq+m4S9gN/ostpgdNLCV1Rg3x+VhHrtE8YQkBM4u4r921Dna5xk+kj+hhzmdHb
         y+6L9OD8vNBm+P0i3YT/xLmDZjvnmlkvUCc4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dH3bEGXxws2/efK5ddAqvJF6HnPj8tGaZ8CP38zM4ZAmNBe95w84TfI06jbE9ydTnl
         Ag5/Z3HNkGPcs/V7wSKyCnNedwYnj4WhHFrAuMmTmqzKK2mCg6gIua9/6grPY2u6Flj/
         kJTkmx1C+/fWZcExtJzGntn+3Gs7933Dp42F4=
Received: by 10.100.166.9 with SMTP id o9mr5499089ane.59.1235469117389;
        Tue, 24 Feb 2009 01:51:57 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm9073521and.54.2009.02.24.01.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:56 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111273>

The existing output of "git remote show <remote>" is too verbose for the
information it provides. This patch teaches it to provide more
information in less space.

The output for push refspecs is addressed in followup patch.

Before the patch:

$ git remote show origin
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  HEAD branch: master
  Remote branch merged with 'git pull' while on branch master
    master
  Remote branch merged with 'git pull' while on branch next
    next
  Remote branches merged with 'git pull' while on branch octopus
    foo bar baz frotz
  New remote branch (next fetch will store in remotes/origin)
    html
  Stale tracking branch (use 'git remote prune')
    bogus
  Tracked remote branches
    maint
    man
    master
    next
    pu
    todo

After this patch:

$ git remote show origin
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  HEAD branch: master
  Remote branches:
    bogus  stale (use 'git remote prune' to remove)
    html   new (next fetch will store in remotes/origin)
    maint  tracked
    man    tracked
    master tracked
    next   tracked
    pu     tracked
    todo   tracked
  Local branches configured for 'git pull':
    master  rebases onto remote master
    next    rebases onto remote next
    octopus  merges with remote foo
                and with remote bar
                and with remote baz
                and with remote frotz

$ git remote show origin -n
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  HEAD branch: (not queried)
  Remote branches: (status not queried)
    bogus
    maint
    man
    master
    next
    pu
    todo
  Local branches configured for 'git pull':
    master  rebases onto remote master
    next    rebases onto remote next
    octopus  merges with remote foo
                and with remote bar
                and with remote baz
                and with remote frotz

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c  |  190 ++++++++++++++++++++++++++++++++++++++++-------------
 t/t5505-remote.sh |   31 +++++----
 2 files changed, 162 insertions(+), 59 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index a822bd5..852f779 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -149,6 +149,7 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
+	int rebase;
 };
 
 static struct string_list branch_list;
@@ -165,10 +166,11 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 static int config_read_branches(const char *key, const char *value, void *cb)
 {
 	if (!prefixcmp(key, "branch.")) {
+		const char *orig_key = key;
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
-		enum { REMOTE, MERGE } type;
+		enum { REMOTE, MERGE, REBASE } type;
 
 		key += 7;
 		if (!postfixcmp(key, ".remote")) {
@@ -177,6 +179,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else if (!postfixcmp(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
+		} else if (!postfixcmp(key, ".rebase")) {
+			name = xstrndup(key, strlen(key) - 7);
+			type = REBASE;
 		} else
 			return 0;
 
@@ -187,9 +192,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		info = item->util;
 		if (type == REMOTE) {
 			if (info->remote_name)
-				warning("more than one branch.%s", key);
+				warning("more than one %s", orig_key);
 			info->remote_name = xstrdup(value);
-		} else {
+		} else if (type == MERGE) {
 			char *space = strchr(value, ' ');
 			value = abbrev_branch(value);
 			while (space) {
@@ -200,7 +205,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(xstrdup(value), &info->merge);
-		}
+		} else
+			info->rebase = git_config_bool(orig_key, value);
 	}
 	return 0;
 }
@@ -215,6 +221,7 @@ static void read_branches(void)
 struct ref_states {
 	struct remote *remote;
 	struct string_list new, stale, tracked, heads;
+	int queried;
 };
 
 static int handle_one_branch(const char *refname,
@@ -637,20 +644,6 @@ static int rm(int argc, const char **argv)
 	return result;
 }
 
-static void show_list(const char *title, struct string_list *list,
-		      const char *extra_arg)
-{
-	int i;
-
-	if (!list->nr)
-		return;
-
-	printf(title, list->nr > 1 ? "es" : "", extra_arg);
-	printf("\n");
-	for (i = 0; i < list->nr; i++)
-		printf("    %s\n", list->items[i].string);
-}
-
 static void free_remote_ref_states(struct ref_states *states)
 {
 	string_list_clear(&states->new, 0);
@@ -694,6 +687,7 @@ static int get_remote_ref_states(const char *name,
 			states->remote->url[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
+		states->queried = 1;
 		if (query & GET_REF_STATES)
 			get_ref_states(remote_refs, states);
 		if (query & GET_HEAD_NAMES)
@@ -702,6 +696,103 @@ static int get_remote_ref_states(const char *name,
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
 	}
+	return 0;
+}
+
+struct show_info {
+	struct string_list *list;
+	struct ref_states *states;
+	int width;
+	int any_rebase;
+};
+
+int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
+{
+	struct show_info *info = cb_data;
+	int n = strlen(item->string);
+	if (n > info->width)
+		info->width = n;
+	string_list_insert(item->string, info->list);
+	return 0;
+}
+
+int show_remote_info_item(struct string_list_item *item, void *cb_data)
+{
+	struct show_info *info = cb_data;
+	struct ref_states *states = info->states;
+	const char *name = item->string;
+
+	if (states->queried) {
+		const char *fmt = "%s";
+		const char *arg = "";
+		if (string_list_has_string(&states->new, name)) {
+			fmt = " new (next fetch will store in remotes/%s)";
+			arg = states->remote->name;
+		} else if (string_list_has_string(&states->tracked, name))
+			arg = " tracked";
+		else if (string_list_has_string(&states->stale, name))
+			arg = " stale (use 'git remote prune' to remove)";
+		else
+			arg = " ???";
+		printf("    %-*s", info->width, name);
+		printf(fmt, arg);
+		printf("\n");
+	} else
+		printf("    %s\n", name);
+
+	return 0;
+}
+
+int add_local_to_show_info(struct string_list_item *branch_item, void *cb_data)
+{
+	struct show_info *show_info = cb_data;
+	struct ref_states *states = show_info->states;
+	struct branch_info *branch_info = branch_item->util;
+	struct string_list_item *item;
+	int n;
+
+	if (!branch_info->merge.nr || !branch_info->remote_name ||
+	    strcmp(states->remote->name, branch_info->remote_name))
+		return 0;
+	if ((n = strlen(branch_item->string)) > show_info->width)
+		show_info->width = n;
+	if (branch_info->rebase)
+		show_info->any_rebase = 1;
+
+	item = string_list_insert(branch_item->string, show_info->list);
+	item->util = branch_info;
+
+	return 0;
+}
+
+int show_local_info_item(struct string_list_item *item, void *cb_data)
+{
+	struct show_info *show_info = cb_data;
+	struct branch_info *branch_info = item->util;
+	struct string_list *merge = &branch_info->merge;
+	const char *also;
+	int i;
+
+	if (branch_info->rebase && branch_info->merge.nr > 1) {
+		error("invalid branch.%s.merge; cannot rebase onto > 1 branch",
+			item->string);
+		return 0;
+	}
+
+	printf("    %-*s ", show_info->width, item->string);
+	if (branch_info->rebase) {
+		printf("rebases onto remote %s\n", merge->items[0].string);
+		return 0;
+	} else if (show_info->any_rebase) {
+		printf(" merges with remote %s\n", merge->items[0].string);
+		also = "    and with remote";
+	} else {
+		printf("merges with remote %s\n", merge->items[0].string);
+		also = "   and with remote";
+	}
+	for (i = 1; i < merge->nr; i++)
+		printf("    %-*s %s %s\n", show_info->width, "", also,
+		       merge->items[i].string);
 
 	return 0;
 }
@@ -715,6 +806,8 @@ static int show(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
+	struct string_list info_list = { NULL, 0, 0, 0 };
+	struct show_info info;
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
@@ -725,6 +818,9 @@ static int show(int argc, const char **argv)
 		query_flag = (GET_REF_STATES | GET_HEAD_NAMES);
 
 	memset(&states, 0, sizeof(states));
+	memset(&info, 0, sizeof(info));
+	info.states = &states;
+	info.list = &info_list;
 	for (; argc; argc--, argv++) {
 		int i;
 
@@ -738,37 +834,37 @@ static int show(int argc, const char **argv)
 		else if (!states.heads.nr)
 			printf("  HEAD branch: (unknown)\n");
 		else if (states.heads.nr == 1)
-			printf("  HEAD branch: %s\n",
-				states.heads.items[0].string);
-		else
-			show_list("  HEAD branch%s:", &states.heads, "");
-
-		for (i = 0; i < branch_list.nr; i++) {
-			struct string_list_item *branch = branch_list.items + i;
-			struct branch_info *info = branch->util;
-			int j;
-
-			if (!info->merge.nr || strcmp(*argv, info->remote_name))
-				continue;
-			printf("  Remote branch%s merged with 'git pull' "
-				"while on branch %s\n   ",
-				info->merge.nr > 1 ? "es" : "",
-				branch->string);
-			for (j = 0; j < info->merge.nr; j++)
-				printf(" %s", info->merge.items[j].string);
-			printf("\n");
-		}
-
-		if (!no_query) {
-			show_list("  New remote branch%s (next fetch "
-				"will store in remotes/%s)",
-				&states.new, states.remote->name);
-			show_list("  Stale tracking branch%s (use 'git remote "
-				"prune')", &states.stale, "");
+			printf("  HEAD branch: %s\n", states.heads.items[0].string);
+		else {
+			printf("  HEAD branch (remote HEAD is ambiguous,"
+			       " may be one of the following):\n");
+			for (i = 0; i < states.heads.nr; i++)
+				printf("    %s\n", states.heads.items[i].string);
 		}
 
-		show_list("  Tracked remote branch%s", &states.tracked, "");
-
+		/* remote branch info */
+		info.width = 0;
+		for_each_string_list(add_remote_to_show_info, &states.new, &info);
+		for_each_string_list(add_remote_to_show_info, &states.tracked, &info);
+		for_each_string_list(add_remote_to_show_info, &states.stale, &info);
+		if (info.list->nr)
+			printf("  Remote branch%s:%s\n",
+			       info.list->nr > 1 ? "es" : "",
+				no_query ? " (status not queried)" : "");
+		for_each_string_list(show_remote_info_item, info.list, &info);
+		string_list_clear(info.list, 0);
+
+		/* git pull info */
+		info.width = 0;
+		info.any_rebase = 0;
+		for_each_string_list(add_local_to_show_info, &branch_list, &info);
+		if (info.list->nr)
+			printf("  Local branch%s configured for 'git pull':\n",
+			       info.list->nr > 1 ? "es" : "");
+		for_each_string_list(show_local_info_item, info.list, &info);
+		string_list_clear(info.list, 0);
+
+		/* git push info */
 		if (states.remote->push_refspec_nr) {
 			printf("  Local branch%s pushed with 'git push'\n",
 				states.remote->push_refspec_nr > 1 ?
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 56146eb..835adbd 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -28,7 +28,7 @@ tokens_match () {
 }
 
 check_remote_track () {
-	actual=$(git remote show "$1" | sed -e '1,/Tracked/d') &&
+	actual=$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
 	shift &&
 	tokens_match "$*" "$actual"
 }
@@ -137,19 +137,21 @@ cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
   HEAD branch: master
-  Remote branch merged with 'git pull' while on branch master
-    master
-  New remote branch (next fetch will store in remotes/origin)
-    master
-  Tracked remote branches
-    master
-    side
+  Remote branches:
+    master new (next fetch will store in remotes/origin)
+    side   tracked
+  Local branches configured for 'git pull':
+    foo    rebases onto remote master
+    master  merges with remote master
+    oct     merges with remote topic-a
+               and with remote topic-b
+               and with remote topic-c
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
 * remote two
   URL: ../two
-  HEAD branches:
+  HEAD branch (remote HEAD is ambiguous, may be one of the following):
     another
     master
 EOF
@@ -159,8 +161,12 @@ test_expect_success 'show' '
 	 git config --add remote.origin.fetch \
 		refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
+	 git branch --track oct origin/master &&
+	 git branch --track foo origin/master &&
 	 git branch -d -r origin/master &&
 	 git config --add remote.two.url ../two &&
+	 git config branch.foo.rebase true &&
+	 git config branch.oct.merge "topic-a topic-b topic-c" &&
 	 (cd ../one &&
 	  echo 1 > file &&
 	  test_tick &&
@@ -170,6 +176,7 @@ test_expect_success 'show' '
 	 git config --add remote.origin.push \
 		+refs/tags/lastbackup &&
 	 git remote show origin two > output &&
+	 git branch -d foo oct &&
 	 test_cmp expect output)
 '
 
@@ -177,11 +184,11 @@ cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
   HEAD branch: (not queried)
-  Remote branch merged with 'git pull' while on branch master
-    master
-  Tracked remote branches
+  Remote branches: (status not queried)
     master
     side
+  Local branch configured for 'git pull':
+    master merges with remote master
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
-- 
1.6.2.rc1.291.g83eb
