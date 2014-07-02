From: Jeff King <peff@peff.net>
Subject: Re: Compile Error on Git 2.0.1 on Redhat 5.9 with Fix
Date: Wed, 2 Jul 2014 12:29:47 -0400
Message-ID: <20140702162947.GA14404@sigill.intra.peff.net>
References: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eldon Nelson <eldon_nelson@ieee.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NPv-000890-KV
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157AbaGBQ3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:29:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:54942 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751717AbaGBQ3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:29:50 -0400
Received: (qmail 22370 invoked by uid 102); 2 Jul 2014 16:29:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jul 2014 11:29:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2014 12:29:47 -0400
Content-Disposition: inline
In-Reply-To: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252792>

On Wed, Jul 02, 2014 at 10:56:25AM -0500, Eldon Nelson wrote:

> When compiling Git 2.0.1 on RedHat 5.9 as a non-root user I get the
> following error:
> 
> BUILD ERROR
> 
> ```
> make prefix=/home/eldon/local all doc info
> ...
>     CC zlib.o
>     CC unix-socket.o
>     CC thread-utils.o
>     CC compat/strlcpy.o
>     AR libgit.a
> /bin/sh: gar: command not found
> make: *** [libgit.a] Error 127
> ```

The Makefile defines AR as:

  $ git grep ^AR Makefile
  Makefile:AR = ar

so it should already do what you want by default.  But that make
variable can be overridden. Can you show us the contents of your
config.mak and config.mak.autogen files (if either exists)?

It's also possible that you have AR set in your environment (show us
"echo $AR"), but that would usually not override the Makefile unless
"make -e" is used (and that is not in your command-line above, but it's
possible that make is a shell alias or something).

> My fix was to make a symlink below:
> 
> SYMLINK
> 
> ```
> gar -> /usr/bin/ar
> ```

A simpler workaround is probably:

  make AR=ar ...

but probably the "right" solution is to eliminate whatever is providing
the bogus override in the first place.

-Peff
