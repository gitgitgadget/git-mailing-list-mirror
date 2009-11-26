From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit-dev] Re: jgit problems for file paths with non-ASCII
	characters
Date: Thu, 26 Nov 2009 12:03:35 -0800
Message-ID: <20091126200335.GW11919@spearce.org>
References: <4B0D356D.1080709@syntevo.com> <200911252211.55137.robin.rosenberg@dewire.com> <20091126005423.GM11919@spearce.org> <4B0E8FF2.8040206@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: EGit developer discussion <egit-dev@eclipse.org>,
	git@vger.kernel.org, robin.rosenberg@dewire.com
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 21:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDkZ3-0002LQ-Mo
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 21:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZKZUDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbZKZUDa
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 15:03:30 -0500
Received: from george.spearce.org ([209.20.77.23]:54321 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbZKZUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 15:03:29 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D77703842F; Thu, 26 Nov 2009 20:03:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B0E8FF2.8040206@syntevo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133829>

Marc Strapetz <marc.strapetz@syntevo.com> wrote:
> > We should try to work harder with the git-core folks to get character
> > set encoding for file names worked out.  We might be able to use a
> > configuration setting in the repository to tell us what the proper
> > encoding should be, and if not set, assume UTF-8.
> 
> I agree that this should be the ultimate goal, though the default should
> better be "system encoding" for compatibility with current git
> repositories and instead have newer git versions always set encoding to
> UTF-8. Thus, for our jgit clone I've introduced a system property to
> configure Constants.PATH_ENCODING set to system encoding. It's used by
> PathFilter and this resolves my original problem.

That's probably a good point, using the system encoding on a
repository may produce the file names in a more compatible way
with git-core.  But we probably don't want the encoding to be a
single encoding constant in this JVM, we probably need to support
a per-repository configuration of the encoding for path names so
that we can eventually move to a non-platform specific encoding.

> I have tried to switch more usages from Constants.CHARACTER_ENCODING to
> Constants.PATH_ENCODING, but ended up in confusion due to my lack of
> understanding: primarily because I couldn't tell anymore whether encoded
> strings were file names or not.

Heh.  Yea.  There are a number of file name encoding sites.  I think
everything in the treewalk package, as well as the GitIndex, Tree and
DirCache* classes.  Also the Patch class and its FileHeader friend.

> Does it make sense to explicitly
> distinguish encoding usages in that way? We could try to contribute here
> (and hopefully cause less review effort to jgit developers than the
> changes itself are worth ;-)

Yes, it does.  Because we eventually need to support encodings
other than the current UTF-8 we assume for file names, especially
if a repository is using the local filesystem encoding and that
isn't UTF-8.

-- 
Shawn.
