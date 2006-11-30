X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 17:08:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:09:04 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32810>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpu5C-00018t-0x for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031530AbWK3WI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031537AbWK3WI2
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:08:28 -0500
Received: from iabervon.org ([66.92.72.58]:43280 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1031530AbWK3WI1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:08:27 -0500
Received: (qmail 8859 invoked by uid 1000); 30 Nov 2006 17:08:24 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 30
 Nov 2006 17:08:24 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

One thing that I think is non-intuitive to a lot of users (either novice 
or who just don't do it much) is that it matters where in the process you 
do "git add <path>" if you're also changing the file. Even if you 
understand the index, you may not realize (or may not have internalized 
the fact) that what git-add does is update the index with what's there 
now.

I think the more obvious behavior is to have it record the fact that you 
want to have the path tracked, but require one of the usual updating 
mechanisms to get a particular content into the index.

This should be pretty simple to implement: use --cacheinfo 0 0 $path 
instead of --add -- $path, and teach programs that look at the objects 
recorded in the index (rather than just hashes or other info) about all-0 
hashes meaning "but no content there". write-tree would probably just 
skip the entry (and then you could add a file, but still produce commits 
without it until you actually do either an update-index explicitly or one 
of the commit option sets that updates it); diff would treat it as empty; 
checkout would ignore it.

	-Daniel
