X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 25 Nov 2006 11:30:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org>
 <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
 <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
 <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 25 Nov 2006 19:31:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45689747.3020403@midwinter.com>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32302>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go3F9-000876-Gr for gcvg-git@gmane.org; Sat, 25 Nov
 2006 20:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967144AbWKYTbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 14:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967143AbWKYTbQ
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 14:31:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19158 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967144AbWKYTbP (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 14:31:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAPJUlix030874
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 25
 Nov 2006 11:30:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAPJUkYi010582; Sat, 25 Nov
 2006 11:30:47 -0800
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org



On Sat, 25 Nov 2006, Steven Grimm wrote:

> Linus Torvalds wrote:
> > So I actually think that submodules should at least start out as something
> > rather independent, where a "commit -a" in the supermodule will _only_
> > commit the supermodule itself - and if you haven't committed the submodule
> > yet, you'll just get the current HEAD state of the submodule.
> 
> That would make it impossible to atomically commit a change that affects two
> submodules, yes?

No. Quite the reverse. What you do is:

 (a) commit both submodules INDEPENDENTLY.

 (b) then commit the supermodule that contains the submodules.

And note how the important part here is that committing in a submodule 
DOES NOT AFFECT THE SUPERMODULE AT ALL!

The git trees are _independent_. That's important. You should _not_ try to 
mix them up and make a commit in one commit anything AT ALL in some other 
tree, exctly because it gets impossible to do (a) interesting things and 
(b) atomic commits otherwise.

Note that this is true also in the case of a submodule that itself 
contains a submodule. That doesn't change anything - you still need to be 
able to view _each_ layer as an independent thing.

