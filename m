X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Tue, 5 Dec 2006 10:28:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 18:29:11 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4575B32F.5060108@ramsay1.demon.co.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33361>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grf2S-0003y7-Ly for gcvg-git@gmane.org; Tue, 05 Dec
 2006 19:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968609AbWLES3F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968598AbWLES3F
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 13:29:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34020 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968609AbWLES3C
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 13:29:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB5IStID014722
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 5
 Dec 2006 10:28:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB5ISr8D006469; Tue, 5 Dec
 2006 10:28:54 -0800
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org



On Tue, 5 Dec 2006, Ramsay Jones wrote:
>
> Have you had time to look at my test cases?
> As I said, I found them very useful when debugging
> my git-diff3 code, and (hopefully) you will find them
> to be equally useful.

It might be interesting to also do a simple test:

 - take every single merge in git (or the kernel, if you want even more)

 - ignore all the trivial ones that didn't have any file-level merging at 
   all (ie done entirely in the index)

 - for all the rest, just compare what the end result is when re-doing the 
   merge with "xdl_merge" vs "external 3-way merge".

[ Side note: DO NOT COMPARE AGAINST THE ACTUAL RESULT IN GIT OR IN THE 
  KERNEL ARCHIVE! Those will obviously have been fixed up by humans in the 
  event of a data conflict, and sometimes even in the _absense_ of a data 
  conflict (ie "git commit --amend" to fix up something that got mismerged 
  perfectly automatically or whatever).

  So a script should literally re-do the merge two ways, and compare the 
  end result ]

Is that any "proof"? Of course not. And it will probably show differences 
due to any conflict handling, but a lot of the time you'd expect to get 
exactly the same end result, so the occasional differences are going to be 
just all the more interesting ("it resolved differently, but it was 
an equally good resolve" is interesting data on its own).

Anybody want to write a small script to do this?

