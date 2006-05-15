From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1.3.2.gde1d fails to build on OpenBSD
Date: Mon, 15 May 2006 09:00:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605150854420.3866@g5.osdl.org>
References: <86psiftlgf.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 18:00:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FffUo-0003x0-57
	for gcvg-git@gmane.org; Mon, 15 May 2006 18:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWEOQAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEOQAa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 12:00:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750880AbWEOQAa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 12:00:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FG0RtH011096
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 09:00:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FG0M1i007294;
	Mon, 15 May 2006 09:00:25 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86psiftlgf.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20062>



On Mon, 15 May 2006, Randal L. Schwartz wrote:
> 
> GIT_VERSION = 1.3.2.gde1d
> gcc -o sha1_file.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR sha1_file.c
> sha1_file.c:16:20: stdint.h: No such file or directory
> gmake: *** [sha1_file.o] Error 1
> 
> I think you want
> 
>         #include <sys/types.h>
> 
> on OpenBSD.

Gaah. This was one reason why I absolutely _detested_ those "intXX_t" 
types historically. I thought the world had gotten over it, and they were 
all so common and standard that we'd never need to worry about it.

Randal: we already _do_ include <sys/types.h>, as part of the standard set 
of headers in git-compat-util.h.

So the problem is that that wasn't enough on OS X, which wanted 
<stdint.h>.

Junio: I'd suggest just using "unsigned int", or just defining your own 
types in "cache.h". I would suggest

	typedef unsigned char u8;
	typedef unsigned short u16;
	typedef unsigned int u32;

	typedef signed char s8;
	typedef short s16;
	typedef int s32;

which is the only sane way to avoid idiotic crap like autoconf, and which 
avoids that whole "standard namespace" issue.

Yeah, some people will complain. Ten years later, they _still_ complain 
about me doing this right in the kernel. But you can sleep well, knowing 
that the complainers are standards-weenies that have read books, but never 
seen the real world.

				Linus
