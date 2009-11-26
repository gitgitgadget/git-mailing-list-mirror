From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit-dev] Re: jgit problems for file paths with non-ASCII
	characters
Date: Wed, 25 Nov 2009 16:54:23 -0800
Message-ID: <20091126005423.GM11919@spearce.org>
References: <4B0D356D.1080709@syntevo.com> <200911252211.55137.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: EGit developer discussion <egit-dev@eclipse.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDScw-0004c7-CD
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759347AbZKZAyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757404AbZKZAyS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:54:18 -0500
Received: from george.spearce.org ([209.20.77.23]:36455 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbZKZAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:54:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 956B93842F; Thu, 26 Nov 2009 00:54:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200911252211.55137.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133744>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> onsdag 25 november 2009 14:47:25 skrev  Marc Strapetz:
> > I have noticed that jgit converts file paths to UTF-8 when querying the
> > repository.
...
> > Is this a bug or a misconfiguration of my repository? I'm using jgit
> > (commit e16af839e8a0cc01c52d3648d2d28e4cb915f80f) on Windows.
> 
> A bug. 
> 
> The problem here is that we need to allow multiple encodings since there
> is no reliable encoding specified anywhere.

This is a design fault of both Linux and git.  git gets a byte
sequence from readdir and stores that as-is into the repository.
We have no way of knowing what that encoding is.  So now everyone
touching a Git repository is screwed.

> The approach I advocate is
> the one we use for handling encoding in general. I.e. if it looks like UTF-8,
> treat it like that else fallback. This is expensive however

We should try to work harder with the git-core folks to get character
set encoding for file names worked out.  We might be able to use a
configuration setting in the repository to tell us what the proper
encoding should be, and if not set, assume UTF-8.

> and then we have
> all the other issues with case insensitive name and the funny property that
> unicode has when it allows characters to be encoding using multiple sequences
> of code points as empoloyed by Apple.

But as you said, this still doesn't make the Apple normal form
any easier.  Though if we know we are on such a strange filesystem
we might be able to assume the paths in the repository are equally
damaged.  Or not.

-- 
Shawn.
