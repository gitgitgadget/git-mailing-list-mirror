X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Resolving conflicts
Date: Thu, 30 Nov 2006 23:39:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
References: <456FD461.4080002@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 07:39:41 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456FD461.4080002@saville.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32859>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq2zd-0007P5-Be for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934527AbWLAHja (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934962AbWLAHj3
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:39:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19893 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S934527AbWLAHj3 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 02:39:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB17dOjQ010014
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 23:39:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB17dNKX005050; Thu, 30 Nov
 2006 23:39:24 -0800
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Wink Saville wrote:
> 
> I then searched the net for how to resolve conflicts, seems you
> should start by doing a git-diff, so I did and I get this:
> 
>   diff --cc kernel/fork.c
>   index d74b4a5,8cdd3e7..0000000
>   --- a/kernel/fork.c
>   +++ b/kernel/fork.c
>   diff --cc kernel/spinlock.c
>   index f4d1718,2c6c2bf..0000000
>   --- a/kernel/spinlock.c
>   +++ b/kernel/spinlock.c

Hmm. That doesn't look like a conflict. If it had a real conflict, I'd 
have expected to see it mentioned in that diff..

This may be a stupid question, but if you haven't actually ever needed to 
do any file-level merges before, this may be the first time you've 
actually had the external 3-way "merge" program called, and that's one of 
the few things that git still depends on _external_ programs for. And if 
that program is broken or missing, you'd get bubkis.

(This is hopefully getting fixed, and we'll have one less external 
dependency to worry about, but it's the only thing that springs to mind)

That's especially true since the merge-head your log shows wasn't even all 
that long ago: there's just 80 commits since that common merge base, and 
only two of them even change those two files, and only in rather simple 
ways at that.

So my guess is that there wasn't actually a conflict at all, but the 
"merge" program (usually in /usr/bin/merge) returned an error for some 
reason. What does "which merge" and "rpm -qf /usr/bin/merge" say?

But you can also do "git diff --ours" (or "git diff --their") to get a 
simple two-way diff of the end result of the merge to what you were 
looking at.

