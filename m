From: Swanny Lorenzi <swanny@jfg-networks.net>
Subject: error: Untracked working tree file '(myfile)' would be overwritten
 by merge. when checking out a more recent branch
Date: Mon, 30 Jun 2008 12:15:56 +0200
Message-ID: <4868B25C.1030005@over-blog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 12:17:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDGRg-0004cc-JU
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 12:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759884AbYF3KQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 06:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759314AbYF3KQB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 06:16:01 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:47818 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbYF3KQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 06:16:00 -0400
Received: by gv-out-0910.google.com with SMTP id e6so155007gvc.37
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 03:15:58 -0700 (PDT)
Received: by 10.103.16.16 with SMTP id t16mr2139842mui.131.1214820957822;
        Mon, 30 Jun 2008 03:15:57 -0700 (PDT)
Received: from ?192.168.0.110? ( [82.224.249.154])
        by mx.google.com with ESMTPS id j9sm21447449mue.5.2008.06.30.03.15.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 03:15:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86901>

Hi,

We got at work a surprising error when trying to checkout a more recent 
branch :
error: Untracked working tree file '(file)' would be overwritten by 
merge. (I replaced the actual file name by 'file' in this mail)

The context is :
- Each developer has its own git repository, and makes all developement 
work in it
- We use a "central" git repository to gather all our work, all devs 
track this common repository's branches to pull and push they work.
- We don't allow devs to track another dev branch, everything must pass 
by this central repository.
- We use git v 1.5.5.4, tig and git gui.
- Our main branch is called "trunk", and we use several other branches 
for our work.


Last Thursday, I had to replace 6 directories (with files in them) by 
symbolic links to another directory, in the "trunk" branch.
I removed them using sh rm -rf, then ln -s to create the links. Problem, 
git gui failed to stage the changes to a single commit.
I split the change into 2 operations : the directory removal -> commit, 
then the symlink creation -> commit.
I pushed the 2 commits - and other commits after - into our central 
repository, no error was prompted.

Then came the issue :
Each time a dev tried to checkout the trunk branch from an older version 
(e.g. a branch that has its origin to an older commit of trunk), he got 
the error message
error: Untracked working tree file '(file)' would be overwritten by merge.
=> Checkout failed, etc. Obliged to force the checkout with git checkout -f.

- The file listed in the error message is absolutely not affected by any 
commit in the 2 I mentioned above, nor in the 10 surrounding them. It 
was not even changed for 2 monthes.
- The error occur even if we don't have any "modified" file (git status 
answers nothing to commit, nor any untracked files)
- After investigations, it seems that the error occurs each time we ask 
git to run the 2 commits mentioned above in a single checkout command : 
If I checkout a branch pointing to the 1st commit (dir deletion), then 
another checkout to the trunk head, the error does not occur.
- The file mentioned in the error is the first file in the directory 
that follow the parent dir of the removed dirs (in the order returned by 
ls):

- I failed to reproduce this bug using clean repositories...

Has anyone got this error before ?
Is it a git bug ?

Thanks for all

Swanny
