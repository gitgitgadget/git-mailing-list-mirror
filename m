From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 10:35:32 -0400
Message-ID: <19434.48308.815673.263230@winooski.ccs.neu.edu>
References: <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
	<20100508044434.GC14998@coredump.intra.peff.net>
	<19428.62170.654092.308682@winooski.ccs.neu.edu>
	<20100508053025.GG14998@coredump.intra.peff.net>
	<7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	<19429.3589.823244.270582@winooski.ccs.neu.edu>
	<20100512113855.GB23847@coredump.intra.peff.net>
	<19434.39095.448649.313537@winooski.ccs.neu.edu>
	<20100512124948.GA11761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 12 16:35:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCD2I-00037g-3i
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 16:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab0ELOfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 10:35:41 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:37794 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300Ab0ELOfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 10:35:40 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OCD24-0008Mv-Qi; Wed, 12 May 2010 10:35:32 -0400
In-Reply-To: <20100512124948.GA11761@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146950>

On May 12, Jeff King wrote:
> On Wed, May 12, 2010 at 08:01:59AM -0400, Eli Barzilay wrote:
> 
> > > I have no opinion on moving --follow around, but I definitely agree that
> > > more clearly marking the diff-options (and including them after
> > > revision traversal options) is much better.
> > 
> > Should I send that reorganization as a proper patch then?
> 
> Yes, please.

Done.


> > > This ":git-log: 1" magic should probably follow the include. It sets up
> > > an attribute for diff-options.txt to conditionally include some
> > > log-specific bits.
> > 
> > It seemed like it's a definition that could be used elsewhere too (eg,
> > in other includes that could be added in the future).
> 
> Yeah, I considered that, too. So maybe it is best at the top of the
> options list (but in that case, perhaps it should go at the very top
> of the file).

Since I don't know, I just dragged it along with the include.  (Moving
it to the top would be better better done with the other files, so
it's a different thing...)


> Anyway, here is the patch. My testing so far has been very simple,
> so please try it on a few repos and let me know if it does what you
> expect in all cases. Note that is based on "next", as it has Bo's
> find_copies_harder patch.

I tried it with our repository -- it does what I expected it to do wrt
showing the log messages, and at a very small penalty (~0.9s vs ~0.7s
for scanning a history of about 20k commits).

But with `-p' it was doing something confusing: I used two files that
were recently renamed, and the result was the correct log history, but
the first patch that was shown (the rename) showed the two files as
added.  (That's even when I added `-C' and `-M'.)  This happens even
with a single path.  OTOH, using `--follow' with `-p' and a single
path without your patch produces the expected result where the first
patch is a rename (even without `-C'/`-M').

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
