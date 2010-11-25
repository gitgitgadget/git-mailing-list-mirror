From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 15/18] revert: add NONE action and make parse_args()
	manage it
Date: Thu, 25 Nov 2010 22:20:46 +0100
Message-ID: <20101125212050.5188.96830.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIh-0007NM-4q
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab0KZFzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:36 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47973 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab0KZFze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:34 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6E610A60E8;
	Fri, 26 Nov 2010 06:55:27 +0100 (CET)
X-git-sha1: dc48b8dc48456665cd29a032c5d3cfbf42574184 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162201>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7513a00..fee2e38 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -40,7 +40,7 @@ static const char * const cherry_pick_usage[] = {
 };
 
 struct args_info {
-	enum { REVERT, CHERRY_PICK } action;
+	enum { NONE = 0, REVERT, CHERRY_PICK } action;
 	int edit;
 	int no_replay;
 	int no_commit;
@@ -90,6 +90,17 @@ static void parse_args(int argc, const char **argv, struct args_info *info)
 		OPT_END(),
 	};
 
+	if (info->action == NONE) {
+		if (argc < 1)
+			die("no action argument");
+		if (!strcasecmp(argv[0], "p") || !strcasecmp(argv[0], "pick"))
+			info->action = CHERRY_PICK;
+		else if (!strcasecmp(argv[0], "revert"))
+			info->action = REVERT;
+		else
+			die("unknown action argument: %s", argv[0]);
+	}
+
 	info->me = info->action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, info->me, 0);
 
-- 
1.7.3.2.504.g59d466
