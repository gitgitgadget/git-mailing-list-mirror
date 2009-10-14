From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Efficient cloning from svn (with multiple branches/tags
	subdirs)
Date: Wed, 14 Oct 2009 11:00:17 -0700
Message-ID: <20091014180013.GA24741@dcvr.yhbt.net>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net> <32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8Bs-00029q-LL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbZJNSA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbZJNSA7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:00:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45893 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZJNSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:00:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 5B3AB1F92E;
	Wed, 14 Oct 2009 18:00:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130310>

Avery Pennarun <apenwarr@gmail.com> wrote:
> On Wed, Oct 14, 2009 at 2:03 AM, Eric Wong <normalperson@yhbt.net> wrote:
> > Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk> wrote:
> >> What surprises me is that it looks like it's looping over and over,
> >> since sometimes it starts back from SVN revision 1 when it's trying to
> >> import a new tag.
> >
> > Yeah, that's an unfortunate thing about the flexibility of Subversion,
> > basically anything can be a "tag" or a directory and it's extremely
> > hard for git svn to support any uncommon cases for tags/branches
> > out-of-the box, so the manual config editing is needed.
> 
> I've been thinking about this myself for some time.  One option that
> might be "interesting" would be to just grab the *entire* svn tree
> (from the root), and then use git-subtree[1] to slice and dice it into
> branches using your local copy of git (which is fast and uses no
> bandwidth) instead of during the svn fetch (which is slow and uses
> lots of bandwidth).  I think it would also simplify the git-svn code
> quite a lot, at least for fetching, since there would always be a
> global view of the tree and SVN things like "copy branch A to tag B"
> would just be exactly that.
> 
> Of course I have no time to code this up myself, so I apologize for
> just dumping ideas on you without code behind them.  If this inspires
> anyone, I'd be happy to help with any missing features (or
> documentation) this exposes in git-subtree, though.

This was actually the original use case of git svn back when I started.

  git svn clone SVNREPO_ROOT   (without --stdlayout)

It's still an option if you have the disk space for the working copies,
but I had to create the branches/tags support since the working copies
would be become prohibitively large.  If git-subtree could be
taught to work on a bare repo (git svn has a --no-checkout option)
it might be an option, too.

> Have fun,
> 
> Avery
> 
> [1] http://github.com/apenwarr/git-subtree

-- 
Eric Wong
