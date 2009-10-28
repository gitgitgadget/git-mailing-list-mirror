From: Adam Spiers <git@adamspiers.org>
Subject: git svn show-ignore is excrutiatingly slow
Date: Wed, 28 Oct 2009 17:43:07 +0000
Message-ID: <20091028174307.GA5691@atlantic.linksys.moosehall>
Reply-To: Adam Spiers <git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3CzZ-0001wn-9H
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbZJ1SLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbZJ1SLT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:11:19 -0400
Received: from arctic.adamspiers.org ([212.13.194.176]:58792 "EHLO
	arctic.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbZJ1SLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:11:18 -0400
X-Greylist: delayed 1694 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2009 14:11:18 EDT
Received: from localhost (dsl-217-155-199-114.zen.co.uk [217.155.199.114])
	by arctic.adamspiers.org (Postfix) with ESMTP id F08BC2415D
	for <git@vger.kernel.org>; Wed, 28 Oct 2009 17:43:08 +0000 (UTC)
Mail-Followup-To: git mailing list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Linux
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131491>

Something is badly wrong here ...

$ cd $svn_wd
$ time svn propget -R svn:ignore >/dev/null
svn propget -R svn:ignore > /dev/null  0.28s user 0.20s system 98% cpu 0.490 total
$ cd $git_wd
$ time git svn show-ignore > show-ignore.out
git svn show-ignore > show-ignore.out  20.52s user 33.69s system 1% cpu 1:23:42.17 total

That's 10,000 times slower for what is effectively the same source
tree!  Admittedly the svn propget was a "warm" run and took longer the
first time around, but even so there are several orders of magnitude
difference.

I had a quick look at the code and it seemed to be doing the svn tree
recursion itself via Git::SVN::prop_walk(), which might explain why.
However I did not have time to dig deeper, so would welcome any ideas.

Thanks,
Adam
