From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use a temporary index for interactive git-commit
Date: Wed, 29 Dec 2010 23:33:55 -0500
Message-ID: <20101230043355.GA24555@sigill.intra.peff.net>
References: <1293670038-8606-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 05:34:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYADC-00028i-NN
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 05:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0L3Ed6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 23:33:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41870 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab0L3Ed5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 23:33:57 -0500
Received: (qmail 9954 invoked by uid 111); 30 Dec 2010 04:33:56 -0000
Received: from pool-74-108-55-63.nycmny.fios.verizon.net (HELO sigill.intra.peff.net) (74.108.55.63)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 30 Dec 2010 04:33:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Dec 2010 23:33:55 -0500
Content-Disposition: inline
In-Reply-To: <1293670038-8606-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164349>

On Thu, Dec 30, 2010 at 12:47:18AM +0000, Conrad Irwin wrote:

> Hitherto even an aborted git commit -p or git commit --interactive has
> added the selected changes to the index.

Hmm. I see how it could be confusing if you do ^C in "git commit -p" and
it actually commits what you had staged. But if I am reading the patch
right here:

> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -378,7 +386,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	if (patch_interactive)
>  		add_interactive = 1;
>  	if (add_interactive)
> -		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
> +		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive, NULL));
>  

this behavior will not apply to "git add -p". So doesn't that introduce
a new confusing inconsistency, that ^C from "git commit -p" abandons
changes entirely, but from "git add -p" will silently stage changes?

-Peff
