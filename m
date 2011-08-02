From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 7/8] bisect: add documentation for --no-checkout option.
Date: Tue,  2 Aug 2011 21:29:04 +1000
Message-ID: <1312284545-2426-8-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDBB-0004bt-33
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab1HBLa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41800 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1HBLa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:30:27 -0400
Received: by mail-gy0-f174.google.com with SMTP id 3so3985580gyh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WJiwfesncgSxUJs91+snFB1aTt3fmIVqRa2Ab+HceTg=;
        b=K43f9CDa2hHyRO6Gkw0diSu6LLGMJmaFWO6zNd00GmLG3loZZyAmliqxRHWdNlXK0d
         DbPz7b1TXHv9cmetyUaACteD/IlPvfJMZZWr244VWew8/1DfP2+KjN13g4gAMWBh4n5a
         VwfTyMTAK0wK00lYLAMwIhfzW3PwVMO20sNI0=
Received: by 10.142.193.18 with SMTP id q18mr2015004wff.442.1312284626673;
        Tue, 02 Aug 2011 04:30:26 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.30.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:30:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178458>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..2014894 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect help
- git bisect start [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [(<rev>|<range>)...]
@@ -263,6 +263,17 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the "git bisect run" command loop
 determine the eventual outcome of the bisect session.
 
+OPTIONS
+-------
+--no-checkout::
++
+This option is used to specify that 'git bisect' should not modify the working
+tree or index on each iteration of the bisection process but should
+update HEAD instead.
++
+This option is useful in circumstances in which checkout is either not
+possible (because of a damaged respository) or is otherwise not required.
+
 EXAMPLES
 --------
 
@@ -343,6 +354,25 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 This shows that you can do without a run script if you write the test
 on a single line.
 
+* Locate a good region of the object graph in a damaged repository
++
+------------
+$ git bisect start HEAD <known-good-commit> [ <boundary-commit> ... ] --no-checkout
+$ git bisect run eval '
+rc=1;
+if git rev-list --objects HEAD >tmp.$$; then
+   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
+fi;
+rm tmp.$$;
+test $rc -eq 0;'
+
+------------
++
+In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
+has at least one parent whose reachable graph is fully traversable in the sense
+required by 'git pack objects'.
+
+
 SEE ALSO
 --------
 link:git-bisect-lk2009.html[Fighting regressions with git bisect],
-- 
1.7.6.353.g3461
