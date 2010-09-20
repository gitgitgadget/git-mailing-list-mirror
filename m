From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 18:53:38 -0400
Message-ID: <5FA82BA4-AE76-44F5-9635-36E199E97B00@kellerfarm.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil> <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com> <CWxE18Hq1ro8utv-_dFm1ZaVIKpCDTv-TbEB4u_l84GvbeJh1vKing@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 21 00:54:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxpFH-0002fp-VD
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 00:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0ITWxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 18:53:43 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:54070 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753184Ab0ITWxm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 18:53:42 -0400
Received: from public-70-200.emich.edu ([164.76.70.200])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OxpEp-0002By-R8; Mon, 20 Sep 2010 18:53:31 -0400
In-Reply-To: <CWxE18Hq1ro8utv-_dFm1ZaVIKpCDTv-TbEB4u_l84GvbeJh1vKing@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156674>

On Sep 20, 2010, at 3:12 PM, Brandon Casey wrote:
> On 09/20/2010 11:56 AM, Andrew Keller wrote:
> 
>> This is what it took to compile Git on this server without root privileges (Solaris 8 / Sparc):
> 
> I thought it was Solaris 9? :)

Ah, you're right; I didn't catch that.  The documentation for the server says Solaris 8, but uname -a says "SunOS hpl 5.9 Generic_122300-54 sun4u sparc SUNW,UltraAX-i2".  I'd trust uname, so that makes this Solaris 9.

>> # compile and install git
>> $ ln -s /usr/local/bin/tclsh8.4 /usr/users/students/ak4390/.local/bin/tclsh
> 
> You can set TCL_PATH instead of creating this symbolic link.
> 
>> $ export CC=/usr/local/bin/gcc
>> $ cd <path-to-git-src>
>> $ ./configure --prefix=/usr/users/students/ak4390/.local --with-python=/usr/local/bin/python --enable-pthreads=no
>> $ make NO_PERL_MAKEMAKER=1 all install
>> 
>> Letting the configure figure out the threading did not seem to work.
>> The compile and install worked, with lots of warnings from gcc about not
>> recognizing -pthreads, but when you try to do a clone, git complained about
>> not being able to fork off the demultiplexer.  So I just turned off threading
>> and it works.
> 
> Maybe the configure script is broken with respect to detecting threads on
> Solaris 8 (or 9)?  You probably don't really need to run the configure
> script on your platform.  I don't.  Since you're using gcc to compile, the
> default pthread switch '-lpthread' should be appropriate.  You could try
> deleting the config.mak.autogen file that configure creates, and just run
> make by itself.  Based on what you've describe, it would look something
> like this:
> 
>   cd <path-to-git-src>
>   rm config.mak.autogen
>   cat >config.mak <<EOF
> CC=/usr/local/bin/gcc
> PREFIX=/usr/users/students/ak4390/.local
> PYTHON_PATH=/usr/local/bin/python
> TCL_PATH=/usr/local/bin/tclsh8.4
> NO_PERL_MAKEMAKER=1
> EOF
>   make
> 
> Then add 'install' to the make command line when you are ready.
> 
> Notice, I placed all of the make settings in a file named config.mak.  This
> file is imported by the main Makefile automatically and is intended to be
> used like this for user settings.  If you really need to disable pthreads,
> then you can add NO_PTHREADS=1.  Check out the comments at the top of the
> Makefile for a list of all variables that can be set.

Compiling as described above appears to go down in flames:

$ make
/bin/sh: curl-config: not found
    CC fast-import.o
In file included from builtin.h:4,
                 from fast-import.c:147:
git-compat-util.h:140:25: openssl/ssl.h: No such file or directory
git-compat-util.h:141:25: openssl/err.h: No such file or directory
In file included from builtin.h:6,
                 from fast-import.c:147:
cache.h:9:21: openssl/sha.h: No such file or directory
In file included from fast-import.c:156:
csum-file.h:10: error: syntax error before "SHA_CTX"
csum-file.h:10: warning: no semicolon at end of struct or union
csum-file.h:15: error: 'crc32' redeclared as different kind of symbol
/usr/local/include/zlib.h:1285: error: previous declaration of 'crc32' was here
csum-file.h:15: error: 'crc32' redeclared as different kind of symbol
/usr/local/include/zlib.h:1285: error: previous declaration of 'crc32' was here
csum-file.h:17: error: syntax error before '}' token
fast-import.c: In function `store_object':
fast-import.c:995: error: `SHA_CTX' undeclared (first use in this function)
fast-import.c:995: error: (Each undeclared identifier is reported only once
fast-import.c:995: error: for each function it appears in.)
fast-import.c:995: error: syntax error before "c"
fast-import.c:1000: warning: implicit declaration of function `SHA1_Init'
fast-import.c:1000: error: `c' undeclared (first use in this function)
fast-import.c:1001: warning: implicit declaration of function `SHA1_Update'
fast-import.c:1003: warning: implicit declaration of function `SHA1_Final'
fast-import.c: At top level:
fast-import.c:1118: error: syntax error before "SHA_CTX"
fast-import.c: In function `truncate_pack':
fast-import.c:1120: error: `to' undeclared (first use in this function)
fast-import.c:1126: error: dereferencing pointer to incomplete type
fast-import.c:1127: error: dereferencing pointer to incomplete type
fast-import.c:1128: error: dereferencing pointer to incomplete type
fast-import.c:1128: error: `ctx' undeclared (first use in this function)
fast-import.c: In function `stream_blob':
fast-import.c:1140: error: `SHA_CTX' undeclared (first use in this function)
fast-import.c:1140: error: syntax error before "c"
fast-import.c:1154: error: `pack_file_ctx' undeclared (first use in this function)
fast-import.c:1154: error: dereferencing pointer to incomplete type
fast-import.c:1160: error: `c' undeclared (first use in this function)
make: *** [fast-import.o] Error 1

And, this is the same source tree that just worked a minute ago, when I used configure/make/make install.  I then copied the entire source folder, with the modified config.mak file, to my laptop running Snow Leopard, modified the variables in the config.mak file to match the system, and it compiled and installed just fine.  So, this server seems to have a problem with not running the configure script first.

~ Andrew Keller
