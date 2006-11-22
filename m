X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Struggling with tangled
Date: Wed, 22 Nov 2006 12:01:15 +0100
Organization: At home
Message-ID: <ek1aj0$u09$1@sea.gmane.org>
References: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 22 Nov 2006 11:00:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 54
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32077>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmppk-0003GG-SV for gcvg-git@gmane.org; Wed, 22 Nov
 2006 12:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162059AbWKVK77 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 05:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162058AbWKVK74
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 05:59:56 -0500
Received: from main.gmane.org ([80.91.229.2]:55168 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162055AbWKVK7z (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 05:59:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmppX-0003Cg-6A for git@vger.kernel.org; Wed, 22 Nov 2006 11:59:51 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 11:59:51 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 22 Nov 2006
 11:59:51 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:

> I am trying to sort out a tangled (in the sense that I several branches that 
> split a long time ago, but are reasonably close subsets of each other) 
> repository of mine using git rebase.  I want to isolate the commits that 
> cause the key differences so that I can then easily enhance the code but 
> carry forward the variants (using git-rebase again probably). 
> 
> I have some questions which are causing me some grief after merge conflicts. 
> Can someone help me. 
> 
> 1) I often edit a merge conflicted file to the state I expect it to be in at 
> the end.  This sometimes means that I edit it to a state where no change is 
> seen.  git-update-index notices this and doesn't do anything, but when I try 
> git-rebase --continue it won't because it says git-update-index has not been 
> run.  What am I supposed to do then? [Is the answer git-rebase --skip ?] 

If you resolve conflict to the state where no change is seen, it means that
the commit you currently are rebasing doesn't bring any changes; it was
applied. So you have to do "git rebase --skip".

Sidenote: with git version 1.4.3.4 you cannot "git rebase --skip" while
there are conflict in the index. It is most annoying - I'd like to skip
the resolving. I bring the files in conflict to the "base" version and run
"git update-index" before "git rebase --skip", but I'd like to skip that part.

> 2) Some files get completely munged with conflict resolution markers every 
> few lines.  Is there a simple way to say "don't use this file, but use the 
> [stage2/stage3] sources of the merge". (ie one of the original inputs to the 
> merge - and if so, which one is which) 

"git cat-file -p :<stage>: <filename> > <filename>", where stage = 1 means
version from the ancestor, stage = 2 means version from the HEAD (from the
base), and stage = 3 means version from the remote/other branch (from the
branch being rebased).  

> 3) I sometime hit a merge conflict in a file which I know will actually be 
> deleted at the tip of the topic I am rebasing.  Is there a way at this point 
> to just tell the conflict resolution to say make this file go away. 

"git rm <filename>" plus "git update-index <filename>" doesn't work?

> 4) I repeat the question I asked in a thread above.  What is the --merge 
> switch on git-rebase actually do.  The man page starts talking about merge 
> strategies, but there already is a -s switch for that. 

"git rebase" uses "git format-patch" + "git-am --3way" machinery by default.
The --merge option makes it use merge machinery instead (similar to the way 
"git checkout -m" uses merge strategy IIRC).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

