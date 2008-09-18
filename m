From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Help using Git(-svn) for specific use case
Date: Thu, 18 Sep 2008 09:56:28 +0400
Message-ID: <20080918055628.GB21650@dpotapov.dyndns.org>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com> <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com> <aa2b76740809170709y77275473k93d48e354bea55e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pico Geyer <picogeyer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 07:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCWP-00062B-AW
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 07:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYIRF4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 01:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYIRF4g
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 01:56:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:3523 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYIRF4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 01:56:35 -0400
Received: by ug-out-1314.google.com with SMTP id k3so638046ugf.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 22:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YKNyQBJRQ75lL5A4zDzKGp8gz0sLLotiDf1+C4iORAo=;
        b=M8eyor1MA3YMap2vkwrjm0FsQl6YuBmY5kV5d1FTF72NN/lqSOEiGTGj8vpvgJ6e0L
         PpvZ01mH6LoQuNVvd7Y8VTpmYYD4WIijOVKg/A+/V6pj6/1/5TukAahVsf/fEJFt1p7k
         1HuZ1r6R0LNKVzylxQolQVOgYfIO3hZStfmhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KSn9QT9X41H++XpTfGF8byweZkjC6R0M9Yop+cyTlWrUsTYdytiIGQUDTcWAwMlR7I
         Dm2zQJgS+Np1vYSlZg5yEMsk+037uRroFDvbDNxe3CIepmtnebrGUgTZMapdHo/e2vx9
         2vN8XCQ1PVyijlmCGhtrtUmqodgmXzF0KNp0Q=
Received: by 10.103.22.11 with SMTP id z11mr2507622mui.83.1221717393010;
        Wed, 17 Sep 2008 22:56:33 -0700 (PDT)
Received: from localhost ( [85.141.191.174])
        by mx.google.com with ESMTPS id s10sm13970888mue.15.2008.09.17.22.56.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 22:56:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <aa2b76740809170709y77275473k93d48e354bea55e5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96160>

Hi Pico,

I will try answer your question, but unfortunately I don't have much
time for detail explanations, so maybe someone else will add a few
more comments.

On Wed, Sep 17, 2008 at 04:09:51PM +0200, Pico Geyer wrote:
> 
> I'm going to give example commands to confirm my understanding of the
> git-svn workflow you described.
> Any comments or corrections are welcome.
> 
> On the local server, get a clone of the repository:
> srvA# git svn clone http://server.com/repo/proj/trunk proj
> srvA# cd proj
> 
> Create a local branch, where developers will push to
> srvA# git branch integration
> 
> Now a developer clones the repository on the server, and makes a local
> branch for developement:
> dev1# git clone ssh://svrA/path/to/repo
> dev1# git checkout -b new_featureX
> (Developer makes some changes and commits to the new_featureX branch)

I believe developers should start from the integration branch, i.e.:

git checkout -b new_featureX origin/integration

> 
> Developer now pushes the changes to the integration branch
> dev1# git push origin new_featureX:integration

If someone already push there, push will refuse saying that it is
non-fast forward update. So, the developer will have to rebase his/her
branch on top of origin/integration:

  git fetch && git rebase origin/integration

or provided that you created your branch from origin/integration,
you can run:

  git pull --rebase

which does git fetch and rebase on the top of the original branch.

> 
> The merge master now rebases the changes on to the master branch:
> srvA# git rebase integration

What this commands does is to rebase your current branch on top
of the integration branch. I suppose you have something like
this before running it:

master            integration
 o------o-----o-------o

If you are staying at the master, it will advance master to
integration. So, yes, it does what you need, but your wording:
"rebases the changes on to the master branch" is not correct,
because it is master is rebased on top of integration, which
in your case is just fast-forward update of it to integration:

                  integration=master
o------o-----o-------o

you can have the same effect by "git merge integration".

> 
> Now push the changes to the upstream subversion server:
> srvA# git svn dcommit

I usually run "git svn dcommit --dry-run" first to make sure that it
will commit what I want. It is very useful when you try a new setup.

> 
> At some stage svn users will commit to the subversion repository, and
> we will need to pull changes into srvA:
> srvA# git svn rebase

Yes, but you usually do that before git svn dcommit...

> 
> Now the integration branch does not include the changes in master, so
> rebase the changes to integration:
> srvA# git rebase master integration

That is okay but may lead to the situation that conflicts that were
already resolved during git svn rebase will be re-emerge again.

You can force integration branch to be the same master after you 
have dcommited changes to SVN using the following command:
   git branch -f integration master
but if someone push into repository after the point where 'master' was
equal to 'integration' then those changes may be lost. To prevent this
from happening, you can lock repository (or only this particular branch)
from being push into when you dcommit changes to svn. Then when you have
finished, you can safely use the above command. The lock can be
implemented using the 'update' hook (for instance, the hook verifies
whether the "integration.lock" tag exists, if it does then the hook
exists with non-zero value).

> 
> Finally the developer needs those changes too, so on his master branch:
> dev1# git rebase origin

No, it is
  git fetch && git rebase origin/integration
or just
  git pull --rebase
provided that you started your branch from origin/integration.

> 
> Is this the process that you were trying to describe?
> Any additional steps that need to be added?

Yes, basically, it is. It could be some variations though. Instead of
having the integration branch in the repository that you use to sync
with SVN, you can have a separate bare repository where 'master' will
represent the integration branch, while git-svn repository is private to
the merge master. The advantage is that merge master does not need the
shell access to the server. Also, developers see only one branch 'master'
(less confusion about what to use as the starting point). In this setup,
you need to allow to the merge master non-fast forward update to the
bare repository (to update 'master' after commiting changes to SVN),
while the rest developers should have only fast-forward update.

> 
> And how do I make sure that when developers push to the server that it
> results in a fast-forward merge? Do I do that with commit hooks?

No, all commits and merges are purely local things. git push never
merges anything, it only propogates changes and update the branch
references. The only thing you should guarantee that no one (except
the merge master if necessary) can do non-fast forward push to server.
To disable to all users non-fast forward update, you can set
receive.denyNonFastForwards = true

If you disable to some users but not to others then you can use
either $GIT_DIR/hooks/pre-receive or $GIT_DIR/hooks/update.
See man git-receive-pack for more information, and examples
of the update hook included in Git.


Dmitry
