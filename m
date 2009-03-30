From: rocketraman@fastmail.fm
Subject: [PATCH 2/2] Add feature release instructions to gitworkflows man page
Date: Mon, 30 Mar 2009 01:35:19 -0400
Message-ID: <1238391319-4953-2-git-send-email-rocketraman@fastmail.fm>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 07:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoABB-0001bV-T2
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbZC3Ff2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZC3Ff2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:35:28 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:37126 "HELO
	smtp105.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752317AbZC3FfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 01:35:25 -0400
Received: (qmail 82552 invoked from network); 30 Mar 2009 05:35:22 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp105.rog.mail.re2.yahoo.com with SMTP; 30 Mar 2009 05:35:22 -0000
X-YMail-OSG: cJS.vNEVM1mvF7u9s_pB3GRuIYu0MDpJQIq7N5axcuYmAVG_ihkU2L_ntbLVDADAOA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 85F6E21C04F1
	for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:35:21 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfHaBYoSdECu for <git@vger.kernel.org>;
	Mon, 30 Mar 2009 01:35:21 -0400 (EDT)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id 3DA9A21C051A
	for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:35:20 -0400 (EDT)
Received: by zeus (sSMTP sendmail emulation); Mon, 30 Mar 2009 01:35:20 -0400
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115080>

From: Raman Gupta <raman@rocketraman.com>

Based on a mailing list discussion, add a description of the workflow,
and associated commands, for creating a feature release.

Signed-off-by: Raman Gupta <raman@rocketraman.com>
---
 Documentation/gitworkflows.txt |   73 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 2b021e3..6a31d7b 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -348,6 +348,79 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
 other options.
 
 
+RELEASE WORKFLOW
+----------------
+
+The maintainer may use the following release workflow:
+
+He first tags the tip of 'master' with a release tag, then he updates
+the 'maint' branch to the current tip of 'master' for managing future
+maintenance fixes on the current release, and lastly he optionally
+rebuilds 'next' from the tip of 'master'.
+
+
+Release Tagging
+~~~~~~~~~~~~~~~
+
+The new feature release is tagged on 'master' with a tag matching
+vX.Y.Z, where X.Y.Z is the new feature release version.
+
+.Release tagging
+[caption="Recipe: "]
+==========================================
+`git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
+==========================================
+
+
+Maintenance branch update
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The current maintenance branch is optionally copied to another branch
+named with the older release version number to allow for further
+maintenance releases on the older codebase. If the current tip of
+maint corresponds to an older release tag, then creating the maint
+branch for the older codebase can also be done later if and when it
+is required.
+
+.Copy maint
+[caption="Recipe: "]
+=====================================
+`git branch maint-X.Y.(Z-1) maint`
+=====================================
+
+'maint' is now updated to the new release code so that maintenance
+fixes can be merged for the current version.
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git branch -f maint master`
+=====================================
+
+This creates 'maint' from 'master', while preserving the 'maint'
+reflog.
+
+
+Update next branch
+~~~~~~~~~~~~~~~~~~
+
+The 'next' branch may be rewound and rebuilt from the tip of 'master'
+using the surviving topics on 'next'.
+
+This step is optional. If it is done by the maintainer, then a public
+announcement will be made indicating that 'next' was rewound and
+rebuilt.
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git branch -f next master`
+* `git merge ai/topic_in_next1`
+* `git merge ai/topic_in_next2`
+* ...
+=====================================
+
+
 SEE ALSO
 --------
 linkgit:gittutorial[7],
-- 
1.6.2
