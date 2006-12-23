From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC] git reflog show
Date: Sat, 23 Dec 2006 05:19:56 -0500
Message-ID: <20061223101956.GD9396@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 23 11:20:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy3z6-0001bx-9Y
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 11:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbWLWKUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 05:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbWLWKUD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 05:20:03 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42938 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbWLWKUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 05:20:01 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy3yX-0001oh-M1; Sat, 23 Dec 2006 05:19:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7246D20FB65; Sat, 23 Dec 2006 05:19:57 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35310>

I'm toying with what a 'git reflog show' might look like.  I attached
the prototype code below.  Here's the output from the recent part of
my mmap pack window topic:

  $ ./git-reflog show refs/heads/sp/mapwin
  ...clipped for space...
  
  ref sp/mapwin@{10}
  commit f6ec09f.. -> 1960ea7..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:46:07 2006 -0500
  
      commit (amend): Support unmapping windows on 'temporary' packfiles.
  
  ref sp/mapwin@{9}
  commit 1960ea7.. -> e70352c..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:49:10 2006 -0500
  
      commit: Create pack_report() as a debugging aid.
  
  ref sp/mapwin@{8}
  commit e70352c.. -> 161cd2d..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:53:48 2006 -0500
  
      commit (amend): Create pack_report() as a debugging aid.
  
  ref sp/mapwin@{7}
  commit 161cd2d.. -> 81e4d26..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:03 2006 -0500
  
      reset --hard 
  
  ref sp/mapwin@{6}
  commit 81e4d26.. -> e69e59b..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:44 2006 -0500
  
      commit (amend): Fully activate the sliding window pack access.
  
  ref sp/mapwin@{5}
  commit e69e59b.. -> 11bedbb..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:51 2006 -0500
  
      am: Load core configuration in git-verify-pack.
  
  ref sp/mapwin@{4}
  commit 11bedbb.. -> 88035fd..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:52 2006 -0500
  
      am: Ensure core.packedGitWindowSize cannot be less than 2 pages.
  
  ref sp/mapwin@{3}
  commit 88035fd.. -> b3b706e..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:52 2006 -0500
  
      am: Improve error message when packfile mmap fails.
  
  ref sp/mapwin@{2}
  commit b3b706e.. -> 62c8beb..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:52 2006 -0500
  
      am: Support unmapping windows on 'temporary' packfiles.
  
  ref sp/mapwin@{1}
  commit 62c8beb.. -> 6b43fd0..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 01:58:52 2006 -0500
  
      am: Create pack_report() as a debugging aid.
  
  ref sp/mapwin@{0}
  commit 6b43fd0.. -> bbdc8fa..
  User: Shawn O. Pearce <spearce@spearce.org>
  Date: Sat Dec 23 02:06:23 2006 -0500
  
      commit: Test suite for sliding window mmap implementation.
  

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d4f7353..7156a2c 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -161,8 +161,173 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+struct cmd_reflog_list_ref
+{
+	const char *name;
+	unsigned int ent_cnt;
+};
+
+struct cmd_reflog_list_ent
+{
+	struct cmd_reflog_list_ent* next;
+	struct cmd_reflog_list_ref *ref;
+	const char *cmd;
+	char *user;
+	unsigned long timestamp;
+	int tz;
+	unsigned int pos;
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
+};
+
+struct cmd_reflog_list_cb
+{
+	struct cmd_reflog_list_ent* entries;
+	struct cmd_reflog_list_ref* cur_ref;
+	unsigned int ref_cnt;
+	unsigned int ent_cnt;
+};
+
+static int list_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		char *data, void *cb_data)
+{
+	struct cmd_reflog_list_cb *cb = cb_data;
+	struct cmd_reflog_list_ent *e;
+	unsigned long timestamp;
+	int tz;
+	char *user_end, *cp, *ep;
+
+	cp = strchr(data, '>');
+	if (!cp || *++cp != ' ')
+		return 0; /* corrupt line? */
+	user_end = cp;
+	timestamp = strtoul(cp, &ep, 10);
+	if (*ep++ != ' ')
+		return 0; /* corrupt line? */
+	tz = strtol(ep, &cp, 10);
+	if (*cp++ != '\t')
+		return 0; /* corrupt line? */
+
+	e = xmalloc(sizeof(*e));
+	e->ref = cb->cur_ref;
+	e->cmd = xstrdup(cp);
+	e->user = xmalloc(user_end - data + 1);
+	strncpy(e->user, data, user_end - data);
+	e->user[user_end - data] = 0;
+	e->timestamp = timestamp;
+	e->tz = tz;
+	e->pos = cb->cur_ref->ent_cnt++;
+	hashcpy(e->old_sha1, osha1);
+	hashcpy(e->new_sha1, nsha1);
+	e->next = cb->entries;
+	cb->entries = e;
+	cb->ent_cnt++;
+	return 0;
+}
+
+static int list_reflog(const char *ref, const unsigned char *sha1,
+		int unused, void *cb_data)
+{
+	struct cmd_reflog_list_cb *cb = cb_data;
+
+	cb->ref_cnt++;
+	cb->cur_ref = xmalloc(sizeof(*cb->cur_ref));
+	cb->cur_ref->name = xstrdup(ref);
+	cb->cur_ref->ent_cnt = 0;
+	for_each_reflog_ent(ref, list_reflog_ent, cb);
+	return 0;
+}
+
+static int list_cmp(const void *_a, const void *_b)
+{
+	const struct cmd_reflog_list_ent *a = *((void**)_a);
+	const struct cmd_reflog_list_ent *b = *((void**)_b);
+	if (a->ref == b->ref)
+		return a->pos < b->pos ? -1 : 1;
+	if (a->timestamp < b->timestamp)
+		return -1;
+	if (a->timestamp == b->timestamp)
+		return 0;
+	return 1;
+}
+
+static void reflog_show(struct cmd_reflog_list_ent *e)
+{
+	const char *ref = e->ref->name;
+	if (!strncmp("refs/heads/", ref, 11))
+		ref += 11;
+	printf("ref %s@{%u}\n", ref, e->ref->ent_cnt - e->pos - 1);
+	printf("commit ");
+	if (is_null_sha1(e->old_sha1))
+		printf("deleted");
+	else
+		printf("%s..", find_unique_abbrev(e->old_sha1, DEFAULT_ABBREV));
+	printf(" -> ");
+	if (is_null_sha1(e->new_sha1))
+		printf("deleted");
+	else
+		printf("%s..", find_unique_abbrev(e->new_sha1, DEFAULT_ABBREV));
+	printf("\n");
+	printf("User: %s\n", e->user);
+	printf("Date: %s\n", show_date(e->timestamp, e->tz, 0));
+	printf("\n");
+	printf("    %s\n", e->cmd);
+}
+
+static const char reflog_show_usage[] =
+"git-reflog show [--all|<refs>...]";
+
+static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
+{
+	struct cmd_reflog_list_cb cb;
+	unsigned char sha1[20];
+	int i, do_all = 0, status = 0;
+	struct cmd_reflog_list_ent **ent_arr;
+	struct cmd_reflog_list_ent *e;
+
+	cb.ref_cnt = 0;
+	cb.ent_cnt = 0;
+	cb.entries = NULL;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--all"))
+			do_all = 1;
+		else if (arg[0] == '-')
+			usage(reflog_show_usage);
+		else
+			break;
+	}
+	if (do_all)
+		status |= for_each_ref(list_reflog, &cb);
+	while (i < argc) {
+		const char *ref = argv[i++];
+		if (!resolve_ref(ref, sha1, 1, NULL))
+			status |= error("no such ref: %s", ref);
+		else
+			status |= list_reflog(ref, sha1, 0, &cb);
+	}
+	if (!cb.ref_cnt) {
+		const char *ref = "HEAD";
+		if (!resolve_ref(ref, sha1, 1, NULL))
+			status |= error("no such ref: %s", ref);
+		else
+			status |= list_reflog(ref, sha1, 0, &cb);
+	}
+
+	ent_arr = xmalloc(cb.ent_cnt * sizeof(*ent_arr));
+	for (i = 0, e = cb.entries; e; i++, e = e->next)
+		ent_arr[i] = e;
+	qsort(ent_arr, cb.ent_cnt, sizeof(*ent_arr), list_cmp);
+
+	for (i = 0; i < cb.ent_cnt; i++)
+		reflog_show(ent_arr[i]);
+
+	return status;
+}
+
 static const char reflog_usage[] =
-"git-reflog (expire | ...)";
+"git-reflog (expire | show | ...)";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
@@ -170,6 +335,8 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 		usage(reflog_usage);
 	else if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
+	else if (!strcmp(argv[1], "show"))
+		return cmd_reflog_show(argc - 1, argv + 1, prefix);
 	else
 		usage(reflog_usage);
 }
