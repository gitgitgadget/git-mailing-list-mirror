From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/4] Add more tests of cvsimport
Date: Sat, 21 Feb 2009 14:04:35 +0100
Message-ID: <1235221480-31473-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 14:06:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LarYt-00041j-Ov
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 14:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbZBUNFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 08:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZBUNFA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 08:05:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:57471 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbZBUNE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 08:04:59 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1LD4fLC022313;
	Sat, 21 Feb 2009 14:04:41 +0100
X-Mailer: git-send-email 1.6.1.3
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110945>

Thanks for all the feedback.  I think I have incorporated it all:

- Renamed the library from t/t96xx/cvs-lib.sh to t/lib-cvs.sh.

- Added t/t9601/cvsroot/.gitattributes to avoid whitespace warnings.

- Fixed the "cvs co" command for when checking out a branch/tag.

- Implemented a recursive diff in test_cmp_branch_tree rather than
  relying on GNU diff features.  It is only a dozen lines of code, but
  please review this carefully as I'm not such a shell jockey.

  I tried using "git diff" but it didn't seem to work for this
  purpose, even if I deleted the CVS directories manually to avoid the
  need for "-x" functionality:

  - If I used --no-index, it insisted on showing differences within
    the .git directory.

  - It didn't seem to find any differences (even when there were some)
    when I didn't use --no-index.

  - I couldn't see any documentation that the return value is nonzero
    iff differences are found.  In my tests the return value was
    always zero.

  The library can always be changed later to use "git diff", but I
  don't see this as urgent.  It would also have the disadvantage of
  making "git cvsimport" tests fail if there are bugs in "git diff".

I also added another test script, t9602, in the (new) 5th patch in the
series.  It tests "git cvsimport"'s handling of branches and tags.
Only 5/11 of the tests in this script pass.

Cheers,
Michael
