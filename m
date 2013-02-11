From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 4/5] Git.pm: add interface for git credential command
Date: Mon, 11 Feb 2013 11:53:31 -0500
Message-ID: <20130211165331.GD16402@sigill.intra.peff.net>
References: <cover.1360599057.git.mina86@mina86.com>
 <2ec5dd694878055e9ce9d650889ee85369073568.1360599712.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wdi-0000UL-7v
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023Ab3BKQxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:53:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44345 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757893Ab3BKQxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:53:34 -0500
Received: (qmail 23774 invoked by uid 107); 11 Feb 2013 16:55:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 11:55:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 11:53:31 -0500
Content-Disposition: inline
In-Reply-To: <2ec5dd694878055e9ce9d650889ee85369073568.1360599712.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216052>

On Mon, Feb 11, 2013 at 05:23:38PM +0100, Michal Nazarewicz wrote:

> +=item credential_read( FILE_HANDLE )
> +
> +Reads credential key-value pairs from C<FILE_HANDLE>.  Reading stops at EOF or
> +when an empty line is encountered.  Each line must be of the form C<key=value>
> +with a non-empty key.  Function returns a hash with all read values.  Any
> +white space (other then new-line character) is preserved.
> +
> +=cut
> +
> +sub credential_read {
> +	my ($self, $reader) = _maybe_self(@_);
> +	my %credential;
> +	while (<$reader>) {
> +		chomp;
> +		if ($_ eq '') {
> +			last;
> +		} elsif (!/^([^=]+)=(.*)$/) {
> +			throw Error::Simple("unable to parse git credential data:\n$_");
> +		}
> +		$credential{$1} = $2;
> +	}
> +	return %credential;
> +}

Should this return a hash reference? It seems like that is how we end up
using and passing it elsewhere (since we have to anyway when passing it
as a parameter).

I don't have a strong preference, and it's somewhat a matter of taste.
And maybe returning the actual hash matches the rest of the module
better. I admit I don't really use Git.pm much.

-Peff
