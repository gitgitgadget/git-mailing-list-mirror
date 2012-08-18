From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Test failures in t4034
Date: Sat, 18 Aug 2012 02:03:26 -0400
Message-ID: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 08:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2cI2-0001Of-Pw
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 08:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab2HRGNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 02:13:07 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54521 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2HRGNE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 02:13:04 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 02:13:04 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3AC6C92981FF; Sat, 18 Aug 2012 06:03:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.5 tests=ALL_TRUSTED,BAYES_50
	autolearn=ham version=3.2.5
Received: from [192.168.1.10] (cpe-72-230-193-225.stny.res.rr.com [72.230.193.225])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id A57AE92981FE;
	Sat, 18 Aug 2012 06:03:25 +0000 (UTC)
X-Mailer: Apple Mail (2.1485)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203670>

I've been getting a couple of test failures and finally had the time to track them down.

t4034-diff-words fails tests "22 diff driver 'bibtex'" and "26 diff driver 'html'".  Bisecting shows that the file started giving me errors in commit 8d96e72 "t4034: bulk verify builtin word regex sanity", which appears to introduce those tests.  I don't see anything obviously wrong with the tests and I'm not familiar with the diff-words code, so I'm not sure what's wrong.

I am running on OS X 10.8, with Xcode 4.4.1 (llvm-gcc 4.2.1).

Test results follow:

---------- 8< ----------

expecting success: 
		cp "$TEST_DIRECTORY/t4034/bibtex/pre" \
			"$TEST_DIRECTORY/t4034/bibtex/post" \
			"$TEST_DIRECTORY/t4034/bibtex/expect" . &&
		echo "* diff=bibtex" >.gitattributes &&
		word_diff --color-words
	
--- expect	2012-08-18 05:54:29.000000000 +0000
+++ output.decrypted	2012-08-18 05:54:29.000000000 +0000
@@ -8,8 +8,8 @@
   author={Aldous, <RED>D.<RESET><GREEN>David<RESET>},
   journal={Information Theory, IEEE Transactions on},<RESET>
   volume={<RED>33<RESET><GREEN>Bogus.<RESET>},
-  number={<RED>2<RESET><GREEN>4<RESET>},
+  number={4},
   pages={219--223},<RESET>
-  year=<GREEN>1987,<RESET>
-<GREEN>  note={This is in fact a rather funny read since ethernet works well in practice. The<RESET> {<RED>1987<RESET><GREEN>\em pre} reference is the right one, however.<RESET>}<RED>,<RESET>
+  year=<RED>{1987},<RESET><GREEN>1987,<RESET>
+  note={This is in fact a rather funny read since ethernet works well in practice. The {\em pre} reference is the right one, however.}
 }<RESET>
not ok - 22 diff driver 'bibtex'

---------- 8< ----------

expecting success: 
		cp "$TEST_DIRECTORY/t4034/html/pre" \
			"$TEST_DIRECTORY/t4034/html/post" \
			"$TEST_DIRECTORY/t4034/html/expect" . &&
		echo "* diff=html" >.gitattributes &&
		word_diff --color-words
	
--- expect	2012-08-18 05:54:29.000000000 +0000
+++ output.decrypted	2012-08-18 05:54:29.000000000 +0000
@@ -4,5 +4,5 @@
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,3 +1,3 @@<RESET>
 <tag <GREEN>newattr="newvalue"<RESET>><GREEN>added<RESET> content</tag>
-<tag attr=<RED>"value"<RESET><GREEN>"newvalue"<RESET>><RED>content<RESET><GREEN>changed<RESET></tag>
-<<RED>tag<RESET><GREEN>newtag<RESET>>content <RED>&entity;<RESET><GREEN>&newentity;<RESET><<RED>/tag<RESET><GREEN>/newtag<RESET>>
+<tag attr="newvalue">changed</tag>
+<newtag>content &newentity;</newtag>
not ok - 26 diff driver 'html'