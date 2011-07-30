From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 5/5] bisect: add documentation for --no-checkout[=<ref>] option.
Date: Sat, 30 Jul 2011 18:28:31 +1000
Message-ID: <1312014511-7157-6-git-send-email-jon.seymour@gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4v5-0002PD-91
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab1G3I3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 04:29:03 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39956 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1G3I26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 04:28:58 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so7731301pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xe8ea0LLtTWLYwJYReptPiVJNfnuJkemP/Bi3fF4zv4=;
        b=HdQvWQPPZj8quTT8IzxRO1BGDsMMr/6LMXXXF9LMiVQIJTMhsP2aHFN3tyc7Y8qO2/
         IQlV7sI/g7M4SeARetQ4nO+w/vIBM7trwhti7+tbLNS1rVu/MUw2SE53+G/01nBRKE82
         LjRoGEFCOEEzNbHZtvCLT6kWMlizS3aJTAz7M=
Received: by 10.68.10.232 with SMTP id l8mr66888pbb.120.1312014538701;
        Sat, 30 Jul 2011 01:28:58 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id p7sm3012490pbn.65.2011.07.30.01.28.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 01:28:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.387.g991c2
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178185>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..0ad3b01 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect help
- git bisect start [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--no-checkout[=<ref>]] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [(<rev>|<range>)...]
@@ -263,6 +263,17 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the "git bisect run" command loop
 determine the eventual outcome of the bisect session.
 
+OPTIONS
+-------
+--no-checkout[=<ref>]::
++
+If this option is specified, git bisect does not update the working tree
+or index but instead simply updates the specified reference. <ref> defaults
+to HEAD if not specified.
++
+This option is useful in circumstances in which checkout is either not
+possible (because of a damaged respository) or otherwise not required.
+
 EXAMPLES
 --------
 
@@ -343,6 +354,19 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 This shows that you can do without a run script if you write the test
 on a single line.
 
+* Locate the earliest damaged commit in a repository
++
+------------
+$ git bisect start HEAD <known-good-commit> [ <missing-or-damaged-commit> ... ] --no-checkout
+$ git bisect run eval "
+git rev-list --objects HEAD >/dev/null && 
+git rev-list --objects HEAD | git pack-objects --stdout >/dev/null || false"
+------------
++
+This shows how to use `git bisect --no-checkout` with a repository containing damaged commits 
+to find the earliest commit reachable from the HEAD commit such that the graph rooted at the 
+parents of that commit is undamaged.
+
 SEE ALSO
 --------
 link:git-bisect-lk2009.html[Fighting regressions with git bisect],
-- 
1.7.6.387.g991c2
