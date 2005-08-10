From: Wolfgang Denk <wd@denx.de>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 09:46:07 +0200
Message-ID: <20050810074607.30803353C46@atlas.denx.de>
References: <20050810003012.GB22778@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 09:48:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2lIF-0001ij-BJ
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 09:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVHJHq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 03:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVHJHq2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 03:46:28 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:37558 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S965037AbVHJHq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 03:46:28 -0400
Received: from fwd28.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1E2lI2-0006nZ-04; Wed, 10 Aug 2005 09:46:18 +0200
Received: from denx.de (GiUsUmZ6YeDI+iBQB4zMx22j5VKzjuOP5TdADFMnypndCSWerKLyEz@[84.150.65.8]) by fwd28.sul.t-online.de
	with esmtp id 1E2lHs-1Yl0xk0; Wed, 10 Aug 2005 09:46:08 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 6B33142ECE; Wed, 10 Aug 2005 09:46:07 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 30803353C46;
	Wed, 10 Aug 2005 09:46:07 +0200 (MEST)
To: Ryan Anderson <ryan@michonline.com>
In-reply-to: Your message of "Tue, 09 Aug 2005 20:30:12 EDT."
             <20050810003012.GB22778@mythryan2.michonline.com> 
X-ID: GiUsUmZ6YeDI+iBQB4zMx22j5VKzjuOP5TdADFMnypndCSWerKLyEz@t-dialin.net
X-TOI-MSGID: 76af9ebf-d28e-4eb1-8036-df82888b86ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <20050810003012.GB22778@mythryan2.michonline.com> you wrote:
>
> > The problematic one is git-send-email-script.  
> 
> Yup.  I'll take the blame for that one - I forget how inclusive the
> Debian packaging is compared to the other distributions.

Actually this may be more of a problem  with  Fedora  Core  /  RedHat
dependency generation and checking.

As far as the RPM *build* is concerned this looks pretty harmless  to
me:

	BuildRequires:  zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
	...
	Prereq:         sh-utils, diffutils, rsync, rcs, mktemp >= 1.5


But the RPM itself seems  to  contain  additional  information  about
required packages:

	# rpm -q --requires -p /usr/local/RPMS/i386/git-core-0.99.3-1.i386.rpm
	/bin/sh  
	/usr/bin/env  
	/usr/bin/perl  
	diffutils  
	libc.so.6  
	libc.so.6(GLIBC_2.0)  
	libc.so.6(GLIBC_2.1)  
	libc.so.6(GLIBC_2.1.3)  
	libc.so.6(GLIBC_2.2.3)  
	libc.so.6(GLIBC_2.3)  
	libcrypto.so.4  
	libcurl.so.2  
	libssl.so.4  
	libz.so.1  
	mktemp >= 1.5
	perl(Data::Dumper)  
	perl(Email::Valid)  
	perl(File::Basename)  
	perl(File::Path)  
	perl(File::Spec)  
	perl(File::Temp)  
	perl(Getopt::Long)  
	perl(Getopt::Std)  
	perl(IO::Pipe)  
	perl(IO::Socket)  
	perl(Mail::Sendmail)  
	perl(POSIX)  
	perl(Term::ReadLine)  
	perl(Time::Local)  
	perl(strict)  
	perl(warnings)  
	rcs  
	rpmlib(CompressedFileNames) <= 3.0.4-1
	rpmlib(PayloadFilesHavePrefix) <= 4.0-1
	rpmlib(VersionedDependencies) <= 3.0.3-1
	rsync  
	sh-utils  

It's then the "perl(Email::Valid)" and "perl(Mail::Sendmail)"  depen-
dencies  which  cause  problems.  I  installed  all perl packages and
modules I was able to find in the standard FC places,  but  this  did
not solve the problem. Maybe this is actually a bug in Fedora Core ?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The question of whether a computer can think is no more  interesting
than the question of whether a submarine can swim"
                                                - Edsgar W.  Dijkstra
