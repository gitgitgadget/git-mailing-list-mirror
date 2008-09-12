From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 6/6] adjust the command lists (by category) to the new doc link macros
Date: Fri, 12 Sep 2008 12:55:26 +0200
Message-ID: <1221216926-20435-8-git-send-email-git@drmicha.warpmail.net>
References: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-2-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-3-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-4-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-5-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-6-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-7-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 12:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6Ll-00044i-Tc
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbYILK4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYILK4i
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:56:38 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59721 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753248AbYILK4d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 06:56:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6780915FBF1
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:56:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 12 Sep 2008 06:56:31 -0400
X-Sasl-enc: NuhTQKkdCCvOwEbghzYMeeZmYLTTJEtpAx7SihA2EyuX 1221216990
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6BA7E276E8;
	Fri, 12 Sep 2008 06:56:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
In-Reply-To: <1221216926-20435-7-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95705>

This patch introduces a new attribute "dashed" to be used in the master
command list. Server type commands are marked as "dashed", and
"cmd-list.perl" is taught to use this attributes when writing out links
in the command lists by category:

git-cvsserver
git-daemon
git-receive-pack
git-shell
git-upload-archive
git-upload-pack

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/cmd-list.perl |    7 ++++++-
 command-list.txt            |   12 ++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 04f9977..dd24b29 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -27,7 +27,12 @@ sub format_one {
 		die "No description found in $name.txt";
 	}
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
-		print $out "linkgit:$name\[1\]::\n\t";
+		if ($attr =~ / dashed /) {
+			print $out "linkgitasis:$name\[1\]::\n\t";
+		} else {
+			$name =~ /^git-(.*)$/;
+			print $out "link-git:$1\[1\]::\n\t";
+		}
 		if ($attr =~ / deprecated /) {
 			print $out "(deprecated) ";
 		}
diff --git a/command-list.txt b/command-list.txt
index 3583a33..02bc251 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -26,8 +26,8 @@ git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
-git-cvsserver                           foreignscminterface
-git-daemon                              synchingrepositories
+git-cvsserver                           foreignscminterface dashed
+git-daemon                              synchingrepositories dashed
 git-describe                            mainporcelain
 git-diff                                mainporcelain common
 git-diff-files                          plumbinginterrogators
@@ -86,7 +86,7 @@ git-push                                mainporcelain common
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain common
-git-receive-pack                        synchelpers
+git-receive-pack                        synchelpers dashed
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
 git-remote                              ancillarymanipulators
@@ -101,7 +101,7 @@ git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain common
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
-git-shell                               synchelpers
+git-shell                               synchelpers dashed
 git-shortlog                            mainporcelain
 git-show                                mainporcelain common
 git-show-branch                         ancillaryinterrogators
@@ -121,8 +121,8 @@ git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
 git-update-ref                          plumbingmanipulators
 git-update-server-info                  synchingrepositories
-git-upload-archive                      synchelpers
-git-upload-pack                         synchelpers
+git-upload-archive                      synchelpers dashed
+git-upload-pack                         synchelpers dashed
 git-var                                 plumbinginterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
-- 
1.6.0.1.308.gede4c
