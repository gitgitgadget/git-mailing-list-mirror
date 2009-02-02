From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] add -p: trap Ctrl-D in 'goto' mode
Date: Mon,  2 Feb 2009 22:46:29 +0100
Message-ID: <1233611191-18590-3-git-send-email-trast@student.ethz.ch>
References: <1233611191-18590-1-git-send-email-trast@student.ethz.ch>
 <1233611191-18590-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>, Jeff King <peff@peff.net>,
	Suraj Kurapati <sunaku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 22:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU6fO-0001pu-7Y
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759095AbZBBVqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759072AbZBBVqx
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:46:53 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9370 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816AbZBBVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:46:49 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:44 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:44 +0100
X-Mailer: git-send-email 1.6.1.2.513.g04677
In-Reply-To: <1233611191-18590-2-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Feb 2009 21:46:44.0627 (UTC) FILETIME=[BDABE630:01C9857F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108129>

If the user hit Ctrl-D (EOF) while the script was in 'go to hunk?'
mode, it threw an undefined variable error.  Explicitly test for EOF
and have it re-enter the goto prompt loop.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 551b447..3bf0cda 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -994,6 +994,9 @@ sub patch_update_file {
 					}
 					print "go to which hunk$extra? ";
 					$response = <STDIN>;
+					if (!defined $response) {
+						$response = '';
+					}
 					chomp $response;
 				}
 				if ($response !~ /^\s*\d+\s*$/) {
-- 
1.6.1.2.513.g04677
