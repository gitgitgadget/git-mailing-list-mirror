From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Complain in the tests about git config not failing
 with, keys without a section
Date: Tue, 6 Mar 2012 03:06:24 -0500
Message-ID: <20120306080624.GB21199@sigill.intra.peff.net>
References: <4F50A79E.5060206@philosof.dk>
 <7v8vjiethh.fsf@alter.siamese.dyndns.org>
 <4F547261.7000506@philosof.dk>
 <20120305103714.GA30463@sigill.intra.peff.net>
 <7veht626ex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rune Philosof <rune@philosof.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:06:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4pPl-0000S7-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758514Ab2CFIG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:06:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38227
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758301Ab2CFIG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:06:26 -0500
Received: (qmail 5230 invoked by uid 107); 6 Mar 2012 08:06:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 03:06:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 03:06:24 -0500
Content-Disposition: inline
In-Reply-To: <7veht626ex.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192309>

On Mon, Mar 05, 2012 at 11:29:10AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For "git config --list", as you noticed, we include it in the output. I
> > suspect we should simply omit it as cruft. But we could also issue a
> > warning, and/or die.
> 
> A new warning might be worth if we were to suddenly start omitting
> them from --list output, but dying won't fly well.
> 
> People have been happily lived with their config with such lines
> that do not affect what git does, but a new version of git starts to
> "die" on them.  For what purpose?  Whom is such a change designed to
> help?

The only people you might help are those who would like to be informed
that their config file is bogus, and that those entries are being
ignored (which might be an error, for example, if they accidentally
deleted a section header). But I don't think it's a huge deal; it
certainly is not the first config error one could make that isn't
detected (e.g., you could just as easily typo "core.quotpath", and git
will never say a word).

A warning probably serves to inform such people just as well as dying.
I am actually just fine with omitting it from --list, too. We can be
liberal in what we accept from people's config files, and just pretend
that bogus things do not exist (just like core.quotpath ends up being
silently ignored). You cannot access a section-less variable via "git
config" directly, so it is probably better to just act as if it does not
exist.

For the record, I am also fine with just leaving it as-is. This seems
like such a low priority that until somebody shows up with a patch, I
can't bring myself to care too much.

-Peff
