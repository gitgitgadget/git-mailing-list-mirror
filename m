From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Fri, 22 Dec 2006 08:51:42 +0100
Message-ID: <20061222075142.GA9595@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org> <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com> <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net> <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl> <20061221112835.GA7713@fiberbit.xs4all.nl> <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 08:52:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxfC6-0001dM-Od
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 08:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945955AbWLVHvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 02:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbWLVHvw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 02:51:52 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:57206 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945955AbWLVHvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 02:51:51 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GxfBu-0002c1-VA; Fri, 22 Dec 2006 08:51:42 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35138>

On Thursday December 21st 2006 at 16:52 Junio C Hamano wrote:

> Personally, I think hiding interfaces such as strXXX and memXXX
> based on _XOPEN_SOURCE level is already a bug in the system
> header implementation.  The symbols that begin with str are
> already reserved by the standard and I do not see any point
> in the system headers to try avoiding namespace contamination.
> 
> But we are not in the business of fixing the system headers.

;-)

Perhaps the idea behind this might be that it allows you to easier
develop software that really only uses interfaces strictly defined in
some "standards" to be always available on compliant platforms. That's
all I could think of why you ever would want to do it like this yes.

> Two and half questions.
> 
>  #0.5 Have you checked the tip of 'master' that has Terje's
>       patch?  It was reported to work yesterday and that is what
>       was committed already.

For some reason a normal "pull" didn't show this one here yet. But I can
see it by merging. The commit "c902c9a" that I now see from Terje does
indeed work here. At any rate that one alone doesn't fix the (same)
FreeBSD issue as reported by Rocco Rutte who sent in an almost identical
patch but with the __FreeBSD__ define.

>  #1   __APPLE__ vs __APPLE_CC__ is not something I can decide (I
>       do not run a Mac).  If MaxOS is derived from FreeBSD, does
>       it by chance define __FreeBSD as well?

As far as I know __APPLE__ is the preferred way of finding out we're
running for a Darwin target. Someone mentioned that __APPLE_CC__ was not
introduced until Apple OS X 10.4. It's value here ('5367') is the build
version of the Apple gcc compiler, doesn't seem very standardized. The
__APPLE__ macro is defined as '1'.

Unfortunately no there is _not_ any "BSD" like macro defined here, so no
__FreeBSD or something. And interesting enough we already know that
OpenBSD specifically needs the _XOPEN_SOURCE define. Anyone out there
with a NetBSD box so we can fix that as well? ;-)

>  #2   Terje's patch excludes _XOPEN_SOURCE_EXTENDED as well on a
>       Mac, but yours doesn't.  Is there a reason that you would
>       want '#define _XOPEN_SOURCE_EXTENDED 1'?  Do both FreeBSD
>       and Mac behave well with it defined?

On Apple compiling git works fine both with and without
_XOPEN_SOURCES_EXTENDED. But looking in the headers, in contrast to the
_XOPEN_SOURCE define which restricts functionality to some predefined
set, the _XOPEN_SOURCES_EXTENDED only adds functionality and doesn't
remove it. So I thought it might be best to keep as much symbols as
possible to be the same for all platforms for future expandibility.

Probably FreeBSD behaves the same with respect to
_XOPEN_SOURCE_EXTENDED. Will check later today.

I don't know if the "Apple Public Source License" allows me to put the
Darwin system headers in a publicly accessable place, so I won't do
that, but if people are interested I can of course privately provide the
system headers and predefined symbols for anyone interested.
-- 
Marco Roeland
