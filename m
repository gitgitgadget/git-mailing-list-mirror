From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 00:14:31 -0500
Message-ID: <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 06:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Gm-0005K5-2z
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbZBSFOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 00:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbZBSFOt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:14:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:48516 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbZBSFOp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 00:14:45 -0500
Received: by gxk22 with SMTP id 22so689334gxk.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 21:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MYVL44of2iRnGMKV+IzyKI2wgU+cBnMrvL7mlnT1Q4g=;
        b=CPU9Kpwr2i2PJ9VbgIWCcy2NFstqnZw9VchPt1fYI2S6tc5AgijCsJT9eD89wiodZY
         0QRsC64kYuAK+A8NzGgtqoOSeptvbVCXWBfyq8DtaxFZgWbruQ0euq1OAM1Gi7+24HR0
         b6FvukkXeotXGYRaT6TkfAaK38f3AzUKfNBZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NpXafd6upw9HM965CpHg1G4dBqZwAEAHuq89OCbdVrakG0OjqiPWOdmStalJdfsO/k
         8EPF7S90TwRnNzIERSD9qCMPkhV4CFuQxPoQtN62S6I7NJnmL6fomvc0bWJby4oPNTQL
         s7EhGQeX1bhNhvFze+DyvO35HMb3tO/+9Bow4=
Received: by 10.151.44.15 with SMTP id w15mr580986ybj.249.1235020483897;
        Wed, 18 Feb 2009 21:14:43 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id h27sm2004096elf.17.2009.02.18.21.14.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 21:14:43 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110626>

The existing output of "git remote show <remote>" is too verbose for the
information it provides. This patch teaches it to provide more
information in less space.

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
    octopus merges w/remote foo, bar, baz, frotz

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
    octopus merges w/remote foo, bar, baz, frotz

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Dscho, using --patience made this more readable. So thank you for
adding that.

 builtin-remote.c  |  172 ++++++++++++++++++++++++++++++++++++++--------------
 t/t5505-remote.sh |   32 +++++-----
 2 files changed, 141 insertions(+), 63 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index b61f754..6f0e40f 100644
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
+		char *orig_key = key;
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
@@ -634,20 +641,6 @@ static int rm(int argc, const char **argv)
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
@@ -698,10 +691,93 @@ static int get_remote_ref_states(const char *name,
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
 	}
+	states->queried = query;
 
 	return 0;
 }
 
