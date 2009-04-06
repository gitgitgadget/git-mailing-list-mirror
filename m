From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] 64-bit fix for date.c.
Date: Mon, 6 Apr 2009 15:06:58 -0400
Message-ID: <20090406190657.GC28120@coredump.intra.peff.net>
References: <20090406172637.GA17437@jenna.bytemine.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernd Ahlers <bernd@ba-net.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LquBm-0005KG-1t
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbZDFTHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 15:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZDFTHS
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:07:18 -0400
Received: from peff.net ([208.65.91.99]:53211 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbZDFTHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:07:18 -0400
Received: (qmail 26080 invoked by uid 107); 6 Apr 2009 19:07:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 15:07:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 15:06:58 -0400
Content-Disposition: inline
In-Reply-To: <20090406172637.GA17437@jenna.bytemine.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115870>

On Mon, Apr 06, 2009 at 07:26:37PM +0200, Bernd Ahlers wrote:

> @@ -871,13 +871,15 @@ unsigned long approxidate(const char *date)
>  	struct timeval tv;
> +	time_t time_sec;
> [...]
>  	gettimeofday(&tv, NULL);
> -	localtime_r(&tv.tv_sec, &tm);
> +	time_sec = tv.tv_sec;
> +	localtime_r(&time_sec, &tm);

Hmph. According to POSIX, tv_sec _is_ a time_t. But I see on FreeBSD,
also, it is actually a "long". So I think this fix makes sense.

-Peff
