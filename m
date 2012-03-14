From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/2] t0303: set reason for skipping tests
Date: Wed, 14 Mar 2012 15:14:01 +0100
Message-ID: <20120314141401.GC28595@in.waw.pl>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
 <1331553907-19576-2-git-send-email-zbyszek@in.waw.pl>
 <20120312123031.GA14456@sigill.intra.peff.net>
 <4F5E65AE.8050401@in.waw.pl>
 <20120313215331.GC27752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7oy7-0007Gn-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab2CNOOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:14:18 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55760 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab2CNOOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:14:03 -0400
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S7oxl-0008LB-H6; Wed, 14 Mar 2012 15:14:01 +0100
Content-Disposition: inline
In-Reply-To: <20120313215331.GC27752@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193108>

On Tue, Mar 13, 2012 at 05:53:32PM -0400, Jeff King wrote:
> The reason is that the individual tests do not verify all of the
> preconditions themselves, but rather build on each other.
Right. I added a note based on this sentence in the test description.

> In an ideal world, each test snippet would be totally independent and
> check its preconditions. That would give us an accurate count of how
> many tests actually passed or failed. But fundamentally we only care
> about "did they all succeed or not?", which the current script does tell
> us (either test 2 fails, or if it succeeds, then we have checked the
> precondition for test 4). And the tests end up way shorter, because we
> don't repeat the preconditions over and over.
> 
> If you want to try to make the tests more robust, you can (for example,
> you can tighten the precondition on 4 to check "does it give the right
> answer with the right protocol" instead of just "does it ever give us
> the right answer"). But personally, I'm not sure it's worth that much
> effort.
Yeah.

> > >Should they actually say "# SKIP ..." to tell prove what's going on? I
> > >don't know very much about TAP.
> > # SKIP is used when skipping individual tests (IIUC), but when we
> > skip a group of tests, we simply jump over them and this message is
> > purely informative output that is not interpreted by the harness.
> 
> Just looking at test-lib.sh, it seems like we output "# SKIP" when we do
> skip_all. But I think you would have to give a count of which tests you
> skipped (e.g., try "./t5541-http-push.sh" to see its TAP output). Which
> means when skipping a subset, you'd have to deal with test numbering,
> which is a pain. So it's probably not worth worrying about.
Skipped test numbering could done automatically by using test prereqs,
but (after actually doing that and discarding) I agree that it isn't
worth the trouble.


Jonathan Nieder wrote:
> Nice idea, but shouldn't this description be in test_description so I
> can view it by running "sh t0303-credential-external.sh --help"?
Done.

Updated patches follow.

(This time I tested with GIT_TEST_CREDENTIAL_HELPER=cache
GIT_TEST_CREDENTIAL_HELPER_TIMEOUT="cache --timeout=1,3" and things
seem to work as expected.)

Zbyszek
