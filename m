From: Jeff King <peff@peff.net>
Subject: Re: List tags for a certain branch
Date: Sun, 23 Aug 2015 13:07:52 -0400
Message-ID: <20150823170751.GA24194@sigill.intra.peff.net>
References: <55D9E672.4050503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: CoDEmanX <codemanx@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:08:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTYkr-0001Hh-Uw
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 19:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbbHWRIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 13:08:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:48751 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752195AbbHWRHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 13:07:54 -0400
Received: (qmail 27131 invoked by uid 102); 23 Aug 2015 17:07:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 12:07:54 -0500
Received: (qmail 16118 invoked by uid 107); 23 Aug 2015 17:07:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 13:07:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Aug 2015 13:07:52 -0400
Content-Disposition: inline
In-Reply-To: <55D9E672.4050503@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276412>

On Sun, Aug 23, 2015 at 05:27:46PM +0200, CoDEmanX wrote:

> the question how to list tags, that point to commits contained in a certain
> branch came up on StackOverflow couple times, and this appears to be the
> only fast solution (example for local devel branch):
> 
>     git log --simplify-by-decoration --decorate --pretty=%d
> "refs/heads/devel" | fgrep 'tag: '
> 
> It would be much much simpler, if the tag command supporter an optional
> parameter to specify a branch:
> 
>     git tag --list --branch devel
> 
> It should result in something like:
> 
> Test-Tag1
> Test-Tag2
> Test-Tag3
> Another-Tag
> And-Another

I think the option you are looking for is "--merged", which currently
only the "branch" command nows about. So right now you can do:

  git branch --merged devel

to get a list of branches that are contained in "devel". There is work
underway to unify the selection/filter code for git-branch and git-tag,
so in a future version of git you should be able to do "git tag
--merged" to get the tags that are "merged" to a particular branch.

-Peff

PS I'm not sure if we should pick a more generic name than "--merged"
when git-tag learns this feature. For branches, it makes sense to ask
"which branches are merged to this other branch". But the operation is
really "which items are ancestors of the commit I gave". It is the
opposite of "--contains" in that sense. Sort of a "--contained-in".
