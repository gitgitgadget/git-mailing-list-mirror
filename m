From: Jeff King <peff@peff.net>
Subject: Re: git-fetch: default globally to --no-tags
Date: Wed, 19 Nov 2014 15:32:09 -0500
Message-ID: <20141119203208.GA11053@peff.net>
References: <20141119030523.GO22361@norris-Latitude-E6410>
 <xmqqr3wzrpur.fsf@gitster.dls.corp.google.com>
 <20141119185708.GA9908@peff.net>
 <xmqqa93nrldf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:32:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrBvG-0006EG-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483AbaKSUcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:32:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:42463 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756694AbaKSUcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:32:10 -0500
Received: (qmail 29405 invoked by uid 102); 19 Nov 2014 20:32:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 14:32:10 -0600
Received: (qmail 7321 invoked by uid 107); 19 Nov 2014 20:32:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 15:32:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 15:32:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa93nrldf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 12:22:36PM -0800, Junio C Hamano wrote:

> With a separate local-tags hierarchy, the look-up part still has to
> be enhanced.  After doing "git tag v2.0" and "git tag -l snapshot00",
> you would want to be able to say "git log snapshot00..v2.0" and have
> these found.
> 
> If you don't allow a private local-tags hierarchy, then those who
> make releases are burdened to be very careful not to contaminate
> their public repository --- "git tag snapshot00" cannot be used by
> them lightly just to mark their private state, if their day
> typically is concluded with "git push --follow-tags", as that will
> push out the "tags" that are meant to be private.

It's not that I want to disallow a private local-tags hierarchy. It's
just that I consider it a completely orthogonal feature. In other words,
the problem of tags in a global namespace is not solved at all by
local-tags. It just helps people keep things out of the global namespace
that they did not want to be there in the first place[1]. It does
nothing for viewers who need to coalesce multiple global tag namespaces
(either from multiple projects, or "proposals" of global tags they have
pulled in from other non-canonical repositories).

> > But the superproject is pulling them both together; if it uses
> > refs/tags, the global namespaces will clash. Instead, it would be more
> > convenitn to have refs/remotes/project1/tags and so on.
> 
> Yeah, but isn't it an orthogonal issue?  refs/tags/project{1,2}/*
> would be what I would recommend to use for "global" stuff whose
> purpose is to give people a shared world view.

How do they get that split? They cannot use tag auto-following, which
puts the tags in the global refs/tags.

Certainly it can be done with git _today_ by setting up the appropriate
refspecs. I think this is more about making things useful out of the
box. 

-Peff

[1] I am actually not convinced that the mixing of local and global tags
    is a huge problem in practice. We do not push tags by default, so
    local tags tend to stay local. OTOH, I think the world would be a
    better place if "git push --follow-tags" were the default, which
    would entail somehow separating global from local tags.
