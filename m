From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 02/15] const-expr.patch
Date: Tue, 16 Mar 2010 08:23:21 +0000
Message-ID: <20100316082321.GA26540@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054306.167331000@mlists.thewrittenword.com>
 <4B9F33DC.3030309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Apr 25 08:57:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5vmp-0004Zl-7k
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 08:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab0DYG5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 02:57:44 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64075 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab0DYG5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 02:57:43 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Apr 2010 02:57:43 EDT
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id C6EE15CE8
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 07:11:28 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com C6EE15CE8
Authentication-Results: mail1.thewrittenword.com; dkim=hardfail (SSP) header.i=unknown
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 96442A48
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 06:50:26 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 2F819158F; Sun, 25 Apr 2010 01:50:26 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <4B9F33DC.3030309@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145718>

On Tue, Mar 16, 2010 at 08:31:40AM +0100, Johannes Sixt wrote:
> Gary V. Vaughan schrieb:
> > Unfortunately, there are still plenty of production systems with
> > vendor compilers that choke unless all compound declarations can be
> > determined statically at compile time, for example hpux10.20 (I can
> > provide a comprehensive list of our supported platforms that exhibit
> > this problem if necessary).
> 
> Yes, a comprehensive list would be appreciated. This change is an
> uglification that I personally would prefer to stay out of the code base
> unless many consumers of git are hurt.

Portable code is rarely pretty... just take a look at the output of
autoconf or automake.

Of the various architectures we support, the latest vendor compilers
for IRIX 6.5 and older, and for HP-UX 10.20 and older do not compile
dynamic compound declarations, throwing errors such as:

cc-1028 cc: ERROR File = const-expr.c, Line = 6
  The expression used must have a constant value.

      const char *array[2] = { str, NULL };
                               ^

1 error detected in the compilation of "const-expr.c".

> The problem with this non-feature is that it is all too easy that new code
> introduces new incompatibilities.

Do you mean that new code may prevent the code from compiling on those
machines again?  Well, that's kinda the same problem you have when you
wish to support any architecture that you don't have access to... the
beauty of free software is that if it bites any significant number of
people you will get bug reports, and probably patches for as long as
people want to use the software on those machines.

> > Index: b/ll-merge.c
> > ===================================================================
> > --- a/ll-merge.c
> > +++ b/ll-merge.c
> 
> BTW, did you notice that git is a version control system that hosts itself? ;)

I did... but we use the SCM neutral quilt package to manage our local
stack of per-package patches.  I'm not particularly fluent with git
yet, and it took only a couple of minutes to get quilt to submit a
message threaded set of patch emails to the list in a git-like format.

Does git absolutely require that you clone the entire project history
to your local disk?  For the thousands of ports we maintain, that
would fast become a giant chunk of disk!

> > +	dict[0].placeholder = "O"; dict[0].value = temp[0];
> > +	dict[1].placeholder = "A"; dict[1].value = temp[1];
> > +	dict[2].placeholder = "B"; dict[2].value = temp[2];
> > +	dict[3].placeholder = "L"; dict[3].value = temp[3];
> > +	dict[3].placeholder = NULL; dict[3].value = NULL;
> 
> 	dict[4]...

Oops.  Nice catch, thanks.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
