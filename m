From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] show-branch --reflog: show the reflog message at the top.
Date: Fri, 19 Jan 2007 15:51:07 -0800
Message-ID: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 20 00:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83Vv-00040z-QY
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 00:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbXASXvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 18:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbXASXvL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 18:51:11 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62366 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXASXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 18:51:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119235108.WNST9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 18:51:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DBrR1W00E1kojtg0000000; Fri, 19 Jan 2007 18:51:25 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37222>

This changes the output so the list at the top shows the reflog
message, along with their relative timestamps.

You can use --reflog=<n> to show <n> most recent log entries, or
use --reflog=<n>,<b> to show <n> entries going back from the
entry <b>.  <b> can be either a number (so --reflog=4,20 shows 4
records starting from @{20}) or a timestamp (e.g. --reflog='4,1 day').

Here is a sample output (with --list option):

  $ git show-branch --reflog=10 --list jc/show-reflog
    [jc/show-reflog@{0}] (3 minutes ago) commit (amend): show-branch --ref
    [jc/show-reflog@{1}] (5 minutes ago) reset HEAD^
    [jc/show-reflog@{2}] (14 minutes ago) commit: show-branch --reflog: sho
    [jc/show-reflog@{3}] (14 minutes ago) commit: show-branch --reflog: sho
    [jc/show-reflog@{4}] (18 minutes ago) commit (amend): Extend read_ref_a
    [jc/show-reflog@{5}] (18 minutes ago) commit (amend): Extend read_ref_a
    [jc/show-reflog@{6}] (18 minutes ago) commit (amend): Extend read_ref_a
    [jc/show-reflog@{7}] (18 minutes ago) am: read_ref_at(): allow retrievi
    [jc/show-reflog@{8}] (18 minutes ago) reset --hard HEAD~4
    [jc/show-reflog@{9}] (61 minutes ago) commit: show-branch --reflog: use

This shows what I did more cleanly:

  $ git show-branch --reflog=10 jc/show-reflog
  ! [jc/show-reflog@{0}] (3 minutes ago) commit (amend): show-branch --ref
   ! [jc/show-reflog@{1}] (5 minutes ago) reset HEAD^
    ! [jc/show-reflog@{2}] (14 minutes ago) commit: show-branch --reflog:
     ! [jc/show-reflog@{3}] (14 minutes ago) commit: show-branch --reflog:
      ! [jc/show-reflog@{4}] (18 minutes ago) commit (amend): Extend read_
       ! [jc/show-reflog@{5}] (18 minutes ago) commit (amend): Extend read
        ! [jc/show-reflog@{6}] (18 minutes ago) commit (amend): Extend rea
         ! [jc/show-reflog@{7}] (18 minutes ago) am: read_ref_at(): allow
          ! [jc/show-reflog@{8}] (18 minutes ago) reset --hard HEAD~4
           ! [jc/show-reflog@{9}] (61 minutes ago) commit: show-branch --r
  ----------
  +          [jc/show-reflog@{0}] show-branch --reflog: show the reflog
    +        [jc/show-reflog@{2}] show-branch --reflog: show the reflog
   +++       [jc/show-reflog@{1}] show-branch --reflog: show the reflog
  +++++      [jc/show-reflog@{4}] Extend read_ref_at() to be usable fro
       +     [jc/show-reflog@{5}] Extend read_ref_at() to be usable fro
        +    [jc/show-reflog@{6}] Extend read_ref_at() to be usable fro
         +   [jc/show-reflog@{7}] read_ref_at(): allow retrieving the r
           + [jc/show-reflog@{9}] show-branch --reflog: use updated rea
           + [jc/show-reflog@{9}^] read_ref_at(): allow reporting the c
           + [jc/show-reflog@{9}~2] show-branch --reflog: show the refl
           + [jc/show-reflog@{9}~3] read_ref_at(): allow retrieving the
  ++++++++++ [jc/show-reflog@{8}] dwim_ref(): Separate name-to-ref DWIM

At @{9}, I had a commit to complete 5 patch series, but I wanted
to consolidate two commits that enhances read_ref_at() into one
(they were @{9}^ and @{9}~3), and another two that touch show-branch
into one (@{9} and @{9}~2).

I first saved them with "format-patch -4", and then did a reset
at @{8}.  At @{7}, I applied one of them with "am", and then
used "git-apply" on the other one, and amended the commit at
@{6} (so @{6} and @{7} has the same parent).  I did not like the
log message, so I amended again at @{5}.

