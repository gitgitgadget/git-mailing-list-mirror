From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sat, 21 Nov 2009 14:36:00 -0500
Message-ID: <20091121193600.GA3296@coredump.intra.peff.net>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsT-00041R-EY
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZKUTgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 14:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756624AbZKUTgA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 14:36:00 -0500
Received: from peff.net ([208.65.91.99]:50784 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536AbZKUTf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 14:35:59 -0500
Received: (qmail 1718 invoked by uid 107); 21 Nov 2009 19:39:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 21 Nov 2009 14:39:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Nov 2009 14:36:00 -0500
Content-Disposition: inline
In-Reply-To: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133403>

On Sat, Nov 21, 2009 at 07:43:30PM +0200, Felipe Contreras wrote:

> Some MTAs make smart decisions based on the 'from' envelope (i.e. msmtp)

So my first thought was "how in the world is this different from setting
the envelope sender?"

Reading the code, it seems:

> -	$raw_from = $envelope_sender if (defined $envelope_sender);
> +	if (defined $envelope_sender) {
> +		$raw_from = $envelope_sender;
> +		$envelope_from = 1;
> +	}
>  	$raw_from = extract_valid_address($raw_from);
>  	unshift (@sendmail_parameters,
> -			'-f', $raw_from) if(defined $envelope_sender);
> +			'-f', $raw_from) if(defined $envelope_from);

that this is a boolean to mean "use the from address as the envelope
sender".

It was of course all the more confusing for not being documented at all,
but even if documented, --envelope-from is IMHO confusingly similar to
--envelope-sender. Maybe --use-from-in-envelope would be a better name?

And of course, your patch is missing docs and tests.

-Peff
