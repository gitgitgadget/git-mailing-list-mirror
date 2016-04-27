From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/29] refname_is_safe(): insist that the refname already
 be normalized
Date: Wed, 27 Apr 2016 16:37:29 -0400
Message-ID: <20160427203728.GA8364@sigill.intra.peff.net>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
 <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
 <1461787832.11504.1.camel@twopensource.com>
 <20160427201512.GA8073@sigill.intra.peff.net>
 <1461789293.11504.5.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:37:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWDJ-0004sc-N6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbcD0Uhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:37:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:57886 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752486AbcD0Uhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:37:32 -0400
Received: (qmail 3836 invoked by uid 102); 27 Apr 2016 20:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 16:37:31 -0400
Received: (qmail 2114 invoked by uid 107); 27 Apr 2016 20:37:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 16:37:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 16:37:29 -0400
Content-Disposition: inline
In-Reply-To: <1461789293.11504.5.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292819>

On Wed, Apr 27, 2016 at 04:34:53PM -0400, David Turner wrote:

> > I thought the point is that one is a lesser check than the other, and
> > we
> > need different rules for different situations. So we might allow
> > deletion on a refname that does not pass check_refname_format(), but
> > we
> > must make sure it is not going to cause any mischief (e.g., escaping
> > ".git" and deleting random files).
> > 
> > But anything writing a _new_ refname (whether the actual ref, or
> > referencing it via a symref) should be using check_refname_format()
> > before writing.
> 
> Unfortunately, neither check is lesser -- refname_is_safe allows
> refs/heads//foo but not a/b while check_refname_format allows a/b but
> not refs/heads//foo.  So sometimes we need both, while other times we
> just need one :(

IMHO, that sounds like a bug. check_refname_format() should
conceptually[1] be a superset of refname_is_safe(). Is there a case
where we would want to _allow_ a refname that is not safe to look at on
disk?

-Peff

[1] The implementation can be a direct call, or can simply implement a
    superset of the rules, if that's more efficient.
