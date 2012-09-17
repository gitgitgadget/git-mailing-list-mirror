From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Mon, 17 Sep 2012 16:11:19 -0400
Message-ID: <20120917201119.GB24888@sigill.intra.peff.net>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhfH-0004oY-Hk
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab2IQULX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:11:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46770 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755612Ab2IQULW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:11:22 -0400
Received: (qmail 12087 invoked by uid 107); 17 Sep 2012 20:11:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 16:11:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 16:11:19 -0400
Content-Disposition: inline
In-Reply-To: <1347882637-21766-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205735>

On Mon, Sep 17, 2012 at 12:50:37PM +0100, Adam Spiers wrote:

> The end result of these changes is that:
> 
>   - red is _only_ used for things which have gone unexpectedly wrong:
>     test failures, unexpected test passes, and failures with the
>     framework,
> 
>   - yellow is _only_ used for known breakages, and
> 
>   - green is _only_ used for things which have gone to plan and
>     require no further work to be done.

Sounds reasonable, and I think the new output looks nice. I notice that
skipped tests are still in green. I wonder if they should be in yellow,
too. They may or may not be a problem, but you are failing to run some
portion of the test suite.

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index ae6a3f0..4e111b4 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -81,9 +81,10 @@ test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib
>  	./passing-todo.sh >out 2>err &&
>  	! test -s err &&
>  	sed -e 's/^> //' >expect <<-\\EOF &&
> -	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
> -	> # fixed 1 known breakage(s)
> -	> # passed all 1 test(s)
> +	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
> +	> # fixed 1 known breakage(s); please update test(s)
> +	> # still have 1 known breakage(s)
> +	> # passed all remaining 0 test(s)
>  	> 1..1
>  	EOF
>  	test_cmp expect out)

This hunk is surprising after reading the commit message. It looks like
you are also breaking down expect_fail tests by fixed and not fixed.

I think that is probably an OK thing to do (although it might make more
sense in a separate patch), but are your numbers right?  It looks from
that count as if there are 2 tests expecting failure (one fixed and one
still broken).

-Peff
