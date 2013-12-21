From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] wt-status.c: disable those distracting
 -Wformat-zero-length warnings
Date: Sat, 21 Dec 2013 04:42:02 -0500
Message-ID: <20131221094202.GA32622@sigill.intra.peff.net>
References: <1387554301-23901-1-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 21 10:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuJ4Y-0001DF-KZ
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 10:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab3LUJmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 04:42:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:48354 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528Ab3LUJmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 04:42:05 -0500
Received: (qmail 25543 invoked by uid 102); 21 Dec 2013 09:42:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 03:42:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 04:42:02 -0500
Content-Disposition: inline
In-Reply-To: <1387554301-23901-1-git-send-email-naesten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239587>

On Fri, Dec 20, 2013 at 10:45:01AM -0500, Samuel Bronson wrote:

> These warnings don't really seem to make much sense for this file.

Agreed, though the advice so far has been to put -Wno-format-zero-length
in your CFLAGS.

> +/* We have good reasons for using zero-length format strings, and
> + * there's unfortunately no way to turn this off on a per-function
> + * basis ... */
> +#pragma GCC diagnostic ignored "-Wformat-zero-length"

Are other compilers happy to ignore this pragma? I guess we could wrap
it in an #ifdef, if so.

It's also really not about this file in particular. The whole concept of
format-zero-length is questionable, as it ignores the concept that a
format function might actually do something useful with an empty format
(e.g., by adding boilerplate, or having a side-effect). It's just that
this file is the only one that happens to do so.

Annotating the _function_ to say "it's useful to pass an empty format
into this function" would make sense, but as you note, there is no way
to do that.

So I dunno. This seems like it does not quite specify what we want to
say as well as just "-Wno-format-zero-length", but it is more convenient
in practice (because we take care of it in the source code, rather than
relying on the user's build settings).

-Peff
