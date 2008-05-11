From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CIFS fixes
Date: Sun, 11 May 2008 10:04:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805110957530.3330@woody.linux-foundation.org>
References: <524f69650805082054g43823f85i623cb2c11cd01039@mail.gmail.com>  <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org>  <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>  <alpine.LFD.1.10.0805110948530.3330@woody.linux-foundation.org>
 <524f69650805110953t6561ff84t1867681bea093d35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve French <smfrench@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEzb-0006tJ-Mu
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYEKRE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbYEKRE5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:04:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37130 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752637AbYEKRE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 13:04:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BH4rfT024891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 May 2008 10:04:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4BH4qJJ015314;
	Sun, 11 May 2008 10:04:52 -0700
In-Reply-To: <524f69650805110953t6561ff84t1867681bea093d35@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81796>



On Sun, 11 May 2008, Steve French wrote:
>
> That is not what I meant.   I meant that since May 6th I only did one
> - and those messages still showed up.  So I just ran a git-rebase
> origin which removed them

You're doing something wrong then, and your rebased result is suspect.

Have you done a "git fetch" to fetch what is in my current tree? Because 
if you haven't, then you're generating the "this is the new state" without 
actually taking into account that the old state was already pulled!

And that *old* state contains those four merges that I got from your 
previous pull request!

So now you likely rebased the commits that I already merged (again, 
because you *think* they are just local to your branch, because you 
haven't updated your origin reference point), and they are now duplicates 
of something I already have (but with different commit ID's, since your 
rebase has moved them around in the history).

So now, if I were to pull again, I'd just get the same commits all over 
again, just as duplicates (plus any new ones, of course). Git would 
probably merge it all fine - unless your new ones were to the same area as 
the old ons, in which case it might be unhappy about the fact that both 
branches changed things in the same area - but the history would be crud.

In other words: you *must*not* rebase stuff that you have already 
publicized. That just creates problems.

The good news is that you can most likely fix it all up by just doing

	git fetch
	git rebase origin

because now the *new* rebase will try to rebase it all over again, but now 
it will see that I already merged the old ones, so the rebase will just 
skip those commits, and you should have only the *real* new ones pending 
again.

		Linus
