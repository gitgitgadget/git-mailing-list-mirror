From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 'git gc' always run, on old kernel repo?
Date: Thu, 28 Feb 2008 15:13:31 -0500
Message-ID: <47C715EB.3060303@garzik.org>
References: <47C71233.4050705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 21:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUp8v-00042A-V0
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763062AbYB1UNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762783AbYB1UNf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:13:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51507 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761008AbYB1UNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:13:34 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JUp8G-0006qv-Jl; Thu, 28 Feb 2008 20:13:33 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <47C71233.4050705@garzik.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75440>

Jeff Garzik wrote:
>> [jgarzik@pretzel netdev-2.6]$ git-am --signoff --utf8 /g/tmp/mbox 
>> Applying Add support for HT1100 SATA controller - sent from evolution
>> Auto packing your repository for optimum performance. You may also
>> run "git gc" manually. See "git help gc" for more information.
>> Counting objects: 1, done.
>> Writing objects: 100% (1/1), done.
>> Total 1 (delta 0), reused 0 (delta 0)
>> warning: There are too many unreachable loose objects; run 'git prune' 
>> to remove them.
> 
> IMO there is a broken hueristic in there somewhere...  I regularly run 
> 'git gc' on my repos...


Follow-up...   this is already becoming a PITA.

I am going through and rebasing multiple repos in the same repository... 
and it keeps running 'git gc' on each branch!  grrrr.

Step 1:
pull "../linux-2.6" into master branch of local repo.  this repo was 
created with "--reference".  It _might_ be reasonable to expect 'git gc' 
to be run:

> [jgarzik@pretzel libata-dev]$ git pull ../linux-2.6/
> Updating bfa274e..7704a8b
> Fast forward
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 462, done.
> Compressing objects: 100% (333/333), done.
> Writing objects: 100% (462/462), done.
> Total 462 (delta 345), reused 176 (delta 129)
> warning: There are too many unreachable loose objects; run 'git prune' to remove them.


Step 2:
In the same repo, rebase a branch (contains a single changeset), 
immediately following step #1:

> [jgarzik@pretzel libata-dev]$ git branch
>   ALL
>   NEXT
> * master
>   mv-ahci-pata
>   new-eh
>   sii-lbt
> [jgarzik@pretzel libata-dev]$ git-checkout sii-lbt && git-rebase master
> Switched to branch "sii-lbt"
> First, rewinding head to replay your work on top of it...
> HEAD is now at 7704a8b... Merge branch 'for-linus' of git://oss.sgi.com:8090/xfs/xfs-2.6
> Applying [libata] sata_sil: Turn on Large Block Transfer (LBT) feature
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 4, done.
> Compressing objects: 100% (4/4), done.
> Writing objects: 100% (4/4), done.
> Total 4 (delta 0), reused 0 (delta 0)
> warning: There are too many unreachable loose objects; run 'git prune' to remove them.


Step 3:
Ditto, a second rebase in the same repo, immediately following step #2:

> [jgarzik@pretzel libata-dev]$ git-checkout new-eh && git-rebase master
> Switched to branch "new-eh"
> First, rewinding head to replay your work on top of it...
> HEAD is now at 7704a8b... Merge branch 'for-linus' of git://oss.sgi.com:8090/xfs/xfs-2.6
> Applying [libata #new-eh] sata_sx4: convert to new EH
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 4, done.
> Compressing objects: 100% (4/4), done.
> Writing objects: 100% (4/4), done.
> Total 4 (delta 0), reused 0 (delta 0)
> warning: There are too many unreachable loose objects; run 'git prune' to remove them.


Step 4:
Ditto, a third rebase in the same repo, immediately following step #3:

> [jgarzik@pretzel libata-dev]$ git-checkout mv-ahci-pata && git-rebase master
> Switched to branch "mv-ahci-pata"
> First, rewinding head to replay your work on top of it...
> HEAD is now at 7704a8b... Merge branch 'for-linus' of git://oss.sgi.com:8090/xfs/xfs-2.6
> Applying [libata #mv-ahci-pata] ahci: add rough draft Marvell PATA support
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Counting objects: 5, done.
> Compressing objects: 100% (5/5), done.
> Writing objects: 100% (5/5), done.
> Total 5 (delta 0), reused 0 (delta 0)
> warning: There are too many unreachable loose objects; run 'git prune' to remove them.


Will the 'git gc' never end???

	Jeff



