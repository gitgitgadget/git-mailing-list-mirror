From: dhruva <dhruva@ymail.com>
Subject: Re: What's the status of MinGW port.
Date: Mon, 8 Sep 2008 13:52:10 +0530 (IST)
Message-ID: <532046.43033.qm@web95005.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>, Kevin Yu <yujie052@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 10:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcc1x-0001rP-Hl
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 10:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYIHIWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYIHIWO
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 04:22:14 -0400
Received: from n4a.bullet.mail.tp2.yahoo.com ([203.188.202.98]:46980 "HELO
	n4a.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752269AbYIHIWO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 04:22:14 -0400
Received: from [203.188.202.76] by n4.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 08:22:12 -0000
Received: from [202.43.196.224] by t2.bullet.mail.tp2.yahoo.com with NNFMP; 08 Sep 2008 08:22:12 -0000
Received: from [203.212.168.60] by t1.bullet.tpe.yahoo.com with NNFMP; 08 Sep 2008 08:22:12 -0000
Received: from [203.104.17.88] by t1.bullet.kr1.yahoo.com with NNFMP; 08 Sep 2008 08:22:12 -0000
Received: from [127.0.0.1] by omp102.mail.in2.yahoo.com with NNFMP; 08 Sep 2008 08:22:10 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 632233.53764.bm@omp102.mail.in2.yahoo.com
Received: (qmail 43690 invoked by uid 60001); 8 Sep 2008 08:22:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Wfr+Q3EZJrdlnUbneSOxTDIIAfRaNAlYrIYpAEFsrXIgHvMRo5w1Puj3navo3TpPFKqhf5fF4NrwFe6gvBLUcE31SKEj69QfO7xmcMvpKJNg7g3oWBTylNDIak8wDXwO6zThZMIaIy23szD0gckVa2jbXKzhJAR7VXRDkoaRjG4=;
X-YMail-OSG: Yr61K34VM1nthladzcnOMYQqNN.8MMR8z.BrgjGDyhN6.JHsLdz0EWGnapiu3VDW6z2ntmj3t_1R.OfzD4nkHvtlr46beqfsy7SWbPpVNH73dEnNKqwCyGu1IVBoyG0-
Received: from [202.3.112.9] by web95005.mail.in2.yahoo.com via HTTP; Mon, 08 Sep 2008 13:52:10 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95228>

Hi,
 I cloned the git repo from 'git://git2.kernel.org/pub/scm/git/git.git'. I had an earlier msysGIT with build environment. I just got into the msys (bash) environment and ran a 'gmake'. It built fine on Windows XP.
 I thank everyone involved in making git work on windoze. It really makes it a lot more easier to push git as a serious dVCS in the corporate world with development hapenning on different platforms :-)
 Once I iron out git-p4, hoping to say "Git the hell out of here ... p4" soon.

A trivial issue in install:
'gmake install' had a small issue in trying to install non existant 'git-shell.exe'. The following trivial patch on master to Makefile handles that:


diff --git a/Makefile b/Makefile
index dfed7ba..d5a3327 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,7 +1365,10 @@ install: all
        $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
        $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
        $(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-       $(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive
$X git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
+ifndef NO_POSIX_ONLY_PROGRAMS
+       $(INSTALL) git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
+endif
+       $(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive
$X '$(DESTDIR_SQ)$(bindir_SQ)'
        $(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
        $(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK


-dhruva


----- Original Message ----
> From: Johannes Sixt <j.sixt@viscovery.net>
> To: Kevin Yu <yujie052@gmail.com>
> Cc: git@vger.kernel.org
> Sent: Monday, 8 September, 2008 12:38:08 PM
> Subject: Re: What's the status of MinGW port.
> 
> Kevin Yu schrieb:
> >       GIT is a great tool, but I'm running Windows XP.
> >       It seems like msysgit hasn't been updated for a long time,
> > neither has the mingw.git branch.
> >       Is there any plan to create a native version of GIT on MS Windows?
> 
> There are no plans anymore to create such a thing.
> 
> It is already there: http://code.google.com/p/msysgit/
> 
> If the lack of activity is worrysome to you, you could help create a
> release tarball for 1.6..0(.x).
> 
> -- Hannes
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
