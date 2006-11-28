X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Workflow example for remote repository use of GIT
Date: Tue, 28 Nov 2006 17:18:09 +0100
Organization: At home
Message-ID: <ekhncj$1be$1@sea.gmane.org>
References: <89b129c60611280708x10a9c42fia23e6b7770971838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 16:18:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 105
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32545>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp5eM-0004cG-0C for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935722AbWK1QRE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935724AbWK1QRD
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:17:03 -0500
Received: from main.gmane.org ([80.91.229.2]:62398 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935722AbWK1QRB (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 11:17:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp5da-0004Nk-MU for git@vger.kernel.org; Tue, 28 Nov 2006 17:16:50 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 17:16:50 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 17:16:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sean Kelley wrote:

> I have been trying to set-up a workflow for developers in my group
> using GIT. I came up with this simplified flow.  Do you all see any
> problems with this approach?
> 
> Thanks,
> 
> Sean
> 
> 
> 
> Always work out of master
> 
>   git checkout master

This conflicts a bit with later "Create a topic branch" statement.
The statement should be I think twofold: "Never work out of tracking
branches" (if you use separate remotes, git takes care of that for
yourself), and for typical workflow "Always work out of master
or merge changes into master".
 
This of course deopends on the structure of your repo. For example,
how many development branches are there. Git repository uses four
development branches: 'maint' (maintenance, stable, bugfixes),
'master' (trunk, main development, stable), 'next' (development)
and 'pu' (proposed updates, a kind of topic branch digest).

> Getting The Latest Upstream Code into master
> 
>   git pull origin master

It always is "merge into current branch".

Please read what this mean in git-pull(1):

    ?  A parameter <ref> without a colon is equivalent  to  <ref>:  when
       pulling/fetching,  so  it  merges  <ref>  into the current branch
       without storing the remote branch anywhere locally.

So what "git pull origin master" do is to fetch _single_ remote branch
'master' from remote (repository) 'origin' _without_ storing it anywhere
locally (with separate remotes it would be 'remotes/origin/master',
without separate remotes it would be 'origin'), and merge it into _current_
branch.

What you usually want to do, when you are on branch "master", is

  git pull origin

or even

  git pull

> Create a topic branch for your development work
> 
>   git checkout -b <new topic branch name>

One might want to create topic branch off other commit than HEAD,
using

  git checkout -b <new topic branch name> <branch point>

> Do your development in the topic branch
> 
>   edit/debug/test
> 
> Committing Changes
> 
>   git commit -a

Depending on your project policy, it might be "git commit -a -s",
i.e. add signoff line.

> Switch back to master
> 
>   git checkout master
> 
> Update the master branch from origin again
> 
>   git pull origin master

The same comment as above.

By the way, this is _not_ CVS, you can merge your topic branch first,
_then_ pull from origin.

> Now Merge your topic branch
> 
>   git pull . <topic branch to merge into current branch>

I'd point out that '.' means current repository here.

> How do I push my changes to the original repository?
> 
>   git push origin master

Probably (and better) just "git push origin" if everything is set up
correctly.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

