From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] Refactor mechanics of testing in a sub test-lib
Date: Wed, 19 Sep 2012 13:56:55 -0400
Message-ID: <20120919175655.GC11699@sigill.intra.peff.net>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
 <1348074915-19985-5-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOWK-0007dH-1H
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804Ab2ISR47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:56:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49774 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932807Ab2ISR45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:56:57 -0400
Received: (qmail 2658 invoked by uid 107); 19 Sep 2012 17:57:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 13:57:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 13:56:55 -0400
Content-Disposition: inline
In-Reply-To: <1348074915-19985-5-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205963>

On Wed, Sep 19, 2012 at 06:15:13PM +0100, Adam Spiers wrote:

> This will allow us to test the test framework more thoroughly
> without disrupting the top-level test metrics.

I see this is prep for the next patch, and the parts pulling out the
test-runs into functions make sense. But this hunk confuses me:

> @@ -166,7 +176,7 @@ test_expect_success 'tests clean up even on failures' "
>  	test_must_fail ./failing-cleanup.sh >out 2>err &&
>  	! test -s err &&
>  	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
> -	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
> +	sed -e 's/Z$//' -e 's/^> //' >expect <<-EOF &&
>  	> not ok 1 - tests clean up even after a failure
>  	> #	Z
>  	> #	touch clean-after-failure &&

Is it just that you are dropping the '\' in all of the here-docs because
they are not needed? I think our usual style is not to interpolate, and
to do so only when we explicitly want it, which can prevent accidental
errors due to missing quoting.

Also, why is this one not converted into a check_sub... invocation?

-Peff
