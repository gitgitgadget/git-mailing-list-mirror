From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/67] mailsplit: make PATH_MAX buffers dynamic
Date: Wed, 16 Sep 2015 16:22:54 -0400
Message-ID: <20150916202254.GA3915@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152806.GJ29753@sigill.intra.peff.net>
 <CAPig+cQ+TvT2_ZrbbYFQOdjDNs+b-ADJb+EbKVTP-HaCghjCow@mail.gmail.com>
 <20150916101418.GD13966@sigill.intra.peff.net>
 <20150916102524.GA28002@sigill.intra.peff.net>
 <xmqqpp1iqlke.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJET-0004SC-1U
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbbIPUXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:23:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:60316 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752347AbbIPUXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:23:03 -0400
Received: (qmail 24336 invoked by uid 102); 16 Sep 2015 20:23:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 15:23:02 -0500
Received: (qmail 22928 invoked by uid 107); 16 Sep 2015 20:23:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:23:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 16:22:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp1iqlke.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278060>

On Wed, Sep 16, 2015 at 11:13:37AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +		free(file);
> > +		file = xstrfmt("%s/%s", maildir, list.items[i].string);
> 
> Repeated pattern makes one wonder if a thin wrapper
> 
> 	xstrfmt_to(&file, "%s/%s", maildir, list.items[i].string);
> 
> that first frees the existing value and then overwrites is an
> overall win.  Perhaps not, as you would (1) initialize the variable
> to NULL before doing a series of xstrfmt_to(), and (2) free the final
> one yourself.

Yeah, exactly. If you want to wrap it up in something that understands
invariants, I think strbuf is the way to go. I dunno. Maybe I should
just have done this whole thing with strbufs.

-Peff
