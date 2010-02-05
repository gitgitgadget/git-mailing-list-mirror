From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix an error message in git-push so it goes to stderr
Date: Fri, 5 Feb 2010 10:06:38 -0500
Message-ID: <20100205150638.GB14116@coredump.intra.peff.net>
References: <20100205004140.GA2841@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 16:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdPlb-0002Sm-F2
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 16:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab0BEPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 10:06:38 -0500
Received: from peff.net ([208.65.91.99]:43314 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554Ab0BEPGi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 10:06:38 -0500
Received: (qmail 25216 invoked by uid 107); 5 Feb 2010 15:06:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 05 Feb 2010 10:06:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2010 10:06:38 -0500
Content-Disposition: inline
In-Reply-To: <20100205004140.GA2841@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139048>

On Thu, Feb 04, 2010 at 07:41:40PM -0500, Larry D'Anna wrote:

> Having it go to standard output interferes with git-push --porcelain.
> ---
>  builtin-push.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin-push.c b/builtin-push.c
> index 5633f0a..0a27072 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -124,9 +124,9 @@ static int push_with_options(struct transport *transport, int flags)
>  		return 0;
>  
>  	if (nonfastforward && advice_push_nonfastforward) {
> -		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
> -		       "Merge the remote changes before pushing again.  See the 'Note about\n"
> -		       "fast-forwards' section of 'git push --help' for details.\n");
> +		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
> +				"Merge the remote changes before pushing again.  See the 'Note about\n"
> +				"fast-forwards' section of 'git push --help' for details.\n");

I agree that stderr is a more sensible place for such a message to go,
but shouldn't the porcelain output format just suppress it entirely? The
whole point of it is to be machine readable, and this text is

  a. formatted for humans

  b. totally redundant with the machine-readable information presented
     earlier

-Peff
