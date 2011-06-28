From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] test: skip clean-up when running under --immediate
 mode
Date: Tue, 28 Jun 2011 18:51:47 -0400
Message-ID: <20110628225147.GD4192@sigill.intra.peff.net>
References: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbh8O-00057A-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab1F1Wvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:51:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39310
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1F1Wvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:51:50 -0400
Received: (qmail 11268 invoked by uid 107); 28 Jun 2011 22:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Jun 2011 18:52:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2011 18:51:47 -0400
Content-Disposition: inline
In-Reply-To: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176431>

On Mon, Jun 27, 2011 at 11:02:22AM -0700, Junio C Hamano wrote:

> Some tests try to be too careful about cleaning themselves up and
> do
> 
>     test_expect_success description '
>         set-up some test refs and/or configuration &&
>         test_when_finished "revert the above changes" &&
> 	the real test
>     '
> 
> Which is nice to make sure that a potential failure would not have
> unexpected interaction with the next test. This however interferes when
> "the real test" fails and we want to see what is going on, by running the
> test with --immediate mode and descending into its trash directory after
> the test stops. The precondition to run the real test and cause it to fail
> is all gone after the clean-up procedure defined by test_when_finished is
> done.
> 
> Update test_run_ which is the workhorse of running a test script
> called from test_expect_success and test_expect_failure, so that we do not
> run clean-up script defined with test_when_finished when a test that is
> expected to succeed fails under the --immediate mode.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Likes, dislikes?

This sounds to me like the right thing to do. The current behavior has
never been a problem for me, but that is probably because
test_when_finished is relatively new. If I were to run into this
situation, your patch does exactly what I would expect.

-Peff
