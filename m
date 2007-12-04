From: Jeff King <peff@peff.net>
Subject: [PATCH] t9600: require cvsps 2.1 to perform tests
Date: Mon, 3 Dec 2007 20:41:45 -0500
Message-ID: <20071204014145.GA20145@coredump.intra.peff.net>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site> <20071203015954.GB8322@coredump.intra.peff.net> <47548CEC.6010701@gmail.com> <7vir3fe54c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMnd-0003ZO-6m
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXLDBlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbXLDBlv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:41:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1957 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXLDBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:41:50 -0500
Received: (qmail 1537 invoked by uid 111); 4 Dec 2007 01:41:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 20:41:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 20:41:45 -0500
Content-Disposition: inline
In-Reply-To: <7vir3fe54c.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66986>

git-cvsimport won't run at all with less than cvsps 2.1, because it
lacks the -A flag. But there's no point in preventing people who have an
old cvsps from running the full testsuite.

Tested-by: A Large Angry SCM <gitzilla@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Dec 03, 2007 at 03:21:55PM -0800, Junio C Hamano wrote:

> Jeff, would you want to further amend the patch to use "say" as Hannes
> suggested to make it look nicer?

Here it is.

 t/t9600-cvsimport.sh |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 08f0f2a..7706430 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,13 +3,29 @@
 test_description='git-cvsimport basic tests'
 . ./test-lib.sh
 
-if ! ( type cvs && type cvsps ) >/dev/null 2>&1
+if ! type cvs >/dev/null 2>&1
 then
-	test_expect_success 'skipping cvsimport tests, cvs/cvsps not found' ''
+	say 'skipping cvsimport tests, cvs not found'
 	test_done
 	exit
 fi
 
+cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
+case "$cvsps_version" in
+2.1)
+	;;
+'')
+	say 'skipping cvsimport tests, cvsps not found'
+	test_done
+	exit
+	;;
+*)
+	say 'skipping cvsimport tests, cvsps too old'
+	test_done
+	exit
+	;;
+esac
+
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
 # for clean cvsps cache
-- 
1.5.3.7.2070.g88cf2-dirty
