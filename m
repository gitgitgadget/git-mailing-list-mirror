From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lib-httpd.sh: print error.log on error
Date: Mon, 13 Jun 2016 07:56:08 -0400
Message-ID: <20160613115608.GA5652@sigill.intra.peff.net>
References: <20160612104154.31446-1-pclouds@gmail.com>
 <20160612125921.GA15289@sigill.intra.peff.net>
 <20160613114014.GA15562@ash>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 13:56:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQTZ-0005uf-1o
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 13:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423060AbcFML4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 07:56:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:53768 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422963AbcFML4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 07:56:12 -0400
Received: (qmail 11354 invoked by uid 102); 13 Jun 2016 11:56:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 07:56:11 -0400
Received: (qmail 13635 invoked by uid 107); 13 Jun 2016 11:56:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 07:56:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 07:56:08 -0400
Content-Disposition: inline
In-Reply-To: <20160613114014.GA15562@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297180>

On Mon, Jun 13, 2016 at 06:40:14PM +0700, Duy Nguyen wrote:

> I like the verbose route, so here's v2

I think this is OK, though...

> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index f9f3e5f..67bc7ad 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -180,6 +180,8 @@ start_httpd() {
>  	if test $? -ne 0
>  	then
>  		trap 'die' EXIT
> +		test "$verbose" = t && \
> +			cat "$HTTPD_ROOT_PATH"/error.log 2>/dev/null

I think you can just spell this:

  cat >&4 ...

(I had originally thought that we set up those fds only inside the
test_expect blocks, but it is the redirection 2>&4 that we set up there;
you can always use fd 4 as necessary).

It does incur a useless "cat" when we are not verbose, but I don't think
that's a big deal for the error path like this.

-Peff
