From: Andy Polyakov <appro@fy.chalmers.se>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Tue, 18 Aug 2009 23:26:15 +0200
Message-ID: <4A8B1C77.5080003@fy.chalmers.se>
References: <20090803034741.23415.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWLL-0000lq-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbZHRVfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZHRVfa
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:35:30 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:62722 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZHRVf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:35:29 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2009 17:35:29 EDT
Received: from fyserv1.fy.chalmers.se (fyserv1.fy.chalmers.se [129.16.110.66])
	by atum.ita.chalmers.se (Postfix) with ESMTP id 3C4C6828A;
	Tue, 18 Aug 2009 23:26:15 +0200 (CEST)
Received: from [127.0.0.1] (stty [129.16.50.165])
	by fyserv1.fy.chalmers.se (8.8.8/8.8.8) with ESMTP id XAA07976;
	Tue, 18 Aug 2009 23:24:45 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <20090803034741.23415.qmail@science.horizon.com>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126461>

George Spelvin wrote:
> (Work in progress, state dump to mailing list archives.)
> 
> This started when discussing git startup overhead due to the dynamic
> linker.  One big contributor is the openssl library, which is used only
> for its optimized x86 SHA-1 implementation.  So I took a look at it,
> with an eye to importing the code directly into the git source tree,
> and decided that I felt like trying to do better.
> 
> The original code was excellent, but it was optimized when the P4 was new.

Even though last revision took place when "the P4 was new" and even
triggered by its appearance, *all-round* performance was and will always
be the prime goal. This means that improvements on some particular
micro-architecture is always weighed against losses on others [and
compromise is considered of so required]. Please note that I'm *not*
trying to diminish George's effort by saying that proposed code is
inappropriate, on the contrary I'm nothing but grateful! Thanks, George!
I'm only saying that it will be given thorough consideration. Well, I've
actually given the consideration and outcome is already committed:-) See
http://cvs.openssl.org/chngview?cn=18513. I don't deliver +17%, only
+12%, but at the cost of Intel Atom-specific optimizations. I used this
opportunity to optimize even for Intel Atom core, something I was
planning to do at some point anyway...

>   http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
> - "tar xz cryptogams-0.tar.gz"

If there is interest I can pack new tar ball with updated modules.

> An open question is how to add appropriate CPU detection to the git
> build scripts. (Note that `uname -m`, which it currently uses to select
> the ARM code, does NOT produce the right answer if you're using a 32-bit
> compiler on a 64-bit platform.)

It's not only that. As next subscriber noted problem on MacOS X, it
[MacOS X] uses slightly different assembler convention and ELF modules
can't be compiled on MacOS X. OpenSSL perlasm takes care of several
assembler flavors and executable formats, including MacOS X. I'm talking
about

> +++ Makefile	2009-08-02 06:44:44.000000000 -0400
> +%.s : %.pl x86asm.pl x86unix.pl
> +	perl $< elf > $@
                ^^^ this argument.

Cheers. A.
