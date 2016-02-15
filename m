From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] remote: simplify remote_is_configured()
Date: Mon, 15 Feb 2016 13:21:13 -0500
Message-ID: <20160215182113.GF26443@sigill.intra.peff.net>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:21:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNlw-00070L-4q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbcBOSVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:21:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:42285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751910AbcBOSVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:21:16 -0500
Received: (qmail 25353 invoked by uid 102); 15 Feb 2016 18:21:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:21:16 -0500
Received: (qmail 10031 invoked by uid 107); 15 Feb 2016 18:21:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:21:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:21:13 -0500
Content-Disposition: inline
In-Reply-To: <1455558150-30267-3-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286224>

On Mon, Feb 15, 2016 at 06:42:28PM +0100, Thomas Gummerer wrote:

> The remote_is_configured() function allows checking whether a remote
> exists or not.  The function however only works if remote_get() wasn't
> called before calling it.  In addition, it only checks the configuration
> for remotes, but not remotes or branches files.
> 
> Make use of the origin member of struct remote instead, which indicates
> where the remote comes from.  It will be set to some value if the remote
> is configured in any file in the repository, but is initialized to 0 if
> the remote is only created in make_remote().

Makes sense. I wonder if we would want to give this an explicit slot in
the enum. I.e.:

> diff --git a/remote.h b/remote.h
> index 4fd7a0f..7a5ee77 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -5,7 +5,7 @@
>  #include "hashmap.h"
>  
>  enum {
> -	REMOTE_CONFIG,
> +	REMOTE_CONFIG = 1,
>  	REMOTE_REMOTES,
>  	REMOTE_BRANCHES
>  };

Add in "REMOTE_UNCONFIGURED = 0" here. It makes no difference to
correctness, but is perhaps documents what is going on a bit better.

-Peff
