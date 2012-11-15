From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 00:33:17 -0800
Message-ID: <20121115083315.GA23377@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYutD-0003d2-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab2KOIdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:33:22 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49171 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755772Ab2KOIdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 03:33:21 -0500
Received: (qmail 14465 invoked by uid 107); 15 Nov 2012 08:34:10 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 03:34:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 00:33:17 -0800
Content-Disposition: inline
In-Reply-To: <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209810>

On Thu, Nov 15, 2012 at 03:08:42AM +0100, Felipe Contreras wrote:

> I don't think there's any need for all that, this does the trick:
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index aea66a0..503e551 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -748,16 +748,11 @@ if (!$force) {
>         }
>  }
> 
> -my $prompting = 0;
>  if (!defined $sender) {
>         $sender = $repoauthor || $repocommitter || '';
> -       $sender = ask("Who should the emails appear to be from? [$sender] ",
> -                     default => $sender,
> -                     valid_re => qr/\@.*\./, confirm_only => 1);
> -       print "Emails will be sent from: ", $sender, "\n";
> -       $prompting++;
>  }
> 
> +my $prompting = 0;
> 
> This passes all the current tests and the ones you added.

It may pass on your system, but it will not on a system that meets the
AUTOIDENT prerequisite (it fails the new t9001.19 on my system; I
suspect your system config is such that we skip t9001.19 and run
t9001.20, whereas mine is the opposite).

> Which kind of user will get the prompt with your patch, that would
> miss it with mine?

One whose system is configured in such a way that git can produce an
automatic ident (i.e., has a non-blank GECOS name and a FQDN).

-Peff
