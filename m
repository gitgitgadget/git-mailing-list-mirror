From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 02:14:01 -0500
Message-ID: <20140228071401.GA1229@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <531032DD.9000904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 08:14:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHe5-0006fi-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaB1HOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 02:14:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:58521 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751193AbaB1HOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 02:14:03 -0500
Received: (qmail 12535 invoked by uid 102); 28 Feb 2014 07:14:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 01:14:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 02:14:01 -0500
Content-Disposition: inline
In-Reply-To: <531032DD.9000904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242897>

On Fri, Feb 28, 2014 at 07:55:25AM +0100, Johannes Sixt wrote:

> > This should use test_i18ncmp, as the string you are matching is
> > internationalized.
> 
> More generally, stderr output shouldn't be tested with test_cmp or
> test_i18ncmp at all, but with grep and test_i18ngrep. The reason is that
> when you run the test with 'sh -x t3200* -v -i', the trace output is also
> in stderr, and the test_cmp/test_i18ncmp fails due to the unexpected extra
> text.

I didn't think we bothered to make "sh -x" work robustly. I don't mind
if we do, but "git grep -E 'test_(i18n)?cmp .*err" shows many potential
problem spots.

Hmm. Looks like it is only a problem if you are calling a shell function
(since it is the shell function's trace output you are seeing). So this
test would be OK as-is, but testing for an error, like:

  test_must_fail git branch -u foo foo 2>stderr

would not be, because we see the trace from test_must_fail. So some of
the callsites found by my grep are actually probably fine.

-Peff
