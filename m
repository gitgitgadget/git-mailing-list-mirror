From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 16:06:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807281605330.8986@racer>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-580811775-1217257566=:8986"
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 17:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNUJh-0005GP-F5
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 17:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbYG1PGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757249AbYG1PGI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 11:06:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:47193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757031AbYG1PGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 11:06:07 -0400
Received: (qmail invoked by alias); 28 Jul 2008 15:06:05 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp067) with SMTP; 28 Jul 2008 17:06:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BfT87oBWBMX/qv+ZCLgn+PDNa1OW1STyQ++QemR
	VD+uBtCcQ8FnzO
X-X-Sender: gene099@racer
In-Reply-To: <20080728142023.GC6701@neumann>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90465>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-580811775-1217257566=:8986
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Jul 2008, SZEDER Gábor wrote:

> there is a race somewhere in these 'git-mv: Keep moved index entries
> inact' changes.
> 
> The test cases 'git mv should overwrite symlink to a file' or 'git mv
> should overwrite file with a symlink' fail occasionaly.  It's quite
> non-deterministic:  I have run t7001-mv.sh in a loop (see below) and
> one or the other usually fails around 50 runs (but sometimes only
> after 150).  Adding some tracing echos to the tests shows that both
> tests fail when running 'git diff-files' at the end.

To make it more convenient to test: with this patch it fails all the time:

-- snipsnap --

 t/t7001-mv.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b0fa407..6699abd 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -180,6 +180,7 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	echo 1 >moved &&
 	ln -s moved symlink &&
 	git add moved symlink &&
+	sleep 1 &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
 	! test -e moved &&
--8323329-580811775-1217257566=:8986--
