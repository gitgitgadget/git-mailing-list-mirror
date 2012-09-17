From: Alex Riesen <raa.lkml@gmail.com>
Subject: Parallel make failed in perl/perl.mak
Date: Mon, 17 Sep 2012 20:13:35 +0200
Message-ID: <CALxABCbzr653R4aCc_YOXNZYo8Zeu8WiU72OmyyMyz5WR+p6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 20:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfpd-0005oZ-Al
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 20:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab2IQSN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 14:13:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36395 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab2IQSN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 14:13:56 -0400
Received: by pbbrr13 with SMTP id rr13so9404125pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=S5uWCePSNPtfwWUhrHCwP/8Uwg9K6Ssgmh2rQQeDqL4=;
        b=YSucgxFxOTS84EfcHj9PXoZKWOJGbVwk0FtLvsUzTgDBDGjnMus/rYPt9L2sRvSgZG
         Ot+II580C8DIDJsjN6ojlRj549LOrcxk63afe9QqsmfZNCrCULoi9C7+C1YjmsKvqNBO
         OXOwA9V1s1uOm6oghQYUugUhNkqCDmWsukRo+OInbSKgr0CR5oSmVnrp/cyZiRQmO3hZ
         tOI28BUfV9h+hKzUQXNPqJjmne/ePS+uooLVZvBgzIugUVsYPzu7bE8ZPLTEleJNdUbq
         o9UpZ90WRLM0x3CQwqQ+5WAoUvsPWS34oTE/RCeKdObjwxAR9O6Z/DPk+502UeHsR9on
         6hVQ==
Received: by 10.66.88.40 with SMTP id bd8mr21354379pab.36.1347905635892; Mon,
 17 Sep 2012 11:13:55 -0700 (PDT)
Received: by 10.66.160.232 with HTTP; Mon, 17 Sep 2012 11:13:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205727>

mv: cannot stat `perl.mak': No such file or directory
mv: cannot move `perl.mak' to `perl.mak.old': No such file or directory
Writing perl.mak for Git
Writing MYMETA.yml
Writing perl.mak for Git
Writing MYMETA.yml
Writing perl.mak for Git
Writing MYMETA.yml
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-difftool] Error 2
make: *** Waiting for unfinished jobs....
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-archimport] Error 2
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
make: *** [git-add--interactive] Error 2

I wasn't able to reproduce it, so this message is the only thing I have.
It was the first compilation after I merged the current master
(v1.7.12-464-g83379df).
Yes, I tried to jump back and forth in time, removing and touching perl.mak,
generating it with previous releases and build with the current. No luck.

Probably the old perl.mak is the problem, and the only thing I can think
for reasons why it wasn't regenerated is this:

diff --git a/perl/Makefile b/perl/Makefile
index 15d96fc..766d02a 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -79,7 +79,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else
-$(makfile): Makefile.PL ../GIT-CFLAGS
+$(makfile): Makefile.PL ../GIT-CFLAGS Makefile
 	$(PERL_PATH) $< PREFIX='$(prefix_SQ)' INSTALL_BASE=''
--localedir='$(localedir_SQ)'
 endif

Could someone please take a look at it?
