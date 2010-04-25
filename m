From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 07/15] host-IRIX.patch
Date: Sun, 25 Apr 2010 03:39:25 -0500 (CDT)
Message-ID: <20100317061353.GC27121@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054331.991677000@mlists.thewrittenword.com>
 <VUV1ChwKH_zLPsIikaNeBZfWtyUI9YmyOzkiMdEjHJ0PuUAnPbDsEw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:39:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xNE-0007A8-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab0DYIj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:39:27 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:53044 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:39:26 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id DDF8B5CC0
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 09:00:27 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com DDF8B5CC0
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 92D919A4
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:39:25 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 5259157C; Sun, 25 Apr 2010 03:39:25 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <VUV1ChwKH_zLPsIikaNeBZfWtyUI9YmyOzkiMdEjHJ0PuUAnPbDsEw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145729>

[It seems that while the list allows me to start a new thread, all my
replies are actually discarded or held for moderation :( Please
forward a copy to the list on my behalf]

On Tue, Mar 16, 2010 at 10:27:07AM -0500, Brandon Casey wrote:
> On 03/16/2010 12:42 AM, Gary V. Vaughan wrote:
> > 
> > Irix 6.5 does not define 'sgi', but does define '__sgi'.
> > 
> > Also, Irix 6.5 requires _BSD_TYPES to be defined in order for the BSD
> > u_short types et. al. to be declared properly.
> 
> Which IRIX release (uname -R) and compiler version are you using?
> 
> I have IRIX 6.5.29m and MIPSpro Compiler 7.4.4m.

IRIX 6.5.26m here, with the same compiler.

> Both 'sgi' and '__sgi' appear to be predefined by the preprocessor
> on my system.  I wasn't aware of '__sgi' when I added 'sgi', otherwise
> I would have used it.

I was quite surprised too, but __sgi is necessary here.

> On my system, defining _SGI_SOURCE causes _SGIAPI to be enabled which
> causes all of the BSD types to be enabled.  In my header files in
> /usr/include/ everywhere I see a test for _BSD_TYPES, I also see a
> test for _SGIAPI (or something equivalent) like this:
> 
>    #if _SGIAPI || defined(_BSD_TYPES)
> 
> So defining _BSD_TYPES will probably not affect compiling on IRIX for
> me (though I haven't tested your patches yet), but do your header
> files not do the same thing with _SGI_SOURCE, _SGIAPI, and _BSD_TYPES?

They do, but when I was looking for a macro to define to get the
additional declarations, _BSD_TYPES was the first one I found.
_SGI_SOURCE, _SGIAPI and even _BSD_COMPAT appear to work equally well.

> Which shell are you using? Bash? or the native Korn shell?  If you're
> trying to use the Korn shell, then you'll need a patch to t/test-lib.sh
> in order for the test suite to work properly.  I can send it to you if
> you'd like.

I believe we're using bash.  At least our environment has
SHELL=/opt/fsw/bash32/bin/bash and we call configure with '${SHELL}
./configure ...' and gmake with 'make SHELL=${SHELL}'.  But I suppose
it's possible that if t/Makefile ignores those settings and the tests
begin with '#!/bin/sh', then perhaps they are using Korn shell?

Thanks, yes, I'll be interested to see your patch... but shouldn't we
try to fix git in the repo so that it respects the SHELL environment
and make setting?

> I compile and test with the following config.mak settings:
> 
> GIT_SKIP_TESTS := \
>    t3900.1[129] t3900.2[0234] \
>    t5100.5 t5100.1[09] \
>    t8005.[234]
> export GIT_SKIP_TESTS
> 
> # perl 5.8.0
> # python 2.1
> # GNU tar 1.2
> PERL_PATH = /apps/bin/perl
> PYTHON_PATH = /apps/bin/python
> TAR = /sw/local/bin/gtar
> 
> CC = c99
> CFLAGS = -n32 -O2
> 
> NO_C99_FORMAT = 1
> NO_CURL = 1
> NO_TCLTK = 1
> NO_MMAP =
> NO_OPENSSL = 1
> BLK_SHA1 = 1
> DEFAULT_PAGER = more
> 
> # For IRIX <= 6.5.20 compatibility (uname -R)
> # i.e. the next two are not necessary for IRIX > 6.5.20
> NO_STRLCPY = 1
> NO_DEFLATE_BOUND = 1

And similarly, shouldn't these settings be fed back upstream for the
benefit of other IRIX users of git?

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
