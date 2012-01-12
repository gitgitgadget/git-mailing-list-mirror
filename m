From: Jeff King <peff@peff.net>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 15:17:10 -0500
Message-ID: <20120112201710.GA31427@sigill.intra.peff.net>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
 <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
 <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
 <20120112194710.GA28148@sigill.intra.peff.net>
 <20120112201122.GE6038@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 21:17:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlR5J-0005ht-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 21:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab2ALURN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 15:17:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36274
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215Ab2ALURM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 15:17:12 -0500
Received: (qmail 3735 invoked by uid 107); 12 Jan 2012 20:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 15:24:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 15:17:10 -0500
Content-Disposition: inline
In-Reply-To: <20120112201122.GE6038@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188481>

On Thu, Jan 12, 2012 at 02:11:22PM -0600, Jonathan Nieder wrote:

> > I am tempted to suggest
> [...]
> >              That would make all of these work as most people would
> > expect:
> >
> >   git cherry-pick A B C
> >   git cherry-pick A..B
> >   git cherry-pick A..B B..C
> >
> > but would be a regression for:
> >
> >   git cherry-pick B ^A
> >
> > versus the current code. I suspect that the latter form is not all that
> > commonly used, though, and certainly I would accept it as a casualty of
> > making the "A B C" form work. My only hesitation is that it is in fact a
> > regression.
> 
> I find myself using such complicated expressions as
> 
> 	list-revs-to-skip |
> 	xargs git cherry-pick --cherry-pick --right-only HEAD...topic --not
> 
> so yeah, that would be a pretty serious loss in functionality.

That's gross. :)

But thank you for providing a real-world example. I had a vague notion
that the full power of the revision parser was not actually useful to
people, but clearly not.

OTOH, if cherry-pick were more simplistic, you could perhaps get by
with:

  list-revs-to-skip |
  xargs git rev-list --cherry-pick --right-only HEAD...topic --not |
  git cherry-pick --stdin

-Peff
