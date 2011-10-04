From: Jeff King <peff@peff.net>
Subject: Re: Do we have a convenient way to refer to a specific commit in an
 already filtered rev-list?
Date: Tue, 4 Oct 2011 03:05:29 -0400
Message-ID: <20111004070529.GA6916@sigill.intra.peff.net>
References: <CAEvN+1jPD53-e8a31g+iz6vMB0-e2LECjouBELkBOXBV5=oGBg@mail.gmail.com>
 <20110927213517.GB5176@sigill.intra.peff.net>
 <CAEvN+1gODnGy2v2=d6NXJ8b1nBJgpqj+BkDm2eQC1xqyTKXhEg@mail.gmail.com>
 <7v1uutg8xw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tzu-Jung Lee <roylee17@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:05:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAz4K-000206-VG
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab1JDHFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 03:05:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51949
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab1JDHFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 03:05:31 -0400
Received: (qmail 3704 invoked by uid 107); 4 Oct 2011 07:10:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 03:10:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 03:05:29 -0400
Content-Disposition: inline
In-Reply-To: <7v1uutg8xw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182729>

On Mon, Oct 03, 2011 at 12:40:43PM -0700, Junio C Hamano wrote:

> Tzu-Jung Lee <roylee17@gmail.com> writes:
> 
> > And also teach the rev-list to parse or interpret the 'saved' refs differently.
> > So we can have the following use case:
> >
> >    git log branch_foo --author=some_one -S some_string --saved=cached_ref
> >    git log cached_ref
> >    git cherry-pick cached_ref~4
> >    git format-patch cached_ref~6..cached_ref~2
> >
> > I often have such use cases. not sure others would be benefited from
> > such feature.
> > Just asking for comment. :)
> 
> It feels too much hackery for too little gain.

Agreed. It means that each entry in refs/saved is subtly _not_ a ref,
but rather a list of refs. Until now, most refs are considered equal
with respect to basic things like ref lookup.  So if git were to save
this, I'm not sure refs/ would be the right place. A reflog would be a
bit closer in concept.

But I really don't see the need for git to handle this at all. There is
already a general solution:

> $ git log --oneline master..branch --author=A.U.Thor -Spickaxe >foos.txt
> 
> and working from the text file foos.txt at least would not contaminate any
> ref namespace and you do not have to clean them after you are done.

Which works just as well, and is way more flexible. You have to be a
little more proficient in using the shell, but that is at least a
general skill which transfers to many other programs.

-Peff
