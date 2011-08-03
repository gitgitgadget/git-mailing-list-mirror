From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v15 7/7] bisect: add documentation for --no-checkout option.
Date: Thu,  4 Aug 2011 01:03:31 +1000
Message-ID: <1312383811-7130-8-git-send-email-jon.seymour@gmail.com>
References: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 17:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qod03-00021l-ES
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 17:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab1HCPEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 11:04:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43862 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab1HCPEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 11:04:41 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so190655pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XcGIne91AHyGrqBDiQ+XW7UIAWH7Bvq7jPiBdeop/go=;
        b=h8aIonjjeln/rKVuBCRF3D/FZdoiy/ElrFHdhczKz72LkTa71OXRSeY57VsYlsSIEE
         zi+HrEGkP4R7/d3mMSplsviWVrXMPXI/cWOFSN58MSGwVt6w+HR4scvptMclgVp/WQ16
         1ae7ULSI79je7re+j3BZzOSNUhSrMGzxBb8QE=
Received: by 10.142.225.11 with SMTP id x11mr4804874wfg.221.1312383876565;
        Wed, 03 Aug 2011 08:04:36 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id d1sm1133916pbj.88.2011.08.03.08.04.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 08:04:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.gd542a2
In-Reply-To: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178588>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..2f23829 100644
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
+Do not checkout the new working tree at each iteration of the bisection
+process. Instead just update a special reference named 'BISECT_HEAD' to make
+it point to the commit that should be tested.
++
+This option is useful in circumstances in which checkout is either not
+possible (because the repository is damaged) or is otherwise not required.
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
+if git rev-list --objects BISECT_HEAD >tmp.$$; then
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
1.7.6.352.gd542a2
