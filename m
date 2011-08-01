From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 7/7] bisect: add documentation for --no-checkout option.
Date: Mon,  1 Aug 2011 21:56:17 +1000
Message-ID: <1312199777-10144-8-git-send-email-jon.seymour@gmail.com>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7s-0006Bk-BK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab1HAL5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60595 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1HAL52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:57:28 -0400
Received: by mail-yx0-f174.google.com with SMTP id 11so3066694yxi.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nCDiWirShm6M+SLXDtK/w/9WOZ4QJJwC7Y6bvoqDH7U=;
        b=gC6fLHA1DufcVGrRmS61IoUxbkAIj9Ej6KzxSAzC52AXzsNriJoTbgK8BSmgW8Kt2N
         EVsHgxysVQSIY9Sf0H527YJe1t7Rw4pPf+fgGZntOa0yrnYQ6a6u11pyw7q3o2Q/uAWS
         F9/q/d3GJLAERLFZ3cb7ur6NtljQhOQQ8oop8=
Received: by 10.142.144.15 with SMTP id r15mr2954474wfd.439.1312199848064;
        Mon, 01 Aug 2011 04:57:28 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.57.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:57:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
In-Reply-To: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178341>

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
1.7.6.352.g0c69b
