X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 14:41:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281432300.4244@woody.osdl.org>
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
 <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 22:42:05 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32601>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBeG-0003dU-6w for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754505AbWK1Wlw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbWK1Wlw
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:41:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:26035 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1754505AbWK1Wlv (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:41:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASMfWix009418
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 14:41:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASMfV5S029004; Tue, 28 Nov
 2006 14:41:32 -0800
To: Nicholas Allen <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org



On Tue, 28 Nov 2006, Linus Torvalds wrote:
> On Tue, 28 Nov 2006, Nicholas Allen wrote:
> > 
> > All useful conflict status is lost isn't it?
> 
> No, it's actually there, but "git status" doesn't really explain it to 
> you.

Side note, to clarify: in the _simple_ cases it's all actually there.

I can well imagine that in more complex cases, involving multiple 
different files, you may well want to re-do the merge and let the merge 
tell you why it refused to merge something.

So the index, for example, contains just a "final end result" of what the 
merge gave up on, and while for a simple rename conflict like your example 
you could certainly see that directly from the index state (and thus we 
could, for example, have a "git status" that talks about it being a 
filename conflict), if you have a criss-cross rename, the index itself 
doesn't really tell you _why_, and it could look superficially like a data 
conflict. 

In such a case, you'd really have to either go back to the merge itself to 
see what happened, or you'd use the "git log" thing and just work it out 
from there (ie you can ask "git log" to tell you about any renames as they 
happened etc).

I don't think I've actually hit a complex enough merge to need this yet, 
but the graphical tools should help too, ie "gitk --merge" should give you 
everything that "git log --merge" gives you (ie just the commits that 
aren't common, and simplified to just the ones that matter for the 
unmerged filenames in the end result). I can well imagine that being 
useful too.

So the tools are certainly there. "git status" just isn't necessarily the 
best one (or the best that it could be, for that matter)..

