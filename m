From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Wed, 21 Nov 2007 15:27:58 +0100
Message-ID: <1195655278-19535-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 15:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuqaB-00052X-FU
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbXKUO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbXKUO3V
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:29:21 -0500
Received: from wincent.com ([72.3.236.74]:54970 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbXKUO3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:29:21 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALERwF8017452;
	Wed, 21 Nov 2007 08:28:00 -0600
X-Mailer: git-send-email 1.5.3.6.866.g67e44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65653>

The user interface provided by the command loop in git-add--interactive
gives the impression that subcommands can only be launched by entering
an integer identifier from 1 through 8.

A "hidden" feature is that any string can be entered, and an anchored
regex search is used to find the first matching option.

This patch makes this feature a little more obvious by highlighting the
first character of each subcommand (for example "patch" is displayed as
"[p]atch"). The mechanism for doing this is to add an optional third
element to the array defining each subcommand; if present, it will be
used for display purposes, while the actual name of the subcommand (the
first element) is still used for matching purposes.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

And another thought: if the colorization for git-add--interactive goes
ahead, we could drop the square brackets used here in favor of underline
or boldface, if people find that more attractive.

 git-add--interactive.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0317ad9..2b1c55a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -179,7 +179,7 @@ sub list_and_choose {
 			my $print = $stuff[$i];
 			if (ref $print) {
 				if ((ref $print) eq 'ARRAY') {
-					$print = $print->[0];
+					$print = $print->[2] || $print->[0];
 				}
 				else {
 					$print = $print->{PRINT};
@@ -774,14 +774,14 @@ EOF
 }
 
 sub main_loop {
-	my @cmd = ([ 'status', \&status_cmd, ],
-		   [ 'update', \&update_cmd, ],
-		   [ 'revert', \&revert_cmd, ],
-		   [ 'add untracked', \&add_untracked_cmd, ],
-		   [ 'patch', \&patch_update_cmd, ],
-		   [ 'diff', \&diff_cmd, ],
-		   [ 'quit', \&quit_cmd, ],
-		   [ 'help', \&help_cmd, ],
+	my @cmd = ([ 'status', \&status_cmd, '[s]tatus', ],
+		   [ 'update', \&update_cmd, '[u]date', ],
+		   [ 'revert', \&revert_cmd, '[r]evert', ],
+		   [ 'add untracked', \&add_untracked_cmd, '[a]dd untracked', ],
+		   [ 'patch', \&patch_update_cmd, '[p]atch', ],
+		   [ 'diff', \&diff_cmd, '[d]iff', ],
+		   [ 'quit', \&quit_cmd, '[q]uit', ],
+		   [ 'help', \&help_cmd, '[h]elp', ],
 	);
 	while (1) {
 		my ($it) = list_and_choose({ PROMPT => 'What now',
-- 
1.5.3.6.866.g67e44
