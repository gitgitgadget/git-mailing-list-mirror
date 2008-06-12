From: "David A. Greene" <greened@obbligato.org>
Subject: git-svn for vendor branches?
Date: Thu, 12 Jun 2008 14:59:04 -0500
Message-ID: <200806121459.12570.greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 22:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tQ3-0002cL-0B
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbYFLU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755790AbYFLU2R
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:28:17 -0400
Received: from mail1.cray.com ([136.162.0.111]:33469 "EHLO mail1.cray.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755775AbYFLU2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:28:17 -0400
X-Greylist: delayed 1717 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 16:28:16 EDT
Received: from beaver.us.cray.com (beaver.us.cray.com [172.30.74.51])
	by mail1.cray.com (8.13.6/8.13.3/gw-5323) with ESMTP id m5CJxbwB010655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 14:59:38 -0500 (CDT)
Received: from CFEXFE01.us.cray.com (cfexfe01.us.cray.com [172.30.74.93])
	by beaver.us.cray.com (8.13.8/8.13.3/hub-5273) with ESMTP id m5CJxanN010047
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 14:59:36 -0500
Received: from transit.us.cray.com ([172.31.17.53]) by CFEXFE01.us.cray.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Jun 2008 14:59:36 -0500
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-OriginalArrivalTime: 12 Jun 2008 19:59:36.0066 (UTC) FILETIME=[D6E01620:01C8CCC6]
X-Cray-VirusStatus: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84786>

I've been reading some things about git-svn and am wondering if it could be
used to manage vendor branches where both the upstream and local
repositories are in svn (don't ask, I didn't set this stuff up).

My situation looks something like this:

upstream repo (svn)
  trunk
  tags
    release-1.0
    release-1.1
    release-1.2
    ...
  branches
    release-1.0
    release-1.1
    release-1.2
    ...

local repo (svn, copy of upstream via svn_load_dirs)
  trunk
  tags
  branches
    release-5.6
    release-5.7
    ...

In the past, we have updated our local trunk from the upstream trunk via 
svn_load_dirs/svnmerge.  This works ok.  Not good by any means but it's
at least functional.

The problem really gets unsolvable with svn when you start looking at 
merging from upstream *branches.*  In that case, what's in the branch/tag
is something that appears nowhere on the upstream trunk.  At some point
it was branched from trunk and stuff was cherry-picked into it from trunk as
bugs were fixed for release.  So one can't just do an svn_load_dirs from
trunk at the point of the branch/tag.  And one can't svn_load_dirs from a
release branch and then svn_load_dirs from trunk later because svn_load_dirs
by its very nature aggregates lots of individual revisions into one giant one.
There's no way to do the merge without a horrible number of conflicts, most
of which are spurious.

We really do need to merge from a release branch into our local repository
and in the future do merges from later release branches or from trunk.

If everything was in git, this would all be nearly trivial.

But it's not and I have to deal with it.

Now, there is a git mirror of the upstream repository, presumably kept in
sync via git-svn.  So my question is, can I somehow do a git-clone of this
repository and then use git-svn to "bounce" it into our local svn repository
to do merges?  My reading so far tells me "no" but I wanted to check with
the gurus.  I believe git-svn only knows about one svn repository and in
this case it would be the upstream svn that feeds the public git mirror.

I don't know how people handle this kind of need with svn.

Thanks for your help!

                              -Dave
