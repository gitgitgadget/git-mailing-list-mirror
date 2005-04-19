From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 15:21:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191514550.2274@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com>
 <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org><200504191412.00227.mason@suse.com>
 <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org>
 <Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:16:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO10I-0004Zh-Sj
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVDSWTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDSWTk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:19:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:35003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261698AbVDSWTT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:19:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JMJ8s4022906
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 15:19:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JMJ3WI002996;
	Tue, 19 Apr 2005 15:19:05 -0700
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, David Lang wrote:
> 
> what if you turned the forest of quilt patches into a forest of git trees? 
> (essentially applying each patch against the baseline seperatly) would 
> this make sense or be useful?

It has a certain charm, but the fact is, it gets really messy to sort out 
later.

The thing is, there's a huge benefit to a straight-line tree: you can do 
binary searching etc of patches that cause problems, and in general it's 
just a lot _easier_ to work with a linear set of patches for pretty much 
everybody.

So yes, it's "cool" to show the fact that patches are independent and show 
them as each applying to the baseline (and then you can have the "mother 
of all merges" that ties them all together), but that's just a _nightmare_ 
when you actually try to debug things and sort things out.

So while I'm a huge proponent of parallell development, and having lots of
branches, I actually think that _linearizing_ stuff is a good thing. 

So let's put it this way: parallel development and merging is wonderful as
a tool to handle true distributed development, and it's the thing that GIT
really tries to do. But once you have "local" development (like in a set
of quilt patches), the _last_ thing you want to do is try to make it look
parallel. You're much better off picking a good order, and sticking with
it. Because otherwise, 2 months down the line, you'll just look at that
tree, and what you'll want to do is to visualize them linearly anyway.

		Linus
