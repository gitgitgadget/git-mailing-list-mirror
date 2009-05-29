From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: What is the mechanism of a git checkout?
Date: Fri, 29 May 2009 01:15:12 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh1udov.6ls.sitaramc@sitaramc.homelinux.net>
References: <23764024.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 03:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9qhJ-0002ps-7g
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 03:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZE2BPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 21:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbZE2BPc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 21:15:32 -0400
Received: from main.gmane.org ([80.91.229.2]:53507 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbZE2BPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 21:15:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M9qgw-0003ih-9B
	for git@vger.kernel.org; Fri, 29 May 2009 01:15:26 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 01:15:26 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 01:15:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120245>

On 2009-05-28 15:21:59, mastermindxs <mastermindxs@gmail.com> wrote:
>
> does a git checkout pull the contents of a branch? how does it physically
> separate files in your working directory from other branches? 
>
> The speed of which it works leads me to the logical conclusion that the
> files in the working directory are all there for all branches and git simply
> only shows you the files of the active branch.
>
> Can anyone shed more light on the underlying mechanisms of git checkout
> maybe even branch and merge as well?

I explain it as below when I get asked this question.  It's
a simplified answer but largely correct, I believe.
Corrections from git.gods welcome :-)

When you checkout a branch, you are moving from a "before"
branch to an "after" branch.  git does this:

  - untracked files are never touched; the rest of this
    discussion does not apply to them

  - files which do NOT show up in "git status" (ie unchanged
    with respect to the "before" branch) are changed as per
    their status in the "after" branch.

    - if they exist in the "after" branch, and are the same
      as in the "before" branch, they are left alone

      This is where all the speed you see comes from!

    - if they exist in the "after" branch, and they are
      **different** than in the "before" branch, they are
      checked out from the "after" branch

      This is the bulk of the disk activity; if there are
      few of these, it's fast enough for you think nothing
      is actually happening ;-)

    - if they do not exist in the "after" branch, they are
      deleted

  - files that do show up in "git status" in the "before"
    branch, are either modified or staged.
    
    - if the "before" branch version is the same as the
      "after" branch version, that also is not touched.  In
      the new branch, running "git status" will show you the
      same files.

    - if the "before" branch version and the "after" branch
      version are *not* the same, git would lose your local
      (uncommitted) changes, so it refuses to do the
      checkout and stays where it is.
