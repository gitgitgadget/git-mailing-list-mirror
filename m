From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Tue, 25 Nov 2014 00:03:31 -0500
Message-ID: <20141125050331.GB20805@peff.net>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
 <20141125034424.GA19161@peff.net>
 <xmqqtx1nub9e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 06:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt8Ho-0004LN-N2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 06:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbaKYFDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 00:03:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:44643 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750770AbaKYFDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 00:03:32 -0500
Received: (qmail 30725 invoked by uid 102); 25 Nov 2014 05:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 23:03:32 -0600
Received: (qmail 26828 invoked by uid 107); 25 Nov 2014 05:03:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 00:03:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 00:03:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtx1nub9e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260194>

On Mon, Nov 24, 2014 at 08:58:37PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   1. It is a bit more obvious when debugging or dumping arguments (e.g.,
> >      via GIT_TRACE), especially if new options are added after the
> >      first.
> >
> >   2. It makes it easier for a script to work on old and new versions of
> >      git. It sees either "amend" or "noamend" for the two obvious cases,
> >      and if it sees no argument, then it knows that it does not know
> >      either way (it is running on an old version of git).
> >
> >      Technically one can tell the difference in shell between an empty
> >      string and a missing argument, but it is sufficiently subtle that I
> >      think "noamend" is a better route.
> 
> If we ever add more info, would we want to keep piling on new
> arguments, though?  Wouldn't it a viable option to use "amend" vs
> not giving anything (not even an empty string), so that normal case
> there won't be no parameter?

Then when you add new arguments, the hook has to search through the
parameters looking for one that matches, rather than just checking "$1"
for "amend" (and "$2" for the new option, and so on). As long as the set
of options remains relatively small, I think that is preferable.

We could also just pass them through the environment, which gives nice
named parameters.

-Peff
