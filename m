From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 03/10] Documentation/bisect: revise overall content
Date: Mon, 29 Jun 2015 17:40:28 +0200
Message-ID: <1435592435-27914-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bBf-0003OX-6x
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF2Pl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:41:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46717 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbbF2PlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:41:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFefMP018087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFehg6031669;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAo-0008DY-TQ; Mon, 29 Jun 2015 17:40:42 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 17:40:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFefMP018087
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197242.48447@PxVZpGhtQZXQi4C2qRHd3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272965>

From: Michael Haggerty <mhagger@alum.mit.edu>

Thoroughly revise the "git bisect" manpage, including:

* Beef up the "Description" section.

* Make the first long example less specific to kernel development.

* De-emphasize implementation details in a couple of places.

* Add "(roughly N steps)" in the places where example output is shown.

* Properly markup code within the prose.

* Lots of wordsmithing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 122 ++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 2bdc3b8..e97f2de 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -3,7 +3,7 @@ git-bisect(1)
 
 NAME
 ----
-git-bisect - Find by binary search the change that introduced a bug
+git-bisect - Use binary search to find the commit that introduced a bug
 
 
 SYNOPSIS
@@ -16,7 +16,6 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect help
  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
@@ -26,58 +25,71 @@ on the subcommand:
  git bisect replay <logfile>
  git bisect log
  git bisect run <cmd>...
+ git bisect help
 
-This command uses 'git rev-list --bisect' to help drive the
-binary search process to find which change introduced a bug, given an
-old "good" commit object name and a later "bad" commit object name.
+This command uses a binary search algorithm to find which commit in
+your project's history introduced a bug. You use it by first telling
+it a "bad" commit that is known to contain the bug, and a "good"
+commit that is known to be before the bug was introduced. Then `git
+bisect` picks a commit between those two endpoints and asks you
+whether the selected commit is "good" or "bad". It continues narrowing
+down the range until it finds the exact commit that introduced the
+change.
 
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Using the Linux kernel tree as an example, basic use of the bisect
-command is as follows:
+As an example, suppose you are trying to find the commit that broke a
+feature that was known to work in version `v2.6.13-rc2` of your
+project. You start a bisect session as follows:
 
 ------------------------------------------------
 $ git bisect start
 $ git bisect bad                 # Current version is bad
-$ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version
-                                 # tested that was good
+$ git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good
+------------------------------------------------
+
+Once you have specified at least one bad and one good commit, `git
+bisect` selects a commit in the middle of that range of history,
+checks it out, and outputs something similar to the following:
+
+------------------------------------------------
+Bisecting: 675 revisions left to test after this (roughly 10 steps)
 ------------------------------------------------
 
-When you have specified at least one bad and one good version, the
-command bisects the revision tree and outputs something similar to
-the following:
+You should now compile the checked-out version and test it. If that
+version works correctly, type
 
 ------------------------------------------------
-Bisecting: 675 revisions left to test after this
+$ git bisect good
 ------------------------------------------------
 
-The state in the middle of the set of revisions is then checked out.
-You would now compile that kernel and boot it. If the booted kernel
-works correctly, you would then issue the following command:
+If that version is broken, type
 
 ------------------------------------------------
-$ git bisect good			# this one is good
+$ git bisect bad
 ------------------------------------------------
 
-The output of this command would be something similar to the following:
+Then `git bisect` will respond with something like
 
 ------------------------------------------------
-Bisecting: 337 revisions left to test after this
+Bisecting: 337 revisions left to test after this (roughly 9 steps)
 ------------------------------------------------
 
-You keep repeating this process, compiling the tree, testing it, and
-depending on whether it is good or bad issuing the command "git bisect good"
-or "git bisect bad" to ask for the next bisection.
+Keep repeating the process: compile the tree, test it, and depending
+on whether it is good or bad run `git bisect good` or `git bisect bad`
+to ask for the next commit that needs testing.
+
+Eventually there will be no more revisions left to inspect, and the
+command will print out a description of the first bad commit. The
+reference `refs/bisect/bad` will be left pointing at that commit.
 
-Eventually there will be no more revisions left to bisect, and you
-will have been left with the first bad kernel revision in "refs/bisect/bad".
 
 Bisect reset
 ~~~~~~~~~~~~
 
 After a bisect session, to clean up the bisection state and return to
-the original HEAD (i.e., to quit bisecting), issue the following command:
+the original HEAD, issue the following command:
 
 ------------------------------------------------
 $ git bisect reset
@@ -94,9 +106,10 @@ instead:
 $ git bisect reset <commit>
 ------------------------------------------------
 
-For example, `git bisect reset HEAD` will leave you on the current
-bisection commit and avoid switching commits at all, while `git bisect
-reset bisect/bad` will check out the first bad revision.
+For example, `git bisect reset bisect/bad` will check out the first
+bad revision, while `git bisect reset HEAD` will leave you on the
+current bisection commit and avoid switching commits at all.
+
 
 Bisect visualize
 ~~~~~~~~~~~~~~~~
