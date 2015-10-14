From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: [PATCH 2/2] contrib/git-candidate: Add README
Date: Wed, 14 Oct 2015 18:30:45 +0100
Message-ID: <1444843845-8017-3-git-send-email-richard.ipsum@codethink.co.uk>
References: <1444843845-8017-1-git-send-email-richard.ipsum@codethink.co.uk>
Cc: Richard Ipsum <richard.ipsum@codethink.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 19:33:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmPva-0000d3-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 19:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbbJNRdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 13:33:11 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36551 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210AbbJNRdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 13:33:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 5978A461B11;
	Wed, 14 Oct 2015 18:33:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ful98eGx70qs; Wed, 14 Oct 2015 18:33:01 +0100 (BST)
Received: from salo.dyn.ducie.codethink.co.uk. (salo.dyn.ducie.codethink.co.uk [10.24.1.215])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id E6880460189;
	Wed, 14 Oct 2015 18:32:58 +0100 (BST)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1444843845-8017-1-git-send-email-richard.ipsum@codethink.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279581>

Describes motivation for git-candidate and shows an example workflow.

Signed-off-by: Richard Ipsum <richard.ipsum@codethink.co.uk>
---
 contrib/git-candidate/README.md | 153 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 contrib/git-candidate/README.md

diff --git a/contrib/git-candidate/README.md b/contrib/git-candidate/README.md
new file mode 100644
index 0000000..3291a12
--- /dev/null
+++ b/contrib/git-candidate/README.md
@@ -0,0 +1,153 @@
+git-candidate
+=============
+
+git-candidate provides candidate review and patch tracking,
+it differs from other tools that provide this by storing _all_
+content within git.
+
+## Why?
+
+Existing tools such as Github's pull-requests and Gerrit are already
+in wide use, why bother with something new?
+
+We are concerned that whilst git is a distributed version control
+system the systems used to store comments and reviews for content
+under version control are usually centralised,
+git-candidate aims to solve this by storing
+all patch-tracking data in git proper.
+
+## Example review process
+
+### Contributor - Submits a candidate
+
+	(hack hack hack)
+
+	(feature)$ git commit -m "Add archived repo"
+	(feature)$ git candidate create archivedrepo master
+		-m "Add support for archived repo"
+	Candidate archivedrepo created successfully.
+	(feature)$ git candidate submit archivedrepo origin
+	Candidate was submitted successfully.
+
+### Upstream - Reviews candidate
+
+	(master)$ git candidate fetch origin
+	(master)$ git candidate status archiverepo origin
+	Revision: 6239bd72d597357af901718becae91cee2a32b73
+	Ref: candidates/origin/archiverepo
+	Status: active
+	Land: master
+
+	Add archived repo support
+
+	 lib/gitano/command.lua | 28 ++++++++++++++++++++++------
+	 1 file changed, 22 insertions(+), 6 deletions(-)
+
+	(master)$ git show candidates/origin/archiverepo
+	commit 2db28539c8fa7b81122382bcc526c6706c9e113a
+	Author: Richard Ipsum <richard.ipsum@codethink.co.uk>
+	Date:   Thu Oct 8 10:43:22 2015 +0100
+
+	    Add support for archived repository masking in `ls`
+
+	    By setting `project.archived` to something truthy, a repository
+	    is thusly masked from `ls` output unless --all is passed in.
+
+	    Signed-off-by: Richard Ipsum <richard.ipsum@codethink.co.uk>
+	....
+	....
+
+
+	(master)$ git candidate review archiverepo origin --vote -1
+		-m "Sorry, I'll need to see tests before I can accept this"
+	Review added successfully
+
+### Contributor - Revises candidate
+
+	(master)$ git candidate fetch origin
+	(master)$ git candidate status archiverepo origin
+	Revision: 6239bd72d597357af901718becae91cee2a32b73
+	Ref: candidates/origin/archiverepo
+	Status: active
+	Land: master
+
+	Add archived repo support
+
+	 lib/gitano/command.lua | 28 ++++++++++++++++++++++------
+	 1 file changed, 22 insertions(+), 6 deletions(-)
+
+	--------------------------------------------------------------------------------
+	1 review
+	--------------------------------------------------------------------------------
+
+	    Author: Emmet Hikory <persia@shipstone.jp>
+	    Date:   Tue Oct 13 10:09:45 2015 +0100
+	    Vote:   -1
+
+	    Sorry, I'll need to see tests before I can accept this
+
+	--------------------------------------------------------------------------------
+
+	(hack hack hack add tests)
+
+	(feature_v2)$ git log --oneline -1
+	Ensure the `ls` yarn checks for archived repos
+
+	(feature_v2)$ git candidate revise archiverepo origin
+		-m "Add archived repo support with tests"
+	Candidate archiverepo revised successfully.
+
+	(feature_v2)$ git candidate submit archiverepo origin
+	Candidate was submitted successfully.
+
+### Upstream - Merges candidate
+
+	(master)$ git candidate fetch origin
+	(master)$ git candidate status archiverepo origin
+	Revision: 4cd3d1197d399005a713ca55f126a9086356a072
+	Ref: candidates/origin/archiverepo
+	Status: active
+	Land: master
+
+	Add archived repo support with tests
+
+	 lib/gitano/command.lua      | 28 ++++++++++++++++++++++------
+	 testing/02-commands-ls.yarn | 19 +++++++++++++++++++
+	 2 files changed, 41 insertions(+), 6 deletions(-)
+
+	(master)$ git candidate review archiverepo origin --vote +2
+		-m "Looks good, merging.  Thanks for your efforts"
+	Review added successfully
+
+	(master)$ git candidate submit archiverepo origin
+	Candidate was submitted successfully.
+
+	(master)$ git merge candidates/origin/archiverepo
+	(master)$ git push origin master
+
+### Contributor - Observes candidate has been accepted
+
+	(feature_v2)$ git candidate fetch origin
+	(feature_v2)$ git candidate status archiverepo origin
+	Revision: 4cd3d1197d399005a713ca55f126a9086356a072
+	Ref: candidates/origin/archiverepo
+	Status: active
+	Land: master
+
+	Add archived repo support with tests
+
+	 lib/gitano/command.lua      | 28 ++++++++++++++++++++++------
+	 testing/02-commands-ls.yarn | 19 +++++++++++++++++++
+	 2 files changed, 41 insertions(+), 6 deletions(-)
+
+	--------------------------------------------------------------------------------
+	1 review
+	--------------------------------------------------------------------------------
+
+	    Author: Emmet Hikory <persia@shipstone.jp>
+	    Date:   Tue Oct 13 10:35:00 2015 +0100
+	    Vote:   +2
+
+		Looks good, merging.  Thanks for your efforts
+
+	--------------------------------------------------------------------------------
-- 
2.1.4
