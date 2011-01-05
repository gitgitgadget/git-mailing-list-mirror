From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Tracking branches and pulling on remote
Date: Wed, 05 Jan 2011 17:40:26 +0100
Message-ID: <4D249EFA.5050408@seznam.cz>
References: <loom.20110105T013525-413@post.gmane.org> <20110105050108.GA5884@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 17:54:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaWco-00014x-AN
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 17:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab1AEQyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 11:54:08 -0500
Received: from smtp.seznam.cz ([77.75.76.43]:41685 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab1AEQyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 11:54:07 -0500
X-Greylist: delayed 810 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2011 11:54:06 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=Omh7iWE+9pW8R510ZU6eM88bGvv1lh6o6dwPzdxe/REL6/KVY3Hy5HpdOgeHZFtN+
	NPr/qHpZ9TYBfW4AZz2EBHU9QgYOxlw9ccwQo6Od1fC9Mmy0kVQTJ5EEWp+nRTST9th
	E4kns6+r9ptQ+OnqaWR9vFEZX9IP3Exgj1uaiwc=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay1.ng.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Wed, 05 Jan 2011 17:40:25 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110105050108.GA5884@sigill.intra.peff.net>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 1376
X-Country: CZ
X-QM-Mark: email-qm3<567942454>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164573>

On 11-01-05 06:01, Jeff King wrote:
> On Wed, Jan 05, 2011 at 12:58:47AM +0000, Maaartin wrote:
> 
>> 1.
>> I'm using git for couple of months and still don't get it. In a new repo a have 
>> two branches: master and X. I pushed both to the server, everything seems to 
>> work. However, there's origin/master but no origin/X in my repo. When I execute
>> git fetch --all -v
>> only master gets fetched. I've created an entry in the .git/config, no change. 
>> I've tried things like
>> git branch --track X origin/X
>> and all of them ends with an error message. Finally I've found out that
>> git config --add remote.origin.fetch refs/heads/X:refs/remotes/origin/X
>> seems to do it, was it right?
> 
> There should already have been a remote.origin.fetch that looked like:
> 
>   $ git config remote.origin.fetch
>   +refs/heads/*:refs/remotes/origin/*
> 
> which is a superset of what you added. If you run the git config command
> I did above, what do you see?

No, there had been just the single line

refs/heads/master:refs/remotes/origin/master

and after my change I got

refs/heads/X:refs/remotes/origin/X
error: More than one value for the key remote.origin.fetch:
refs/heads/master:refs/remotes/origin/master

It was probably my fault, I may have copied a config file from elsewhere
(and adapted the URL).

> If you have a wildcard line like the one
> above (which is added during the initial clone), then the config you
> added would have done nothing.

I see.

> Are you absolutely sure that the branch was pushed to the remote side in
> the first place? How did you push it?

Yes, I'm sure. I don't remember how I did it, probably using
git push origin master

I think it's clear now.

>> 2.
>> I'd like to do some (at least for now) private changes on a foreign project. The 
>> ideal way I think about would be the following:
>> - my local repo is linked to my own server (for backup purposes and for private 
>> cooperation with a college)
>> - the repo on my server is linked to the github hosting the project
>> Now, I'd need to do something like
>> ssh myserver git fetch
>> and everything would be fine. I can do it this way, but I'd prefer something like
>> git remote fetch
>> or even
>> git fetch --remote-too
>> which would first make my server fetch from its origin and then my local repo 
>> fetch from my server. Is there such a thing? Would you recommend me doing it in 
>> a different way?
> 
> There isn't really a shortcut for the two-level thing you're trying to
> do. But consider rearranging your topology to always pull to the local
> repo, and then push changes up to your backup/collaboration server.
> 
> Something like:
> 
>   $ git clone http://github.com/whatever/project.git
>   $ cd project
>   $ git remote add myserver myserver:/path/to/backup repo
> 
> and then your workflow is:
> 
>   : hmm, I feel like working on project. what happened upstream?
>   $ git pull ;# or git fetch origin; gitk origin... ; git merge origin
>   $ hack hack hack
>   : ok, now I have some work to show to my collaborator
>   $ git push myserver
> 
> or possibly:
> 
>   : ok, now what has my collaborator been up to
>   $ git fetch myserver
>   $ gitk myserver/topic
>   : I like it, let's merge
>   $ git merge myserver/topic
>   : Now push back my merge
>   $ git push myserver
> 
> You might also find it convenient to swap which remote is "origin"
> (since it is the default for "git push" without arguments). That is, you
> primarily consider your local repo to be a clone of what's on
> "myserver", but you occasionally fetch and merge changes from upstream,
> like:
> 
>   : ok, what has my collaborator been working on?
>   $ git pull
>   : and what has upstream been up to?
>   $ git fetch upstream
>   : oh, neat stuff. let's merge it
>   $ git merge upstream
>   : and then let's publish it so our collaborator will also work on top
>   : of it
>   $ git push ;# implicitly to origin
> 
> How you want to set it up really depends on which mental model
> represents your workflow best.

OK, I swapped origin and upstream and made aliases
	fetchboth = !"git fetch; git fetch upstream"
	fetup = fetch upstream
which is about everything I need for now.

Thanks, Maaartin.