@@ -141,17 +154,17 @@ $ git bisect replay that-file
 Avoiding testing a commit
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If, in the middle of a bisect session, you know that the next suggested
-revision is not a good one to test (e.g. the change the commit
-introduces is known not to work in your environment and you know it
-does not have anything to do with the bug you are chasing), you may
-want to find a nearby commit and try that instead.
+If, in the middle of a bisect session, you know that the suggested
+revision is not a good one to test (e.g. it fails to build and you
+know that the failure does not have anything to do with the bug you
+are chasing), you can manually select a nearby commit and test that
+one instead.
 
 For example:
 
 ------------
 $ git bisect good/bad			# previous round was good or bad.
-Bisecting: 337 revisions left to test after this
+Bisecting: 337 revisions left to test after this (roughly 9 steps)
 $ git bisect visualize			# oops, that is uninteresting.
 $ git reset --hard HEAD~3		# try 3 revisions before what
 					# was suggested
@@ -163,18 +176,19 @@ the revision as good or bad in the usual manner.
 Bisect skip
 ~~~~~~~~~~~~
 
-Instead of choosing by yourself a nearby commit, you can ask Git
-to do it for you by issuing the command:
+Instead of choosing a nearby commit by yourself, you can ask Git to do
+it for you by issuing the command:
 
 ------------
 $ git bisect skip                 # Current version cannot be tested
 ------------
 
-But Git may eventually be unable to tell the first bad commit among
-a bad commit and one or more skipped commits.
+However, if you skip a commit adjacent to the one you are looking for,
+Git will be unable to tell exactly which of those commits was the
+first bad one.
 
-You can even skip a range of commits, instead of just one commit,
-using the "'<commit1>'..'<commit2>'" notation. For example:
+You can also skip a range of commits, instead of just one commit,
+using range notation. For example:
 
 ------------
 $ git bisect skip v2.5..v2.6
@@ -190,8 +204,8 @@ would issue the command:
 $ git bisect skip v2.5 v2.5..v2.6
 ------------
 
-This tells the bisect process that the commits between `v2.5` included
-and `v2.6` included should be skipped.
+This tells the bisect process that the commits between `v2.5` and
+`v2.6` (inclusive) should be skipped.
 
 
 Cutting down bisection by giving more parameters to bisect start
@@ -225,14 +239,14 @@ or bad, you can bisect by issuing the command:
 $ git bisect run my_script arguments
 ------------
 
-Note that the script (`my_script` in the above example) should
-exit with code 0 if the current source code is good, and exit with a
-code between 1 and 127 (inclusive), except 125, if the current
-source code is bad.
+Note that the script (`my_script` in the above example) should exit
+with code 0 if the current source code is good/old, and exit with a
+code between 1 and 127 (inclusive), except 125, if the current source
+code is bad/new.
 
 Any other exit code will abort the bisect process. It should be noted
-that a program that terminates via "exit(-1)" leaves $? = 255, (see the
-exit(3) manual page), as the value is chopped with "& 0377".
+that a program that terminates via `exit(-1)` leaves $? = 255, (see the
+exit(3) manual page), as the value is chopped with `& 0377`.
 
 The special exit code 125 should be used when the current source code
 cannot be tested. If the script exits with this code, the current
@@ -241,7 +255,7 @@ as the highest sensible value to use for this purpose, because 126 and 127
 are used by POSIX shells to signal specific error status (127 is for
 command not found, 126 is for command found but not executable---these
 details do not matter, as they are normal errors in the script, as far as
-"bisect run" is concerned).
+`bisect run` is concerned).
 
 You may often find that during a bisect session you want to have
 temporary modifications (e.g. s/#define DEBUG 0/#define DEBUG 1/ in a
@@ -254,7 +268,7 @@ next revision to test, the script can apply the patch
 before compiling, run the real test, and afterwards decide if the
 revision (possibly with the needed patch) passed the test and then
 rewind the tree to the pristine state.  Finally the script should exit
-with the status of the real test to let the "git bisect run" command loop
+with the status of the real test to let the `git bisect run` command loop
 determine the eventual outcome of the bisect session.
 
 OPTIONS
@@ -301,12 +315,12 @@ $ git bisect run ~/test.sh
 $ git bisect reset                   # quit the bisect session
 ------------
 +
-Here we use a "test.sh" custom script. In this script, if "make"
+Here we use a `test.sh` custom script. In this script, if `make`
 fails, we skip the current commit.
-"check_test_case.sh" should "exit 0" if the test case passes,
-and "exit 1" otherwise.
+`check_test_case.sh` should `exit 0` if the test case passes,
+and `exit 1` otherwise.
 +
-It is safer if both "test.sh" and "check_test_case.sh" are
+It is safer if both `test.sh` and `check_test_case.sh` are
 outside the repository to prevent interactions between the bisect,
 make and test processes and the scripts.
 
-- 
2.5.0.rc0.10.gd2bff5d
