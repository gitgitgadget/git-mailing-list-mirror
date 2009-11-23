From: Jeff King <peff@peff.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 14:25:18 -0500
Message-ID: <20091123192518.GA1607@coredump.intra.peff.net>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCeXU-0000wq-Ju
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 20:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbZKWTZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 14:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbZKWTZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 14:25:16 -0500
Received: from peff.net ([208.65.91.99]:53020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbZKWTZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 14:25:15 -0500
Received: (qmail 4323 invoked by uid 107); 23 Nov 2009 19:29:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Nov 2009 14:29:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2009 14:25:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133526>

On Mon, Nov 23, 2009 at 11:56:43AM -0500, Nicolas Pitre wrote:

> > We need to do one of:
> > 
> >   1. make --all-progress imply "if we are using progress, then make it
> >      more verbose. Otherwise, ignore."
> > 
> >   2. fix all callers to check isatty(2) before unconditionally passing
> >      the option
> 
> None of the above would fix the issue as this only affects progress 
> display for phase #3.  You'd still get progress display for the counting 
> phase and the compressing phase.

I think it does fix the issue, as it is exactly the side effect that we
are concerned about (and I tested my patch for 1, which squelched it).
But your --all-progress-implied is a better fix, so I think we should go
with that.

> That doesn't mean it is OK for send-pack to unconditionally use 
> --all-progress though, although it does provide the -q argument to 
> pack-objects when push -q is used which inhibits any progress display 
> already.

It does, and I almost suggested that (although -q is new as of 1.6.5, so
it may not help the original poster). But "-q" actually does more than
that; it also silences any output for a successful push, which may not
be desired.

-Peff
