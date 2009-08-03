From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Building GIT on HP-UX: "make test" fails
Date: Mon, 03 Aug 2009 12:54:03 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <4A76DDEE.6699.119A5FD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 13:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXvI0-0005XQ-0G
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 13:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbZHCLBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 07:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbZHCLBE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 07:01:04 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.52]:37509 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754280AbZHCLBB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 07:01:01 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2009 07:01:01 EDT
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id D8D17844
	for <git@vger.kernel.org>; Mon,  3 Aug 2009 12:53:49 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTPS id 9E1AA91E
	for <git@vger.kernel.org>; Mon,  3 Aug 2009 12:53:49 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n73AsJL2020949
	for <git@vger.kernel.org>; Mon, 3 Aug 2009 12:54:19 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    3 Aug 09 12:54:17 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 3 Aug 09 12:54:08 +0100
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.41.0+V=4.41+U=2.07.230+R=04 May 2009+T=732365@20090803.105238Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124691>

(not subscribed, so please CC: replies to me, please (if replies go to the list))
Hello,

I've tried to build GIT (git-1.6.2.5) on HP-UX 11.31 (IA64) using "gcc (GCC) 
4.2.1". Unfortunately the "make test" failed after build. Here are some details:

Configure command:
./configure CC=gcc LIBS="-L../gzip-1.3.12/lib -lgzip" --prefix=/usr/local

(There were problems with "-lz" which seems to be "-lgzip" for recent builds; I 
had to manually edit the Makefile)
[...]
checking for deflateBound in -lz... no
[...]
Is the configure program expected to continue if there is no "-lz"?

"-lz" problem:
% make all
    LINK git-fast-import
ld: Can't find library for -lz
Fatal error.
collect2: ld returned 1 exit status

Eventually the build succeeded, but there was one warning:
daemon.c: In function 'service_loop':
daemon.c:855: warning: passing argument 3 of 'accept' from incompatible pointer 
type

Line is:
int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);

HP-UX manual has this prototype:
int accept(int s, void *addr, int *addrlen);

Here is the end of "make test":
[...]
*** t0100-previous.sh ***
*   ok 1: branch -d @{-1}
*   ok 2: branch -d @{-12} when there is not enough switches yet
* FAIL 3: merge @{-1}

                git checkout A &&
                test_commit B &&
                git checkout A &&
                test_commit C &&
                git branch -f master B &&
                git branch -f other &&
                git checkout other &&
                git checkout master &&
                git merge @{-1} &&
                git cat-file commit HEAD | grep "Merge branch 'other'"

* FAIL 4: merge @{-1} when there is not enough switches yet

                git reflog expire --expire=now &&
                git checkout -f master &&
                git reset --hard B &&
                git branch -f other C &&
                git checkout other &&
                git checkout master &&
                test_must_fail git merge @{-12}

* failed 2 among 4 test(s)
make[2]: *** [t0100-previous.sh] Error 1
[...]

I can try some simple things fixing the problem, but I don't have an Internet 
connection at that machine.

Regards,
Ulrich
