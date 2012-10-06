From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Sat, 06 Oct 2012 18:33:08 +0100
Message-ID: <50706B54.8090004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 19:34:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKYGz-0002rK-TH
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 19:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab2JFRef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 13:34:35 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:49605 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754237Ab2JFRee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 13:34:34 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3F6CB384081;
	Sat,  6 Oct 2012 18:34:33 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 7B40638406F;	Sat,  6 Oct 2012 18:34:32 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat,  6 Oct 2012 18:34:31 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207158>


The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
variable, either from the environment or command line of an
'make test' invocation. In order to allow the malloc checks to be
disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
to the environment using an export directive.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Now that the malloc checks have been enabled, running the tests has
become somewhat noisy with "malloc: using debugging hooks" messages
spewing continuously to the terminal. [I usually run the tests like
so:

    ramsay$ time $(make test >test-out 2>&1)
    malloc: using debugging hooks
    malloc: using debugging hooks
    ...
    malloc: using debugging hooks

    real    16m11.408s
    user    5m17.412s
    sys     4m54.786s
    ramsay$ 
]
strace tells me that the controlling terminal, /dev/tty, is being
opened directly in order to write these messages. I find this
annoying, so I tried to disable the malloc checks from config.mak ...

Note that I decided not to write the TEST_NO_MALLOC_CHECK setting
to the GIT-BUILD-OPTIONS file, since I prefer to enable/disable
the malloc checks myself when running the test script directly.

ATB,
Ramsay Jones

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 8413606..f69979e 100644
--- a/Makefile
+++ b/Makefile
@@ -2636,6 +2636,7 @@ bin-wrappers/%: wrap-for-bin.sh
 # with that.
 
 export NO_SVN_TESTS
+export TEST_NO_MALLOC_CHECK
 
 ### Testing rules
 
-- 
1.7.12
