X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Getting CVS and Git to play nicely in the same box
Date: Thu, 30 Nov 2006 23:21:18 +0100
Organization: Dewire
Message-ID: <200611302321.19129.robin.rosenberg.lists@dewire.com>
References: <1164890354.21950.92.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 22:19:22 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <1164890354.21950.92.camel@okra.transitives.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32812>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuFO-0003nw-6h for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031556AbWK3WTK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031558AbWK3WTK
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:19:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:38952 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1031556AbWK3WTI (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:19:08 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id B630A802AB3; Thu, 30 Nov 2006 23:15:22 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13596-04; Thu, 30 Nov
 2006 23:15:22 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 4027B802806; Thu, 30 Nov 2006 23:15:20 +0100 (CET)
To: kernel-hacker@bennee.com
Sender: git-owner@vger.kernel.org

torsdag 30 november 2006 13:39 skrev Alex Bennee:
> Hi,
>
> I'm trying to get a setup where I can use git for my day to day coding
> on problems but still mirror a CVS repo. The situation is muddied
> slightly by the way we manage changes in our CVS repository and
> baselines.
>
> The CVS manner of working means we create a branch at a given point to
> do work on it:
>
>           BL1_CH2
>          /
>         /
>        BL1_CH1
> BL1---/
>
> And then in the meantime a new baseline may be released:
>
>
> BL2    BL1_CH2
>
> |     /
> |     BL1_CH1
>
> BL1--/
>
> So we employ the "cvs -q update -dP -j BL1 -j BL2" on our development
> branch
>
>           BL2_CH2
>          /
> BL2     BL1_CH2
>
> |      /
> |    BL1_CH1
>
> BL1--/
>
> I want to mirror this sort of behaviour it git (basically making the
> cvs -j -j operation a git merge, separate from the normal development
> track). I however also need to maintain the CVS meta-data so when I get to
> given points I can commit my work into the main development server.
>
> I can set up a git repo that ignore all the CVS gubbins with exclude info
> but the CVS metadata gets in the way. I think I have to maintain two git
> repos, one that tracks the baseline and one which is a clone (which can
> then pull updates) but has the CVS meta data for my development branch.
You don't need to use GIT to track metadata (I asume you mean CVS/Entries) is 
not necessary. Use a plain CVS checkout for that and cvsexportcommit to it.

> However CVS does seem to get very confused when the world moves under it
> when you switch branches in GIT.
Exaktly. Forget about it, it won't work and there is a simpler solution.

> Has anyone successfully set up such a working environment? Can anyone offer
> any tips on how to make it all work nicely?

My setup is like this:

- A tracking repo on a server runs git-cvsimport every night.
- I pull from the tracking repo
- I have a CVS checkout for the branch I'm interested in committing to
- Then I use cvsexportcommit to export changes back to CVS. Actuallly I use a 
small script that runs cvs update and then exports the changes defined by a 
named commit so I say "tocvs a-commitid--tag-or-stgit-patch-name".

Since I use StGit I get no problem from my changes coming back through the 
cvsimport executed on the server. StGit makes the patches empty when my own 
code returns from CVS.

