From: dev <dev@cor0.com>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Wed, 27 Aug 2014 15:48:40 -0400 (EDT)
Message-ID: <805178325.32077.1409168920760.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140827192848.GC7561@peff.net>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: peff@peff.net, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 27 21:48:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMjDA-0007gU-A4
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbaH0Tss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:48:48 -0400
Received: from atl4mhob07.myregisteredsite.com ([209.17.115.45]:57975 "EHLO
	atl4mhob07.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935594AbaH0Tsr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 15:48:47 -0400
X-Greylist: delayed 2020 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2014 15:48:47 EDT
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7RJmeJF032170;
	Wed, 27 Aug 2014 15:48:40 -0400
In-Reply-To: <20140827192848.GC7561@peff.net>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v-
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256034>

Good day gentlemen. With coffee in hand I am taking a crack and getting
git to compile out of the sources neatly and therefore I have hit a
few bumps.  Inline comments below :

On August 27, 2014 at 3:28 PM Jeff King <peff@peff.net> wrote:
> On Wed, Aug 27, 2014 at 03:15:05PM -0400, dev wrote:
>
> > This causes a problem on things like Solaris :
> >
> >  * new build flags
> >     CC credential-store.o
> > "git-compat-util.h", line 516: error: identifier redeclared:
> > inet_ntop
> >         current : function(int, pointer to const void, pointer to
> > char,
> > unsigned long) returning pointer to const char
> >         previous: function(int, pointer to const void, pointer to
> > char,
> > unsigned int) returning pointer to const char :
> > "/usr/include/arpa/inet.h", line 68
> > cc: acomp failed for credential-store.c
> > gmake: *** [credential-store.o] Error 2
>
> That declaration should only be used if you have NO_INET_NTOP defined
> by
> the Makefile.

wow.

OKay, in that case there seems to be another problem which, as you say,
would fix a few things in one shot. So we have inet_ntop() in the basic
socket function libs in Solaris for sure so we should not see
NO_INET_NTOP
defined.  But we are.  :-\

> That is not defined by default for Solaris. Have you
> specified it yourself, or are you using the autoconf script? If the
> latter, I suspect its test for inet_ntop needs to be fixed.

I am going to extract the tarball once again and start fresh.


$ mdigest -a sha256 $SRC/git-2.0.4.tar.gz
dd9df02b7dcc75f9777c4f802c6b8562180385ddde4e3b8479e079f99cd1d1c9
 /usr/local/src/git-2.0.4.tar.gz

$ gzip -dc $SRC/git-2.0.4.tar.gz | tar -xf -
$ mv git-2.0.4 git-2.0.4_SunOS5.10_sparcv9.002
$
$ cd git-2.0.4_SunOS5.10_sparcv9.002
$
$ echo $CFLAGS
-errfmt=error -erroff=%none -errshort=full -xstrconst -xildoff -m64
-xmemalign=8s -xnolibmil -Xa -xcode=pic32 -xregs=no%appl -xlibmieee -mc
-g -xs -ftrap=%none -Qy -xbuiltin=%none -xdebugformat=dwarf -xunroll=1
-xtarget=ultraT2 -xcache=8/16/4:4096/64/16
$
$ env | sort | grep LD
BUILD=/usr/local/build
LD=/usr/ccs/bin/sparcv9/ld
LD_LIBRARY_PATH=/usr/local/lib:/usr/local/ssl/lib
LD_OPTIONS=-64 -Qy
-R/usr/local/lib/$ISALIST:/usr/local/ssl/lib/$ISALIST:/usr/local/lib:/usr/local/ssl/lib
-L/usr/local/lib/$ISALIST:/usr/local/ssl/lib$ISALIST:/usr/local/lib:/usr/local/ssl/lib
LD_RUN_PATH=/usr/local/lib:/usr/local/ssl/lib
OLDPWD=/usr/local/build




I ran configure like so :


$ ./configure --enable-pthreads --with-openssl --with-libpcre
--with-curl --with-expat --with-iconv=/usr/local
--with-editor=/usr/xpg4/bin/vi --with-shell=/usr/local/bin/bash
--with-perl=/usr/local/bin/perl --with-zlib=/usr/local
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads
configure: CHECKS for site configuration
configure: Setting ICONVDIR to /usr/local
configure: Setting DEFAULT_EDITOR to /usr/xpg4/bin/vi
configure: Setting SHELL_PATH to /usr/local/bin/bash
configure: Setting PERL_PATH to /usr/local/bin/perl
configure: Setting ZLIB_PATH to /usr/local
configure: CHECKS for programs
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... no
checking whether /opt/solarisstudio12.3/bin/cc accepts -g... yes
checking for /opt/solarisstudio12.3/bin/cc option to accept ISO C89...
none needed
checking for inline... inline
checking if linker supports -R... yes
checking for gtar... no
checking for tar... tar
checking for gnudiff... no
checking for gdiff... gdiff
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for pcre_version in -lpcre... yes
checking for curl_global_init in -lcurl... yes
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -liconv... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... no
checking for inet_ntop... no
checking for inet_ntop in -lresolv... no
checking for inet_pton... no
checking for inet_pton in -lresolv... no
checking for hstrerror... no
checking for hstrerror in -lresolv... yes
checking for basename in -lc... yes
checking for gettext in -lc... yes
checking how to run the C preprocessor... /opt/solarisstudio12.3/bin/cc
-E
checking for grep that handles long lines and -e... /usr/xpg4/bin/grep
checking for egrep... /usr/xpg4/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking libintl.h usability... yes
checking libintl.h presence... yes
checking for libintl.h... yes
configure: CHECKS for header files
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking sys/poll.h usability... yes
checking sys/poll.h presence... yes
checking for sys/poll.h... yes
checking for inttypes.h... (cached) yes
checking for old iconv()... yes
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... no
checking for struct passwd.pw_gecos... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking whether the platform regex can handle null bytes... no
checking whether system succeeds to read fopen'ed directory... no
checking whether snprintf() and/or vsnprintf() return bogus value... no
configure: CHECKS for library functions
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking paths.h usability... no
checking paths.h presence... no
checking for paths.h... no
checking libcharset.h usability... yes
checking libcharset.h presence... yes
checking for libcharset.h... yes
checking for strings.h... (cached) yes
checking for locale_charset in -liconv... yes
checking for strcasestr... no
checking for memmem... no
checking for strlcpy... yes
checking for library containing strlcpy... none required
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for mkstemps... no
checking for initgroups... yes
checking for library containing initgroups... none required
checking for POSIX Threads with ''... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
config.status: executing config.mak.autogen commands
$

Then I see in some Makefile's :

$ find . -type f -name Makefile | xargs grep "^CFLAGS" | cut -f2 -d\:
CFLAGS = -g -O2 -Wall
CFLAGS = -g -O2 -Wall
CFLAGS = -g -O2 -Wall
CFLAGS = -g -O2 -Wall
CFLAGS = -O2 -Wall
$


So CFLAGS is ignored entirely.


Also in the Makefile at the top level I see :


ifdef NO_INET_NTOP
        LIB_OBJS += compat/inet_ntop.o
        BASIC_CFLAGS += -DNO_INET_NTOP
endif
ifdef NO_INET_PTON
        LIB_OBJS += compat/inet_pton.o
        BASIC_CFLAGS += -DNO_INET_PTON
endif


No reason for either of those to be defined, but I bet that you are
right
and they are ... and should not be.

> > Also the Makefile's generated are all borked full of GCCism "CFLAGS
> > = -g
> > -O2 -Wall"  which means very little on some OS wherein the gcc
> > compiler
> > is not the default.
>
> Yes, this is a potential portability problem we've discussed before,
> but
> literally nobody has ever complained.

* wave *

> I suspect it's a combination of
> many compilers accepting those arguments (e.g., clang is fine with it)
> and people on exotic compilers accepting that "make CFLAGS=" is a
> reasonable starting point (you can also put "CFLAGS = " into your
> config.mak if you do not want to remember to include it on each make
> invocation).

A config.mak file eh ?

I must look for that.

> > is Solaris and am using ORacle Studio 12.3 compilers and therefore
> > the
> > CFLAGS in the Makefiles are just silly.  Lastly, the linkage to
> > libintl
> > should look in /usr/local/lib if the LD_LIBRARY_PATH and other env
> > vars
> > are setup correctly. However the Makefile's seem to miss this fact
> > and
> > -lintl needs to be manually hacked into place.
>
> I do not usually see Makefiles peeking at LD_LIBRARY_PATH, which is
> for
> runtime resolution. Do you need to set LDFLAGS in your environment (or
> in config.mak)?


Yep, you're right of course. You can see I have no LDFLAGS defined.
Guess
I need that.

Anyways, thanks for the input. I would love to see this "just build" and
with a few more emails and some tinkering it should right?

dev
