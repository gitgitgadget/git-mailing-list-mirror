From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] remote.c: drop "remote" pointer from "struct branch"
Date: Tue, 31 Mar 2015 18:24:31 -0400
Message-ID: <20150331222431.GB31948@peff.net>
References: <20150331173339.GA17732@peff.net>
 <20150331173555.GB18912@peff.net>
 <xmqqvbhgq4ci.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:24:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4aN-0006jX-0A
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbCaWYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:24:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:40689 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751668AbbCaWYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:24:34 -0400
Received: (qmail 30033 invoked by uid 102); 31 Mar 2015 22:24:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 17:24:34 -0500
Received: (qmail 29295 invoked by uid 107); 31 Mar 2015 22:24:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 18:24:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 18:24:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbhgq4ci.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266567>

On Tue, Mar 31, 2015 at 01:50:05PM -0700, Junio C Hamano wrote:

> > Getting rid of it drops one potential source of confusion:
> > is the value the match for "remote_name", or is it the
> > remote we would fetch from when on that branch (i.e., does
> > it fall back to "origin")?
> 
> I had to read the above three times before I realized that you were
> wondering "what is the value of this 'remote' field?  is it what
> remote_get() would give us for 'remote_name' and is NULL if
> remote_name is not set, or is it never NULL and instead have the
> remote for 'origin' if remote_name is not set?"
> 
> But perhaps it is just me.
> 
> We certainly have duplicated information between the two fields, and
> it first looked somewhat unnatural that you kept the name with which
> you need to trigger a search for the structure, instead of keeping
> the structure, one of whose field is its name already.  Perhaps
> there was a valid reason behind this choice, and I am guessing that
> it is probably because it will not let you differenciate the case
> where the user explicitly said 'origin' and we used 'origin' as a
> fallback, if you keep a "remote" field that stores the instance of
> the remote structure for 'origin' without keeping "remote_name".

That is the reason I was trying to explain above. Though I suppose you
could argue that remote_name suffers the same question (i.e., would we
ever set it to "origin"?)

It is much worse for pushremotes, which can come from
branch.*.pushremote, remote.pushdefault, branch.*.remote, or "origin".

I'll try to re-word the commit message.

-Peff
