From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update cygwin.c for new mingw-64 win32 api headers
Date: Mon, 12 Nov 2012 15:58:32 -0500
Message-ID: <20121112205832.GI4623@sigill.intra.peff.net>
References: <1352679440-4098-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:59:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY16A-0003Hk-4v
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab2KLU6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:58:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45019 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392Ab2KLU6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:58:36 -0500
Received: (qmail 14042 invoked by uid 107); 12 Nov 2012 20:59:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 15:59:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 15:58:32 -0500
Content-Disposition: inline
In-Reply-To: <1352679440-4098-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209525>

On Sun, Nov 11, 2012 at 07:17:20PM -0500, Mark Levedahl wrote:

> The cygwin project recently switched to a new implementation of the
> windows api, now using header files from the mingw-64 project. These
> new header files are incompatible with the way cygwin.c included the
> old headers: cygwin.c can be compiled using the new or the older (mingw)
> headers, but different files must be included in different order for each
> to work. The new headers are in use only for the current release series
> (based upon the v1.7.x dll version). The previous release series using
> the v1.5 dll is kept available but unmaintained for use on older versions
> of Windows. So, patch cygwin.c to use the new include ordering only if
> the dll version is 1.7 or higher.

I have very little knowledge of cygwin compatibility, so thanks for a
nice explanation.  I'll queue it in 'pu' for now, and hopefully we can
get some test reports from other cygwin folks (on new and old cygwin).

> diff --git a/Makefile b/Makefile
> index f69979e..1cc5d96 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1082,6 +1082,7 @@ ifeq ($(uname_O),Cygwin)
>  		NO_SYMLINK_HEAD = YesPlease
>  		NO_IPV6 = YesPlease
>  		OLD_ICONV = UnfortunatelyYes
> +		V15_MINGW_HEADERS = YesPlease
>  	endif

The "if" part of the conditional that did not make it into the context
above is an expr match for "1.6.*" From the name, I would think that we
would want to use these headers on cygwin 1.5.* , too. Is v1.5 too old
to care about now?

-Peff
