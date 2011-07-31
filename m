From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 6/7] bisect: add documentation for --no-checkout and --update-ref=<ref> options.
Date: Sun, 31 Jul 2011 21:55:20 +1000
Message-ID: <1312113321-28760-7-git-send-email-jon.seymour@gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 13:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUdq-0002z3-97
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab1GaL5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:57:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1GaL5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:57:03 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9556049pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jTWrP3hDo/5NGMTQZ3OJJaZsKxax01WrsqnMfR8vzcE=;
        b=KkmVlURptYI5W4uQFfg3SfneFbiBGAyjmTdnMkVAr4YCWQS354f7jdg6Gzw/EfqDo8
         xgW67txKzB6yPHVBk1m5OBXUH/w4jIYcRcIomxsKFOSPFZq+z9qmby+cfifno7moMxMG
         pSakoPzSf8/J2iOQnmHJhAwVAjTQLXOgUO/AU=
Received: by 10.68.9.41 with SMTP id w9mr5796868pba.315.1312113422591;
        Sun, 31 Jul 2011 04:57:02 -0700 (PDT)
Received: from localhost.localdomain ([120.16.239.154])
        by mx.google.com with ESMTPS id g4sm4306620pbj.41.2011.07.31.04.56.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 04:57:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g62761
In-Reply-To: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178243>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..25a25b3 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect help
- git bisect start [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--no-checkout|--update-ref=<ref>] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [(<rev>|<range>)...]
@@ -263,6 +263,21 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the "git bisect run" command loop
 determine the eventual outcome of the bisect session.
 
+OPTIONS
+-------
+--no-checkout::
++
+This option is a synonym for --update-ref=HEAD.
+
+--update-ref=<ref>::
++
+This option is used to specify that 'git bisect' should not modify the working
+tree or index on each iteration of the bisection process but should
+update the reference specified by <ref> instead.
++
+This option is useful in circumstances in which checkout is either not
+possible (because of a damaged respository) or is otherwise not required.
+
 EXAMPLES
 --------
 
@@ -343,6 +358,23 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 This shows that you can do without a run script if you write the test
 on a single line.
 
+* Locate a good region of the object graph in a damaged repository
++
+------------
+$ git bisect start HEAD <known-good-commit> [ <missing-or-damaged-commit> ... ] --no-checkout
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
+has at least one parent which is fully reachable in the sense of 'git pack-objects'.
+
 SEE ALSO
 --------
 link:git-bisect-lk2009.html[Fighting regressions with git bisect],
-- 
1.7.6.391.g168d0.dirty
