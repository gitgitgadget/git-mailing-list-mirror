From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 08:01:59 -0400
Message-ID: <19434.39095.448649.313537@winooski.ccs.neu.edu>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
	<20100508044434.GC14998@coredump.intra.peff.net>
	<19428.62170.654092.308682@winooski.ccs.neu.edu>
	<20100508053025.GG14998@coredump.intra.peff.net>
	<7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	<19429.3589.823244.270582@winooski.ccs.neu.edu>
	<20100512113855.GB23847@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 12 14:02:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCAdj-0007Na-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 14:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab0ELMCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 08:02:10 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:42596 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755576Ab0ELMCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 08:02:08 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OCAdT-0003cL-LJ; Wed, 12 May 2010 08:01:59 -0400
In-Reply-To: <20100512113855.GB23847@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146942>

On May 12, Jeff King wrote:
> On Sat, May 08, 2010 at 03:08:53AM -0400, Eli Barzilay wrote:
> 
> > So I think that it would really help if (1) the diff options in the
> > git-log man page move to after its own options, and (2) they appeared
> > after a title saying that these are the diff options, (3) `--follow'
> > moves up before the few preceding options that seem to me less
> > important.  To clarify, I added a simple patch to the end of this
> > message.  (`git-format-patch' has the same thing, but there it looks
> > more sensible to leave it as is.)
> 
> I have no opinion on moving --follow around, but I definitely agree that
> more clearly marking the diff-options (and including them after
> revision traversal options) is much better.

Should I send that reorganization as a proper patch then?


> > diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> > index fb184ba..6bc7064 100644
> > --- a/Documentation/git-log.txt
> > +++ b/Documentation/git-log.txt
> > @@ -24,7 +24,6 @@ OPTIONS
> >  -------
> >  
> >  :git-log: 1
> > -include::diff-options.txt[]
> 
> This ":git-log: 1" magic should probably follow the include. It sets up
> an attribute for diff-options.txt to conditionally include some
> log-specific bits.

It seemed like it's a definition that could be used elsewhere too (eg,
in other includes that could be added in the future).


> > How about these options:
> > 
> >   git config log.follow if-single-file
> >     makes it use --follow only when there's a single file path given,
> >     ignoring it otherwise (with no confusion about it now)
> > 
> >   git config log.follow if-possible
> >     makes it do the same, but might also do it for more cases if/when
> >     they become available (so this is the "do the best you can"
> >     option)
> > 
> >   git config log.follow true
> >     invalid until it is always possible to use --follow
> 
> I'm not thrilled with it. It still leaves the confusing behavior,
> but because we forced the user to pick the confusing behavior, we
> get to claim it is their fault. So while we may be guilt-free, I'm
> not happy with an option that produces such confusing behavior.

Well, yes -- it leaves that potential source of confusion, which could
result if someone recommends to just use the `if-single-file' thing,
and I do that while being unaware of what it actually does.  But OTOH,
it helps with the apparently popular confusion that makes people panic
and send "WHERE DID MY HISTORY GO???" emails.  (It's been about 2-3
weeks since we migrated from svn to git, and I had at least three
people do exactly that.)


> I really wonder if it would be that hard to just fix the code to follow
> several files. [...]

That would obviously be a better solution...

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
