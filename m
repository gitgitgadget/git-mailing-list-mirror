From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 17:30:49 -0600
Message-ID: <alpine.LNX.1.10.0807301700500.13032@xenau.zenez.com>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca>
 <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com> <20080730225635.GM10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOL97-0003K4-Dg
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYG3Xaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbYG3Xav
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:30:51 -0400
Received: from zenez.com ([166.70.62.2]:3348 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbYG3Xav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:30:51 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 397BD3F97F; Wed, 30 Jul 2008 17:30:50 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 1F65C3F97D;
	Wed, 30 Jul 2008 17:30:50 -0600 (MDT)
In-Reply-To: <20080730225635.GM10399@yugib.highrise.ca>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90873>

On Wed, 30 Jul 2008, Aidan Van Dyk wrote:
> * Boyd Lynn Gerber <gerberb@zenez.com> [080730 17:28]:
> > How about doing a fresh 
> > 
> > working directory.  And just for the fun of it try...
> 
> Unfortunately, I can't use configure, apparently that SCO box does'nt
> have a new enough toolc change for M4/autoconf/etc...
> 
> But I've never had to use configure before, I've always just built with
> make (gmake on boxes with borked make)

I did have to install m4 and have /usr/local/bin before /usr/bin and /bin 
so it uses the gnu m4.

I have m4-1.4.3 at 

ftp://ftp.zenez.com/pub/zenez/prgms/m4-1.4.3-osr6-all.tar.gz

I really have to be able to use configure for most of my OpenSource 
Projects for SCO OS's.

I made the changes so that most things work with the auto tools.  
 
> > tech0 > CC=cc CXX=CC CFLAGS="-Kalloca -Kthread" CPPFLAGS="-Kalloca 
> > -Kthread" ./configure
> > tech0 > gmake
> 
> So, with gmake, that "generally" works.  I still need to add:
> 	SNPRINTF_RETURNS_BOGUS=1 NO_MKDTEMP=1
> 
> > tech0 > CC=cc CXX=CC ./configure 
> > tech0 > gmake
> 
> And here, until I rid CFLAGS of -Wall, it fails.

I did a VM install of OpenServer 6 to try things out.  I was able to get 
your -Wall failure, but once I ran the CC=cc CXX=CC ./configure I was able 
to run gmake without any errors. I did have to install the M4 from above 
to get configure to work.  So, the straight out of the box install has to 
have gnu m4 to run configure. 
   
> > > Unfortunately, I have access to only that one SCO box, so I have no idea
> > > of mkdtemp and sprintf problems are on all SCO, or just R=5 ones.
> > > 
> > > That allows me to build with NO_POSIX_ONLY_PROGRAMS=1, because for some reason, the
> > > linker complains on linking git-shell:
> > > 	Undefined                       first referenced
> > > 	symbol                              in file
> > > 	hexval_table                        abspath.o
> > > 	null_sha1                           abspath.o
> > > 	trust_executable_bit                abspath.o
> > > 	has_symlinks                        abspath.o
> > > 	UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
> > > 
> > > These are all extern varualbes declared in cache.h, but no defined in
> > > any of the objects git-shell links, normally not a problem, but this is SCO.
> > 
> > I do not see the problem on my systems.
> 
> 	aidan@jpradley:~/git$ touch abspath.c
> 	aidan@jpradley:~/git$ gmake V=1 git-shell
> 	cc -o abspath.o -c -Kalloca  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM abspath.c
> 	cc -g -Kalloca  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -o git-shell   -L/usr/local/lib abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o compat/lib.a
> 	Undefined                       first referenced
> 	symbol                              in file
> 	hexval_table                        abspath.o
> 	null_sha1                           abspath.o
> 	trust_executable_bit                abspath.o
> 	has_symlinks                        abspath.o
> 	UX:ld: ERROR: Symbol referencing errors. No output written to git-shell
> 	gmake: *** [git-shell] Error 1
> 	aidan@jpradley:~/git$ cat config.mak
> 	NO_OENSSL=1
> 	NO_MKDTEMP=1
> 	SHELL=/bin/bash
> 	SNPRINTF_RETURNS_BOGUS=1
> 	CFLAGS=-Kalloca
> 	CPPFLAGS=-Kalloca
> 
> I've found that if I set CFLAGS to -O2, it links properly:
> 	aidan@jpradley:~/git$ touch abspath.c
> 	aidan@jpradley:~/git$ gmake V=1 git-shell
> 	cc -o abspath.o -c -Kalloca -O2  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM abspath.c
> 	cc -Kalloca -O2  -Kthread -I/usr/local/include -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>' -DSNPRINTF_RETURNS_BOGUS -DNO_STRCASESTR -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -o git-shell   -L/usr/local/lib abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o compat/lib.a
> 
> So I think it's "not inlining" stuff like:
> 	static inline unsigned int hexval(unsigned char c)
> 	{
> 		return hexval_table[c];
> 	}
>  
> So, finally, it pretty much works on SCO out of the box - here's my
> settings, which which the test suite passed (well, is passing, I'm at
> t5400, but I expect it to all pass again with these settings):
> 
> 	aidan@jpradley:~/git$ cat config.mak
> 	NO_TCLTK=1
> 	NO_MKDTEMP=1
> 	SHELL=/bin/bash
> 	SNPRINTF_RETURNS_BOGUS=1
> 	CFLAGS=-O2


-g and -O2 are mutually exclusive.  You can have either one but not both.

I do have tcl and tk

drwxr-xr-x   12 gerberb  zenez       2048 Jun 10 17:30 tcl8.5.2
drwxr-xr-x   12 gerberb  zenez       2048 Jun 10 17:30 tk8.5.2

So I am not sure what the best option should be.  There is a patch for 
UnixWare 7 MP4 that has to be installed to MP4 for so failures, but it 
works even with ksh with it.

Also on UnixWare 7.1.4 I could not get any m4 greater than 1.4.9 to 
compile and work.  I finally just used 

drwxr-xr-x    8 gerberb  zenez          2048 May 19 03:05 m4-1.4.9
drwxrwxrwx    9 gerberb  zenez          4096 Apr  3 00:11 make-3.81
drwxr-xr-x   12 gerberb  zenez          2048 Jun 10 16:43 tcl8.5.2
drwxr-xr-x   12 gerberb  zenez          2048 Jun 10 16:44 tk8.5.2
drwxr-xr-x    9 gerberb  zenez          4096 May 19 03:18 sed-4.1.4

On UnixWare 7.1.4 MP4 with ptf9055a.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
