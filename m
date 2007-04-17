From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 10:31:20 -0400
Message-ID: <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
References: <4624CD58.90103@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:31:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdoiQ-0005Gf-1F
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 16:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbXDQOb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXDQOb0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 10:31:26 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60092 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030360AbXDQObZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 10:31:25 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 05F801FFC003;
	Tue, 17 Apr 2007 14:31:24 +0000 (UTC)
In-Reply-To: <4624CD58.90103@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44770>


On Apr 17, 2007, at 9:36 AM, Rene Herman wrote:

> Is it possible to switch the current branch without checking it  
> out? Not really essential, but I'm happily flaundering around with  
> git and still start from scratch fairly regularly; to speed this up  
> I've found the -n switch to git clone useful and would like  
> something similar when reconstructing my "branch hierarchies".
>
> Upto now I only know about "git checkout" (with or without -b) to  
> switch the current branch. As said it's not really essential, but I  
> was expecting there would be something like a "branch --switch".  
> Did I overlook it?

Perusing git-checkout points me to git-symbolic-ref to update the  
HEAD ref to a new branch:

git symbolic-ref HEAD refs/heads/<branch>

However, I'm somewhat confused as to why you'd want HEAD and the  
working directory to get out of sync.  It would cause any further  
commits to have broken history information.  If you want to make the  
content of one branch ($branchA) the same as the other ($branchB),  
you should do something like:

git checkout -b temp $branchB    # Get content from branchB
git merge -s ours $branchA       # Merge history (not content) from  
branchA
git branch -M $branchA           # Make this new merge branchA

This would be significantly simpler if there was a "theirs" merge  
strategy "git checkout $branchA; git merge -s theirs $branchB", but  
there isn't.  Should be simple to write if you really need it though.

~~ Brian
