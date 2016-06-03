From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/10] combine-diff.c: convert trivial snprintf calls to
 xsnprintf
Date: Fri, 3 Jun 2016 04:54:41 -0400
Message-ID: <20160603085441.GD28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-4-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:54:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ksY-0007WQ-Fh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 10:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbcFCIyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 04:54:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:48319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932250AbcFCIyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 04:54:49 -0400
Received: (qmail 1359 invoked by uid 102); 3 Jun 2016 08:54:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:54:44 -0400
Received: (qmail 19202 invoked by uid 107); 3 Jun 2016 08:54:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:54:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 04:54:41 -0400
Content-Disposition: inline
In-Reply-To: <20160603074724.12173-4-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296289>

On Fri, Jun 03, 2016 at 07:47:18AM +0000, Elia Pinto wrote:

> diff --git a/combine-diff.c b/combine-diff.c
> index 8f2313d..a91d9b3 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -293,7 +293,7 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
>  
>  	if (S_ISGITLINK(mode)) {
>  		blob = xmalloc(100);
> -		*size = snprintf(blob, 100,
> +		*size = xsnprintf(blob, 100,
>  				 "Subproject commit %s\n", oid_to_hex(oid));

This one seems like a no-brainer to convert to xstrmft(), since we're
already using a heap buffer, and then we can get rid of that meaningless
"100" magic number.

-Peff
