From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] trailer: display a trailer without its trailing
 newline
Date: Fri, 7 Nov 2014 14:22:39 -0500
Message-ID: <20141107192239.GC5695@peff.net>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
 <20141107185053.16854.84253.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmp7O-0004Bn-2o
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbaKGTWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:22:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:37693 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752972AbaKGTWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:22:41 -0500
Received: (qmail 29674 invoked by uid 102); 7 Nov 2014 19:22:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 13:22:41 -0600
Received: (qmail 24918 invoked by uid 107); 7 Nov 2014 19:22:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 14:22:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2014 14:22:39 -0500
Content-Disposition: inline
In-Reply-To: <20141107185053.16854.84253.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 07:50:49PM +0100, Christian Couder wrote:

> diff --git a/trailer.c b/trailer.c
> index 761b763..f4d51ba 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -583,8 +583,12 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
>  	strbuf_addch(&seps, '=');
>  	len = strcspn(trailer, seps.buf);
>  	strbuf_release(&seps);
> -	if (len == 0)
> -		return error(_("empty trailer token in trailer '%s'"), trailer);
> +	if (len == 0) {
> +		struct strbuf sb = STRBUF_INIT;
> +		strbuf_addstr(&sb, trailer);
> +		strbuf_rtrim(&sb);
> +		return error(_("empty trailer token in trailer '%s'"), sb.buf);
> +	}

Doesn't this leak sb.buf?

-Peff
