From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 16:48:05 +0200
Message-ID: <20090623144805.GB24974@pvv.org>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> <4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org> <4A40D864.8040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 16:48:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ7IE-0004cH-Vf
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 16:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbZFWOsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 10:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZFWOsE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 10:48:04 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57916 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZFWOsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 10:48:03 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1MJ7I5-0003ta-Nv; Tue, 23 Jun 2009 16:48:05 +0200
Content-Disposition: inline
In-Reply-To: <4A40D864.8040208@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122092>

On Tue, Jun 23, 2009 at 03:28:04PM +0200, Paolo Bonzini wrote:
> Finn Arne Gangstad wrote:
>> On Tue, Jun 23, 2009 at 02:59:10PM +0200, Paolo Bonzini wrote:
>> [...]
>>> Before going on, can you explain your use case for --push=tracking 
>>> (in a  case where --push=current wouldn't do the same)?
>>
>> The idea with "tracking" is to push the current branch to wherever it
>> would pull from, making push & pull "equivalent" in some sense.
>>
>> This is different from "current" if you have/choose to name the local
>> branch something else than the remote branch. This happens a lot when
>> using multiple remotes.
>
> Yes, but when using multiple remotes is it really common that:
>
> 1) I have the permission to push to them (as opposed to sending a pull  
> request)?  If I have permission to push only to the mob branch, for  
> example, I would still set my tracking branch to the master branch.

I don't know how common it is, but it is certainly not unheard of. You
have a shared public server, and a group-shared public server and so
on. You only need a single shared public server for this to make sense
however.

> 2) I *do* want to push to them often?  If I use tracking for my topic  
> branches, push.default=tracking seems a sure way to big mess when I do  
> "git push" on the wrong branch.

In our shared repositories, we have a few protected branches that only
integrators can push to, so no one else can accidentally push to
them. These are typically the branches that it makes sense to track
"by default".

If a group sets up a shared public branch, it is typically for
working together on some feature. There are very few surprises if
the group works like this:

 1. Do some modifications
 2. git commit
 3. git pull [--rebase]
 4. git push
 5. goto 1 .. 

For people used to CVS, this is a nice way to start working with git.
It requires --tracking to work properly though (--current only works
if you remember to use the same branch name).

> Instead, with push.default=current "git  
> push" would just tell me "new branch created" and then I can do "git  
> push branch-name:" to delete the newly created branch.

Well, you need to add the name of the remote. And while not exactly
impossible to find, for the target audience it may be a bit more
cumbersome than it should be:

branch: git symbolic-ref HEAD | sed -e s=refs/heads/==
remote: git config branch.<branch>.remote

And if you want to figure out what the branch you pulled from is
named, you have to do something like

git config branch.<branch>.merge | sed -e s=refs/heads/==

> I don't remember who it was, but when I tried changing the behavior for  
> "git push" someone screamed loudly that fetching and pushing are two  
> different things, and making things work uniformly across the two is not  
> necessarily correct.  The details probably were different, but I think  
> that I am saying the same now.

Different use cases want different things from push. If you are the top
level integrator of a project and are trying to keep 3 remotes in sync
with your master repository, "matching" seems to be what you want.

If you are a leaf-node worker pushing to a public repository, it
isn't. But --tracking may be a valid choice sometimes (and is, in some
sense, very close to SCMs people may be used to).

- Finn Arne
