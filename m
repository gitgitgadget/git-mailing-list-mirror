From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCH] git_mkstemps: improve test suite test
Date: Fri, 2 Aug 2013 20:27:23 -0400
Message-ID: <201308030027.r730RNWS022924@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 02:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Pgw-0002Yf-MV
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 02:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab3HCA10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 20:27:26 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:36720
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752744Ab3HCA1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Aug 2013 20:27:25 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id 7yoP1m00327AodY5A0TRny; Sat, 03 Aug 2013 00:27:25 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id 80TQ1m00R1KKtkw3f0TQZS; Sat, 03 Aug 2013 00:27:25 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r730RNYq022925;
	Fri, 2 Aug 2013 20:27:24 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r730RNWS022924;
	Fri, 2 Aug 2013 20:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375489645;
	bh=4bbFu7wWOIEbfQgeUWep5fOEqNxiIWiOogFDT2xT1eQ=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=q/09Jlwkp0t+DCf98VX2n22ENyYVzO1dBCnw8TAP7fgawk9ETzZIekX4JJW0Iq36x
	 3qHbESTC/cSC/rp22dMHTNJRfon53zhBrpTTd09++/s967zIKFjnAvULiTp1qAX9Yg
	 s1SArvuACwQJpj6AtfMNH3cdVuUR66eWswyKdFA+ZG2x17Wkh5QOs5fWUKJl+IXvhD
	 Xpwn68Ilj4bW9UO76usHRh6tb3Xu6LzzZqxfeA9TZJOPdfaLqz/LY2yImYSKbHprR6
	 FBpsAo2ghJ1J65BVZzKynmo4eHPLusXyltvPFUBa/tXANbcnY3bxbcpNtXTt6UATF+
	 wlCConpiJz70g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231553>

Commit 52749 fixes a bug regarding testing the return of an open()
call for success/failure.  Improve the testsuite test for that fix by
removing the helper program 'test-close-fd-0' and replacing it with
the shell redirection '<&-'.  (The redirection is Posix, so it should
be portable.)

Signed-off-by: Dale Worley <worley@ariadne.com>
---

> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 19 Jul 2013 07:29:47 -0700
> 
> The change itself looks good; care to write it up as a proper patch
> with a proposed log message?

My apologies for the delay; I've had to do some yak-shaving to learn
how to construct patches properly.  (I've written some clarifications
for Document/SubmittingPatches, which I will submit separately.)

Someone has gone ahead and made the code change, so all that remains
is to update the testsuite test by replacing the helper program
'test-close-fd-0' with the Posix shell redirection '<&-'.

Dale


 Makefile          |    1 -
 test-close-fd-0.c |   14 --------------
 2 files changed, 0 insertions(+), 15 deletions(-)
 delete mode 100644 test-close-fd-0.c

diff --git a/Makefile b/Makefile
index 8ad40d4..3588ca1 100644
--- a/Makefile
+++ b/Makefile
@@ -557,7 +557,6 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
-TEST_PROGRAMS_NEED_X += test-close-fd-0
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
diff --git a/test-close-fd-0.c b/test-close-fd-0.c
deleted file mode 100644
index 3745c34..0000000
--- a/test-close-fd-0.c
+++ /dev/null
@@ -1,14 +0,0 @@
-#include <unistd.h>
-
-/* Close file descriptor 0 (which is standard-input), then execute the
- * remainder of the command line as a command. */
-
-int main(int argc, char **argv)
-{
-	/* Close fd 0. */
-	close(0);
-	/* Execute the requested command. */
-	execvp(argv[1], &argv[1]);
-	/* If execve() failed, return an error. */
-	return 1;
-}
-- 
1.7.7.6
