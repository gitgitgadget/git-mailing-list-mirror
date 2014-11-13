From: Jeff King <peff@peff.net>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 15:06:40 -0500
Message-ID: <20141113200640.GB3869@peff.net>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
 <20141113133615.GA28346@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:06:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp0fG-0003kD-VS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 21:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933911AbaKMUGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 15:06:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:40061 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933146AbaKMUGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 15:06:42 -0500
Received: (qmail 13614 invoked by uid 102); 13 Nov 2014 20:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 14:06:42 -0600
Received: (qmail 30704 invoked by uid 107); 13 Nov 2014 20:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:06:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 15:06:40 -0500
Content-Disposition: inline
In-Reply-To: <20141113133615.GA28346@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 08:36:16PM +0700, Duy Nguyen wrote:

> On Thu, Nov 13, 2014 at 12:32:40PM +0000, Graeme Geldenhuys wrote:
> > [alias]
> >     deploy = !sh -c 'git archive --prefix=$1/ -o deploy_$1.zip HEAD 
> > $(git diff --name-only -D $2)' -
> > 
> > This works very well. The only problem we have so far is that if we 
> > have files with spaces in the name (eg: SQL update scripts), then the 
> > command breaks.
> > 
> > Does anybody have an idea on how this can be resolved?  Any help would 
> > be much appreciated.
> 
> I wonder if it's overkill to do something like this patch ("git
> archive" may need some more updates for it to work though). With it
> you can do:
> 
>   git diff --name-only ... | git archive ... HEAD -- ":(file)-"
> 
> The good thing is it works for other commands as well. But is it
> really a good thing..

I like the idea of taking paths from stdin (and especially if there is a
"-z" option). But using a pathspec that reads from stdin seems like it
creates a lot of corner cases. What would:

  git rev-list --stdin -- ":(file)-"

do? It is kind of neat that you could read from multiple files (besides
stdin), but I'm not sure it is all that useful in practice (you can
always cat them to its stdin).

How about just adding --stdin, which matches other git commands?

-Peff
