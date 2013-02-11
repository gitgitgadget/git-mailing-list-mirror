From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 4/5] Git.pm: add interface for git credential command
Date: Mon, 11 Feb 2013 12:36:32 -0500
Message-ID: <20130211173632.GJ16402@sigill.intra.peff.net>
References: <cover.1360599057.git.mina86@mina86.com>
 <2ec5dd694878055e9ce9d650889ee85369073568.1360599712.git.mina86@mina86.com>
 <20130211165331.GD16402@sigill.intra.peff.net>
 <xa1tr4kmg4cv.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xJL-0004kh-JG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab3BKRgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:36:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44410 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757822Ab3BKRgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:36:35 -0500
Received: (qmail 24356 invoked by uid 107); 11 Feb 2013 17:38:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:38:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:36:32 -0500
Content-Disposition: inline
In-Reply-To: <xa1tr4kmg4cv.fsf@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216067>

On Mon, Feb 11, 2013 at 06:14:24PM +0100, Michal Nazarewicz wrote:

> > Should this return a hash reference? It seems like that is how we end up
> > using and passing it elsewhere (since we have to anyway when passing it
> > as a parameter).
> 
> Admittedly I mostly just copied what git-remote-mediawiki did here and
> don't really have any preference either way, even though with this
> function returning a reference the call site would have to become:
> 
>                 %$credential = %{ credential_read $reader };

Oh, right, because Git::credential takes the credential as an in-out
parameter rather than just returning it. Which is a bit unusual in perl,
but keeps the interface reasonably simple. The alternative would be:

  $cred = Git::credential $cred, sub {
     ...
  }

which is a little less nice.

> Another alternative would be for it to take a reference as an argument,
> possibly an optional one:

I think that is making things more ugly.

> I'd avoid modifying the hash while reading though since I think it's
> best if it's left intact in case of an error.

Agreed.

> And of course, if we want to get even more crazy, credential_write could
> accept either reference or a hash, like so:
> 
> +sub credential_write {
> +	my ($self, $writer, @rest) = _maybe_self(@_);
> +	my $credential = @rest == 1 ? $rest[0] : { @rest };
> +	my ($key, $value);
> +	# ...
> +}

Ugh.

> Bottom line is, anything can be coded, but a question is whether it
> makes sense to do so. ;)

Yes, it is probably OK to leave it as-is, then. It is largely a matter
of taste, and I will defer to your judgement on that. :)

-Peff
