From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by
 default
Date: Thu, 22 Jan 2015 13:35:38 -0500
Message-ID: <20150122183538.GA20085@peff.net>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
 <20150122130036.GC19681@peff.net>
 <CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
 <vpqa91ahg46.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 22 19:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEMba-0003Mv-BJ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 19:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbbAVSfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 13:35:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:37450 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752749AbbAVSfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 13:35:41 -0500
Received: (qmail 7187 invoked by uid 102); 22 Jan 2015 18:35:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 12:35:40 -0600
Received: (qmail 12798 invoked by uid 107); 22 Jan 2015 18:36:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 13:36:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 13:35:38 -0500
Content-Disposition: inline
In-Reply-To: <vpqa91ahg46.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262854>

On Thu, Jan 22, 2015 at 06:36:41PM +0100, Matthieu Moy wrote:

> > Yes, main point is size of executable.
> 
> The Git executable is a few megabytes, i.e. 0.001% the size of a really
> small hard disk. The benefit seems really negligible to me.

I don't know the layout of the symbols with respect to the code, or
whether the stripped version might reduce memory pressure. So in theory
it could have a performance impact.

But...

> OTOH, debug information allow users to do better bug reports in case of
> crash (gdb, valgrind), which outweights by far the benefit of saving a
> handfull of megabytes IMHO.

Me too. Especially for people who are building git themselves, I feel
like leaving the symbols is a sane default. Package builders are already
using "make strip", or some feature of their package-build system (e.g.,
"dh_strip") to take care of this for the "normal" users. But
fundamentally this is a packaging issue, not a build issue.

-Peff

PS We could still add a "DEBUG" knob to the Makefile and default it to
   off. But I do not see much point. If you want to change the CFLAGS,
   then change the CFLAGS knob. It's much more flexible.
