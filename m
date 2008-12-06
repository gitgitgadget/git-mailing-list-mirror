From: Jeff King <peff@peff.net>
Subject: Re: git tag -s: TAG_EDITMSG should not be deleted upon failures
Date: Sat, 6 Dec 2008 16:54:01 -0500
Message-ID: <20081206215400.GA29440@coredump.intra.peff.net>
References: <4936AB74.3090901@jaeger.mine.nu> <20081206194034.GA18418@coredump.intra.peff.net> <7v8wqtvvql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 22:55:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L957U-0000S0-Cv
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 22:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbYLFVyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYLFVyF
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 16:54:05 -0500
Received: from peff.net ([208.65.91.99]:1188 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYLFVyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 16:54:05 -0500
Received: (qmail 8006 invoked by uid 111); 6 Dec 2008 21:54:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 06 Dec 2008 16:54:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2008 16:54:01 -0500
Content-Disposition: inline
In-Reply-To: <7v8wqtvvql.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102478>

On Sat, Dec 06, 2008 at 01:28:50PM -0800, Junio C Hamano wrote:

> Thanks.  I love patches that addresses bugs during -rc period.

Well, I'm not sure this was a bug fix versus an improvement, but at
least wasn't an all new feature. And it was short enough to look at in
one sitting.

Of course, I did still manage to introduce a bug in my 4-line
change...;)

>     - the "path" variable is uninitialized if we do not start editor at
>       all, so unlink(path) and free(path) have a very high chance of
>       failing.
> 
>       I think you need [Update #1] below squashed in to fix this.

Oops. Yes, that is definitely a problem.

> [Update #1]
> [...]
> -	char *path;
> +	char *path = NULL;

Right, that fix looks good.

> +	if (build_tag_object(buf, sign, result) < 0) {
> +		if (path)
> +			fprintf(stderr, "What you edited in your editor is left in %s",
> +				path);
> +		exit(128);
> +	}

Much better, though the message is a bit awkward. How about

  "The tag message has been left in %s"

?

Do you want me to resend, or do you want to fix up locally?

-Peff
