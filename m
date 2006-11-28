X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 14:25:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <456CB197.2030201@onlinehome.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 22:25:57 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456CB197.2030201@onlinehome.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32598>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBOG-0007zQ-8A for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757801AbWK1WZU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757830AbWK1WZU
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:25:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56237 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1757801AbWK1WZS (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:25:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASMPCix008082
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 14:25:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASMPBbe028441; Tue, 28 Nov
 2006 14:25:11 -0800
To: Nicholas Allen <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org



On Tue, 28 Nov 2006, Nicholas Allen wrote:
> 
> Also what happens if I loose the messages because they scrolled off
> screen or the power goes down, I need to reboot for some reason, or I
> don't have time and want to shutdown my computer restart another day and
> resolve the conflicts then?

I'd suggest just re-doing the merge. Something like

	git reset --hard
	git merge -m "dummy message" MERGE_HEAD

will do it for you (that's the new "nicer syntax" for doing a merge, in 
real life I'd personally just have done a re-pull or somehing)

> All useful conflict status is lost isn't it?

No, it's actually there, but "git status" doesn't really explain it to 
you.

The go-to command tends to be "git diff", which after a merge will not 
show anything that already merged correctly (because it will have been 
updated in the git index _and_ updated in the working tree, so there will 
be no diff from stuff that auto-merged). So any output at all after a 
failed merge from "git diff" generally tells you exactly what failed.

But since 99%+ of all merge conflicts are data-conflicts, I suspect the 
output is mostly geared towards that.

The other useful tools to be used are "git log --merge" (explained in a 
separate mail) and for people like me who like the git index and grok it 
fully, doing a

	git ls-files --unmerged --stage

is probably what I'd do (but I have to admit, that is _not_ a very 
user-friendly interface - you need to not only have understood the index 
file, you actually need to understand it on a very deep level).

"git status" is really used to be just a stupid around "git ls-files" 
(it's now largely a built-in), but it was really _so_ stupid that it 
doesn't really try to explain what it does - it's more like a simplified 
version of ls-files with some of the information pruned away, and other 
parts in a slightly more palatable format ;)

So improving "git status" might mean that some people could avoid having 
to learn about the index file details ;)

