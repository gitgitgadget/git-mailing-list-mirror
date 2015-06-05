From: Jeff King <peff@peff.net>
Subject: Re: debugging git tests, was: Re: [PATCH v4 2/8] t5520: test no
 merge candidates cases
Date: Fri, 5 Jun 2015 06:44:41 -0400
Message-ID: <20150605104441.GA19840@peff.net>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-3-git-send-email-pyokagan@gmail.com>
 <e89b333476cbb1e546371a07b357cd42@www.dscho.org>
 <xmqqoalhdbhx.fsf@gitster.dls.corp.google.com>
 <20150518185554.GB11463@peff.net>
 <1254ff617c50077dc0c08321f168c4ce@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 12:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0p7J-0004to-77
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 12:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbFEKop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 06:44:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:41558 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751376AbbFEKoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 06:44:44 -0400
Received: (qmail 26681 invoked by uid 102); 5 Jun 2015 10:44:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 05:44:44 -0500
Received: (qmail 8036 invoked by uid 107); 5 Jun 2015 10:44:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 06:44:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jun 2015 06:44:41 -0400
Content-Disposition: inline
In-Reply-To: <1254ff617c50077dc0c08321f168c4ce@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270824>

On Tue, May 19, 2015 at 03:29:23PM +0200, Johannes Schindelin wrote:

> On 2015-05-18 20:55, Jeff King wrote:
> 
> > As a side note, I've also considered better support for running the
> > debugger on git commands inside a test (right now, I usually stick a
> > "gdb --args" in the pipeline, but you have to remember to run with "-v",
> > and to redirect stdin appropriately). Do other people have this
> > annoyance, too?
> 
> Yes, I have that annoyance, and I usually want to debug one very specific Git call in that script. Therefore, I made this patch:
> 
> https://github.com/git-for-windows/git/commit/0f50fd723beb5d27d2d799ef3a0cfc0b0bbd80a8
> 
> It really served me well during the past four months of Git for Windows 2.x work. Of course I also had to avoid the redirection:
> 
> https://github.com/git-for-windows/git/commit/d27cb6e0572475582677724545a71755d171ea76
> 
> So what I do these days is to run the failing test with `TEST_NO_REDIRECT=1` and with the Git call I want to debug prefixed with `TEST_GDB_GIT=1`.

Thanks for sharing this (I stuck it on my "to read" list and didn't get
to it until today).

This is definitely the direction I'd like to go in. I think it would be
cool to add in a test-harness option enable TEST_GIT_GDB for a specific
test. So something like:

  ./t1234-foo.sh --gdb=8

to just enable it for a particular test (of course some test snippets
run multiple git invocations, but in practice I think it is few enough
that you could just ask gdb to run to completion until you hit the
invocation you want).

I don't have any code to share yet. I'm still at the point of collecting
ideas like this, which I'll rage-implement next time I have to do a lot
of debugging. :)

-Peff
