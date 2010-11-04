From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage
 strings
Date: Thu, 4 Nov 2010 14:13:57 -0400
Message-ID: <20101104181357.GA31016@sigill.intra.peff.net>
References: <20101021222129.GA13262@burratino>
 <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
 <87wrp12p00.fsf@gmail.com>
 <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
 <20101104174917.GA30628@sigill.intra.peff.net>
 <20101104180242.GA16431@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4JP-0007LY-Gx
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab0KDSNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:13:18 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49785 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab0KDSNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:13:17 -0400
Received: (qmail 1331 invoked by uid 111); 4 Nov 2010 18:13:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 18:13:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 14:13:57 -0400
Content-Disposition: inline
In-Reply-To: <20101104180242.GA16431@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160743>

On Thu, Nov 04, 2010 at 01:02:42PM -0500, Jonathan Nieder wrote:

> Yes, that's way more verbose than a typical manpage synopsis.

Well, yes, but...

> For example, from printf(3):
> 
> SYNOPSIS
>        #include <stdio.h>
> 
>        int printf(const char *format, ...);
>        int fprintf(FILE *stream, const char *format, ...);
>        int sprintf(char *str, const char *format, ...);
>        int snprintf(char *str, size_t size, const char *format, ...);
> 
>        #include <stdarg.h>
> 
>        int vprintf(const char *format, va_list ap);
>        int vfprintf(FILE *stream, const char *format, va_list ap);
>        int vsprintf(char *str, const char *format, va_list ap);
>        int vsnprintf(char *str, size_t size, const char *format, va_list ap);
> 
>    Feature Test Macro Requirements for glibc (see feature_test_macros(7)):
> 
>        snprintf(), vsnprintf(): _BSD_SOURCE || _XOPEN_SOURCE >= 500 || _ISOC99_SOURCE; or cc -std=c99

That's a little unfair as a comparison, as it's from a different
section. Try "man IO::Handle", or most other perl modules, for example.
They are quite a bit more verbose.

But yes, in general it is more verbose than other commands in section 1.

> which would suggest that for git-diff(!) we should say something like:
> 
> SYNOPSIS
> 
> 	git diff [options] [--] [<path>...]
> 	git diff [options] --cached [--] [<path>...]
> 	git diff [options] <commit> [--] [<path>...]
> 	git diff [options] --cached <commit> [--] [<path>...]
> 	git diff [options] <commit> <commit> [--] [<path>...]
> 	git diff [options] --no-index [--] <path> <path>

I would be OK with that; my comment lines were an attempt to make it a
bit more clear to the user. But reading your revised versions, they seem
pretty clear to me. I think your example there can actually be collapsed
down to:

	git diff [options] [<commit>] [--] [<path>...]
	git diff [options] --cached [<commit>] [--] [<path>...]
	git diff [options] <commit> <commit> [--] [<path>...]
	git diff [options] [--no-index] [--] <path> <path>

which covers the four major modes.

> I would rather treat --cached as one of the options ("instead of
> comparing the worktree, compare its cached content in the index to the
> specified commit"),

Except it is not quite that. For the first two that I listed above,
--cached makes that distinction. But --cached doesn't make sense at all
in the third or fourth ones. So I think in practice it ends up defining
a mode of operation more than simply an option.

But I do recognize that such a distinction is largely in the mental
model of the user. On the other hand, this is documentation, so we are
trying to promote healthy mental models for users. :)

> and if I were running the world, I'd leave off the [options]. :)

I have no strong opinion on that. There are pretty few unix programs
that don't take [options] at the beginning, so it really is kind of
superfluous. But it's also pretty standard, and clues the user in that
we are a normal program.

-Peff
