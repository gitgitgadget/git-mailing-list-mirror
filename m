From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] add the FORMATPRINTF macro to declare the gcc
 function
Date: Thu, 11 Feb 2016 17:33:24 -0500
Message-ID: <20160211223323.GB641@sigill.intra.peff.net>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
 <xmqq37szxh52.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 23:34:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzoD-0003ab-TH
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcBKWds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:33:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:40772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbcBKWd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:33:26 -0500
Received: (qmail 24864 invoked by uid 102); 11 Feb 2016 22:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:33:26 -0500
Received: (qmail 11832 invoked by uid 107); 11 Feb 2016 22:33:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:33:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:33:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37szxh52.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286014>

On Thu, Feb 11, 2016 at 09:59:21AM -0800, Junio C Hamano wrote:

> Elia Pinto <gitter.spiros@gmail.com> writes:
> 
> > Add the FORMATPRINTF macro for declaring the gcc function attribute 'format printf'
> > for code style consistency with similar macro that git already use for other gcc
> > attributes. And use it where necessary.
> >
> > Elia Pinto (22):
> >   git-compat-util.h: add the FORMATPRINTF macro
> 
> Hmm.  Given that we already have
> 
> #ifndef __GNUC__
> #ifndef __attribute__
> #define __attribute__(x)
> #endif
> #endif
> 
> in git-compat-util.h, it is really between:
> 
>     __attribute__((format (printf, 1, 2)))
>     void advise(const char *advice, ...);
> 
>     __attribute__((format (printf,2,3)))
>     extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
> 
> and
> 
>     FORMATPRINTF(1,2)
>     void advise(const char *advice, ...);
> 
>     FORMATPRINTF(2,3)
>     extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
> 
> 
> Perhaps I am biased for staring at our source code for too long, but
> somehow the latter looks unnecessarily loud, spelled in all caps.
> 
> I dunno.  What does this really buy us?

I had the same thought on reading this. I think the "similar macro" Elia
mentions is probably NORETURN. But in that case, we cannot rely on
__attribute__, because it is spelled so many different ways (e.g.,
__declspec(noreturn)).

This series would be helpful to us if there was a platform that
understood the format attribute, but needed to spell it differently
somehow. But short of that, I think it is a net negative.

-Peff
