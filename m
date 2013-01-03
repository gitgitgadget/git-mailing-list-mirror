From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] DEFAULT_DOC_TARGET
Date: Thu, 3 Jan 2013 15:32:22 -0500
Message-ID: <20130103203222.GB4632@sigill.intra.peff.net>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqrT2-0002Wy-LN
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab3ACUc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:32:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42287 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624Ab3ACUcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:32:25 -0500
Received: (qmail 10252 invoked by uid 107); 3 Jan 2013 20:33:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 15:33:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 15:32:22 -0500
Content-Disposition: inline
In-Reply-To: <1357239920-2201-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212606>

On Thu, Jan 03, 2013 at 11:05:18AM -0800, Junio C Hamano wrote:

> This allows things like:
> 
>   $ DEFAULT_DOC_TARGET=html make doc
>   $ DEFAULT_DOC_INSTALL_TARGET=html make install-doc
> 
> on a platform that does not have manpage viewer.  Which is not very
> useful, given that you can already say
> 
>   $ make install-html
> 
> on such a platform, and these install-$format targets will not go
> away.

I think the usefulness is that it can be set by default for a particular
uname, so people on Windows can just type "make install-doc" without
having to care about setting anything (though to be honest, I do not
even know what they build by default; maybe they do build manpages).
Except that in the original thread:

>   http://thread.gmane.org/gmane.comp.version-control.git/207193/focus=207201

it became clear that to do that we would also want to hoist the uname
automagic defaults into their own file that could be read from
Documentation/Makefile.

> The real motivation behind this was to let me say:
> 
>   $ git checkout $some_old_fork_point
>   $ DEFAULT_DOC_TARGET=git-push.1 make doc
> 
> while updating the sources to the documentation for the maintainance
> track, without having to format everything else that is different
> between the old fork point and the primary branch I usually work on.

I still don't see how this is any advantage over:

  make -C Documentation git-push.1

> The first one was discussed some time ago on the list and all the
> fixes mentioned on the thread already squashed in.  The second one
> is merely for completeness.

I wonder...do we really need DEFAULT_DOC_INSTALL_TARGET? Why isn't it
the same as DEFAULT_DOC_TARGET? I realize that right now we build html
and manpages by default, but only install man. But then why do we bother
building html then?

-Peff
