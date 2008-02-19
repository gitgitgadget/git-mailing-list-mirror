From: Jeff King <peff@peff.net>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default
	semantics
Date: Tue, 19 Feb 2008 11:37:44 -0500
Message-ID: <20080219163743.GA31668@sigill.intra.peff.net>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net> <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jason Garber <jgarber@ionzoft.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVU6-0005cn-78
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbYBSQhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbYBSQhr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:37:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2900 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbYBSQhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:37:46 -0500
Received: (qmail 23292 invoked by uid 111); 19 Feb 2008 16:37:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 11:37:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 11:37:44 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802191610480.30505@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74431>

On Tue, Feb 19, 2008 at 04:14:35PM +0000, Johannes Schindelin wrote:

> Subject: [PATCH(TIC)] push: annoy all users by deprecating the default

Heh. It is a good sign that git has made the patch-generation workflow
so pleasant to use that we are willing to make patches for the sake of
humor. :)

> 	FWIW I would resist, just because that config option would change 
> 	the _semantics_ of a git program.
> 
> 	Just think about the IRC channel.  "How do I update only HEAD?" --
> 	"Just say 'git push'" -- "No, that updates nothing" -- "Well, 
> 	works here" -- "But not here!" ... "Can _nobody_ help me?"

Just say "git push origin HEAD"?

> diff --git a/builtin-push.c b/builtin-push.c
> index c8cb63e..7bcb141 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -134,6 +134,14 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		flags |= TRANSPORT_PUSH_ALL;
>  	if (mirror)
>  		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
> +	if (!all && argc < 2)
> +		warning("Pushing without branch names is deprecated.\n"
> +			"Too many users just assumed what it should do\n"
> +			"according to them, got burned, and blamed us,\n"
> +			"the good git developers.\n\n"
> +			"So everybody has to suffer now, and get used to\n"
> +			"new semantics.\n\n"
> +			"Thank you for your time.\n");
>  
>  	if (argc > 0) {
>  		repo = argv[0];

You forgot to add a "--matching" option in case people want to
explicitly request the old behavior. ;P

Seriously, though, I think it is not just new users. It is that for some
(many? most?) people, wanting to push just the HEAD is the _normal_
workflow. So they must remember to always say "git push origin HEAD",
and if they ever forget, the side effects are non-trivial to clean up.

-Peff
