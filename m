From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/WIP 2/8] wrapper: implement xfopen()
Date: Wed, 27 May 2015 17:55:07 -0400
Message-ID: <20150527215507.GD23259@peff.net>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
 <1432733618-25629-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjIC-00079D-BD
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbbE0VzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 17:55:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:36939 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752481AbbE0VzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:55:10 -0400
Received: (qmail 16981 invoked by uid 102); 27 May 2015 21:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:55:10 -0500
Received: (qmail 11022 invoked by uid 107); 27 May 2015 21:55:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:55:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 17:55:07 -0400
Content-Disposition: inline
In-Reply-To: <1432733618-25629-3-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270105>

On Wed, May 27, 2015 at 09:33:32PM +0800, Paul Tan wrote:

> +/**
> + * xfopen() is the same as fopen(), but it die()s if the fopen() fails.
> + */
> +FILE *xfopen(const char *path, const char *mode)
> +{
> +	FILE *fp;
> +
> +	assert(path);
> +	assert(mode);
> +	fp = fopen(path, mode);
> +	if (!fp) {
> +		if (*mode == 'w' || *mode == 'a')
> +			die_errno(_("could not open '%s' for writing"), path);

This misses "r+". I don't think we use that in our code currently, but
if we're going to introduce a wrapper like this, I think it makes sense
to cover all cases.

-Peff