Then I cherry-picked @{9}~2 to create @{3} (the log message
shows that it needs to learn to set GIT_REFLOG_ACTION -- it uses
"git-commit" and the log entry is attributed for it).  Another
cherry-pick built @{2} out of @{9}, but what I wanted to do was
to squash these two into one, so I did a "reset HEAD^" at @{1}
and then made the final commit by amending what was at the top.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-show-branch.txt |   15 ++++-
 builtin-show-branch.c             |  122 ++++++++++++++++++++++++++++--------
 refs.c                            |    5 +-
 3 files changed, 109 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 912e15b..529f3a6 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-show-branch' [--all] [--remotes] [--topo-order] [--current]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics] [<rev> | <glob>]...
-'git-show-branch' --reflog[=<n>] <ref>
+'git-show-branch' --reflog[=<n>[,<base>]] [--list] <ref>
 
 DESCRIPTION
 -----------
@@ -97,8 +97,10 @@ OPTIONS
 	will show the revisions given by "git rev-list {caret}master
 	topic1 topic2"
 
---reflog[=<n>] <ref>::
-	Shows <n> most recent ref-log entries for the given ref.
+--reflog[=<n>[,<base>]] <ref>::
+	Shows <n> most recent ref-log entries for the given
+	ref.  If <base> is given, <n> entries going back from
+	that entry.  <base> can be specified as count or date
 
 
 Note that --more, --list, --independent and --merge-base options
@@ -165,6 +167,13 @@ With this, `git show-branch` without extra parameters would show
 only the primary branches.  In addition, if you happen to be on
 your topic branch, it is shown as well.
 
+------------
+$ git show-branch --reflog='10,1 hour ago' --list master
+------------
+
+shows 10 reflog entries going back from the tip as of 1 hour ago.
+Without `--list`, the output also shows how these tips are
+topologically related with each other.
 
 
 Author
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c67f2fa..452c15f 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -346,18 +346,21 @@ static void sort_ref_range(int bottom, int top)
 	      compare_ref_name);
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_ref(const char *refname, const unsigned char *sha1,
+		      int allow_dups)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	int i;
 
 	if (!commit)
 		return 0;
-	/* Avoid adding the same thing twice */
-	for (i = 0; i < ref_name_cnt; i++)
-		if (!strcmp(refname, ref_name[i]))
-			return 0;
 
+	if (!allow_dups) {
+		/* Avoid adding the same thing twice */
+		for (i = 0; i < ref_name_cnt; i++)
+			if (!strcmp(refname, ref_name[i]))
+				return 0;
+	}
 	if (MAX_REVS <= ref_name_cnt) {
 		fprintf(stderr, "warning: ignoring %s; "
 			"cannot handle more than %d refs\n",
@@ -380,7 +383,7 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, flag, cb_data);
+	return append_ref(refname + ofs, sha1, 0);
 }
 
 static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
@@ -394,14 +397,14 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, flag, cb_data);
+	return append_ref(refname + ofs, sha1, 0);
 }
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (strncmp(refname, "refs/tags/", 10))
 		return 0;
-	return append_ref(refname + 5, sha1, flag, cb_data);
+	return append_ref(refname + 5, sha1, 0);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -434,7 +437,7 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 		return append_head_ref(refname, sha1, flag, cb_data);
 	if (!strncmp("refs/tags/", refname, 10))
 		return append_tag_ref(refname, sha1, flag, cb_data);
-	return append_ref(refname, sha1, flag, cb_data);
+	return append_ref(refname, sha1, 0);
 }
 
 static void snarf_refs(int head, int remotes)
@@ -507,7 +510,7 @@ static void append_one_rev(const char *av)
 {
 	unsigned char revkey[20];
 	if (!get_sha1(av, revkey)) {
-		append_ref(av, revkey, 0, NULL);
+		append_ref(av, revkey, 0);
 		return;
 	}
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
@@ -562,9 +565,24 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	return 0;
 }
 
+static void parse_reflog_param(const char *arg, int *cnt, const char **base)
+{
+	char *ep;
+	*cnt = strtoul(arg, &ep, 10);
+	if (*ep == ',')
+		*base = ep + 1;
+	else if (*ep)
+		die("unrecognized reflog param '%s'", arg + 9);
+	else
+		*base = NULL;
+	if (*cnt <= 0)
+		*cnt = DEFAULT_REFLOG;
+}
+
 int cmd_show_branch(int ac, const char **av, const char *prefix)
 {
 	struct commit *rev[MAX_REVS], *commit;
+	char *reflog_msg[MAX_REVS];
 	struct commit_list *list = NULL, *seen = NULL;
 	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
@@ -585,6 +603,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int topics = 0;
 	int dense = 1;
 	int reflog = 0;
+	const char *reflog_base = NULL;
 
 	git_config(git_show_branch_config);
 
@@ -631,21 +650,27 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		else if (!strcmp(arg, "--reflog")) {
 			reflog = DEFAULT_REFLOG;
 		}
-		else if (!strncmp(arg, "--reflog=", 9)) {
-			char *end;
-			reflog = strtoul(arg + 9, &end, 10);
-			if (*end != '\0')
-				die("unrecognized reflog count '%s'", arg + 9);
-		}
+		else if (!strncmp(arg, "--reflog=", 9))
+			parse_reflog_param(arg + 9, &reflog, &reflog_base);
 		else
 			usage(show_branch_usage);
 		ac--; av++;
 	}
 	ac--; av++;
 
