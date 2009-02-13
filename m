From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 03:54:35 -0500
Message-ID: <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, peff@peff.net,
	gitster@pobox.com, barkalow@iabervon.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtqf-0003hw-0C
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZBMIyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbZBMIyu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:54:50 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:50221 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZBMIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:54:47 -0500
Received: by yw-out-2324.google.com with SMTP id 5so588604ywh.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=r0Owjoj7bvnqpA6XD7oPEoo8j+0NlpVe5NJSSXcRx1Y=;
        b=C405y0VloGxHir5IzW0z0aW/vSLoIXTeVcbrexDRO/+wjW+6R4bK3unEA+rv9L5a9j
         lF2M8QPMy+cdrNgqSoJ7rZtPtHzIHV4YLE49pz1UEfdpkN6hkemzbLC0jUGLtSmm86xE
         KAPqrpXHChariiXBKMjCAUzVNDYoVHBiuHZW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N+gKLI5xyW9I/yuk53KBtFq8Pa/8c5o/uAOwbP6yhNkys6/Foj9zLtvaTNiNCsi9lM
         RiqovGyalPGxBJ/muGMad9r8l2gN+m4+Pi5XxuXwF9f7Mj86jvHNo8OSH+TPhi22dTTa
         NMCnNuvPubcyHcyAfuf2oARUPWySzlR+6NFPM=
Received: by 10.100.11.14 with SMTP id 14mr705988ank.89.1234515286734;
        Fri, 13 Feb 2009 00:54:46 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c37sm1181503ana.22.2009.02.13.00.54.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 00:54:46 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
In-Reply-To: <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109732>

Provide a porcelain command for setting/deleting
$GIT_DIR/remotes/<remote>/HEAD.

While we're at it, document what $GIT_DIR/remotes/<remote>/HEAD is all
about.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-remote.txt           |   20 ++++++++++-
 builtin-remote.c                       |   54 +++++++++++++++++++++++++++++++-
 contrib/completion/git-completion.bash |    2 +-
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index fad983e..80f2cfe 100644
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
@@ -76,6 +76,22 @@ the configuration file format.
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
+`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch.
++
+Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly.
+
 'show'::
 
 Gives some information about the remote <name>.
diff --git a/builtin-remote.c b/builtin-remote.c
index 465c87a..677e20e 100644
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
@@ -658,7 +659,8 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
-	free(states->head_name);
+	if (states->head_name)
+		free(states->head_name);
 }
 
 static int get_remote_ref_states(const char *name,
@@ -777,6 +779,54 @@ static int show(int argc, const char **argv)
 	return result;
 }
 
+static int sethead(int argc, const char **argv)
+{
+	int opt_a = 0, opt_d = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	char *head_name = NULL;
+
+	struct option options[] = {
+		OPT_GROUP("set-head specific options"),
+		OPT_BOOLEAN('a', 0, &opt_a,
+		            "set refs/remotes/<name>/HEAD according to remote"),
+		OPT_BOOLEAN('d', 0, &opt_d, "delete refs/remotes/<name>/HEAD"),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	if ((argc == 1 && !(opt_a || opt_d)) ||
+	   ((argc == 2 && (opt_a || opt_d))) || argc < 1 || argc > 2)
+		usage_with_options(builtin_remote_usage, options);
+
+	strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
+
+	if (opt_d) {
+		if (result |= delete_ref(buf.buf, NULL, REF_NODEREF))
+			error("Could not delete %s", buf.buf);
+	} else if (opt_a) {
+		struct ref_states states;
+		memset(&states, 0, sizeof(states));
+		get_remote_ref_states(argv[0], &states, 1);
+		head_name = xstrdup(states.head_name);
+		free_remote_ref_states(&states);
+	} else
+		head_name = xstrdup(argv[1]);
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
@@ -947,6 +997,8 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "set-head"))
+		result = sethead(argc, argv);
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
1.6.2.rc0.209.g7c178
