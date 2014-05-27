From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sideband.c: Get rid of ANSI sequence for non-terminal
 shell
Date: Tue, 27 May 2014 12:47:25 -0400
Message-ID: <20140527164725.GC29693@sigill.intra.peff.net>
References: <CABHRWd2-FHL+ZUf7Fp8WnC4Vj4_5=k__huFr1EYSazThyKv=5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	spearce@spearce.org, j6t@kdbg.org, nico@cam.org, junkio@cox.net,
	kusmabite@gmail.com
To: Michael Naumov <mnaoumov@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 18:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpKXD-0006nu-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 18:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaE0Qr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 12:47:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:60318 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751594AbaE0Qr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 12:47:27 -0400
Received: (qmail 18620 invoked by uid 102); 27 May 2014 16:47:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 May 2014 11:47:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2014 12:47:25 -0400
Content-Disposition: inline
In-Reply-To: <CABHRWd2-FHL+ZUf7Fp8WnC4Vj4_5=k__huFr1EYSazThyKv=5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250174>

On Tue, May 27, 2014 at 01:27:12PM +1000, Michael Naumov wrote:

> From ae8d04fdbd71cf322e67903826544d5431f2866d Mon Sep 17 00:00:00 2001
> From: Michael Naumov <mnaoumov@gmail.com>
> Date: Tue, 27 May 2014 12:45:06 +1000
> Subject: [PATCH] sideband.c: Get rid of ANSI sequence for non-terminal shell

You can drop these lines; they are redundant with your email's headers
(but see below for more email tips).

> Some git tools such as GitExtensions for Windows use environment variable
> TERM=msys which causes the weird ANSI sequence shown for the messages
> returned from server-side hooks
> 
> See https://github.com/gitextensions/gitextensions/issues/1313 for more
> details

It's nice to give a pointer to more discussion, but it's also a good
idea to give a one- or two-sentence summary. Something like (after your
first paragraph):

  We add those ANSI sequences to help format sideband data on the user's
  terminal. However, these extensions are not using a terminal, and the
  sequences just confuse them. We can recognize this use by checking
  isatty().

> NOTE: I considered to cover the case that a pager has already been started.
> But decided that is probably not worth worrying about here, though, as we
> shouldn't be using a pager for commands that do network communications (and
> if we do, omitting the magic line-clearing signal is probably a sane thing
> to do).

I was nodding my head in agreement at this, and then went back and
realized that it is paraphrasing me. So I definitely agree with it. :)

> Signed-off-by: Michael Naumov <mnaoumov@gmail.com>
> 
> Thanks-to: Erik Faye-Lund <kusmabite@gmail.com>
> Thanks-to: Jeff King <peff@peff.net>

A minor nit, but please keep these "trailers" together in a single
paragraph. Elsewhere on the list people are developing tools to write
and parse them, and I believe that they only look backwards up to the
last empty line.

> diff --git a/sideband.c b/sideband.c
> index d1125f5..7f9dc22 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -30,7 +30,7 @@ int recv_sideband(const char *me, int in_stream, int out)
> 
>   memcpy(buf, PREFIX, pf);
>   term = getenv("TERM");
> - if (term && strcmp(term, "dumb"))
> + if (isatty(2) && term && strcmp(term, "dumb"))
>   suffix = ANSI_SUFFIX;
>   else
>   suffix = DUMB_SUFFIX;

Your patch looks whitespace damaged. It was also sent as a
multipart/alternative with html, which I suspect means it did not make
it to the list. It looks like you're using gmail. The simplest thing is
to just use git-send-email to send it; there are tips for configuring
send-email with gmail in "git help send-email".

-Peff
