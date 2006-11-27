X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 17:06:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 01:07:00 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32376>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoUxN-00047Q-GV for gcvg-git@gmane.org; Mon, 27 Nov
 2006 02:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755735AbWK0BGp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 20:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbWK0BGp
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 20:06:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:28627 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1755735AbWK0BGp (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 20:06:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAR169ix022023
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 26
 Nov 2006 17:06:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAR168tF015538; Sun, 26 Nov
 2006 17:06:09 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 26 Nov 2006, Junio C Hamano wrote:
>
> This implements an experimental "git log-fpc" command that shows
> short-log style output sorted by topics.
> 
> A "topic" is identified by going through the first-parent
> chains; this ignores the fast-forward case, but for a top-level
> integrator it often is good enough.

Umm. May I suggest that you try this with the kernel repo too..

There, the "first parent chain" tends to be less interesting than a lot of 
other heuristics:

 - committer

   If the committer changes, you should probably consider it a break, the 
   same way a second parent would be a break. You probably won't see this 
   in the git archive, because there tends to be a single committer, but 
   on something like the kernel where we really merge other peoples repos, 
   it's going to be as good (or better) than looking at "other parents".

 - subdirectory heuristics

   Again, with git it's not very interesting, but I bet that you'd be able 
   to use heuristics like "the bulk of the changes were contained within 
   this directory tree" for projects like the kernel, and automatically 
   decide on "topics" like drivers/scsi, fs/ext3 etc.

In other words, I don't think the "fpc" decision is even very interesting. 
If you _really_ want to do a cool shortlogger, I bet it can be done, but I 
suspect that it would be a LOT cooler to do some automatic bayesian 
clustering based on committer, author and list of filenames changed.

Of course, such a thing done well would probably be worthy of a doctoral 
thesis or something. Maybe somebody on this list who is into bayesian 
clustering and doesn't have a thesis subject...

(Of course, since I haven't been in a University setting for the last ten 
years, maybe bayesian clustering isn't the cool thing to work on any 
more).

Anyway, "topics" really should be something that is extremely open to 
various clustering models, bayesian or not ..

