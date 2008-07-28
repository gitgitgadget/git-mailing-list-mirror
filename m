From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Tue, 29 Jul 2008 01:55:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807290155070.2725@eeepc-johanness>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann> <alpine.DEB.1.00.0807281605330.8986@racer> <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807290137370.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:55:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcZ4-0008E8-Rt
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYG1Xym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYG1Xym
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:54:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:47048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751980AbYG1Xym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:54:42 -0400
Received: (qmail invoked by alias); 28 Jul 2008 23:54:40 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp016) with SMTP; 29 Jul 2008 01:54:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q+ohjH2GqijkswrCSnpFtOU4izl6bLibVJoX/vn
	OqocOVZrWQl9lE
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0807290137370.2725@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90528>

Hi,

On Tue, 29 Jul 2008, Johannes Schindelin wrote:

> BTW I have no idea how we could test for this, short of introducing the 
> "sleep 1" I did earlier.  Maybe guard it with a TEST_EXPENSIVE_CTIME 
> variable or something similar.  Dunno.

IOW something like this squashed into your patch:

-- snipsnap --

 t/t7001-mv.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b0fa407..c749059 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -179,6 +179,10 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	git init &&
 	echo 1 >moved &&
 	ln -s moved symlink &&
+	if test ! -z "$TEST_EXPENSIVE_CTIME"
+	then
+		sleep 1
+	fi &&
 	git add moved symlink &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
