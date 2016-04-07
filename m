From: Jeff King <peff@peff.net>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 7 Apr 2016 16:24:48 -0400
Message-ID: <20160407202448.GA7705@sigill.intra.peff.net>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
 <20160407190709.GC4478@sigill.intra.peff.net>
 <xmqq8u0pyzu6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 22:25:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGU5-0000gz-BW
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbcDGUYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:24:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:46117 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753854AbcDGUYw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 16:24:52 -0400
Received: (qmail 1300 invoked by uid 102); 7 Apr 2016 20:24:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 16:24:51 -0400
Received: (qmail 30549 invoked by uid 107); 7 Apr 2016 20:24:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 16:24:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2016 16:24:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8u0pyzu6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290983>

On Thu, Apr 07, 2016 at 12:37:53PM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: setup.c: do not feed NULL to "%.*s" even with the precision 0
> 
> A recent update 75faa45a (replace trivial malloc + sprintf / strcpy
> calls with xstrfmt, 2015-09-24) rewrote
> 
> 	prepare an empty buffer
> 	if (len)
>         	append the first len bytes of "prefix" to the buffer
> 	append "path" to the buffer
> 
> that computed "path", optionally prefixed by "prefix", into
> 
> 	xstrfmt("%.*s%s", len, prefix, path);
> 
> However, passing a NULL pointer to the printf(3) family of functions
> to format it with %s conversion, even with the precision 0, i.e.
> 
> 	xstrfmt("%.*s", 0, NULL)
> 
> yields undefined results, at least on some platforms.  
> 
> Avoid this problem by substituting prefix with "" when len==0, as
> prefix can legally be NULL in that case.  This would mimick the
> intent of the original code better.
> 
> Reported-by: "Tom G. Christensen" <tgc@jupiterrise.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Nicely explained.

Acked-by: Jeff King <peff@peff.net>

Thanks.

-Peff
