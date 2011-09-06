From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Tue, 6 Sep 2011 10:00:03 -0400
Organization: White Oak Technologies
Message-ID: <20110906100003.4c87daba@robyn.woti.com>
References: <20110902140702.066a4668@robyn.woti.com>
	<4E612319.7030006@vilain.net>
	<20110902144922.383ed0f1@robyn.woti.com>
	<4E6127F5.5070009@vilain.net>
	<20110902154206.331b80e9@robyn.woti.com>
	<4E614AE7.7090706@vilain.net>
	<20110903084947.GA16711@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 16:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0wCF-0000K3-US
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 16:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab1IFOAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 10:00:09 -0400
Received: from mail02.woti.us ([66.92.158.6]:58519 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754626Ab1IFOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 10:00:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 87D53504D37EA;
	Tue,  6 Sep 2011 10:00:06 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYNgm8KxZcAc; Tue,  6 Sep 2011 10:00:04 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 19317504D37ED;
	Tue,  6 Sep 2011 10:00:04 -0400 (EDT)
In-Reply-To: <20110903084947.GA16711@dcvr.yhbt.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180801>

On Sat, 3 Sep 2011 08:49:47 +0000
Eric Wong <normalperson@yhbt.net> wrote:

> dcommit needs to continually rebase because it's possible somebody
> else may make a commit to the SVN repo while a git-svn user is
> dcommiting and cause a conflict the user would need to resolve in the
> working tree.
> 
> At least I think that was the reason...  There is also the
> "commit-diff" command in git-svn.  It was the precursor to dcommit
> which requires no changes to the working tree.
> 

Let me see if I've got this right.

The goal here is to commit each x~..x for each x in A..B, aborting if
the SVN tree is not in state "x~" when the diff arrives.

"commit-diff" appears to be doing exactly what "dcommit" is doing, but
iteratively for each change in linearized A..B, rebasing after each
step. This sounds correct to me, assuming that the "apply_diff" method
will correctly abort if a commit races into the upstream SVN before it
is called. So why am I seeing files added in changes on alternate
branches ending up in the working copy when I abort before apply_diff
is called for the commit which merges them into the present branch?

You can check for this yourself with my patch using the example setup I
gave earlier. You'll see files in the present/untracked state - these
interfere with rebasing the user-created-but-not-SVN-dcommited merge
onto the partially-sent-to-SVN tree.

Bryan Jacobs
