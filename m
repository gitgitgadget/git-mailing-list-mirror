From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 4/4] builtin-remote: add set-head subcommand
Date: Fri, 13 Feb 2009 06:42:23 -0500
Message-ID: <1234525343-8014-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902130221q3114fbdbt89692e79158530ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, <gitster@pobox.com>,
	<j.sixt@viscovery.net>, <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 12:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXwUY-0003Xd-MG
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 12:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbZBMLm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 06:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZBMLm3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 06:42:29 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:2510 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbZBMLm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 06:42:28 -0500
Received: by an-out-0708.google.com with SMTP id c2so642896anc.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 03:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mEwUP0ZZM76r54Yo9ymPMaR5BFAcj7oY8pSLVPFOFss=;
        b=N3xuEF3v+uFOQ3mIQb6jh3CQiye+04uBjtLVF808xmJycq/7xBwWkBZsoUwtd/1Ly1
         OzJIxjjkwr2PD2fZKfhiSp9jazvPSkCXNr8kXwoQXSstfg0kgPVURZILYZu5Kp9SGjAY
         AsT3V64MzXQvfV8OsHXWlFNWWPuiKtRHoewxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VE78gcHv7W74OxViDp7XufPjvDtMeW0EigetSlfE+zXSsNywuQFl8nCoGj9GomeQA0
         OL1gNQ+rfq1amEvTSpKlritxig0mJCQpbBjLBpiFMREe3gK9wZ/2gtU5474vLdKlCsIQ
         SJlgvzCMH789yv3I1HKyaWeh/1lA1ERFXp9Ew=
Received: by 10.100.123.11 with SMTP id v11mr2600350anc.71.1234525346627;
        Fri, 13 Feb 2009 03:42:26 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b32sm1309637ana.55.2009.02.13.03.42.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 03:42:26 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.67.g77afc
In-Reply-To: <76718490902130221q3114fbdbt89692e79158530ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109743>

Provide a porcelain command for setting/deleting
$GIT_DIR/remotes/<remote>/HEAD.

While we're at it, document what $GIT_DIR/remotes/<remote>/HEAD is all
about.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This replaces "[PATCH 4/4] builtin-remote: add set-head verb". The rest of
the series is unchanged.

 * Changed commit title to call it a subcommand, not a verb.
 * Clarified documentation slightly
 * Added --auto and --delete long options to make what -a and -d stand for
   more obvious.
 * Fixed small regression where I was checking a pointer for NULL before
   free()'ing it.
 * sethead() -> set_head()
 * Reworked the argument processing in set_head() to be more maintainable if
   additional switches are added later.

On Fri, Feb 13, 2009 at 5:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> You need to customize it to
> favor the one that the HEAD points at on the local side before you start
> (iow, try to keep the current value when you can).
>
> For example, if it points at "frotz" locally when the command was started,
> and you found out that HEAD now points at the commit at the tip of "frotz"
> and "master" branches by peeking, you do not want to repoint HEAD from
> "frotz" to "master".

This I did not do, and I still don't feel it is necessary. However, if you
feel strongly about it I can do it as an additional patch to this series. But
I'd like to see this in pu at least first. I really hope not doing it isn't a
roadblock for the whole series.

 Documentation/git-remote.txt           |   28 ++++++++++++++++-
 builtin-remote.c                       |   51 ++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |    2 +-
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index fad983e..c9c0e6f 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
+'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
 'git remote update' [group]
@@ -53,8 +54,7 @@ is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
-up to point at remote's `<master>` branch instead of whatever
-branch the `HEAD` at the remote repository actually points at.
+up to point at remote's `<master>` branch. See also the set-head command.
 +
 In mirror mode, enabled with `\--mirror`, the refs will not be stored
 in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
@@ -76,6 +76,30 @@ the configuration file format.
 Remove the remote named <name>. All remote tracking branches and
 configuration settings for the remote are removed.
 
+'set-head'::
+
+Sets or deletes the default branch (`$GIT_DIR/remotes/<name>/HEAD`) for
+the named remote. Having a default branch for a remote is not required,
+but allows the name of the remote to be specified in lieu of a specific
+branch. For example, if the default branch for `origin` is set to
+`master`, then `origin` may be specified wherever you would normally
+specify `origin/master`.
++
+With `-d`, `$GIT_DIR/remotes/<name>/HEAD` is deleted.
++
+With `-a`, the remote is queried to determine its `HEAD`, then
+`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
+`HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
+`$GIT_DIR/refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
+only work if `refs/remotes/origin/next` already exists; if not it must be
+fetched first.
++
+Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly. e.g., "git
+remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
+`refs/remotes/origin/master`. This will only work if
+`refs/remotes/origin/master` already exists; if not it must be fetched first.
++
+
 'show'::
 
 Gives some information about the remote <name>.
diff --git a/builtin-remote.c b/builtin-remote.c
index 465c87a..fcb166b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
+	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [group]",
@@ -777,6 +778,54 @@ static int show(int argc, const char **argv)
 	return result;
 }
 
+static int set_head(int argc, const char **argv)
+{
+	int opt_a = 0, opt_d = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	char *head_name = NULL;
+
+	struct option options[] = {
+		OPT_GROUP("set-head specific options"),
+		OPT_BOOLEAN('a', "auto", &opt_a,
+			    "set refs/remotes/<name>/HEAD according to remote"),
+		OPT_BOOLEAN('d', "delete", &opt_d,
+			    "delete refs/remotes/<name>/HEAD"),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	if (argc)
+		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+
+	if (!opt_a && !opt_d && argc == 2) {
+		head_name = xstrdup(argv[1]);
+	} else if (opt_a && !opt_d && argc == 1) {
+		struct ref_states states;
+		memset(&states, 0, sizeof(states));
+		get_remote_ref_states(argv[0], &states, 1);
+		head_name = xstrdup(states.head_name);
+		free_remote_ref_states(&states);
+	} else if (opt_d && !opt_a && argc == 1) {
+		if (delete_ref(buf.buf, NULL, REF_NODEREF))
+			result |= error("Could not delete %s", buf.buf);
+	} else
+		usage_with_options(builtin_remote_usage, options);
+
+	if (head_name) {
+		unsigned char sha1[20];
+		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		/* make sure it's valid */
+		if (!resolve_ref(buf2.buf, sha1, 1, NULL))
+			result |= error("Not a valid ref: %s", buf2.buf);
+		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
+			result |= error("Could not setup %s", buf.buf);
+		free(head_name);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	return result;
+}
+
 static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
@@ -947,6 +996,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "set-head"))
+		result = set_head(argc, argv);
 	else if (!strcmp(argv[0], "show"))
 		result = show(argc, argv);
 	else if (!strcmp(argv[0], "prune"))
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f44f63c..5de1922 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1414,7 +1414,7 @@ _git_config ()
 
 _git_remote ()
 {
-	local subcommands="add rename rm show prune update"
+	local subcommands="add rename rm show prune update set-head"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
-- 
1.6.2.rc0.67.g77afc
