From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/3] git-commit: rename --all to --all-tracked
Date: Sun, 27 Feb 2011 16:50:11 +0100
Message-ID: <5c610a7231ec0344bf02f4631d3a8a51b2cdf824.1298821535.git.git@drmicha.warpmail.net>
References: <4D68D630.9000608@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 16:49:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtisI-0004ft-3d
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab1B0PtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:49:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55657 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752186Ab1B0PtI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 10:49:08 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B4DE22042C;
	Sun, 27 Feb 2011 10:49:07 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Sun, 27 Feb 2011 10:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=MXLhl5x3XcCW5N+iceUY6/vyviY=; b=UzFEVvV/DYlOhhI2xKZbAef6Nm0JU3M+zrnkritvSTzuUhoGytdinOS2LZUrobm3DVN7sNb11CDzok5u7qEW7l2cYZ3rMC+w7Vd5vVYWIioYhlKV4EPn5nnADk10vqX29ZKEebBe0x2Lvj2NRoNZ8xL+fMjRD5KrUlMPQQD+D2I=
X-Sasl-enc: TTWYMpCm8oSS0lWJt5RdLmeH7L8fZYC9oNaR0NLYBbV9 1298821746
Received: from localhost (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BE85A448DAB;
	Sun, 27 Feb 2011 10:49:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
In-Reply-To: <4D68D630.9000608@drmicha.warpmail.net>
In-Reply-To: <cover.1298821535.git.git@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168041>

Currently, the long option "--all" does different things for "add" (it
is "-A") and "commit" (it is "-a").

Rename the "commit" long option to "--all-tracked" which conveys the fact
that it is about all tracked files only.

Also, rename the corresponding static int in code from "all" to
"alltracked" to help future coders.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-commit.txt |    2 +-
 builtin/commit.c             |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 411fa68..70ddb81 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -54,7 +54,7 @@ that, you can recover from it with 'git reset'.
 OPTIONS
 -------
 -a::
---all::
+--all-tracked::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
 	told git about are not affected.
diff --git a/builtin/commit.c b/builtin/commit.c
index d279a84..be0f075 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -83,7 +83,7 @@ static const char *template_file;
 static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int alltracked, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -149,7 +149,7 @@ static struct option builtin_commit_options[] = {
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
-	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
+	OPT_BOOLEAN('a', "all-tracked", &alltracked, "commit all changed tracked files"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
@@ -367,7 +367,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 * (A) if all goes well, commit the real index;
 	 * (B) on failure, rollback the real index.
 	 */
-	if (all || (also && pathspec && *pathspec)) {
+	if (alltracked || (also && pathspec && *pathspec)) {
 		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
@@ -1040,8 +1040,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		author_message_buffer = read_commit_message(author_message);
 	}
 
-	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.");
+	if (!!also + !!only + !!alltracked + !!interactive > 1)
+		die("Only one of --include/--only/--all-tracked/--interactive can be used.");
 	if (argc == 0 && (also || (only && !amend)))
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
@@ -1061,7 +1061,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	handle_untracked_files_arg(s);
 
-	if (all && argc > 0)
+	if (alltracked && argc > 0)
 		die("Paths with -a does not make sense.");
 	else if (interactive && argc > 0)
 		die("Paths with --interactive does not make sense.");
-- 
1.7.4.1.224.gefc87
