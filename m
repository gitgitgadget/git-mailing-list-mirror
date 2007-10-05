From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Problems using StGit and -rt kernel patchset
Date: Fri, 05 Oct 2007 14:45:21 +0100
Message-ID: <1191591921.7321.63.camel@pc1117.cambridge.arm.com>
References: <4703A4EE.3000002@gmail.com>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 15:45:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdnUl-00019h-EP
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 15:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbXJENp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 09:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbXJENp0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 09:45:26 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45177 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593AbXJENpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 09:45:25 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l95DjMhX002562;
	Fri, 5 Oct 2007 14:45:22 +0100 (BST)
Received: from [10.1.79.3] ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Oct 2007 14:45:22 +0100
In-Reply-To: <4703A4EE.3000002@gmail.com>
X-Mailer: Evolution 2.10.1 
X-OriginalArrivalTime: 05 Oct 2007 13:45:22.0060 (UTC) FILETIME=[F98F6CC0:01C80755]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60082>

Clark,

What version of StGIT are you using? You might use a too new GIT with an
older StGIT or maybe there are just some bugs in StGIT.

On Wed, 2007-10-03 at 09:19 -0500, Clark Williams wrote:
> I've been working on the -rt patch series for the kernel and would like to to use
> StGit to manage the patches. Unfortunately I've had limited success, so I thought I'd
> ask the git/stgit community if what I'm doing is wrong.
> 
> I clone Linus's tree to a common directory, then clone it locally to work:
> 
> $ git clone -s -l /home/src/linux-2.6.git scratch.git
> $ cd scratch.git
> $ stg init
> $ stg branch --create rt-2.6.23-rc8-rt1 v2.6.23-rc8
> $ stg import --series --ignore --replace ../sources/patch-queue-2.6.23-rc8-rt1/series
> <fix the things quilt lets through and stg barfs on, like malformed email addresses>

If git-quiltimport behaves better with malformed patches, use it and run
'stg uncommit -n 368' afterwards (the 'uncommit' takes some other useful
options as well, see --help).

> <watch 368 patches be applied and committed>
> <work work work>

Do you modify any of the -rt patches or you create new ones?

> <get a new patch queue>
> $ (cd /home/src/linux-2.6.git && git pull)
> $ stg pull
> $ stg branch --create rt-2.6.23-rc8-rt1 v2.6.23-rc9
> $ stg import --series --ignore --replace ../sources/patch-queue-2.6.23-rc9-rt1/series
> Checking for changes in the working directory ... done
> stg import: env git-commit-tree 520b9d0db6a1142271a68b2b38cca002be40f6cb -p
> da0a81e98c06aa0d1e05b9012c2b2facb1807e12 failed (fatal:
> da0a81e98c06aa0d1e05b9012c2b2facb1807e12 is not a valid 'commit' object)

I'm not sure why the first import worked. It seems that StGIT uses the
tag id (da0a81e9) rather than the corresponding commit id (3146b39c). I
remember having this problem in the past when creating branches and I
fixed StGIT to always get the corresponding commit id. Using
'v2.6.23-rc9^{commit}' as the 'branch' argument rather than just the tag
should fix the problem.

> At this point I'm clueless as to:
> 
> 1. What I've done wrong

Probably nothing (just hidden features of StGIT :-))

> 2. How to recover/debug this

You can recreate the branch with the commit rather than tag id. With a
sufficiently new StGIT, you could use 'stg rebase <id>' on the branch. I
assume that no patch was pushed because import failed (though the first
imported patch might be in an undefined state and can be removed).

Catalin
