From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [patch 07/15] host-IRIX.patch
Date: Tue, 16 Mar 2010 10:27:07 -0500
Message-ID: <VUV1ChwKH_zLPsIikaNeBZfWtyUI9YmyOzkiMdEjHJ0PuUAnPbDsEw@cipher.nrlssc.navy.mil>
References: <20100316054220.075676000@mlists.thewrittenword.com> <20100316054331.991677000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 16:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrYfu-0006fb-96
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 16:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966442Ab0CPP1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 11:27:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53963 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966335Ab0CPP1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 11:27:11 -0400
Received: by mail.nrlssc.navy.mil id o2GFR7N0018083; Tue, 16 Mar 2010 10:27:07 -0500
In-Reply-To: <20100316054331.991677000@mlists.thewrittenword.com>
X-OriginalArrivalTime: 16 Mar 2010 15:27:07.0349 (UTC) FILETIME=[237B5850:01CAC51D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142338>

On 03/16/2010 12:42 AM, Gary V. Vaughan wrote:
> 
> Irix 6.5 does not define 'sgi', but does define '__sgi'.
> 
> Also, Irix 6.5 requires _BSD_TYPES to be defined in order for the BSD
> u_short types et. al. to be declared properly.

Which IRIX release (uname -R) and compiler version are you using?

I have IRIX 6.5.29m and MIPSpro Compiler 7.4.4m.

Both 'sgi' and '__sgi' appear to be predefined by the preprocessor
on my system.  I wasn't aware of '__sgi' when I added 'sgi', otherwise
I would have used it.

On my system, defining _SGI_SOURCE causes _SGIAPI to be enabled which
causes all of the BSD types to be enabled.  In my header files in
/usr/include/ everywhere I see a test for _BSD_TYPES, I also see a
test for _SGIAPI (or something equivalent) like this:

   #if _SGIAPI || defined(_BSD_TYPES)

So defining _BSD_TYPES will probably not affect compiling on IRIX for
me (though I haven't tested your patches yet), but do your header
files not do the same thing with _SGI_SOURCE, _SGIAPI, and _BSD_TYPES?

Which shell are you using? Bash? or the native Korn shell?  If you're
trying to use the Korn shell, then you'll need a patch to t/test-lib.sh
in order for the test suite to work properly.  I can send it to you if
you'd like.

I compile and test with the following config.mak settings:

GIT_SKIP_TESTS := \
   t3900.1[129] t3900.2[0234] \
   t5100.5 t5100.1[09] \
   t8005.[234]
export GIT_SKIP_TESTS

# perl 5.8.0
# python 2.1
# GNU tar 1.2
PERL_PATH = /apps/bin/perl
PYTHON_PATH = /apps/bin/python
TAR = /sw/local/bin/gtar

CC = c99
CFLAGS = -n32 -O2

NO_C99_FORMAT = 1
NO_CURL = 1
NO_TCLTK = 1
NO_MMAP =
NO_OPENSSL = 1
BLK_SHA1 = 1
DEFAULT_PAGER = more

# For IRIX <= 6.5.20 compatibility (uname -R)
# i.e. the next two are not necessary for IRIX > 6.5.20
NO_STRLCPY = 1
NO_DEFLATE_BOUND = 1

-brandon
