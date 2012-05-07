From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon, 7 May 2012 09:54:46 -0400
Message-ID: <20120507135446.GB4860@sigill.intra.peff.net>
References: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
 <4FA7952C.90702@viscovery.net>
 <CABPQNSZ+FtMJ1msSmqvROP6YqRGKvz1uz8w1z5mF3YDXZyiPQw@mail.gmail.com>
 <CABPQNSbbH3ULjgYxW6RdH0emrgXoKf1mkiEAm2fR19LsC5q8_w@mail.gmail.com>
 <CABPQNSYe6dDf20D2pQpF=K97rZnWxqe5weEdO+FdKck9rwwzWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 15:55:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SROPH-0005b5-5i
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab2EGNzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 09:55:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32904
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803Ab2EGNys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:54:48 -0400
Received: (qmail 21238 invoked by uid 107); 7 May 2012 13:55:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 09:55:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 09:54:46 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSYe6dDf20D2pQpF=K97rZnWxqe5weEdO+FdKck9rwwzWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197273>

On Mon, May 07, 2012 at 12:02:46PM +0200, Erik Faye-Lund wrote:

> OK, some blaming shows that this changed in 5bd631b3 ("clone: support
> multiple levels of verbosity"), back in February 2010. Before this
> patch, one would have to specify the "quiet"-flag to clone to suppress
> progress-output, after the patch the default is progress being off.

Yeah, I think this is a bug. We already show progress indicators from
the transports without "-v", so there is no reason to require it for the
checkout progress meter. And reading fbd631b3, it looks like the change
is simply a mistake in the patch.

> This seems like the right thing to do if we want to resurrect the
> progress-output's default-on behavior:
> ---8<---
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 3f863a1..f48e603 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -569,7 +569,7 @@ static int checkout(void)
>  	opts.update = 1;
>  	opts.merge = 1;
>  	opts.fn = oneway_merge;
> -	opts.verbose_update = (option_verbosity > 0);
> +	opts.verbose_update = (option_verbosity >= 0);
>  	opts.src_index = &the_index;
>  	opts.dst_index = &the_index;
> 
> ---8<---

Yes, that looks correct to me. Thanks for looking into this.

-Peff
