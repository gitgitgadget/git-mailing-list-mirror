From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Mon, 12 Nov 2012 18:35:46 -0500
Message-ID: <20121112233546.GG10531@sigill.intra.peff.net>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3Xw-00050l-M6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab2KLXfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:35:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45203 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab2KLXfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:35:50 -0500
Received: (qmail 15915 invoked by uid 107); 12 Nov 2012 23:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 18:36:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 18:35:46 -0500
Content-Disposition: inline
In-Reply-To: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209546>

On Sun, Nov 11, 2012 at 06:06:50PM +0100, Felipe Contreras wrote:

> There's no point in asking this over and over if the user already
> properly configured his/her name and email.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> I got really tired of 'git send-email' always asking me from which address to send mails... that's already configured.

It should be defaulting to your regular git ident, and you just have to
hit enter, right?

I think it's probably reasonable to skip that "enter" in most cases. But
I'm not sure why we ever asked in the first place. What do people input
there if they are not taking the default?

> diff --git a/git-send-email.perl b/git-send-email.perl
> index aea66a0..65b8328 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -748,6 +748,17 @@ if (!$force) {
>  	}
>  }
>  
> +my $name = Git::config('user.name');
> +my $email = Git::config('user.email');
> +
> +if (defined $email) {
> +	if (defined $name) {
> +		$sender = sprintf("%s <%s>", $name, $email);
> +	} else {
> +		$sender = $email;
> +	}
> +}

Why not use Git::ident_person() here? It saves some code, and would also
respect environment variables. Or better yet...

>  my $prompting = 0;
>  if (!defined $sender) {
>  	$sender = $repoauthor || $repocommitter || '';

Why not just use $repoauthor or $repocommitter, as the prompt default
already does?

-Peff
