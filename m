From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 00/13] Eliminate 'top' and 'bottom' files
Date: Sat, 15 Sep 2007 00:31:09 +0200
Message-ID: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJh2-0001Iz-TV
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843AbXINWbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbXINWbO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:14 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56491 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612AbXINWbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 64310200A1CE;
	Sat, 15 Sep 2007 00:31:12 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05544-01-35; Sat, 15 Sep 2007 00:31:10 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E189A200A1B8;
	Sat, 15 Sep 2007 00:31:09 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 2DD68BFA59;
	Sat, 15 Sep 2007 00:31:09 +0200 (CEST)
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58192>

The following series removes the 'bottom' and 'top' files for each
patch, and instead uses the commit objects to keep track of the
patches.

The patches are based on kha/safe
24a81d7a94cd7c9ad2fc741b0179db5b830cce78 and will conflict with the
'conflict' series in at least one place.

The first ten patches are actually only cleanups and refactoring that
could go in regardless of the last ones.  Some of the changes are not
really necessary, but I did them while digging into the the code, and
believe they are improvements. They should not change the way stg
behaves in any way.

The eleventh one is just a sanity check before applying the last two
that removes the top and bottom files.

The last two patches do the final cleansing.  Obviously, this changes
the format, and the format version should be increased and and update
function be written.  So it's not really ready to go in yet.

Also, there are some documentation changes not included in this.

Maybe I should have sent the first ten patches separately, but this
makes it clearer why I did it.

---

David K=C3=A5gedal (13):
      Remove the 'top' field
      Remove the 'bottom' field
      Check bottom and invariants
      Refactor Series.new_patch
      Clear up the semantics of Series.new_patch
      Add a 'bottom' parameter to Series.refresh_patch and use it
      Clean up Series.refresh_patch
      Refactor Series.push_patch
      Remove dead code from push_empty_patch
      Split Series.push_patch in two
      Moved that status function to the status command file
      Clear up semantics of tree_status
      Add some more tests of "stg status" output


 stgit/commands/common.py   |    2=20
 stgit/commands/status.py   |   42 +++++++++-
 stgit/commands/sync.py     |    1=20
 stgit/commands/uncommit.py |    1=20
 stgit/git.py               |   61 +++-----------
 stgit/stack.py             |  189 ++++++++++++++++++++++--------------=
--------
 t/t0002-status.sh          |   36 ++++++++
 7 files changed, 185 insertions(+), 147 deletions(-)

--=20
Signature
