From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] Refactor mechanics of testing in a sub test-lib
Date: Wed, 19 Sep 2012 15:37:08 -0400
Message-ID: <20120919193708.GA21950@sigill.intra.peff.net>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
 <1348074915-19985-5-git-send-email-git@adamspiers.org>
 <20120919175655.GC11699@sigill.intra.peff.net>
 <20120919184406.GC19246@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQ5L-0007IU-DR
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab2ISThM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:37:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49909 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2ISThK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:37:10 -0400
Received: (qmail 4390 invoked by uid 107); 19 Sep 2012 19:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 15:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 15:37:08 -0400
Content-Disposition: inline
In-Reply-To: <20120919184406.GC19246@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205983>

On Wed, Sep 19, 2012 at 07:44:06PM +0100, Adam Spiers wrote:

> > Is it just that you are dropping the '\' in all of the here-docs because
> > they are not needed?
> 
> Hmm, I think I previously misunderstood the point of the \\ due to
> never seeing that syntax before (since my Perl background taught me to
> write <<'EOF' instead).  I noticed that the tests all passed without
> it, and mistakenly assumed it had become unnecessary due to the
> refactoring.

OK. You can write 'EOF' in the shell, too, but we tend not to in this
project (and you can write \EOF in perl, but I agree that it is much
less common in perl code I have seen).

Looking at it again, it is actually quite subtle what is going on. We
wrap the outer test_expect_* calls in double-quotes so that the inner
ones can use single-quotes easily. But that means that technically the
contents of the here-doc _are_ interpolated. But not at test run-time,
but rather at the call to test_expect_*. And that is why we nee to use
"\\" instead of "\". So I think anybody trying to tweak these tests
using shell metacharacters is in for a surprise either way. I'm not sure
it is worth worrying about, though, as handling it would probably make
the existing tests less readable.

> > Also, why is this one not converted into a check_sub... invocation?
> 
> Because it was much further down in that file so I didn't notice it
> during the refactoring ;-)

OK. :)

> I've also noticed I can use test_must_fail instead of introducing
> run_sub_test_lib_test_expecting_failures.

Good catch. I didn't notice that, but it definitely makes sense to reuse
it.

> 
> So I'll have to re-roll 4--6 again.  Presumably I can just reply to
> [PATCH v2 4/6] with modified v3 versions without having to resend
> the first three in the series, which haven't changed.

It all looks sane to me. Thanks again.

-Peff
