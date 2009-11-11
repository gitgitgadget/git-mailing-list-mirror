From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 20:10:26 +0100
Message-ID: <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
References: <1257945756.26362.79.camel@heerbeest> <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com> <1257965806.26362.132.camel@heerbeest>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:11:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Iat-000735-B9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbZKKTKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 14:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758431AbZKKTKw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:10:52 -0500
Received: from office.neopsis.com ([78.46.209.98]:47534 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758351AbZKKTKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 14:10:51 -0500
Received: from [10.3.112.244] ([147.88.200.112])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Wed, 11 Nov 2009 20:10:52 +0100
In-Reply-To: <1257965806.26362.132.camel@heerbeest>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132688>


On Nov 11, 2009, at 7:56 PM, Jan Nieuwenhuizen wrote:

>> These are meant to be used with git-config(1):
>> git config branch.master.remote <nickname>
>
> Okay...that's the other thing I tried.  Look
>
>   $ cp .git/config .git/config.orig
>   19:32:05 janneke@peder:~/vc/gub
>   $ git config branch.master.remote = eddy
>   19:32:08 janneke@peder:~/vc/gub
>   $ diff -u .git/config.orig .git/config
>   --- .git/config.orig	2009-11-11 19:32:05.724046086 +0100
>   +++ .git/config	2009-11-11 19:32:08.304045852 +0100
>   @@ -6,6 +6,7 @@
>    [branch "master"]
> 	    remote = origin
> 	    merge = refs/heads/master
>   +	remote = =
>    [remote "origin"]
> 	    url = git@github.com:janneke/gub.git
> 	    fetch = +refs/heads/*:refs/remotes/origin/*
>   [1]19:32:10 janneke@peder:~/vc/gub

You used this:
$ git config branch.master.remote = <something>
Do you see the difference between that and what I posted?

> Also, if this is meant to be used with git config, then
> /why/ does the text say "in your configuration file"?
>
> I think it might be more helpful if this text said
> configuration file and gave a usable configuration file
> snippet, or alternatively said git config, and gave usable
> git config commands.

Feel free to send a patch ;)

>
>> Or if you want to manually edit the config file, add this:
>>
>> [branch "master"]
>>    remote = <nickname>
>>
>> etc.
>
> Thanks!  Tried this.  However, there already was a
>
>  [branch "master"]
>       remote = origin
>
> which is my default branch that I publish to and pull
> from.  After adding a nickname for this new branch that
> I'll probably be pulling from a lot, my config file reads
>
>   [branch "master"]
> 	    remote = origin
> 	    merge = refs/heads/master
>   [remote "origin"]
> 	    url = git@github.com:janneke/gub.git
> 	    fetch = +refs/heads/*:refs/remotes/origin/*
>   # advise from git pull, using <nickname> = eddy
>   #        branch.master.remote = <nickname>
>   #        branch.master.merge = <remote-ref>
>   #        remote.<nickname>.url = <url>
>   #        remote.<nickname>.fetch = <refspec>
>   [branch "master"]
> 	    remote = eddy
> 	    merge = refs/heads/master
>   [remote "eddy"]
> 	    url = http://github.com/epronk/gub.git
> 	    fetch = +refs/heads/*:refs/remotes/origin/*
>
> With this new "eddy" addition
>
> git pull -r eddy
>
> seems to work fine, but the good old default pull now says
>
>   $ git pull -r
>   error: More than one value for the key branch.master.remote: eddy
>   Current branch master is up to date.

branch.master.remote has two different values, git doesn't know which  
remote to use. Do you want to pull from origin or eddy? I would  
recommend only keeping one [branch "master"] section and edit it  
appropriately.

> and I'm not really sure where it pulls from?  Then I think,
> possibly now I need to specify the <nickname> for the default
> url too [never knew that was a nick], which has automagically
> be named "origin".  Yes, that makes sense.
>
> Well, /then/ I get thoroughly confused
>
>   $ git pull -r origin
>   You asked me to pull without telling me which branch you
>   want to merge with, and 'branch.master.merge' in
>   your configuration file does not tell me either.	Please
>   specify which branch you want to merge on the command line and
>   try again (e.g. 'git pull <repository> <refspec>').
>   See git-pull(1) for details.
>
>   If you often merge with the same branch, you may want to
>   configure the following variables in your configuration
>   file:
>
> 	branch.master.remote = <nickname>
> 	branch.master.merge = <remote-ref>
> 	remote.<nickname>.url = <url>
> 	remote.<nickname>.fetch = <refspec>
>
>   See git-config(1) for details.
>   [1]19:43:02 janneke@peder:~/vc/gub

Hm, I can't explain that one. I would use either the short form (git  
pull -r) or the long form (git pull -r origin master). Try removing  
the duplicate branch.master section and try again.

>
>> As 'pull == fetch + merge' (pull -r == fetch + rebase), pull without
>> merge would be fetch.
>
> Okay, that's fighting over naming conventions, let me retry this.
> I still wonder why does Git have a shorthand for fetch + merge [pull],
> which you almost never want, and no shorthand for fetch + rebase
> [known to most *CS/*SCM users as "update"]?

Is 'git pull -r' not short enough for you? If not, feel free to create  
a alias:
$ git config alias.up 'pull -r'

tom
