From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends
	strerror(errno) to die()
Date: Sat, 6 Jun 2009 18:13:20 -0400
Message-ID: <20090606221320.GB30064@coredump.intra.peff.net>
References: <200906061509.15870.trast@student.ethz.ch> <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 07 00:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD48v-0003Ux-KX
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 00:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbZFFWN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 18:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbZFFWN2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 18:13:28 -0400
Received: from peff.net ([208.65.91.99]:52275 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982AbZFFWN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 18:13:27 -0400
Received: (qmail 12435 invoked by uid 107); 6 Jun 2009 22:13:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 06 Jun 2009 18:13:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Jun 2009 18:13:20 -0400
Content-Disposition: inline
In-Reply-To: <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120943>

On Sat, Jun 06, 2009 at 04:44:51PM +0200, Thomas Rast wrote:

> Code by Jeff King and Alexander Potashev, name by Johannes Sixt.
> [...]
> +void die_errno(const char *err, ...)
> +{
> +	va_list params;
> +	char msg[1024];
> +
> +	va_start(params, err);
> +
> +	vsnprintf(msg, sizeof(msg), err, params);
> +	die("%s: %s", msg, strerror(errno));
> +
> +	va_end(params);
> +}
> +

No, this approach is much more elegant than what I posted, so no need to
credit me, at least. ;)

I do agree with Johannes, though. Style-wise, it reads much better as:

  va_start(params, err);
  vsnprintf(msg, sizeof(msg), err, params);
  va_end(params);

  die("%s: %s", msg, strerror(errno));

since you can more easily see that params isn't leaked (and that die,
which doesn't return, is the _last_ thing called).

-Peff
