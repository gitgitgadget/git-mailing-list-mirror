From: Andreas Ericsson <ae@op5.se>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Wed, 18 Jan 2006 18:08:00 +0100
Message-ID: <43CE75F0.4060009@op5.se>
References: <43CE5666.90502@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:08:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGn4-0008Ir-Am
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWARRIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWARRIF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:08:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60895 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751378AbWARRIC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:08:02 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1A7406BCBE; Wed, 18 Jan 2006 18:08:01 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: luis@itaapy.com
In-Reply-To: <43CE5666.90502@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14841>

Belmar-Letelier wrote:
> Hello,
> 
> Could someone say me how we do in cogito or git the
> 
> arch-tla equivalent of
> 
> $ cd project--luis--0.1
> $ tla missing -sD paul@mail.com--public/project--paul--0.1
> 
> so I get the information like what are the interesting patch to get
> 
> and then I take all of them with
> 
> $ tla star-merge -t paul@mail.com--public/project--paul--0.1
> 
> or I cherry pick only one of them (here patch-6) with
> 
> $ tla replay  somefriend@mail.com--public/project--branchA--0.1--patch-6
> 

Not that I'm even half aware of how arch does this, but if the two repos 
are cloned from the same one (which they seem to be), you could just do

	$ git checkout -b paul
	$ git pull <path-to-pauls-repo> <branch-from-pauls-repo>

The "pull" above will do the merging nessecary. You can merge several 
branches at once if you like (known as "doing an octopus" in gittish. I 
imagine that's a star-merge in arch).

Then, if you want to cherry-pick commits from Paul's repo to your 
master-branch, you do

	$ git checkout master
	$ git cherry-pick -r paul~3

to replay the commit 3 steps below the tip of Paul's latest commit in 
the branch you just pulled from.

If you want to import all of them into your own master branch you can do

	$ git checkout master
	$ git pull . paul


You can also do

	$ cd pauls-repo
	$ git format-patch --mbox -k HEAD~10 -o /your/repo
	$ cd /your/repo
	$ git am -k 00*.txt

but that has the feel of doing things the wrong way around (exporting 
from a repo to import to another should be done by a fetch or, if you 
want to merge them into whatever branch you're currently on, a pull).


Two things worth noting:
* git repositories are damn near indestructible, so long as you don't 
run "git prune" while mucking around doing very strange things or suffer 
hardware failure. Don't be afraid to experiment.

* gitk is your friend for finding out where you are in the repo and what 
actually happens when you merge, reset, revert, rebase, commit, pull, 
fetch, branch, tag or does something else entirely. Use it. You'll be 
glad you did.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
