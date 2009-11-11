From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 21:32:30 +0100
Message-ID: <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
References: <1257945756.26362.79.camel@heerbeest> <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com> <1257965806.26362.132.camel@heerbeest> <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com> <1257968052.26362.155.camel@heerbeest>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8MCq-0004Yp-JE
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759592AbZKKXCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759589AbZKKXCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:02:16 -0500
Received: from office.neopsis.com ([78.46.209.98]:46234 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759534AbZKKXCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:02:15 -0500
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Thu, 12 Nov 2009 00:02:16 +0100
In-Reply-To: <1257968052.26362.155.camel@heerbeest>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132717>


On Nov 11, 2009, at 8:34 PM, Jan Nieuwenhuizen wrote:

> Op woensdag 11-11-2009 om 20:10 uur [tijdzone +0100], schreef Tomas
> Carnecky:
>> On Nov 11, 2009, at 7:56 PM, Jan Nieuwenhuizen wrote:
>
> Hi Tomas,
>
>> You used this:
>> $ git config branch.master.remote = <something>
>> Do you see the difference between that and what I posted?
>
> Sure, I now know what syntax you and the advise mean.  However,
> I'm just pointing out that the git pull advise makes no sense,
> however way you try to interpret it?

It didn't tell you to copy'n'paste the whole lines to a git-config(1)  
commandline. But I do see that the output can be confusing for someone  
not familiar with the git configuration files/git-config.

>>> I think it might be more helpful if this text said
>>> configuration file and gave a usable configuration file
>>> snippet, or alternatively said git config, and gave usable
>>> git config commands.
>>
>> Feel free to send a patch ;)
>
> [just maybe, if my uninstall patch goes in easily, but]
>
> First I need to know what the new advise should be.  As you
> can see below, I'm still confused.
>
> I was hoping someone would say: Ah blast!  That was me,
> stupid: Fixed in master :-)  And everything would make
> sense and work.

You can use git-blame(1) to find out who wrote those lines ;)

>
>> branch.master.remote has two different values, git doesn't know which
>> remote to use.
>
> Well, it can see that there already is a value for  
> branch.master.remote
> defined, and it /still/ advises to add one.  It also uses <nickname>,
> which suggests there could be multiple values?
>
> For all I know, pull can only handle one nickname and it shouldn't
> give this advise at all?
>
>> Do you want to pull from origin or eddy?
>
> I'm publishing on origin -- that's what the original clone was
> from.  Also, I use it to update from most often, when I work
> from different locations.  All fine.
>
> Now this Eddy guy says: pull from here.  I try it and get
> this advise.  So, I'd like to have
>
>   git pull  # use origin by default
>   git pull eddy # pull from eddy's url

I don't know the relationship between you and eddy, but usually you  
shouldn't rebase (=rewrite) eddies commits. That also means you'd have  
to live with the merge commits.

>
>> I would
>> recommend only keeping one [branch "master"] section and edit it
>> appropriately.
>
> Yes, I tried that and came up with
>
>    [branch "master"]
> 	    remote = origin
> 	    merge = refs/heads/master
>    [remote "origin"]
> 	    url = git@github.com:janneke/gub.git
> 	    fetch = +refs/heads/*:refs/remotes/origin/*
>    # advise from git pull, using <nickname> = eddy
>    #        branch.master.remote = <nickname>
>    #        branch.master.merge = <remote-ref>
>    #        remote.<nickname>.url = <url>
>    #        remote.<nickname>.fetch = <refspec>
>    #[branch "master"]
>    #	remote = eddy # ignore branch.master.remote advise
>    #	merge = refs/heads/master
>    [remote "eddy"]
> 	    url = http://github.com/epronk/gub.git
> 	    fetch = +refs/heads/*:refs/remotes/origin/*

I see your mistake. Both the origin and eddy remote write to the same  
namespace (refs/remotes/origin/*), and that's also why you get (force  
update) below

. Change the fetch line of remote.eddy.fetch to +refs/heads/*:refs/ 
remotes/eddy/*. After that both command (pull -r / pull -r eddy)  
should work (I hope).

>
> This /seems/ to work.  However, I still get this
>
>    $ git pull -r
>    From git@github.com:janneke/gub
>     + 7bb5905...8ff38da master     -> origin/master  (forced update)
>    First, rewinding head to replay your work on top of it...
>    Fast-forwarded master to 8ff38da0a7013a891de18a0b7bec12b9d1fa6637.
>    20:25:55 janneke@peder:~/vc/gub
>
> [looks okay]
>
>    $ git pull -r eddy
>    From http://github.com/epronk/gub
>     + 8ff38da...7bb5905 master     -> origin/master  (forced update)
> [looks fine too, but still continues with]
>    You asked me to pull without telling me which branch you
>    want to merge with, and 'branch.master.merge' in
>    your configuration file does not tell me either.	Please
>    specify which branch you want to merge on the command line and
>    try again (e.g. 'git pull <repository> <refspec>').
>    See git-pull(1) for details.
>
>    If you often merge with the same branch, you may want to
>    configure the following variables in your configuration
>    file:
>
> 	branch.master.remote = <nickname>
> 	branch.master.merge = <remote-ref>
> 	remote.<nickname>.url = <url>
> 	remote.<nickname>.fetch = <refspec>
>
>    See git-config(1) for details.
>    [1]20:26:01 janneke@peder:~/vc/gub
>    $
>
> so I'm still missing something?
>
>> Is 'git pull -r' not short enough for you?
>
> It's more of a usability thing.  It annoys me that the most
> used functionality needs a command line option.  Worse however,
> is that people [myself included] tend to forget that "-r",
> and our logs have lots of these ugly, unnecessary
>
>    c377994 Merge branch 'master' of ssh+git://git.sv.gnu.org/srv/git/lilypond
>
> Also, we need to explain this to all newcomers.

I've found that all the available guides and books about git explain  
merging pretty well (it's a central part of git after all).

tom
