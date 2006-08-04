From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Fri, 04 Aug 2006 22:27:25 +0200
Organization: At home
Message-ID: <eb0ai4$h7k$2@sea.gmane.org>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net> <eb0554$1pu$1@sea.gmane.org> <7vejvwjp2l.fsf@assigned-by-dhcp.cox.net> <7vy7u4i8lm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 04 22:27:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G96GB-0000ye-TA
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 22:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWHDU1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWHDU1D
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 16:27:03 -0400
Received: from main.gmane.org ([80.91.229.2]:20449 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932623AbWHDU1C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 16:27:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G96G3-0000wg-4w
	for git@vger.kernel.org; Fri, 04 Aug 2006 22:26:59 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:26:59 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:26:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24835>

Junio C Hamano wrote:

> (3) NEEDS_LIBICONV is found to be unnecessary by configure, but
>     the link fails like this without it:
> 
>         builtin-mailinfo.o: In function `convert_to_utf8':
>         /git/builtin-mailinfo.c:539: undefined reference to `_libiconv_open'
>         /git/builtin-mailinfo.c:560: undefined reference to `_libiconv'
>         /git/builtin-mailinfo.c:561: undefined reference to `_libiconv_close'
>         collect2: ld returned 1 exit status

Does the following patch help?

+++
autoconf: Set NEEDS_LIBICONV unconditionally if there is no iconv in libc

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5926f3c..61c9fa3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,8 +172,7 @@ AC_CHECK_LIB([expat], [XML_ParserCreate]
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 AC_CHECK_LIB([c], [iconv],[],
-[AC_CHECK_LIB([iconv],[iconv],
- [GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)],[])])
+[GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)])
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-- 
1.4.1.1
