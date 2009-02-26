From: Jeff King <peff@peff.net>
Subject: Re: Building 1.6.2-rc2 in Cygwin
Date: Thu, 26 Feb 2009 10:44:50 -0500
Message-ID: <20090226154450.GA20745@coredump.intra.peff.net>
References: <c115fd3c0902260723o4d475df5yecc9ff23c55c7af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LciRL-0002jp-FN
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZBZPoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 10:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZBZPoz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:44:55 -0500
Received: from peff.net ([208.65.91.99]:55714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbZBZPoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 10:44:54 -0500
Received: (qmail 5711 invoked by uid 107); 26 Feb 2009 15:45:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 10:45:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 10:44:50 -0500
Content-Disposition: inline
In-Reply-To: <c115fd3c0902260723o4d475df5yecc9ff23c55c7af4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111576>

On Thu, Feb 26, 2009 at 10:23:54AM -0500, Tim Visher wrote:

> The reason I'm using `configure` at all is that when I simply do a
> `make` without a `make configure; ./configure` first, it fails with a
> message like:
> 
>     $ make
>         CC fast-import.o
>     In file included from builtin.h:4,
>                      from fast-import.c:142:
>     git-compat-util.h:100:19: iconv.h: No such file or directory
>     make: *** [fast-import.o] Error 1
> 
> Once I configure, even without any options, it builds fine and I can

It sounds like you don't have iconv. You can build with:

  make NO_ICONV=1

on such a platform, which is more or less what the configure script is
doing. Try running './configure' and investigating the
config.mak.autogen it generates; this gets pulled directly into the
Makefile. You can correlate the variables it is setting with the
descriptions in the Makefile.

> My eventual goal is to have git installed with man, info, and html
> pages, into my (and my fellow developers') personal bin, man, info,
> and html directories at ~/x.  It appeared that I could do that with
> ./configure but per the response I got earlier, this doesn't seem to
> be the case.

I think the right thing to do is to fix the broken autoconf support, as
per my other message. But you can workaround it with:

  ./configure
  make htmldir=~/man bindir=~/bin mandir=~/man infodir=~/info

The latter command is simply overriding what's in the Makefile with
what you provide on the command line (so any defaults, or anything
provided by ./configure is ignored).

-Peff
