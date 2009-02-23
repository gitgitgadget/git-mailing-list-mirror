From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 07/13] remote: new show output style
Date: Mon, 23 Feb 2009 01:28:55 -0500
Message-ID: <904c2d8fe812fb5400d1b9946795c146de68eaca.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULO-00072Y-1O
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZBWG3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZBWG32
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:28 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:12876 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZBWG3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:21 -0500
Received: by yx-out-2324.google.com with SMTP id 8so746765yxm.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2tfntA7yXiZmF7bCT+ZWkB66r8NdRM8cubvABUo1y2A=;
        b=XhERklWOSHIQf6xt8f32uDBwwVxh2Qz63BeQPKuX7gwnKYvpfRtqYp/D4ChmJNYIMB
         s04Zhybdxcr2+q5NwWhTJFFkyyIO872/O4pEOwNHO9jo7Q6S9HqJaJc793eLnFK8Blnw
         B+ylVg598PDMExiRd2o82dU3S2V0igJvRPY6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C5LIsUVgMLGSCt3XUEDLFWIvtrhM+3HF6BOs0nfNOMK7+CPgtkCzIBmMMFyV4xgzEh
         velo4VYcHGC0ZapFcgkiRBFNszazVVGSs5vzUv02gniZz4Uo0nPaSLQ0BK1ukrttc6VR
         BvIYU1Zs+mXIOLn8Y/aOg1yz2JBAGqKnojLu4=
Received: by 10.100.41.9 with SMTP id o9mr3540461ano.39.1235370561042;
        Sun, 22 Feb 2009 22:29:21 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c28sm12347124anc.45.2009.02.22.22.29.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:20 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111098>

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
I incorporated the feedback I received to gmane 110626. As the commit
message mentions, the push refspec output is addressed in a later patch
in this series.

 builtin-remote.c  |  187 ++++++++++++++++++++++++++++++++++++++++-------------
 t/t5505-remote.sh |   31 ++++++----
 2 files changed, 161 insertions(+), 57 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index df6b525..4975a0e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -146,6 +146,7 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
+	int rebase;
 };
 
 static struct string_list branch_list;
@@ -162,10 +163,11 @@ static const char *abbrev_ref(const char *name, const char *prefix)
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
@@ -174,6 +176,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else if (!postfixcmp(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
+		} else if (!postfixcmp(key, ".rebase")) {
+			name = xstrndup(key, strlen(key) - 7);
+			type = REBASE;
 		} else
 			return 0;
 
@@ -184,9 +189,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
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
@@ -197,7 +202,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(xstrdup(value), &info->merge);
-		}
+		} else
+			info->rebase = git_config_bool(orig_key, value);
 	}
 	return 0;
 }
@@ -212,6 +218,7 @@ static void read_branches(void)
 struct ref_states {
 	struct remote *remote;
 	struct string_list new, stale, tracked, heads;
+	int queried;
 };
 
 static int handle_one_branch(const char *refname,
@@ -635,20 +642,6 @@ static int rm(int argc, const char **argv)
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
@@ -698,6 +691,105 @@ static int get_remote_ref_states(const char *name,
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
 	}
+	states->queried = query;
+
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
@@ -711,6 +803,8 @@ static int show(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
+	struct string_list info_list = { NULL, 0, 0, 0 };
+	struct show_info info;
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
@@ -718,6 +812,9 @@ static int show(int argc, const char **argv)
 		return show_all();
 
 	memset(&states, 0, sizeof(states));
+	memset(&info, 0, sizeof(info));
+	info.states = &states;
+	info.list = &info_list;
 	for (; argc; argc--, argv++) {
 		int i;
 
@@ -731,37 +828,37 @@ static int show(int argc, const char **argv)
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
+			printf("  HEAD branch: %s\n", states.heads.items[0].string);
+		else {
+			printf("  HEAD branch (remote HEAD is ambiguous,"
+			       " may be one of the following):\n");
+			for (i = 0; i < states.heads.nr; i++)
+				printf("    %s\n", states.heads.items[i].string);
 		}
 
-		if (!no_query) {
-			show_list("  New remote branch%s (next fetch "
-				"will store in remotes/%s)",
-				&states.new, states.remote->name);
-			show_list("  Stale tracking branch%s (use 'git remote "
-				"prune')", &states.stale, "");
-		}
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
 
-		show_list("  Tracked remote branch%s", &states.tracked, "");
+		/* git pull info */
+		info.width = 0;
+		info.any_rebase = 0;
+		for_each_string_list(add_local_to_show_info, &branch_list, &info);
+		if (info.list->nr)
+			printf("  Local branch%s configured for 'git pull':\n",
+			       info.list->nr > 1 ? "es" : "");
+		for_each_string_list(show_local_info_item, info.list, &info);
+		string_list_clear(info.list, 0);
 
+		/* git push info */
 		if (states.remote->push_refspec_nr) {
 			printf("  Local branch%s pushed with 'git push'\n",
 				states.remote->push_refspec_nr > 1 ?
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fdc4a29..6dd971e 100755
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
1.6.2.rc1.223.gfed32
