From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: Remote branch can not be resolved as commit?
Date: Thu, 23 May 2013 10:45:44 +0200
Message-ID: <519DD738.4050807@ira.uka.de>
References: <519CD63A.20802@kendallshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kendall Shaw <kshaw@kendallshaw.com>
X-From: git-owner@vger.kernel.org Thu May 23 10:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfR8r-0006NN-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 10:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734Ab3EWIoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 04:44:54 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58676 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757694Ab3EWIou (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 04:44:50 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UfR8d-0000oD-OE; Thu, 23 May 2013 10:44:49 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UfR8d-00086L-GF; Thu, 23 May 2013 10:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <519CD63A.20802@kendallshaw.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1369298689.247041000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225223>

Am 22.05.2013 16:29, schrieb Kendall Shaw:
> I am trying to setup a repository for use inside the LAN, but I have
> been unable to checkout any branch so far. I am very new to git.
>
> The repository is being served from gitblit over https. I have
> GIT_SSL_NO_VERIFY=true. The repository was created from git svn.

(Never heard of gitblit. Consider my post as first level support ;-)

Remember that git is a distributed CVS, unlike svn. We are talking about 
two repositories, the local one you executed the commands from and the 
one on the server.

> git ls-remote
>
> shows the remote branches, e.g.:
>
> ... refs/remotes/2.0.3
> ... refs/remotes/trunk

I would have expected a listing of
... refs/heads/2.0.3
... refs/heads/trunk

and also a mention of the remote repository (did you remove that before 
posting?).

In refs/remotes you usually find references/pointers to remote branches 
whereas local branches are in refs/heads. So this looks like an empty 
repository that was created and configured with a remote repository.

Either your remote repository failed to get any contents or "git 
ls-remote" lists your local (empty) repository, which is possible if you 
somehow managed to configure your local repository as remote of itself.

I would suggest the following:

1) "git ls-remote .". If it shows the same listing as git "ls-remote", 
you probably have configured your local repository as your remote

2) "git config --list". Is "remote.origin.url" a link to the repository 
on the server or is it "."?

3) Can you log into the server? If yes, change to the repository there 
and try "git log" (are there any commits listed at all?), "git branch -a 
-v". If no commits and no local branches, blame git svn.

> git branch -r
>
> shows none of the remote branches.
>
> git checkout -b new-2.0.3 origin/2.0.3
>
> produces:
>
> fatal: git checkout: updating paths is incompatible with switching
> branches.
> Did you intend to checkout 'origin/2.0.3' which can not be resolved as
> commit?
>
> What does that mean?

http://stackoverflow.com/questions/945654/git-checkout-on-a-remote-branch-does-not-work
