From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 04/10] Sparse: fix some "symbol not declared" warnings
 (Part 2)
Date: Fri, 08 Jun 2007 23:13:46 +0100
Message-ID: <4669D49A.4080106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 01:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwo3c-0007G9-Ka
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 01:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184AbXFHXjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbXFHXji
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 19:39:38 -0400
Received: from anchor-fallback-95.mail.demon.net ([194.217.242.82]:41844 "EHLO
	anchor-fallback-95.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754585AbXFHXjh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 19:39:37 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1530 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S816182AbXFHWca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:32:30 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmxy-0005nh-1O; Fri, 08 Jun 2007 22:29:59 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49524>


The complete warning message reads something like:

    symbol 'whatever' was not declared. Should be static?

In this commit, the answer is yes; all of these symbols have
no need to be visible beyond the compilation unit, so make
them static.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-branch.c |    4 ++--
 builtin-revert.c |    6 +++---
 commit.c         |    2 +-
 daemon.c         |    2 +-
 refs.c           |    2 +-
 upload-pack.c    |    2 +-
 wt-status.c      |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 7408285..b2104fe 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -55,7 +55,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-int git_branch_config(const char *var, const char *value)
+static int git_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color = git_config_colorbool(var, value);
@@ -72,7 +72,7 @@ int git_branch_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
-const char *branch_get_color(enum color_branch ix)
+static const char *branch_get_color(enum color_branch ix)
 {
 	if (branch_use_color)
 		return branch_colors[ix];
diff --git a/builtin-revert.c b/builtin-revert.c
index ea2f15b..f58d32e 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -25,7 +25,7 @@ static const char *cherry_pick_usage = "git-cherry-pick [--edit] [-n] [-r] [-x]
 
 static int edit;
 static int replay;
-enum { REVERT, CHERRY_PICK } action;
+static enum { REVERT, CHERRY_PICK } action;
 static int no_commit;
 static struct commit *commit;
 static int needed_deref;
@@ -104,7 +104,7 @@ static char *get_oneline(const char *message)
 	return result;
 }
 
-char *get_encoding(const char *message)
+static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
@@ -126,7 +126,7 @@ char *get_encoding(const char *message)
 	return NULL;
 }
 
-struct lock_file msg_file;
+static struct lock_file msg_file;
 static int msg_fd;
 
 static void add_to_msg(const char *string)
diff --git a/commit.c b/commit.c
index bee066f..be0c76d 100644
--- a/commit.c
+++ b/commit.c
@@ -27,7 +27,7 @@ struct sort_node
 
 const char *commit_type = "commit";
 
-struct cmt_fmt_map {
+static struct cmt_fmt_map {
 	const char *n;
 	size_t cmp_len;
 	enum cmit_fmt v;
diff --git a/daemon.c b/daemon.c
index b79e905..64f1f34 100644
--- a/daemon.c
+++ b/daemon.c
@@ -439,7 +439,7 @@ static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
 	}
 }
 
-void fill_in_extra_table_entries(struct interp *itable)
+static void fill_in_extra_table_entries(struct interp *itable)
 {
 	char *hp;
 
diff --git a/refs.c b/refs.c
index 89876bf..820e6ac 100644
--- a/refs.c
+++ b/refs.c
@@ -150,7 +150,7 @@ static struct ref_list *sort_ref_list(struct ref_list *list)
  * Future: need to be in "struct repository"
  * when doing a full libification.
  */
-struct cached_refs {
+static struct cached_refs {
 	char did_loose;
 	char did_packed;
 	struct ref_list *loose;
diff --git a/upload-pack.c b/upload-pack.c
index d3a09e7..1046ea9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -62,7 +62,7 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 	return safe_write(fd, data, sz);
 }
 
-FILE *pack_pipe = NULL;
+static FILE *pack_pipe = NULL;
 static void show_commit(struct commit *commit)
 {
 	if (commit->object.flags & BOUNDARY)
diff --git a/wt-status.c b/wt-status.c
index a055990..fd8a877 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -197,7 +197,7 @@ static void wt_read_cache(struct wt_status *s)
 	read_cache();
 }
 
-void wt_status_print_initial(struct wt_status *s)
+static void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
 	char buf[PATH_MAX];
-- 
1.5.2
