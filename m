From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix builtin checkout crashing when given an invalid path
Date: Thu, 28 Feb 2008 17:30:47 +0100
Message-ID: <20080228163047.GA4069@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUlfo-0001tN-5S
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 17:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbYB1QbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 11:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYB1QbS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 11:31:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:50777 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYB1QbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 11:31:18 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jKuj8=
Received: from tigra.home (Faec3.f.strato-dslnet.de [195.4.174.195])
	by post.webmailer.de (klopstock mo4) (RZmta 16.8)
	with ESMTP id h03f9dk1SDRapy ; Thu, 28 Feb 2008 17:31:16 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 29083277BD;
	Thu, 28 Feb 2008 17:31:16 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 870AD56D24; Thu, 28 Feb 2008 17:30:47 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75422>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Noticed in t2008, which actually passed, but silently removed
core-files (I saw segfaults in syslog) and did not properly check the
exit code.  The change for the t2008 comes as seperate patch, but it
should be noted that "! command" is *not* how you check for a command
to have failed. It could have crashed.

 builtin-checkout.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 4a4bb8b..9579ff4 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -545,6 +545,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	if (argc) {
 		const char **pathspec = get_pathspec(prefix, argv);
+
+		if (!pathspec)
+			die("invalid path specification");
+
 		/* Checkout paths */
 		if (opts.new_branch || opts.force || opts.merge) {
 			if (argc == 1) {
-- 
1.5.4.3.253.g9f1d5


