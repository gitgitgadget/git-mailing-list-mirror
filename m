From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn: Supporting multiple branch subdirs?
Date: Sat, 13 Jun 2009 13:46:10 +0200
Message-ID: <4A339182.1090204@drmicha.warpmail.net>
References: <4A32CCA5.7040404@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, normalperson@yhbt.net
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFRhh-0005qK-2h
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZFMLrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbZFMLrG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:47:06 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47379 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751255AbZFMLrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 07:47:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AD748357333;
	Sat, 13 Jun 2009 07:47:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 13 Jun 2009 07:47:06 -0400
X-Sasl-enc: cElGPBW9o4fKkfJjZe3N16HShLMrc1S1eTxg7a85hc5N 1244893626
Received: from localhost.localdomain (p5485A135.dip0.t-ipconnect.de [84.133.161.53])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C851C39B67;
	Sat, 13 Jun 2009 07:47:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A32CCA5.7040404@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121499>

Marc Branchaud venit, vidit, dixit 12.06.2009 23:46:
> Hi,
> 
> I believe I need git-svn to support multiple branch subdirectories.
> 
> The motivation for this is the (partial) gitification of the FreeBSD subversion repository.  FreeBSD doesn't follow the usual branches/tags/trunk pattern.  Instead:
> 
> - FreeBSD's /trunk is called /head.
> 
> - /head is branched into /stable/X subdirs.
> 
> - Each /stable/X branch is sub-branched into /releng/X.Y subirs.
> 
> - /releng/X.Y.Z branches are tagged under /release/foo.
> 
> I'm only looking to get an updatable mirror of their repo -- I don't (yet) need to push changes back to FreeBSD.
> 
> I'd like to modify git-svn to support multiple (at least two) -b parameters, so I could import the FreeBSD repo with something like
> 	git svn init --trunk=head \
> 		--branches=stable \
> 		--branches=releng \
> 		--tags=release \
> 		file:///local/mirror/of/svn.freebsd.org/base/
> 	git svn fetch
> 
> Is this approach wise or even feasible?  A couple of possible show-stoppers I see are:

After doing the init with "--branches=stable" (without releng), do
git config --add svn-remote.svn.branches 'releng/*:refs/remotes/*'

This gives you two branches refspecs in .git/config (feel free to put
them in different dirs under remotes if there may be name clashes
between stable and releng branches).

> 
> - The releng/X.Y branches are created from the stable/X  tree, where X itself doesn't exist from the start.

Well, I assume X exists at the time of creation of X.Y. That's all that
is needed.

> 
> - FreeBSD likes to make single commits that spans multiple branches.  This is usually done as a security patch: One commit can, for example, touch /head, /stable/X, /stable/W, and several branches under /releng.

I assume that git-svn converts such an svn commit into several git
commits, one for each affected branch. Since you have a local mirror
it's easy to try out.

> 
> If this isn't completely off the wall, I'd appreciate some pointers on the git-svn.perl code.  I've tried searching through the code to see how the -b parameter is handled, but I got lost pretty quickly.  How does the fetch command deal with branches?

I think there's no need to hack git-svn. Let us know how it goes with
the two branches configs.

Michael
