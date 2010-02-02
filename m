From: Jeff King <peff@peff.net>
Subject: Re: Fix signal handler
Date: Tue, 2 Feb 2010 15:58:49 -0500
Message-ID: <20100202205849.GA14385@sigill.intra.peff.net>
References: <4B684F5F.7020409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcPps-0004Vz-PX
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab0BBU6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 15:58:52 -0500
Received: from peff.net ([208.65.91.99]:50584 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308Ab0BBU6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 15:58:51 -0500
Received: (qmail 17664 invoked by uid 107); 2 Feb 2010 20:58:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 02 Feb 2010 15:58:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2010 15:58:49 -0500
Content-Disposition: inline
In-Reply-To: <4B684F5F.7020409@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138754>

On Tue, Feb 02, 2010 at 05:14:23PM +0100, Markus Elfring wrote:

> The function "early_output" that is set as a signal handler by the
> function "setup_early_output" contains a simple looking instruction.
> [...]
> A global variable gets a function pointer assigned.
> [...]
> I find that this approach does not fit to standard rules because the
> data type "sig_atomic_t" is the only type that can be safely used for
> global write access in signal handlers.

No, it's not a sig_atomic_t, but it is assignment of a single function
pointer that is properly declared as volatile. Is this actually a
problem on any known system?

If you want to nit-pick, there are much worse cases. For example, in
diff.c, we do quite a bit of work in remove_tempfile_on_signal. It
assumes that char* assignment is atomic, but nothing is even marked as
volatile. But again, is this actually a problem on any system?

You will find that most git developers care about real problems that can
be demonstrated on real systems. Standards can be a useful guide, but
they can be too loose (e.g., we run on some non-POSIX systems) as well
as too restrictive. What matters is what actually runs in practice.

If you can demonstrate a practical problem and provide a patch, then I
am sure people would be happy to read it.

-Peff
