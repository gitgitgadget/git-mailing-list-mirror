From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GPG signing for git commit?
Date: Thu, 16 Apr 2009 07:27:28 -0700
Message-ID: <20090416142728.GG23604@spearce.org>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> <20090415192054.GE23604@spearce.org> <20090415T220710Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 16:30:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuSaN-0005kk-Lc
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 16:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZDPO1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 10:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZDPO1a
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 10:27:30 -0400
Received: from george.spearce.org ([209.20.77.23]:50150 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbZDPO13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 10:27:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 030A438211; Thu, 16 Apr 2009 14:27:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090415T220710Z@curie.orbis-terrarum.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116705>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> On Wed, Apr 15, 2009 at 12:20:54PM -0700, Shawn O. Pearce wrote:
> > > Not sure of the best route to trace this data. Signing the SHA1 makes
> > > the most sense, but need to be able to do that without polluting the tag
> > > namespace.
> > Have the PM push over SSH, and don't ever expire reflogs on the
> > central repository?  The reflog will have the old and new commits
> > and the user name of the PM.
>
> All pushing to the central repo will be git+ssh:// anyway.
> 
> I don't follow where the PM's identity is being stored, and how that's
> distributed back out with the later pulls.

Its stored in the reflog for the branch; see "git log -g branch".
Technically the environment variable GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL is used to populate the identity into the reflog,
but if these aren't set then its guessed from the gecos information
of the effective user.
 
> The other downside to relying on SSH presentation of identity directly,
> is the inability to use the SSH key to uniquely identify the user during
> the SSH auth (see designs like gitosis, where you always push to
> git+ssh://git@host/repo).

Uhm, yea.  That's a fault of gitosis then.  It knows the key that
was used, and has that mapped back to some token that identifies that
account in the configuration file.  Why it doesn't push that into the
GIT_COMMITTER_* environment before launching git-shell, I don't know.

<plug type="shameless">

My day-job project, Gerrit Code Review[1], actually does the right
thing by recording the identity of the user in the reflog...

</plug>


[1] http://code.google.com/p/gerrit/

-- 
Shawn.
