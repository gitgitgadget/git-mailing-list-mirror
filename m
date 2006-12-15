X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: changing log entries
Date: Fri, 15 Dec 2006 09:48:44 +0100
Organization: At home
Message-ID: <eltncn$te5$1@sea.gmane.org>
References: <1166051281.1808.1.camel@jcm.boston.redhat.com> <200612141037.35061.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 08:46:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 64
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34477>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv8iE-0000pC-0u for gcvg-git@gmane.org; Fri, 15 Dec
 2006 09:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751292AbWLOIq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 03:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOIq3
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 03:46:29 -0500
Received: from main.gmane.org ([80.91.229.2]:58373 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751292AbWLOIq2
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 03:46:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gv8i2-0002ZD-Gd for git@vger.kernel.org; Fri, 15 Dec 2006 09:46:26 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 09:46:26 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 09:46:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Wednesday 2006 December 13 23:08, Jon Masters wrote:
> 
>> Anyway, now I would like to change an existing log entry to make it a
>> bit cleaner (read: add a first line that's under 80 characters). What's
>> the best way to change an existing log entry for a commit?
> 
> If it's HEAD you want to change:
>  git-commit --amend
> 
> If it's not, it's a bit harder.  You could pull each commit out as a patch and 
> apply them again later after a git-reset.  However, git has a tool for 
> automating a lot of that:  git-rebase.  man git-rebase has some excellent 
> examples.
> 
>  * -- A -- B -- C (master)
> 
> Let's say you want to edit A; make a new branch at A:
> 
> $ git branch temp-edit-branch master^^
>  
>  * -- A (temp-edit-branch)
>        \
>         B -- C (master)
> 
> Edit A with git-commit --amend.  This makes a new A, A' that has the new 
> commit message:
> 
>  * -- A' (temp-edit-branch)
>   \
>    A -- B -- C (master)
> 
> Then you switch to "master" and rebase master onto temp-edit-branch; you can 
> then delete temp-edit-branch
> 
> $ git-checkout master
> $ git-rebase temp-edit-branch

Theoretically you should do

$ git rebase --onto temp-edit-branch master^^ master

but thanks to automatic detection that patch is already applied the
above also should work. Well, unless you edit the commit so much
that git does not recognize it as the same commit...

> $ git branch -D temp-edit-branch
> 
>  * -- A' -- B' -- C' (master)
>   \
>    A -- B -- C

...in which case "git rebase temp-edit-branch master" would give you

  * -- A' --A* -- B* -- C* (master)
   \
    A -- B -- C

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

