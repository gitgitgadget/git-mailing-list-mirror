From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] config: make parsing stack struct independent
 from actual data source
Date: Fri, 10 May 2013 00:21:58 +0200
Message-ID: <20130509222158.GA30774@sigill.intra.peff.net>
References: <20130509154020.GA26423@book-mint>
 <20130509161932.GE3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 10 00:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZE1-0004lJ-01
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab3EIWWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:22:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:42159 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab3EIWWC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:22:02 -0400
Received: (qmail 15464 invoked by uid 102); 9 May 2013 22:22:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 May 2013 17:22:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2013 00:21:58 +0200
Content-Disposition: inline
In-Reply-To: <20130509161932.GE3526@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223789>

On Thu, May 09, 2013 at 06:19:32PM +0200, Heiko Voigt wrote:

> diff --git a/config.c b/config.c
> index 046642b..2390458 100644
> --- a/config.c
> +++ b/config.c
> @@ -10,20 +10,41 @@
>  #include "strbuf.h"
>  #include "quote.h"
>  
> -typedef struct config_file {
> -	struct config_file *prev;
> -	FILE *f;
> +struct config_source {
> +	struct config_source *prev;
> +	union {
> +		FILE *file;
> +	};

Anonymous unions like this are a C11-ism (I don't know when gcc learned
about them, but I am sure that many of the older compilers we support
would not be happy). You have to do:

  union {
          FILE *file;
  } u;

and access the file as "cf->u.file".

-Peff
