From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Thu, 12 May 2016 03:55:55 -0400
Message-ID: <20160512075555.GC10922@sigill.intra.peff.net>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <1462824758.24478.37.camel@twopensource.com>
 <xmqqinynt01r.fsf@gitster.mtv.corp.google.com>
 <5731062B.6080909@alum.mit.edu>
 <xmqq37pqubup.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 09:56:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lTY-0006sT-W5
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 09:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbcELHz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 03:55:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:38429 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751632AbcELHz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 03:55:59 -0400
Received: (qmail 3775 invoked by uid 102); 12 May 2016 07:55:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 03:55:58 -0400
Received: (qmail 7515 invoked by uid 107); 12 May 2016 07:55:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 03:55:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 03:55:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37pqubup.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294398>

On Mon, May 09, 2016 at 03:04:46PM -0700, Junio C Hamano wrote:

> Note that I only said "it is not necessary", and did not say "it is
> not desirable".  I wouldn't automatically reject a two patch series
> with demonstration followed by fix, only because they are not in a
> single patch.
> 
> Even when I know the maintenance track a particular fix and test
> targets at, I'd do the "only try to test to see how it is broken
> currently" step manually anyway as part of the initial "acceptance"
> check when applying [*1*], so trying the same procedure for older
> maintenance tracks is no big burden for me.  Having these as two
> separate patches is easier to split them apart, which unfortunately
> makes it easier to lose one of them while cherry-picking.
> 
> This is of course subjective.

As a patch-writer, I often find that splitting the tests from the fix
means that you end up having to explain it twice, and often missing some
of the context.  IOW, it's often hard to explain why a test is checking
the right thing without basically explaining the fix. And explaining the
fix when it's not part of that patch gets awkward.

So I don't think split tests/fixes are wrong, but I'd urge people to
look at how their commit messages turn out. Sometimes the split makes
things _easier_ to explain, too.

> *1* There is a bit of white-lie here.  Instead of applying only t/
>     part, I tend to just do "git am" the whole thing, and then pipe
>     "git show" to "git apply -R" to in-work-tree revert only the
>     code that fixes it.  But the result I get is the same.

My trick for checking the before/after of a patch is:

  1. Compile git without the patch.

  2. Apply the patch, then run the test (via ./t1234-*, which does not
     want to re-build git), confirm that it fails.

  3. Re-compile and re-run the test, confirming that it passes.

That also works well with "rebase -i" where you stop at the patch before
to compile.

I like it because it's simple and doesn't affect git's view (so you
can't accidentally commit the in-work-tree revert, for example). But
since there's nothing telling you what state the compiled git is in, it
can be easy to get confused.

-Peff
