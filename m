From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] git_connect: set ssh shell command in GIT_SSH_COMMAND
Date: Mon, 10 Nov 2014 02:11:55 -0500
Message-ID: <20141110071154.GD7677@peff.net>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
 <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
 <20141109095155.GB17369@peff.net>
 <20141109123934.GA50956@melamine.cuivre.fr.eu.org>
 <xmqq389se0up.fsf@gitster.dls.corp.google.com>
 <20141109174738.GA58680@melamine.cuivre.fr.eu.org>
 <xmqqppcwb6ip.fsf@gitster.dls.corp.google.com>
 <20141109224231.GA59064@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Quinot <thomas@quinot.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnj8s-0004R1-6o
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 08:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbaKJHL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 02:11:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:38633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751268AbaKJHL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 02:11:57 -0500
Received: (qmail 17146 invoked by uid 102); 10 Nov 2014 07:11:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:11:57 -0600
Received: (qmail 586 invoked by uid 107); 10 Nov 2014 07:12:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 02:12:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 02:11:55 -0500
Content-Disposition: inline
In-Reply-To: <20141109224231.GA59064@melamine.cuivre.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 11:42:32PM +0100, Thomas Quinot wrote:

> It may be impractical to install a wrapper script for GIT_SSH
> when additional parameters need to be passed. Provide an alternative
> way of specifying a shell command to be run, including command line
> arguments, by means of the GIT_SSH_COMMAND environment variable,
> which behaves like GIT_SSH but is passed to the shell.
> 
> The special circuitry to modify parameters in the case of using
> PuTTY's plink/tortoiseplink is activated only when using GIT_SSH;
> in the case of using GIT_SSH_COMMAND, it is deliberately left up to
> the user to make any required parameters adaptation before calling
> the underlying ssh implementation.
> 
> Signed-off-by: Thomas Quinot <thomas@quinot.org>
> ---
> 
> Amended patch as per discussion with Junio: change variable name
> to GIT_SSH_COMMAND, keep plink special circuitry disabled for
> this case (leaving it enabled only when using GIT_SSH, thus
> preserving compatibility with legacy usage).

I think this version looks good. Thanks for working on it.

Two style micro-nits (that I do not think even merit a re-roll by
themselves, but Junio may want to mark up as he applies):

> +			} else {
> +				ssh = getenv("GIT_SSH");
> +				if (!ssh) ssh = "ssh";

You did not even introduce this line, but only reindented it. However,
our code style usually would write this as:

	if (!ssh)
		ssh = "ssh";

> +				putty = strcasestr(ssh, "plink") != NULL;

We would usually write this as:

	putty = !!strcasestr(ssh, "plink");

-Peff
