From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: provide Allow header for 405
Date: Tue, 10 Sep 2013 02:24:00 -0400
Message-ID: <20130910062359.GA19638@sigill.intra.peff.net>
References: <1378664106-95936-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jkoleszar@google.com,
	gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 08:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJHMv-0006qz-M8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 08:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab3IJGYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 02:24:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:33406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab3IJGYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 02:24:03 -0400
Received: (qmail 20748 invoked by uid 102); 10 Sep 2013 06:24:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Sep 2013 01:24:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Sep 2013 02:24:00 -0400
Content-Disposition: inline
In-Reply-To: <1378664106-95936-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234418>

On Sun, Sep 08, 2013 at 06:15:06PM +0000, brian m. carlson wrote:

> The HTTP 1.1 standard requires an Allow header for 405 Method Not Allowed:
> 
>   The response MUST include an Allow header containing a list of valid methods
>   for the requested resource.
> 
> So provide such a header when we return a 405 to the user agent.

Makes sense.

>  			if (strcmp(method, c->method)) {
>  				const char *proto = getenv("SERVER_PROTOCOL");
> -				if (proto && !strcmp(proto, "HTTP/1.1"))
> +				if (proto && !strcmp(proto, "HTTP/1.1")) {
>  					http_status(405, "Method Not Allowed");
> +					hdr_str("Allow", !strcmp("GET", c->method) ?
> +						"GET, HEAD" : c->method);
> +				}

It took me a minute to figure out what is going on here. But we seem to
convert HEAD requests into GETs elsewhere, so any "GET" service should
be able to do either.

Looks OK to me.

-Peff
