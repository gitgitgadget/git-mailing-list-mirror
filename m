From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/13] sequencer: let "git sequencer--helper" callers set
	"allow_dirty"
Date: Wed, 12 Aug 2009 07:15:41 +0200
Message-ID: <20090812051552.18155.72912.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6Or-000460-T4
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbZHLF2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZHLF2H
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:07 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47728 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbZHLF2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:04 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 118588180F7;
	Wed, 12 Aug 2009 07:27:56 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C7B088180CB;
	Wed, 12 Aug 2009 07:27:53 +0200 (CEST)
X-git-sha1: c10a00fcea2e5901252c8b6145c5cfafe507697e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125665>

This flag can be set when using --reset-hard or --fast-forward, and
in this case changes in the work tree will be kept.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index bd72f65..71a7fef 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -18,8 +18,10 @@ static unsigned char head_sha1[20];
 
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
-	"git sequencer--helper --reset-hard <commit> <reflog-msg> <verbosity>",
-	"git sequencer--helper --fast-forward <commit> <reflog-msg> <verbosity>",
+	"git sequencer--helper --reset-hard <commit> <reflog-msg> "
+		"<verbosity> [<allow-dirty>]",
+	"git sequencer--helper --fast-forward <commit> <reflog-msg> "
+		"<verbosity> [<allow-dirty>]",
 	NULL
 };
 
@@ -247,7 +249,7 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 		char *commit = ff_commit ? ff_commit : reset_commit;
 
-		if (argc != 2)
+		if (argc != 2 && argc != 3)
 			usage_with_options(git_sequencer_helper_usage,
 					   options);
 
@@ -263,6 +265,9 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			return 1;
 		}
 
+		if (argc == 3 && *argv[2] && strcmp(argv[2], "0"))
+			allow_dirty = 1;
+
 		if (ff_commit)
 			return do_fast_forward(sha1);
 		else
-- 
1.6.4.271.ge010d
