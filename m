From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Fri, 16 Oct 2009 07:31:54 -0700
Message-ID: <20091016143154.GS10505@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <ca433830910152120l1bd358ads6401572ccc05b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:34:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynsJ-0004ff-OS
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760447AbZJPOcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760403AbZJPOca
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:32:30 -0400
Received: from george.spearce.org ([209.20.77.23]:45859 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760235AbZJPOca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:32:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 29650381FF; Fri, 16 Oct 2009 14:31:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ca433830910152120l1bd358ads6401572ccc05b29@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130500>

Mark Lodato <lodatom@gmail.com> wrote:
> On Wed, Oct 14, 2009 at 11:36 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > This series is still lacking:
> >
> > ??* The HTTP protocol documentation
> > ??* Tests for the smart http transport code (existing tests pass)
> 
> * Dumb HTTP push support

I'm not interested in implementing a WebDAV server.  13 years
ago when WebDAV was the new shiny I considered it.  Today, bleh,
no desire.
 
> It would be really nice if git-http-backend supported dumb pushing
> over WebDAV.  Currently, to support both smart and dumb pushing, one
> has to configure Apache in a very awkward and confusing way (if it is
> even possible - I'm still trying to figure it out).

Sure, its confusing, its one reason nobody uses it.  Another is
that pushing over WebDAV is slow and error prone, locks get taken
and have to get released, its a general mess.

> Without some way
> to support older clients, it will be very hard to transition to the
> new protocol.

Why?

Smart HTTP is primarily about improving the situation for a client
fetching from the server.  If the server happens to allow writes,
users will just have to upgrade to a new enough version of Git that
understands the push variant of the protocol.

If users don't want to upgrade, or can't upgrade, then you can't
push over HTTP.  Simple.

Really, what it comes down to is, I don't think it matters that
we don't have backwards compatiblity for pushing through WebDAV.
If you think it matters, you are free to write a patch series on
top of mine which adds the functionality.  But don't wait for me
to do it, it won't happen.
 
> Also, your examples use "DocumentRoot /pub/git", but I think most
> people would want to have their main website as the DocumentRoot, have
> the URL "/git" serve the repositories through gitweb, and have that
> same "/git" URL be `git clone'-able.

Why not have git-http-backend exec gitweb when it gets a request
for the repository itself?  Why do you have to go through such
contortions in Apache for this?  The two CGIs are shipped in the
same software package, surely one could actually invoke the other.

> The Apache configuration for
> this is complicated and non-intuitive, so I think an example of this
> in the documentation is warranted.  The following accomplishes what I
> describe, except it does not work with dump HTTP push, and does not
> allow anonymous read-only access.  (I am currently trying to figure
> out how to do both of these things.)

Yes, I'd like to have examples in the git-http-backend manpage.
I put a couple in there already, but they don't consider gitweb
because I assumed we'd find a way to have gitweb be invoked out
of git-http-backend.  Unfortunately that hasn't happened yet.
 
-- 
Shawn.
