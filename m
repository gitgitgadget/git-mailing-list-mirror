From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Wed, 16 Sep 2015 18:39:01 -0400
Message-ID: <20150916223901.GA24945@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915161619.GN29753@sigill.intra.peff.net>
 <xmqq8u86m2i4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:39:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLM8-0005eR-9W
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbIPWjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:39:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:60466 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752527AbbIPWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:39:07 -0400
Received: (qmail 360 invoked by uid 102); 16 Sep 2015 22:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 17:39:07 -0500
Received: (qmail 25092 invoked by uid 107); 16 Sep 2015 22:39:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 18:39:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 18:39:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8u86m2i4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278082>

On Wed, Sep 16, 2015 at 03:18:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/imap-send.c b/imap-send.c
> > index 01aa227..f5d2b06 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -1412,8 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
> >  	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
> >  
> >  	strbuf_addstr(&path, server.host);
> > -	if (!path.len || path.buf[path.len - 1] != '/')
> > -		strbuf_addch(&path, '/');
> > +	strbuf_complete(&path, '/');
> >  	strbuf_addstr(&path, server.folder);
> 
> Is this conversion correct?  This seems to me that the caller wants
> to create an IMAP folder name immediately under the root hierarchy
> and wants to have the leading slash in the result.

Ugh, you're right. This is the "other" style Eric mentioned earlier.

This looks like the only one in the patch (there are many that did not
check buf.len at all, but if we assume they were not invoking undefined
behavior before, then they are fine under the new code).

-Peff
