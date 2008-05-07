From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2 v3] Documentation: bisect: add a few "git bisect run"
 examples
Date: Thu, 8 May 2008 01:00:54 +0200
Message-ID: <20080508010054.e0c48934.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	T
X-From: git-owner@vger.kernel.org Thu May 08 00:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtsZG-00010J-JU
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbYEGW4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbYEGW4I
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:56:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:44316 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbYEGW4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:56:05 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 688541AB2BB;
	Thu,  8 May 2008 00:56:02 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id E4D8D1AB2AB;
	Thu,  8 May 2008 00:56:01 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81491>

Before this patch, there were no "git bisect run" example.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   49 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

	Changes since the previous version:

	- add an example for a broken test suite
	- use "cat" to show the content of "~/test.sh"
	- tell that it's safer to have test scripts outside the repo

	Thank you all for your comments. 

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 698ffde..539f37d 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -224,6 +224,55 @@ tree to the pristine state.  Finally the "run" script can exit with
 the status of the real test to let "git bisect run" command loop to
 know the outcome.
 
+EXAMPLES
+--------
+
+* Automatically bisect a broken build between v1.2 and HEAD:
++
+------------
+$ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
+$ git bisect run make                # "make" builds the app
+------------
+
+* Automatically bisect a broken test suite:
++
+------------
+$ cat ~/test.sh
+#!/bin/sh
+make || exit 125                   # this "skip"s broken builds
+make test                          # "make test" runs the test suite
+$ git bisect start v1.3 v1.1 --    # v1.3 is bad, v1.1 is good
+$ git bisect run ~/test.sh
+------------
++
+Here we use a "test.sh" custom script. In this script, if "make"
+fails, we "skip" the current commit.
++
+It's safer to use a custom script outside the repo to prevent
+interactions between the bisect, make and test processes and the
+script.
++
+And "make test" should "exit 0", if the test suite passes, and
+"exit 1" (for example) otherwise.
+
+* Automatically bisect a broken test case:
++
+------------
+$ cat ~/test.sh
+#!/bin/sh
+make || exit 125                     # this "skip"s broken builds
+~/check_test_case.sh                 # does the test case passes ?
+$ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
+$ git bisect run ~/test.sh
+------------
++
+Here "check_test_case.sh" should "exit 0", if the test case passes,
+and "exit 1" (for example) otherwise.
++
+It's safer if both "test.sh" and "check_test_case.sh" scripts are
+outside the repo to prevent interactions between the bisect, make and
+test processes and the scripts.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.5.5.1.273.g4b50
