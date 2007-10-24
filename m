From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 20:48:54 +0200
Message-ID: <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 20:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IklIq-00054V-LA
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 20:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbXJXStw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 14:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbXJXStw
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 14:49:52 -0400
Received: from mailer.zib.de ([130.73.108.11]:38601 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbXJXStv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 14:49:51 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9OIlRof029245;
	Wed, 24 Oct 2007 20:49:42 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1097b.pool.einsundeins.de [77.177.9.123])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9OIlPIC023359
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 24 Oct 2007 20:47:25 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710231155321.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62226>


On Oct 23, 2007, at 12:58 PM, Johannes Schindelin wrote:

> On Tue, 23 Oct 2007, Steffen Prohaska wrote:
>
>>
>> On Oct 23, 2007, at 1:35 AM, Jakub Narebski wrote:
>>
>>> 2. Git can do a merge with conflicts _only_ if that branch is  
>>> checked
>>> out.
>>
>> Andreas' proposal contains an important requirement that avoids this
>> problem. His proposal states "when they, prior to fetching,  
>> pointed to
>> the same commit [the head in remotes pointed to]". That is only
>> fast-forwards are needed, which never have merge conflicts.
>
> You know what I do not like with this proposal?  The whole _point_  
> of this
> discussion is to make git _easier_.  Go ahead, try to explain to a
> complete git newbie the proposed behaviour.  I have a pound here which
> says that there is _no_ _way_ that this newbie says "well, that's  
> easy".
>
> Some people may not get this, but git has a reputation of being
> complicated, and my "BS" argument was, is, and will be, that we should
> keep clear and simple semantics, because they are the _only_ way to  
> battle
> that reputation.

I try to explain the workflow that I'd use the feature for.
Maybe an easier setup could be used to achieve the same.
Any suggestions for a simpler setup are welcome.

The workflow is used by a group of developers that all have
access to a shared repository. One major goal is to keep the
setup for most developers simple. They are new to git and
as few commands as possible should be sufficient to start
working. Besides the typical stable branches (master, next)
shared topic branches should be available that can be used
to develop and review features before they are merged to the
stable branches. Patches are not send by email.

So here's the setup:

The central shared repo is called project-shared.git and contains,
for example, the following branches:
    master
    next
    work/topicA
    work/topicB
    ...


Developers clone the repo and check out the branches they are
interested in. For example a developer may want to track next
and work on topicB:

    git clone ssh://central.example.com/project-shared.git project
    cd project
    git checkout -b next origin/next
    git checkout -b work/topicB origin/work/topicB

This is sufficient. No adding of remotes is needed. Neither
is a private repository on a server required. After cloning,
developers have all they need.

Later work/topicB has new commits and should be pushed:

    git push origin

The default behaviour of push is fine. Only matching branches
are pushed.

_But_, origin is a shared repository. Therefore branches may
have advanced and git push may report

error: remote 'refs/heads/next' is not a strict subset of local ref  
'refs/heads/next'. maybe you are not up-to-date and need to pull first?

So here's the problem. The developer didn't do anything wrong.
But git complaints with an error. Git also recommends to run
pull, so the developer runs "git pull". But this doesn't help,
because it's only updating work/topicB and "git push" will
complain with the very same error.

What you need to do is

    git checkout <local-branch>
    git pull
    git checkout <local-branch2>
    git pull
    ...

for every local branch.

This is absolutely stupid. Therefore the developer starts
to hate git, or she just starts to ignore the errors because
they don't have a real meaning most of the times. And later,
when the error could be helpful she would ignore it, too.

The problem described can only happen with a shared repository.
In a workflow that pulls from read-only repos and pushes to a
private repo that is read-only for others, such a problem cannot
happen. Because in a non-shared repository the branches cannot
be advanced by others. But in a shared repository they can.

I see two reasonable solutions:
1) "git push" only pushes the current branch.
2) "git pull" pulls all branches as proposed by Andreas.

Maybe something that I don't see is fundamentally wrong with
the setup.

Johannes, you mentioned that it is essential to distinguish
remote branches from local branches. In general, I agree. The
problem described above is 'smaller' if you have less local
branches that you're not actively working on. But I believe
it is reasonable to have more than one of them. The remotes
track everything and your local branches are a subset of things
you're interested in although you're not working on each of
the branch every day. I don't think it's reasonable to delete
a local branch immediately each time you stopped working on it.

I think root of the problem is that git is more focused on
pulling from read-only and pushing to non-shared repos. The
support for shared repos needs to be improved before it
is perfect.

	Steffen
