From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
	only
Date: Thu, 17 Jul 2008 02:38:56 -0400
Message-ID: <20080717063856.GA10450@sigill.intra.peff.net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net> <20080716051829.GB4030@segfault.peff.net> <7v4p6qwezy.fsf@gitster.siamese.dyndns.org> <20080717051833.GA3100@sigio.intra.peff.net> <7v3am9m5ne.fsf@gitster.siamese.dyndns.org> <20080717060143.GA3338@sigill.intra.peff.net> <7vlk01komq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 08:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJN9j-0001sn-5E
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 08:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYGQGjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 02:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbYGQGjA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 02:39:00 -0400
Received: from peff.net ([208.65.91.99]:4420 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbYGQGi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 02:38:59 -0400
Received: (qmail 12937 invoked by uid 111); 17 Jul 2008 06:38:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.138)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 17 Jul 2008 02:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jul 2008 02:38:56 -0400
Content-Disposition: inline
In-Reply-To: <7vlk01komq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88807>

On Wed, Jul 16, 2008 at 11:31:41PM -0700, Junio C Hamano wrote:

> > I started to fix the callsites that Stephan mentioned, but it really is
> > convenient to be able to 'return error("foo")' (or even return
> > func_that_calls_error(), and tracking down deep calls is time consuming
> > and error prone). So maybe we should just enhance the change from
> > 2488df84 and special case "-1" into "1"?
> 
> Didn't the patch to testsuite that triggered this thread talk about "small
> negative integer" not "-1"?  I suspect there might be other negative
> return values from cmd_foo(), although I haven't checked.

It did say that, but I never saw anything in the code except explicit
"return -1" and "return error()". However, some of the diff code may end
up with different values, as I didn't trace it all the way down.
Stephan?

> Is it that somebody do not want 255 exit value, or anything that has 7th
> bit set?  2488df8 (builtin run_command: do not exit with -1., 2007-11-13)
> suggests otherwise at least for Windows runtime, so what we currently have
> that does extra truncation ourselves might be sufficient.

Johannes will have to answer that; however, the truncation there does
leave the extra 7th bit. Maybe & 0x7f would be more appropriate?

-Peff
