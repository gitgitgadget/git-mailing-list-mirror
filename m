From: Jeff King <peff@peff.net>
Subject: Re: DOCBOOK2X_TEXI in Documentation/Makefile invalid on some
 distributions
Date: Thu, 9 Oct 2014 15:35:05 -0400
Message-ID: <20141009193504.GD415@peff.net>
References: <CAMsgyKb-ffkfqRhG-dUkwpnKOcA=3CrZqT57qcqTr+9zm_v2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJUX-0007VO-74
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbaJITfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:35:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:56920 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbaJITfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:35:07 -0400
Received: (qmail 1204 invoked by uid 102); 9 Oct 2014 19:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 14:35:07 -0500
Received: (qmail 27425 invoked by uid 107); 9 Oct 2014 19:35:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Oct 2014 15:35:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Oct 2014 15:35:05 -0400
Content-Disposition: inline
In-Reply-To: <CAMsgyKb-ffkfqRhG-dUkwpnKOcA=3CrZqT57qcqTr+9zm_v2Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 09, 2014 at 12:53:33PM -0500, Derek Moore wrote:

> Following the INSTALL doc, I was building git with:
> 
> make prefix=/usr/local all doc info

I wonder if it is actually sane to recommend building "info" for
newcomers in INSTALL. I do not know if many of the list regulars do so
(I certainly do not), or if it is part of anybody's testing regimen.

> $ git diff
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index cea0e7a..0e6c70a 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -107,7 +107,7 @@ HTML_REPO = ../../git-htmldocs
> 
>  MAKEINFO = makeinfo
>  INSTALL_INFO = install-info
> -DOCBOOK2X_TEXI = docbook2x-texi
> +DOCBOOK2X_TEXI = db2x_docbook2texi
>  DBLATEX = dblatex
>  ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
>  ifndef PERL_PATH

I don't think we would want to take a patch like this, as it is still
called docbook2x-texi at least on Debian.

You can override variables with:

  make DOCBOOK2X_TEXI=db2x_docbook2texi ...

or if you want to use it for multiple make invocations:

  echo DOCBOOK2_TEXI=db2x_docbook2texi >config.mak

If we want a patch to make this Just Work out of the box on Fedora, I'd
suggest looking at config.mak.uname (though I am not sure if there is
enough information there currently to determine Fedora versus another
distro), and/or a patch to configure.ac to detect which name we have.

-Peff
