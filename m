From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] notes remove: --stdin reads from the standard input
Date: Thu, 19 May 2011 14:02:05 -0400
Message-ID: <20110519180205.GA26564@sigill.intra.peff.net>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
 <1305764061-21303-4-git-send-email-gitster@pobox.com>
 <20110519105009.GA11107@sigill.intra.peff.net>
 <7vliy27exx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7Y7-0000bl-1f
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933756Ab1ESSCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:02:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49547
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933691Ab1ESSCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 14:02:08 -0400
Received: (qmail 18511 invoked by uid 107); 19 May 2011 18:04:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 14:04:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 14:02:05 -0400
Content-Disposition: inline
In-Reply-To: <7vliy27exx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173984>

On Thu, May 19, 2011 at 10:55:38AM -0700, Junio C Hamano wrote:

> >> +	if (from_stdin) {
> >> +		struct strbuf sb = STRBUF_INIT;
> >> +		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
> >> +			int len = sb.len;
> >> +			if (len && sb.buf[len - 1] == '\n')
> >> +				sb.buf[--len] = '\0';
> >> +			retval |= remove_one_note(t, sb.buf, flag);
> >> +		}
> >> +	}
> >
> > Wouldn't strbuf_rtrim (or even strbuf_trim) be useful here?
> 
> Thanks for noticing.
> 
> I just mimicked what was done to the result of strbuf_getwholeline() in
> other places (I think from revision.c but I am not sure).

I am tempted to say that other callsites should be "upgraded" to
strbuf_trim. Is there any reason we should not be liberal in accepting
something like:

  echo "  refs/heads/foo  " | git rev-list --stdin

?

I guess for pathspecs we would want to be more literal, though, so maybe
it is a stupid idea.

> An incremental correction, relative to what I had in 'pu' overnight, looks
> like this.

Thanks. BTW, I was too busy picking this one nit to mention that the
general direction of the series is a nice improvement. :)

-Peff
