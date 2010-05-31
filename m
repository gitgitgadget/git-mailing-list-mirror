From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/8] revert: cleanup code for -x option
Date: Mon, 31 May 2010 21:42:32 +0200
Message-ID: <20100531194240.28729.10576.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:04:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHm9-0000OY-Jg
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab0FADEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:41992 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab0FADEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:06 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7F8DF81804E;
	Tue,  1 Jun 2010 05:03:58 +0200 (CEST)
X-git-sha1: b05c168d71858f8cae91b5bf79af330c315f12a8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148063>

There was some dead code and option -x appeared in the short
help message of git revert (when running "git revert -h")
which was wrong.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7976b5a..5df0d69 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -58,7 +58,6 @@ static void parse_args(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
-		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
@@ -71,6 +70,7 @@ static void parse_args(int argc, const char **argv)
 
 	if (action == CHERRY_PICK) {
 		struct option cp_extra[] = {
+			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
@@ -379,10 +379,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
 
-	/* this is copied from the shell script, but it's never triggered... */
-	if (action == REVERT && !no_replay)
-		die("revert is incompatible with replay");
-
 	if (allow_ff) {
 		if (signoff)
 			die("cherry-pick --ff cannot be used with --signoff");
@@ -546,14 +542,12 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	if (isatty(0))
 		edit = 1;
-	no_replay = 1;
 	action = REVERT;
 	return revert_or_cherry_pick(argc, argv);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	no_replay = 0;
 	action = CHERRY_PICK;
 	return revert_or_cherry_pick(argc, argv);
 }
-- 
1.7.1.361.g42de.dirty
