From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Sat, 8 May 2010 01:12:58 -0400
Message-ID: <19428.62170.654092.308682@winooski.ccs.neu.edu>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
	<20100508044434.GC14998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 08 07:17:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcPa-0002w3-3o
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab0EHFNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:13:06 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:44061 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab0EHFNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:13:04 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OAcLS-0001IB-La; Sat, 08 May 2010 01:12:58 -0400
In-Reply-To: <20100508044434.GC14998@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146638>

On May  8, Jeff King wrote:
> On Fri, May 07, 2010 at 02:37:09PM -0400, Eli Barzilay wrote:
> 
> > BTW, I've had at least 4 people now who got confused by this.  Is
> > there any use for -M/-C without --follow?  In any case, it will be
> > very helpful if the -M/-C descriptions said "see also --follow".
> 
> Yes, it detects renames when doing diffs.

OK, so just to clear this up: -C and -M (and --find-copies-harder) are
for `diff', and --follow is for `log' with a single file (and each
will pass it on to the other)?


> Documentation patch is below.

Thanks!  (It would also be nice to mention it in -C, but not critical
since it's right after -M.)


> > Also, is there a way to set this as the default for `git log'?
> 
> If you mean --follow, then no. Nor would you probably want to,
> because the --follow mechanism (as currently implemented) is pretty
> restricted.  It can only take a single path currently.

Well, the "algorithm" I used was probably one that is very popular:

* use `git log some-file' with something that got renamed recently
* be horrified that all history is gone
* remember something vague about git detecting renames => go look at
  the man page
* Find -M, add it, try it, still doesn't work
* Go back to scanning the man page, repeat
* At the end I end up with:
    -C -M --find-copies-harder --follow

So if there was some single

  --do-whatever-you-can-as-much-as-you-can-to-find-all-renames

option that would just turn everything on for all commands (eg, -M and
-C and --find-copies harder for diffs, --follow for log for a single
file, and in some future when it's implemented, --follow for multiple
files and directories), I'd happily jump on that.  For any command
that can accept it.  If there was a way to make it the default, I'd
love to turn it on.

Even with the chain of more flags with descriptions that sound like
they're trying to scare me away by promising that my machine will work
for a REALLY LONG TIME, I'd still want to turn it on -- if it got
something slower I sure didn't notice it so far, and that's on a real
repository which is not that small (but with git's reputation I won't
be surprised if "slower" means that I had to way a whole extra 20ms
for an answer...).  If something would really take too long, as in me
sitting any waiting for an answer, *then* I can try to remove that and
see if I ran into some of the horrible edge cases...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
