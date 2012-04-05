From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Thu, 5 Apr 2012 08:45:39 -0400
Message-ID: <20120405124539.GA10293@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
 <20120403205906.GB24815@sigill.intra.peff.net>
 <7vsjgkbga9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 14:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFm4U-0001FS-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 14:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2DEMpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 08:45:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48829
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab2DEMpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 08:45:43 -0400
Received: (qmail 23179 invoked by uid 107); 5 Apr 2012 12:45:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 08:45:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 08:45:39 -0400
Content-Disposition: inline
In-Reply-To: <7vsjgkbga9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194769>

On Tue, Apr 03, 2012 at 03:29:34PM -0700, Junio C Hamano wrote:

> > Hmm. So this will actually detect "git push $URL" when $URL matches the
> > remote's configured URL. I feel like this distinction has come up
> > before, and we decided not to equate the two. But now I can't remember
> > where (maybe it when fetching via URL versus via remote?).
> >
> > What should happen if there are multiple push URLs configured?
> 
> This is me merely try to be extra nice without succeeding.
> 
> Perhaps it was an ill-thought-out part of the patch.  The reasoning was
> that when you know that your 'origin' is at $URL, it might be irritating
> if "git push $URL" did not do what "git push origin" did, but we can
> always say 'origin' that is a remoteo nickname is different from $URL; a
> remote nickname does not have to be _only_ substitute of the URL, but it
> can do more for you.  That would give you more incentive to define remotes
> that you interact with often, while keeping the bare-metal flexibility
> when interacting with other remotes in a one-shot fashion.

Yeah, this better matches what we do with fetching, where "git fetch
origin" will respect remote.origin.fetch, but "git fetch $(git config
remote.origin.url)" will not. I do not care too much which way we go,
but I think that it makes sense to be consistent in the two cases.

> I personally would be perfectly fine if
> 
> 	$ git push $URL
> 
> that does not say what to push out how, regardless of push.default
> settings, errors out.
> 
> The same can be said when a remote has more than one URL to be pushed to.

I actually think "git push $URL" makes sense for 'current' and
'matching'. I don't think people tend to do a lot of one-off pushes, but
certainly I have done:

  $ git init
  $ hack hack hack
  $ commit commit commit
  $ ssh example.com git init --bare foo.git
  $ git push example.com:foo.git

(and sometimes even followed by "cd .. && rm -rf foo", if my next step
is to actually clone foo.git somewhere else).  Having to say "HEAD" or
":" is not the end of the world (and in fact 'matching' already errors
out in this case), but it's nice to do the right thing when it's obvious
(i.e., for 'current').

> Personally I do not care too much about it, but this is one more reason
> not to support "upstream" over "current" as the default setting.

Agreed.

-Peff
