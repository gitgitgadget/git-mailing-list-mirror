X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Workflow example for remote repository use of GIT
Date: Tue, 28 Nov 2006 10:25:24 -0500
Message-ID: <20061128152524.GA28337@spearce.org>
References: <89b129c60611280708x10a9c42fia23e6b7770971838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 15:26:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <89b129c60611280708x10a9c42fia23e6b7770971838@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32536>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4qB-0006Ix-FC for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758686AbWK1PZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758689AbWK1PZ3
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:25:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:3566 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758686AbWK1PZ2
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:25:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp4pk-0001cP-Lx; Tue, 28 Nov 2006 10:25:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8DB0C20FB7F; Tue, 28 Nov 2006 10:25:24 -0500 (EST)
To: Sean Kelley <sean.v.kelley@gmail.com>
Sender: git-owner@vger.kernel.org

Sean Kelley <sean.v.kelley@gmail.com> wrote:
> I have been trying to set-up a workflow for developers in my group
> using GIT. I came up with this simplified flow.  Do you all see any
> problems with this approach?
...
> Always work out of master
> 
>  git checkout master
> 
> Getting The Latest Upstream Code into master
> 
>  git pull origin master
> 
> Create a topic branch for your development work
> 
>  git checkout -b <new topic branch name>

That can be streamlined slightly:

  git fetch
  git checkout -b <new-topic> origin

as fetch would by default download from remote 'origin' and update
the tracking branches.  And of course developers may not want to
create their new branch from origin, e.g. if they are doing a bug
fix to an earlier release of the product.  I think its a good habit
to be in to always specify the origination point for a branch when
creating it.
 
> Do your development in the topic branch
> 
>  edit/debug/test
> 
> Committing Changes
> 
>  git commit -a

Sure, that's CVS-like and rather simple.
 
> Switch back to master
> 
>  git checkout master
> 
> Update the master branch from origin again
> 
>  git pull origin master
> 
> Now Merge your topic branch
> 
>  git pull . <topic branch to merge into current branch>

Yes, that works and will get you a merge message like

  Merge branch 'my-topic' into master

which is probably what you want if there actually was a merge.
If there wasn't (its just a fast-forward) then you won't get the
merge message.  It also has the nice property that the "trunk (if
there is such a thing)" is the first parent in every merge, with
the topic(s) in the other parents.

Though I tend to just pull the origin into the current branch
and push that directly, e.g.:

  git pull origin master
  git push origin HEAD:master

-- 
