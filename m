From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/19] Add git-list-files
Date: Tue, 2 Dec 2014 15:18:38 -0500
Message-ID: <20141202201837.GC23461@peff.net>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
 <20141202054226.GA1948@peff.net>
 <CACsJy8DBkGVhaJnCTs9_E+g6FYYr4V-6S=XB5wrGBFPjHnEu1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 21:18:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvtuI-0002TT-EX
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 21:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221AbaLBUSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 15:18:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:47370 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933219AbaLBUSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 15:18:37 -0500
Received: (qmail 28321 invoked by uid 102); 2 Dec 2014 20:18:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 14:18:36 -0600
Received: (qmail 18436 invoked by uid 107); 2 Dec 2014 20:18:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 15:18:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 15:18:38 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DBkGVhaJnCTs9_E+g6FYYr4V-6S=XB5wrGBFPjHnEu1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260592>

On Tue, Dec 02, 2014 at 06:45:52PM +0700, Duy Nguyen wrote:

> > As a side note, I wonder if it would be sensible to whitelist some
> > commands as porcelain, and allow aliases to override them (either
> > entirely, or just to add-in some options).
> 
> Agreed. Maybe not all porcelain (some like git-branch almost functions
> like plumbing).

Yeah, many things straddle the plumbing/porcelain line (e.g., "commit"
is porcelain, but it's basically the only sane way for scripts to make a
commit, so many use it). So I'd pick just a few things that should be
safe to override.

> We also need away to stop alias (e.g. in scripts).

Do we? I think the point of allowing this only for porcelain is that you
do not have to care about scripts. That is, a script running "git ls"
would get whatever the user's preferences are for "ls" output. A script
parsing the output of "ls" deserves whatever crap it gets.

> In scripts I can specify full path to a command to make sure I won't
> hit an alias. I guess we can't do the same here. The closet to "full
> path" is git-cmd form, as opposed to "git cmd" form) but I think we
> don't want to bring back git-cmd. Maybe just a "git --no-alias cmd"
> and GIT_NO_ALIAS..

Yeah, I think "--no-alias"/GIT_NO_ALIAS would work. But the problem is
one of compatibility. Scripts are not written to specify no-alias, so
you cannot just turn on the override-commands-with-aliases feature
immediately (and likewise, scripts have little incentive to bother
annotating their calls if it the override feature is not enabled).

-Peff