-	/* Only one of these is allowed */
-	if (1 < independent + merge_base + (extra != 0) + (!!reflog))
-		usage(show_branch_usage);
+	if (!!extra || !!reflog) {
+		/* "listing" mode is incompatible with
+		 * independent nor merge-base modes.
+		 */
+		if (independent || merge_base)
+			usage(show_branch_usage);
+		if (!!reflog && (0 < extra))
+			/*
+			 * Asking for --more in reflog mode does not
+			 * make sense.
+			 */
+			usage(show_branch_usage);
+	}
 
 	/* If nothing is specified, show all branches by default */
 	if (ac + all_heads + all_remotes == 0)
@@ -654,14 +679,51 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	if (all_heads + all_remotes)
 		snarf_refs(all_heads, all_remotes);
 	if (reflog) {
-		int reflen;
-		if (!ac)
+		unsigned char sha1[20];
+		char nth_desc[256];
+		char *ref;
+		int base = 0;
+		if (ac != 1)
 			die("--reflog option needs one branch name");
-		reflen = strlen(*av);
+		if (!dwim_ref(*av, strlen(*av), sha1, &ref))
+			die("No such ref %s", *av);
+
+		/* Has the base been specified? */
+		if (reflog_base) {
+			char *ep;
+			base = strtoul(reflog_base, &ep, 10);
+			if (*ep) {
+				/* Ah, that is a date spec... */
+				unsigned long at;
+				at = approxidate(reflog_base);
+				read_ref_at(ref, at, -1, sha1, NULL,
+					    NULL, NULL, &base);
+			}
+		}
+
 		for (i = 0; i < reflog; i++) {
-			char *name = xmalloc(reflen + 20);
-			sprintf(name, "%s@{%d}", *av, i);
-			append_one_rev(name);
+			char *logmsg, *msg, *m;
+			unsigned long timestamp;
+			int tz;
+
+			if (read_ref_at(ref, 0, base+i, sha1, &logmsg,
+					&timestamp, &tz, NULL)) {
+				reflog = i;
+				break;
+			}
+			msg = strchr(logmsg, '\t');
+			if (!msg)
+				msg = "(none)";
+			else
+				msg++;
+			m = xmalloc(strlen(msg) + 200);
+			sprintf(m, "(%s) %s",
+				show_date(timestamp, 0, 1),
+				msg);
+			reflog_msg[i] = m;
+			free(logmsg);
+			sprintf(nth_desc, "%s@{%d}", *av, base+i);
+			append_ref(nth_desc, sha1, 1);
 		}
 	}
 	else {
@@ -760,8 +822,14 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				printf("%c [%s] ",
 				       is_head ? '*' : '!', ref_name[i]);
 			}
-			/* header lines never need name */
-			show_one_commit(rev[i], 1);
+
+			if (!reflog) {
+				/* header lines never need name */
+				show_one_commit(rev[i], 1);
+			}
+			else
+				puts(reflog_msg[i]);
+
 			if (is_head)
 				head_at = i;
 		}
diff --git a/refs.c b/refs.c
index 60375a7..8117328 100644
--- a/refs.c
+++ b/refs.c
@@ -1068,6 +1068,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 			die("Log %s is corrupt.", logfile);
 		date = strtoul(lastgt + 1, &tz_c, 10);
 		if (date <= at_time || cnt == 0) {
+			tz = strtoul(tz_c, NULL, 10);
 			if (msg)
 				*msg = ref_msg(rec, logend);
 			if (cutoff_time)
@@ -1075,14 +1076,13 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 			if (cutoff_tz)
 				*cutoff_tz = tz;
 			if (cutoff_cnt)
-				*cutoff_cnt = reccnt;
+				*cutoff_cnt = reccnt - 1;
 			if (lastrec) {
 				if (get_sha1_hex(lastrec, logged_sha1))
 					die("Log %s is corrupt.", logfile);
 				if (get_sha1_hex(rec + 41, sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
-					tz = strtoul(tz_c, NULL, 10);
 					fprintf(stderr,
 						"warning: Log %s has gap after %s.\n",
 						logfile, show_rfc2822_date(date, tz));
@@ -1096,7 +1096,6 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, logged_sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
-					tz = strtoul(tz_c, NULL, 10);
 					fprintf(stderr,
 						"warning: Log %s unexpectedly ended on %s.\n",
 						logfile, show_rfc2822_date(date, tz));
-- 
1.5.0.rc1.gcb48c
