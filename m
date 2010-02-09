From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Generate a warning message if we find an unrecognized
 option.
Date: Mon, 8 Feb 2010 19:45:14 -0500
Message-ID: <20100209004514.GB4065@coredump.intra.peff.net>
References: <4B70913F.7060809@winehq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:45:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeeEC-0006Mh-9L
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab0BIApO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:45:14 -0500
Received: from peff.net ([208.65.91.99]:34184 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab0BIApN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:45:13 -0500
Received: (qmail 11856 invoked by uid 107); 9 Feb 2010 00:45:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Feb 2010 19:45:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2010 19:45:14 -0500
Content-Disposition: inline
In-Reply-To: <4B70913F.7060809@winehq.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139342>

On Mon, Feb 08, 2010 at 04:33:35PM -0600, Jeremy White wrote:

> diff --git a/imap-send.c b/imap-send.c
> index 51f371b..885da22 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1360,6 +1360,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
>  		server.ssl_verify = git_config_bool(key, val);
>  	else if (!strcmp("preformattedHTML", key))
>  		server.use_html = git_config_bool(key, val);
> +        else imap_info("Unknown imap configuration option '%s'\n", key);
>  	return 0;
>  }

Slight NAK from me on this. When we later add new options, it makes
using the same config for multiple versions of git difficult (the old
versions will complain about the unknown option).

And obviously that is weighed against the ability to notice things like
typos. But if we are going to start complaining about unknown config, we
would probably do better to complain about _all_ unknown config, and not
just this one subsection.

-Peff
