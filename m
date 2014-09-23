From: Jeff King <peff@peff.net>
Subject: Re: How to compile Git with NDK?
Date: Tue, 23 Sep 2014 12:11:07 -0400
Message-ID: <20140923161107.GB20624@peff.net>
References: <CAHd499C3iwpcGf+Zt+jDJfqW41P=6Uu=b8VGZKJpFZCtw56beg@mail.gmail.com>
 <54209333.7090300@gmail.com>
 <CAHd499C0XJDwNa3n3bzK7hu6iRunV1d=nvbqi+2pyoB8uSzDFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:21:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWSgQ-0004oC-5V
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 18:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbaIWQLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 12:11:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:50983 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932115AbaIWQLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 12:11:10 -0400
Received: (qmail 26871 invoked by uid 102); 23 Sep 2014 16:11:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 11:11:09 -0500
Received: (qmail 29353 invoked by uid 107); 23 Sep 2014 16:11:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 12:11:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 12:11:07 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499C0XJDwNa3n3bzK7hu6iRunV1d=nvbqi+2pyoB8uSzDFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257424>

On Tue, Sep 23, 2014 at 07:47:11AM -0500, Robert Dailey wrote:

> But if I type just 'make', I don't see how it will know where my ARM
> toolchain is. I'll read the INSTALL file in the meantime.

It won't. If you are cross-compiling you'll have to specify CC and LD
manually, plus a host of other settings. We usually pick pretty sane
defaults (which is why you can get away without running autoconf), but
they're not going to be reasonable for cross-compiling. If you do go the
non-autoconf route, you'd probably want to try building with "make
uname_S=whatever" to override our defaults (see config.mak.uname for an
idea of which uname variables we look at).

In your original report:

> >> fe@BLD01:~/code/git$ autoconf
> >> fe@BLD01:~/code/git$ ./configure --prefix=/home/fe/git-arm
> >> --build=x86_64-linux-gnu --host=arm-linux-androideabi
> >> configure: Setting lib to 'lib' (the default)
> >> configure: Will try -pthread then -lpthread to enable POSIX Threads.
> >> configure: CHECKS for site configuration
> >> checking for arm-linux-androideabi-gcc... arm-linux-androideabi-gcc
> >> checking whether the C compiler works... no
> >> configure: error: in `/home/fe/code/git':
> >> configure: error: C compiler cannot create executables
> >> See `config.log' for more details

Autoconf couldn't even build a simple hello-world with the compiler you
specified. So the first step would probably be to figure that out. What
does config.log say?

-Peff
