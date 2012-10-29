From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fix 'make test' for HP NonStop
Date: Mon, 29 Oct 2012 03:06:42 -0400
Message-ID: <20121029070642.GD5102@sigill.intra.peff.net>
References: <003101cdb29f$7c8d9490$75a8bdb0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjR4-0002Mq-2r
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab2J2HGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 03:06:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41854 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2J2HGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:06:45 -0400
Received: (qmail 16099 invoked by uid 107); 29 Oct 2012 07:07:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 03:07:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 03:06:42 -0400
Content-Disposition: inline
In-Reply-To: <003101cdb29f$7c8d9490$75a8bdb0$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208595>

On Thu, Oct 25, 2012 at 12:57:10PM +0200, Joachim Schmitz wrote:

> diff --git a/Makefile b/Makefile
> index f69979e..35380dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1381,6 +1381,15 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> 	MKDIR_WO_TRAILING_SLASH = YesPlease
> 	# RFE 10-120912-4693 submitted to HP NonStop development.
> 	NO_SETITIMER = UnfortunatelyYes
> +
> +	# for 'make test'
> +	# some test don't work with /bin/diff, some fail with /bin/tar
> +	# some need bash, and some need /usr/local/bin in PATH first
> +	SHELL_PATH=/usr/local/bin/bash
> +	SANE_TOOL_PATH=/usr/local/bin

I think we can drop these comments, as the reasoning really should just
go in the commit message.

> +	# as of H06.25/J06.14, we might better use this
> +	#SHELL_PATH=/usr/coreutils/bin/bash
> +	#SANE_TOOL_PATH=/usr/coreutils/bin:/usr/local/bin

Is there any reason not to put both into the default SANE_TOOL_PATH? If
/usr/coreutils/bin does not exist on older versions, it will be a
harmless no-op. I guess we arestuck with picking one $SHELL_PATH,
though.

-Peff
