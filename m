From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Test #7 in t9200-git-cvsexportcommit fails
Date: Sun, 22 Jul 2007 23:42:24 +0200
Message-ID: <20070722214224.GA2732@steel.home>
References: <31e9dd080707221241j5c00aaaaqa79c12d3e2a3345b@mail.gmail.com> <20070722202121.GA3288@steel.home> <31e9dd080707221349g40ff050bue72733f270822603@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjCB-0001r2-MJ
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXGVVm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbXGVVm2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:42:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45967 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbXGVVm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:42:28 -0400
Received: from tigra.home (Fc8c3.f.strato-dslnet.de [195.4.200.195])
	by post.webmailer.de (fruni mo59) (RZmta 9.1)
	with ESMTP id g0482cj6MFddYh ; Sun, 22 Jul 2007 23:42:25 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6DF8E277BD;
	Sun, 22 Jul 2007 23:42:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DCB9CBDD0; Sun, 22 Jul 2007 23:42:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <31e9dd080707221349g40ff050bue72733f270822603@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WOJg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53327>

Jason Sewall, Sun, Jul 22, 2007 22:49:19 +0200:
> >It'll never work, cvs does not commit changes made during one second,
> >as they have the same timestamp.
> 
> Why not add a delay in there, like this:
> 
> id=$(git rev-list --max-count=1 HEAD) && sleep 2
> 
> It makes the test work for me.

It looks just like another reason to disable it. It is not like the
_git_ functionality which is used by git-cvsexportcommit is not
already tested elsewhere.

Note that I do _NOT_ suggest disabling it by default, but a bit of
warning would probably do some good:

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 4efa0c9..e5e9e36 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -6,6 +6,12 @@ test_description='CVS export comit. '
 
 . ./test-lib.sh
 
+echo >&2
+echo >&2 "This test is very timing dependent and may fail."
+echo >&2 "If you don't need git-cvsexportcommit you're better off"
+echo >&2 "disabling it: make test GIT_SKIP_TESTS=t9200"
+echo >&2
+
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
