From: Jeff King <peff@peff.net>
Subject: Re: [PREVIEW v3 4/9] mktree: there are only two line terminators
Date: Thu, 14 Jan 2016 05:11:14 -0500
Message-ID: <20160114101114.GB30772@sigill.intra.peff.net>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:11:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJesG-0001t7-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 11:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbcANKLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 05:11:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:53553 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752176AbcANKLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 05:11:17 -0500
Received: (qmail 14377 invoked by uid 102); 14 Jan 2016 10:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:11:17 -0500
Received: (qmail 5486 invoked by uid 107); 14 Jan 2016 10:11:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:11:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 05:11:14 -0500
Content-Disposition: inline
In-Reply-To: <1452740590-16827-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284027>

On Wed, Jan 13, 2016 at 07:03:04PM -0800, Junio C Hamano wrote:

> @@ -141,23 +141,25 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	unsigned char sha1[20];
> -	int line_termination = '\n';
> +	int lf_lines = 1;
>  	int allow_missing = 0;
>  	int is_batch_mode = 0;
>  	int got_eof = 0;
> +	strbuf_getline_fn getline_fn;
>  
>  	const struct option option[] = {
> -		OPT_SET_INT('z', NULL, &line_termination, N_("input is NUL terminated"), '\0'),
> +		OPT_SET_INT('z', NULL, &lf_lines, N_("input is NUL terminated"), '\0'),

Using '\0' isn't wrong here, but should it now just be "0", since it's
no longer meant to be a "char"?

Also, I notice that other patches in the series flip the logic (instead
of "lf_lines", we get its inverse, "nul_term_line"). That lets us use
the more obvious "OPT_BOOL" here.

-Peff
