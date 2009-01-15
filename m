From: Julius Naperkowski <j.nap@gmx.de>
Subject: autoconf: C99 format check
Date: Thu, 15 Jan 2009 13:22:54 +0000 (UTC)
Message-ID: <loom.20090115T123123-915@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 14:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSF2-0006Ju-AE
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591AbZAONZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756504AbZAONZG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:25:06 -0500
Received: from main.gmane.org ([80.91.229.2]:52773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756457AbZAONZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:25:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LNSDW-0007hl-Av
	for git@vger.kernel.org; Thu, 15 Jan 2009 13:25:02 +0000
Received: from fokus6204.fokus.fraunhofer.de ([195.37.76.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 13:25:02 +0000
Received: from j.nap by fokus6204.fokus.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 13:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.37.76.204 (Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105797>

I am trying to cross-compile git for mips on a x86 host. But it seems that it is
impossible to pass the C99 Format check in the configure script when
cross_compile mode is activated because the script quits even before it starts
the testprogramm. Is this behavior intentional?

configure: CHECKS for programs
checking for mips-linux-cc... ccache mips-linux-uclibc-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether ccache mips-linux-uclibc-gcc accepts -g... yes
checking for ccache mips-linux-uclibc-gcc option to accept ISO C89... none needed
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... yes
checking for mips-linux-gar... mips-linux-uclibc-ar
checking for gtar... /bin/tar
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... no
checking for SHA1_Init in -lssl... no
checking for curl_global_init in -lcurl... no
checking for XML_ParserCreate in -lexpat... no
checking for iconv in -lc... no
checking for iconv in -liconv... no
checking for deflateBound in -lz... no
checking for socket in -lc... yes
configure: CHECKS for header files
checking how to run the C preprocessor... ccache mips-linux-uclibc-gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
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
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking for old iconv()... yes
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... (cached) yes
checking for library containing getaddrinfo... none required
checking whether formatted IO functions support C99 size specifiers...
configure: error: cannot run test program while cross compiling
See `config.log' for more details.


A snippet of the configure script:

...
4928: # Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
4929: # do not support the 'size specifiers' introduced by C99, namely ll, hh,
4930: # j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
4931: # some C compilers supported these specifiers prior to C99 as an extension.
4932: { echo "$as_me:$LINENO: checking whether formatted IO functions support
C99 size specifiers" >&5
4933: echo $ECHO_N "checking whether formatted IO functions support C99 size
specifiers... $ECHO_C" >&6; }
4934: if test "${ac_cv_c_c99_format+set}" = set; then
4935:   echo $ECHO_N "(cached) $ECHO_C" >&6
4936: else
4937:   # Actually git uses only %z (%zu) in alloc.c, and %t (%td) in mktag.c
4938: if test "$cross_compiling" = yes; then
4939:   { { echo "$as_me:$LINENO: error: cannot run test program while cross
compiling
4940: See \`config.log' for more details." >&5
4941: echo "$as_me: error: cannot run test program while cross compiling
4942: See \`config.log' for more details." >&2;}
4943:    { (exit 1); exit 1; }; }
4944: else
4945:   cat >conftest.$ac_ext <<_ACEOF
4946: /* confdefs.h.  */
4947: _ACEOF
4948: cat confdefs.h >>conftest.$ac_ext
4949: cat >>conftest.$ac_ext <<_ACEOF
...


--
Julius
