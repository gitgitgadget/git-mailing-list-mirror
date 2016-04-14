From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fsck_commit_buffer(): do not special case the last
 validation
Date: Thu, 14 Apr 2016 14:10:30 -0400
Message-ID: <20160414181030.GA22068@sigill.intra.peff.net>
References: <20160414180709.28968-1-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:10:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqliy-0007Cy-21
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbcDNSKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:10:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:49528 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752889AbcDNSKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:10:35 -0400
Received: (qmail 14281 invoked by uid 102); 14 Apr 2016 18:10:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:10:34 -0400
Received: (qmail 968 invoked by uid 107); 14 Apr 2016 18:10:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:10:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 14:10:30 -0400
Content-Disposition: inline
In-Reply-To: <20160414180709.28968-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291542>

On Thu, Apr 14, 2016 at 11:07:08AM -0700, Junio C Hamano wrote:

> The pattern taken by all the validations in this function is:
> 
> 	if (notice a violation exists) {
> 		err = report(... VIOLATION_KIND ...);
> 		if (err)
> 			return err;
> 	}
> 
> where report() returns zero if specified kind of violation is set to
> be ignored, and otherwise shows an error message and returns non-zero.
> 
> The last validation in the function immediately after the function
> returns 0 to declare "all good" can cheat and directly return the
> return value from report(), and the current code does so, i.e.
> 
> 	if (notice a violation exists)
> 		return report(... VIOLATION_KIND ...);
> 	return 0;
> 
> But that is a selfish code that declares it is the ultimate and
> final form of the function, never to be enhanced later.  To allow
> and invite future enhancements, make the last test follow the same
> pattern.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  fsck.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Patch looks good, and nicely explained.

-Peff
