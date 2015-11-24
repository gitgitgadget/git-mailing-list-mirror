From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Tue, 24 Nov 2015 17:28:21 -0500
Message-ID: <20151124222821.GA10058@sigill.intra.peff.net>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <20151120111848.GC11198@sigill.intra.peff.net>
 <20151120194651.GC21488@serenity.lan>
 <20151124195842.GA7174@sigill.intra.peff.net>
 <20151124221708.GA18913@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:28:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1M4Y-0002QF-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbbKXW2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:28:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:33504 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754307AbbKXW2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:28:24 -0500
Received: (qmail 27145 invoked by uid 102); 24 Nov 2015 22:28:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:28:23 -0600
Received: (qmail 19286 invoked by uid 107); 24 Nov 2015 22:28:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:28:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:28:21 -0500
Content-Disposition: inline
In-Reply-To: <20151124221708.GA18913@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281642>

On Tue, Nov 24, 2015 at 10:17:08PM +0000, John Keeping wrote:

> I wonder if we should do this to help debug SSL issues:
> 
> -- >8 --
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e057051..6d4e0ee 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1317,6 +1317,10 @@ Message-Id: $message_id
>  			require Net::SMTP::SSL;
>  			$smtp_domain ||= maildomain();
>  			require IO::Socket::SSL;
> +			if ($debug_net_smtp) {
> +				no warnings 'once';
> +				$IO::Socket::SSL::DEBUG = 1;
> +			}
>  			# Net::SMTP::SSL->new() does not forward any SSL options
>  			IO::Socket::SSL::set_client_defaults(
>  				ssl_verify_params());
> -- 8< --

That certainly looks like a reasonable thing to be doing, assuming that
the output from IO::Socket::SSL is generally helpful.

> > > Maybe we shouldn't worry too much about that, but should instead put the
> > > invalid path into the error message:
> > > 
> > > 	die "CA path \"$smtp_ssl_cert_path\" does not exist.";
> > 
> > Given what I wrote above, yeah, I'd agree that is sufficient (and I do
> > think mentioning the path is helpful).
> 
> I'll change it to this in a re-roll.

Thanks.

-Peff
