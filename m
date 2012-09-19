From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 4/6] Refactor mechanics of testing in a sub test-lib
Date: Wed, 19 Sep 2012 19:44:06 +0100
Message-ID: <20120919184406.GC19246@atlantic.linksys.moosehall>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
 <1348074915-19985-5-git-send-email-git@adamspiers.org>
 <20120919175655.GC11699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPFz-0006L7-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab2ISSoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:44:10 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45021 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab2ISSoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:44:09 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 5B5A92E39E;
	Wed, 19 Sep 2012 19:44:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20120919175655.GC11699@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205973>

On Wed, Sep 19, 2012 at 01:56:55PM -0400, Jeff King wrote:
> On Wed, Sep 19, 2012 at 06:15:13PM +0100, Adam Spiers wrote:
> 
> > This will allow us to test the test framework more thoroughly
> > without disrupting the top-level test metrics.
> 
> I see this is prep for the next patch, and the parts pulling out the
> test-runs into functions make sense. But this hunk confuses me:
> 
> > @@ -166,7 +176,7 @@ test_expect_success 'tests clean up even on failures' "
> >  	test_must_fail ./failing-cleanup.sh >out 2>err &&
> >  	! test -s err &&
> >  	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
> > -	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
> > +	sed -e 's/Z$//' -e 's/^> //' >expect <<-EOF &&
> >  	> not ok 1 - tests clean up even after a failure
> >  	> #	Z
> >  	> #	touch clean-after-failure &&
> 
> Is it just that you are dropping the '\' in all of the here-docs because
> they are not needed?

Hmm, I think I previously misunderstood the point of the \\ due to
never seeing that syntax before (since my Perl background taught me to
write <<'EOF' instead).  I noticed that the tests all passed without
it, and mistakenly assumed it had become unnecessary due to the
refactoring.

> I think our usual style is not to interpolate, and
> to do so only when we explicitly want it, which can prevent accidental
> errors due to missing quoting.

Right, that makes sense.  I'd vote to put it back in then.

> Also, why is this one not converted into a check_sub... invocation?

Because it was much further down in that file so I didn't notice it
during the refactoring ;-)  I've also noticed I can use test_must_fail
instead of introducing run_sub_test_lib_test_expecting_failures.

So I'll have to re-roll 4--6 again.  Presumably I can just reply to
[PATCH v2 4/6] with modified v3 versions without having to resend
the first three in the series, which haven't changed.
