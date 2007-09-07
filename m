From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: very slow cherry-pick'ing (old-2.6-bkcvs tree)
Date: Fri, 07 Sep 2007 09:27:21 +0200
Message-ID: <46E0FD59.2060406@eudaptics.com>
References: <200709062351.l86NpnAK004807@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYFV-0006Bi-Vu
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720AbXIGH1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXIGH1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:27:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54148 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245AbXIGH1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:27:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ITYFO-0007yR-HQ; Fri, 07 Sep 2007 09:27:22 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0D22654D; Fri,  7 Sep 2007 09:27:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200709062351.l86NpnAK004807@agora.fsl.cs.sunysb.edu>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.355, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57996>

Erez Zadok schrieb:
> Our group maintains Unionfs on the latest -rc kernel, but we also maintain
> several backports going all the way to 2.6.9.  Once we complete the
> development and testing of a feature/fix in -latest, we cherry-pick those
> commits to older backports, and test those.  When I cherry-pick from -latest
> to my 2.6.{22,21,20,19,18} repositories, it works reasonably fast.  But when
> I cherry-pick to my 2.6.9 tree, it runs about 20 times slower!  Why?  Is
> there anything I can do to inspect what's going on and perhaps speed up the
> cherry-picking process?
> 
> Some info:
> 
> My 2.6.{18,19,20,21,22} trees were cloned from
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.<N>.y.git
> 
> My 2.6.9 tree, however, was cloned from
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/old-2.6-bkcvs.git
> 
> after which, I truncated the tree (git-reset) to Linus commit which read
> "Linux 2.6.9-final".

I *think* that the reason for this is that those repositories don't have any 
commits in common (but I don't have clones to verify my claim). Since 
cherry-pick does merge-recursive, it tries to find a suitable merge base, 
but since there is no history in common, it walks both histories all the way 
down only to find that there is no possible merge base.

You could improve the situation if you graft the histories together:

   echo $first_commit_in_2.6.12 $suitable_commit_in_bkcvs > .git/info/grafts

-- Hannes
