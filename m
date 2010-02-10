From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: Suggestion on git-push --porcelain
Date: Tue, 9 Feb 2010 22:35:57 -0500
Message-ID: <20100210033557.GB5205@cthulhu>
References: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 04:36:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf3Mx-0007bM-ON
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 04:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0BJDf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 22:35:58 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:56332 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0BJDf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 22:35:58 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 60C6F82200F; Tue,  9 Feb 2010 22:35:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139479>

* Tay Ray Chuan (rctay89@gmail.com) [100209 21:34]:
> Hi,
> 
> this is regarding the recent patch series from Larry. (I thought
> replying to any of the patch messages was appropriate, I couldn't find
> a cover-letter, so I'm starting a new thread.)
> 
> Around June last year, a patch from Larry was made to add the
> --porcelain option, so as to produce machine-readable output regarding
> ref status.
> 
> The latest patch series goes a step further, and tries to change
> output - for example, suppressing user-friendly advice and giving "To:
> <destination>".
> 
> I think this is an untenable path - adding/suppressing output of
> certain messages for porcelain writers, while trying to keep things
> fixed enough for porcelain writers to depend on. We will also have to
> keep and eye out for future patches from adding fprintfs to stdout and
> stderr that may break porcelain scripts.

While I agree with you in principle, I'm still advocating that we make these two
changes.  *Especially* suppressing the advice.  That advice did not exist last
June, so the output format has already been changed.  Also, the advice never
should have gone to the standard output in the first place.  All the other
instances of output like that go to standard error.

As for the "To: " lines, unfortunately the lack of them was a pretty serious
design flaw in the original patch :(

> I believe a better approach would be to prefix messages intended for
> porcelain writers. For example, a push session might look like this:
> 
>   $ git push --porcelain
>   PORCELAIN To git://foo.com/git/myrepo.git
>   PORCELAIN uptodate refs/heads/baz:refs/heads/baz 1234ab ba4321
>   PORCELAIN nonff refs/heads/bar:refs/heads/bar 2345cd 3456de
> 
> This is an "positive" approach, in the sense that we don't remove
> anything from the current output; we just add more printf("PORCELAIN")
> lines to wherever is appropriate.

Actually, What I'm proposing is something very similar to this: I think that the
output for the porcelain writer and *only* the output for the porcelain writer
should go to standard output, and everything else should go to standard error.


       --larry
