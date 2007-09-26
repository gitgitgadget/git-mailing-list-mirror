From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] "stg assimilate" on steroids
Date: Wed, 26 Sep 2007 04:15:02 +0200
Message-ID: <20070926020911.1202.2580.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 04:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaMQn-00050z-AO
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 04:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbXIZCPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2007 22:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbXIZCPJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 22:15:09 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2544 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbXIZCPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 22:15:08 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IaMQZ-0006iV-00; Wed, 26 Sep 2007 03:15:03 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59209>

This makes "stg assimilate" a whole lot more useful, and replaces my
DAG appliedness series. (If you have been using that, manually change
the stack format version back to 2, and create empty "applied" and
"unapplied" files, and run the new assimilate. That should fix it. I
hope. I'll be testing it myself tomorrow.)

Here's what assimilate says about itself:

  "assimilate" will repair three kinds of inconsistencies in your
  StGit stack, all of them caused by using plain git commands on the
  branch:

    1. If you have made regular git commits on top of your stack of
       StGit patches, "assimilate" converts them to StGit patches,
       preserving their contents.

    2. Merge commits cannot become patches; if you have committed a
       merge on top of your stack, "assimilate" will simply mark all
       patches below the merge unapplied, since they are no longer
       reachable. If this is not what you want, use "git reset" to get
       rid of the merge and run "assimilate" again.

    3. The applied patches are supposed to be precisely those that are
       reachable from the branch head. If you have used e.g. "git
       reset" to move the head, some applied patches may no longer be
       reachable, and some unapplied patches may have become
       reachable. "assimilate" will correct the appliedness of such
       patches.

  Note that these are "inconsistencies", not "errors"; furthermore,
  "assimilate" will repair them reliably. As long as you are satisfied
  with the way "assimilate" handles them, you have no reason to avoid
  causing them in the first place if that is convenient for you.

---

Karl Hasselstr=C3=B6m (2):
      Test the new powers of "stg assimilate"
      Teach "stg assimilate" to repair patch reachability


 stgit/commands/assimilate.py  |  190 +++++++++++++++++++++++++++++++--=
--------
 stgit/commands/common.py      |    6 +
 stgit/stack.py                |    6 +
 t/t1301-assimilate.sh         |   12 +--
 t/t1302-assimilate-interop.sh |   59 +++++++++++++
 5 files changed, 216 insertions(+), 57 deletions(-)
 create mode 100755 t/t1302-assimilate-interop.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
