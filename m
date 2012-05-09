From: Mark Ashley <mark@ibiblio.org>
Subject: Compiling git on Solaris. Recipe included.
Date: Wed, 9 May 2012 13:11:30 +1000
Message-ID: <CADmdEsnSt5Do+EuJHzfGxNY6aCnGA6AF6fbEETAGpoL6p7Nuwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 05:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRxJk-0005KB-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 05:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab2EIDLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 23:11:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54168 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab2EIDLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 23:11:51 -0400
Received: by pbbrp8 with SMTP id rp8so8833441pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 20:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=f/S/ilRUlq3LMalZH+Fqnf5Oxt3s2co3L2OMLcEr45s=;
        b=RSwjaT7Q3MWwt3OQrTaB//QHADBbQ5GYuRghMNhQu202VeWj5vRh5EyqYds3qLPXJh
         PmA6vOcxQdoop82+pASOEA8YPfuEKu+cfdPd5SSO3X4wXglTVSDds8kX5n7eqqMMB2AJ
         JkSotmwQGbaEvQqF1lBqfa6chXEdz+E4+635xkYbewPEBOcbA66r2+eBhmPWwFOjCfqp
         ftvfPutPZ0Gaj8PVaZZC0SzMrqCxRV84KSWdlokbrRnHmrlUCcby+QaHtGh86JqF+FtF
         HH5or8tmu0kDpIHtYzcwXH+Kh0+1sNmd041dLBgrnFbyfJ7Wqs6XHX6NRNAteckW/DoS
         NEZw==
Received: by 10.68.212.229 with SMTP id nn5mr670507pbc.143.1336533110721; Tue,
 08 May 2012 20:11:50 -0700 (PDT)
Received: by 10.68.27.73 with HTTP; Tue, 8 May 2012 20:11:30 -0700 (PDT)
X-Gm-Message-State: ALoCoQkEH48CEDIRO7IhkoFDsa+b+zE4qs7PTzvzZyoEFvGbkxsICdrE4DX7Pq/l3CuNY0ddxThL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197454>

Hey folks,

I'm compiling git on Solaris 10 and 11 SPARC and X86 using the Sun Studio
12.x compilers.

git doesn't compile out of the box, there are (see below) lots of tweaks to
have it use open source stuff in /usr/local/* and also to pass some of the
configure tests for inet_ntop and -lintl.

This recipe below fixes everything and I'm on to using git now.

Thanks,
Mark.

  cd /var/tmp
  rm -rf /git git-1.7.10
   untgz /usr/local/src/utils/git-1.7.10.tar.gz
  cd git-1.7.10
   mkdir /git

  /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i Makefile
   /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i git-gui/Makefile
  /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i git_remote_helpers/Makefile
   /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i gitk-git/Makefile
  /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i gitweb/Makefile
   /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i perl/Makefile
  /bin/perl -pe "s#^ifndef V#ifdef XYZZY#" -i templates/Makefile

  /bin/perl -pe "s#-lintl#-L/usr/local/lib -lintl#" -i Makefile
   /bin/perl -pe "s#-Wall##" -i Makefile
  /bin/perl -pe "s#^TCL_PATH = tclsh#TCL_PATH = /usr/local/bin/tclsh8.5#"
-i Makefile
   /bin/perl -pe "s#tclsh#/usr/local/bin/tclsh8.5#" -i git-gui/Makefile
  /bin/perl -pe "s#tclsh#/usr/local/bin/tclsh8.5#" -i gitk-git/Makefile
   /bin/perl -pe
"s#LIBC_CONTAINS_LIBINTL=YesPlease#LIBC_CONTAINS_LIBINTL=#" -i configure
  /bin/perl -pe "s#NO_INET_NTOP=YesPlease#NEEDS_RESOLV=YesPlease#" -i
configure
   setenv TCL_PATH /usr/local/bin/tclsh8.5
  ./configure --prefix=/git \
               --with-iconv=/usr/local \
              --with-openssl=/usr/local \
               --with-curl=/usr/local \
              --with-expat=/usr/local \
               --with-zlib=/usr/local \
              --with-tcltk=/usr/local/bin/tclsh8.5 \
                --with-python=/usr/local/bin/python
  gmake
   gmake INSTALL=/usr/local/bin/ginstall install
  unsetenv TCL_PATH
