From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Problems pushing???
Date: Sun, 08 Jul 2012 23:20:25 +0200
Message-ID: <4FF9F999.9030808@ira.uka.de>
References: <1341738766823-7562695.post@n2.nabble.com> <4FF97463.90002@ira.uka.de> <1341759063006-7562705.post@n2.nabble.com> <1341762216101-7562707.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pbGit <pblakeley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnyuE-00070a-S9
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 23:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab2GHVUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 17:20:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52002 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752431Ab2GHVUd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jul 2012 17:20:33 -0400
Received: from dslb-088-066-042-202.pools.arcor-ip.net ([88.66.42.202] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1Snyu1-0002cc-M5; Sun, 08 Jul 2012 23:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1341762216101-7562707.post@n2.nabble.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1341782431.171065000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201184>

Am 08.07.2012 17:43, schrieb pbGit:
> Just tried starting again on my local machine because when I tried pushing,
> git said that it local was also set to bare init.  When I looked this was
> the case.  Silly me.
>
> So I deleted on my local and added a single file and when I try pushing this
> I get the following:
>   ! [rejected]        master ->  master (non-fast-forward)
> error: failed to push some refs to 'paul@localhost:/Users/paul/<prject>'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
> hint: before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>
> When I try and pull I then get the following:
> fatal: No remote repository specified.  Please, specify either a URL or a
> remote name from which new revisions should be fetched.
>
> I then addded my repo with the following command, but  this is the wrong
> syntax!!!
> git pull --repo=<project>
>
> What the hell am I doing wrong???

This is the moment where you have to begin reading man pages, i.e. "git 
fetch", "git help pull", "git help remote" "git help push" (read the 
examples as they show typical use cases) or preferably read about it in 
books like Pro Git (git-scm.com/book/) or tutorials.

For example the --repo parameter in "git push --repo=<project>" doesn't 
exactly do what you think it does. It only sets the default remote repo 
from "origin" to <project>. Normally you would just use "git push 
<project>". And the equivalent pull command would be "git pull <project>".

Naturally you can configure that git pull or git push will just do what 
you want, but for that you need to know what a refspec is and how to use 
"git remote".

Generally git pull and git push are not complementary. Neither in effect 
nor in parameters they take.

For example assume you have just cloned a remote repository. This will 
add configuration that connects both repositories and adds a default 
remote repo named origin and adds default refspecs

"git pull" without parameters will then fetch all remote branches into 
correpondingly named local remote tracking branches (under 
.git/refs/remotes/, do a git branch -a to list them too), but then only 
merge one of them with the branch you are in at the moment.

But "git push" will push *all* your local branches into branches of the 
same name on the remote repository.

Another difference: If you pull, the merge might fail because of merge 
conflicts and you have to manually merge conflicting files. If you push, 
this manual merge is not possible so usually only trivial merges called 
fast-forward-merges are allowed. That is what happened on your push

Something like "git remote add -m master origin <urlofyourrepo>" does 
the same configuration as a "git clone" would do and would allow you to 
just use "git pull" without parameters.