+struct show_info {
+	struct string_list *list;
+	struct ref_states *states;
+	int maxwidth;
+};
+
+int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
+{
+	struct show_info *info = cb_data;
+	int n = strlen(item->string);
+	if (n > info->maxwidth)
+		info->maxwidth = n;
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
+		printf("    %-*s", info->maxwidth, name);
+		printf(fmt, arg);
+		printf("\n");
+	} else
+		printf("    %s\n", name);
+
+	return 0;
+}
+
+int add_local_to_show_info(struct string_list_item *branch, void *cb_data)
+{
+	struct show_info *show_info = cb_data;
+	struct ref_states *states = show_info->states;
+	struct string_list_item *item;
+	struct branch_info *branch_info = branch->util;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+
+	if (!branch_info->merge.nr ||
+	    strcmp(states->remote->name, branch_info->remote_name))
+		return 0;
+	if ((i = strlen(branch->string)) > show_info->maxwidth)
+		show_info->maxwidth = i;
+
+	item = string_list_insert(branch->string, show_info->list);
+
+	if (branch_info->rebase)
+		strbuf_addf(&buf, "rebases onto remote");
+	else
+		strbuf_addf(&buf, "merges w/remote");
+
+	for (i = 0; i < branch_info->merge.nr; i++)
+		strbuf_addf(&buf, " %s,", branch_info->merge.items[i].string);
+
+	if (buf.len)
+		buf.buf[buf.len - 1] = '\0'; /* trailing comma */
+
+	item->util = strbuf_detach(&buf, NULL);
+	return 0;
+}
+
+int show_local_info_item(struct string_list_item *item, void *cb_data)
+{
+	struct show_info *info = cb_data;
+	printf("    %-*s %s\n", info->maxwidth, item->string, (char *) item->util);
+	return 0;
+}
+
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0;
@@ -711,6 +787,10 @@ static int show(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
+	struct string_list info_list = { NULL, 0, 0, 0 };
+	struct show_info info;
+	info.states = &states;
+	info.list = &info_list;
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
@@ -730,40 +810,38 @@ static int show(int argc, const char **argv)
 			printf("  HEAD branch: (not queried)\n");
 		else if (!states.heads.nr)
 			printf("  HEAD branch: (unknown)\n");
-		else if (states.heads.nr == 1)
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
+		else {
+			printf("  HEAD branch%s: ", states.heads.nr > 1 ? "es" : "");
+			for (i = 0; i < states.heads.nr; i++)
+				printf("%s%s", states.heads.items[i].string,
+					i < states.heads.nr - 1 ? ", " : "\n");
 		}
 
-		if (!no_query) {
-			show_list("  New remote branch%s (next fetch "
-				"will store in remotes/%s)",
-				&states.new, states.remote->name);
-			show_list("  Stale tracking branch%s (use 'git remote "
-				"prune')", &states.stale, "");
-		}
+		/* remote branch info */
+		for_each_string_list(add_remote_to_show_info, &states.new, &info);
+		for_each_string_list(add_remote_to_show_info, &states.tracked, &info);
+		for_each_string_list(add_remote_to_show_info, &states.stale, &info);
+		if (info.list->nr)
+			printf("  Remote branch%s:%s\n",
+			       info.list->nr > 1 ? "es" : "",
+				no_query ? " (status not queried)" : ""
+			);
+		for_each_string_list(show_remote_info_item, info.list, &info);
+		string_list_clear(info.list, 0);
+		info.maxwidth = 0;
 
-		show_list("  Tracked remote branch%s", &states.tracked, "");
+		/* git pull info */
+		for_each_string_list(add_local_to_show_info, &branch_list, &info);
+		if (info.list->nr)
+			printf("  Local branch%s configured for 'git pull':\n",
+			       info.list->nr > 1 ? "es" : "");
+		for_each_string_list(show_local_info_item, info.list, &info);
+		string_list_clear(info.list, 1);
+		info.maxwidth = 0;
 
+		/* git push info */
 		if (states.remote->push_refspec_nr) {
-			printf("  Local branch%s pushed with 'git push'\n",
+			printf("  Local branch%s configured for 'git push':\n",
 				states.remote->push_refspec_nr > 1 ?
 					"es" : "");
 			for (i = 0; i < states.remote->push_refspec_nr; i++) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fdc4a29..d3dea3a 100755
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
@@ -137,21 +137,18 @@ cat > test/expect << EOF
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
-  Local branches pushed with 'git push'
+  Remote branches:
+    master new (next fetch will store in remotes/origin)
+    side   tracked
+  Local branches configured for 'git pull':
+    foo    rebases onto remote master
+    master merges w/remote master
+  Local branches configured for 'git push':
     master:upstream
     +refs/tags/lastbackup
 * remote two
   URL: ../two
-  HEAD branches:
-    another
-    master
+  HEAD branches: another, master
 EOF
 
 test_expect_success 'show' '
@@ -159,8 +156,10 @@ test_expect_success 'show' '
 	 git config --add remote.origin.fetch \
 		refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
+	 git branch --track foo origin/master &&
 	 git branch -d -r origin/master &&
 	 git config --add remote.two.url ../two &&
+	 git config branch.foo.rebase true &&
 	 (cd ../one &&
 	  echo 1 > file &&
 	  test_tick &&
@@ -170,6 +169,7 @@ test_expect_success 'show' '
 	 git config --add remote.origin.push \
 		+refs/tags/lastbackup &&
 	 git remote show origin two > output &&
+	 git branch -d foo &&
 	 test_cmp expect output)
 '
 
@@ -177,12 +177,12 @@ cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
   HEAD branch: (not queried)
-  Remote branch merged with 'git pull' while on branch master
-    master
-  Tracked remote branches
+  Remote branches: (status not queried)
     master
     side
-  Local branches pushed with 'git push'
+  Local branch configured for 'git pull':
+    master merges w/remote master
+  Local branches configured for 'git push':
     master:upstream
     +refs/tags/lastbackup
 EOF
-- 
1.6.2.rc1.218.g1b4fab
