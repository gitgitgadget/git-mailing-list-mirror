From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 18:23:25 -0400
Message-ID: <20110919222325.GA4056@sigill.intra.peff.net>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
 <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
 <20110919182049.GA26115@sigill.intra.peff.net>
 <7v62ko9scw.fsf@alter.siamese.dyndns.org>
 <20110919204448.GA3562@sigill.intra.peff.net>
 <7v1uvc9qhz.fsf@alter.siamese.dyndns.org>
 <m2bougtdc2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:23:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5mFU-0000St-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 00:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883Ab1ISWXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 18:23:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37750
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774Ab1ISWX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 18:23:27 -0400
Received: (qmail 10516 invoked by uid 107); 19 Sep 2011 22:28:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 18:28:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 18:23:25 -0400
Content-Disposition: inline
In-Reply-To: <m2bougtdc2.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181714>

On Mon, Sep 19, 2011 at 11:46:37PM +0200, Andreas Schwab wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thinking about it a bit more, I suspect that we should just let the 'eval'
> > grab value out of the $browser_cmd variable, i.e.
> >
> > 	eval '$browser_cmd "$@"'
> >
> > no?
> 
> That's a Useless Use of Eval and 100% equivalent to this:
> 
> $browser_cmd "$@"

Yeah. Doing:

  eval '$browser_cmd'

will do the whitespace-breaking we want, but it won't interpret actual
shell magic characters, which we need in order to be compatible with
other parts of git (which typically use "sh -c ..."). E.g.:

  foo=worked
  browser_cmd='echo $foo'
  # fail
  $browser_cmd
  # fail
  eval '$browser_cmd'
  # works
  eval "$browser_cmd"

-Peff
