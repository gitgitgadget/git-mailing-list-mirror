From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 00/14] git p4 branch handling fixes
Date: Mon, 14 Jan 2013 19:46:54 -0500
Message-ID: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuugg-0008WM-3R
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab3AOArO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:47:14 -0500
Received: from honk.padd.com ([74.3.171.149]:52455 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756930Ab3AOArN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:47:13 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 9BACB2F3F;
	Mon, 14 Jan 2013 16:47:12 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id ED8DC28EC2; Mon, 14 Jan 2013 19:47:08 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213551>

There are multiple oddities in how git-p4 treats multiple
p4 branches, as created with "clone" or "sync" and the
'--branch' argument.  Olivier reported some of these recently
in http://thread.gmane.org/gmane.comp.version-control.git/212613

There are two observable behavior changes, but they
are in the category of "bug fixes" in my opinion:

    - p4/HEAD symbolic ref is always created now; it used to
      be created only after the first sync operation after a clone

    - using clone --branch now checks out files; it used to
      complain that there was no p4/master ref

Pete Wyckoff (14):
  git p4: test sync/clone --branch behavior
  git p4: rearrange and simplify hasOrigin handling
  git p4: add comments to p4BranchesInGit
  git p4: inline listExistingP4GitBranches
  git p4: create p4/HEAD on initial clone
  git p4: verify expected refs in clone --bare test
  git p4: clone --branch should checkout master
  git p4 doc: fix branch detection example
  git p4: allow short ref names to --branch
  git p4: rearrange self.initialParent use
  git p4: fail gracefully on sync with no master branch
  git p4: fix sync --branch when no master branch
  git p4 test: keep P4CLIENT changes inside subshells
  git p4: fix submit when no master branch

 Documentation/git-p4.txt  |  22 +++++--
 git-p4.py                 | 152 ++++++++++++++++++++++++++++++++--------------
 t/t9800-git-p4-basic.sh   |   9 ++-
 t/t9806-git-p4-options.sh | 128 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 253 insertions(+), 58 deletions(-)

-- 
1.8.1.350.gdbf6fd0
