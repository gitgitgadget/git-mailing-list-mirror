From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Fri, 5 Dec 2014 04:30:29 -0500
Message-ID: <20141205093029.GD32112@peff.net>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
 <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
 <20141117213442.GD15880@peff.net>
 <CADQoFhyxFNzazsEaE6Bk2W_KDhogBho8vgJXkDDPsYvC46ZX5Q@mail.gmail.com>
 <20141204091023.GB27455@peff.net>
 <xmqq388vuw9e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	Bryan Turner <bturner@atlassian.com>,
	Stefan Saasen <ssaasen@atlassian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 10:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwpDi-0000Ph-Vt
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 10:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbaLEJad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 04:30:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:48841 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752792AbaLEJab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 04:30:31 -0500
Received: (qmail 20459 invoked by uid 102); 5 Dec 2014 09:30:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 03:30:31 -0600
Received: (qmail 13543 invoked by uid 107); 5 Dec 2014 09:30:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 04:30:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Dec 2014 04:30:29 -0500
Content-Disposition: inline
In-Reply-To: <xmqq388vuw9e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260862>

On Thu, Dec 04, 2014 at 10:04:29AM -0800, Junio C Hamano wrote:

> > If it is a problem (and again, I am just guessing), I'd imagine you
> > would need a similar setup to what you proposed for unlink(): before
> > renaming "packed-refs.lock" into "packed-refs", hard-link it into your
> > "trash" area. And you'd probably want to intercept rename() there, to
> > catch all places where we use this technique.
> 
> Also we need to take it into account that it is not an issue unique
> to Git that the server side may expire these .nfsXXXXX entries left
> by an NFS client ("silly rename") to keep files that have been
> removed or renamed away alive.  Aren't there a knob on the NFS
> server end to control how long these are kept unexpired to avoid
> stale filehandle errors, so that not just Git but all applications
> running on NFS client machines will not be hurt by it?
> 
> Working it around at the application program level for each and
> every application that runs on a machine that can NFS mount
> filesystems from elsewhere may be simply madness, no?

Thanks. That is the vague feeling I have about the series, but without
having actually _seen_ the problem or knowing to what extent it affects
git, I didn't want to say anything so definite (e.g., I am only guessing
that rename() is a problem, but from the original description, it sounds
quite plausible that it is).

If this can be fixed outside of git, I very much agree that is the best
path forward.

-Peff
