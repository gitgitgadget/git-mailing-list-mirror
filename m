X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] change the unpack limit treshold to a saner value
Date: Wed, 6 Dec 2006 19:39:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612061935250.3615@woody.osdl.org>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
 <Pine.LNX.4.64.0612061700120.3542@woody.osdl.org> <Pine.LNX.4.64.0612062213500.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 03:39:49 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612062213500.2630@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33546>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsA6r-00033f-P1 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 04:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968059AbWLGDjn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 22:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968104AbWLGDjn
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 22:39:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43271 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968059AbWLGDjm
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 22:39:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB73daID021278
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 6
 Dec 2006 19:39:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB73dZDh027608; Wed, 6 Dec
 2006 19:39:35 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Wed, 6 Dec 2006, Nicolas Pitre wrote:
> 
> Note that this setting is currently observed for pushes not pulls.
> On the pull side you currentli need to provide -k for not exploding 
> packs.

So noted.

> So the question is what number of objects on average do pushes have?  If 
> most pushes are below the treshold this is not going to be really 
> useful.

It will depend a lot on the project, and "where" in the project you are.

For example, for most end developers, the "push" is likely going to be a 
few commits (say, a days work). Probably on the order of a few tens to 
maybe a few hundred objects. It's actually hard to create a pack with less 
than ten objects if you have a few directory levels (a single small commit 
in the kernel is usually 5-7 objects: commit + 2-3 levels of directory + a 
couple of blobs).

For me, as I pull a big merge and push it out, a push can easily be in the 
thousands of objects, just because I merged other peoples combined work 
over several weeks.

And for a "mirror" server, it will depend on the granularity of the 
mirroring.

> And I think 5000 is definitely way too high.  10 might be too small 
> indeed.  100 is maybe a good default to try out.

I think 100 is a nice round number for humans. Worth trying.

