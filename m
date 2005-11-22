From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: auto-packing on kernel.org? please?
Date: Mon, 21 Nov 2005 21:41:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
 <20051121190151.GA2568@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
 <4382AC11.5090209@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 06:54:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeR0Q-00022m-3T
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVKVFrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVKVFrq
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:47:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932347AbVKVFrp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 00:47:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAM5fLnO000980
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 21:41:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAM5fHMg023907;
	Mon, 21 Nov 2005 21:41:18 -0800
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <4382AC11.5090209@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12529>



On Tue, 22 Nov 2005, Chuck Lever wrote:
>
> there are some things repacking does that breaks StGIT, though.
> 
> git repack -d
> 
> seems to remove old commits that StGIT was still depending on.

If that is true, then "git-fsck-cache" probably also reports errors on a 
StGIT repository. No? Basically, it implies that the tool doesn't know how 
to find all the "heads".

Could somebody (Catalin?) perhaps tell how tools like git-fsck-cache and 
git-repack could figure out which objects are still in use by stgit?

Preferably with some generic mechanism that _other_ projects (not just 
stgit) might want to use?

The preferred way would be to just list the references somewhere under 
.git/refs/stgit, in which case fsck and repack should pick them up 
automatically (so clearly stgit doesn't do that right now ;).

It also implies that doing a "git prune" will do horribly bad things to a 
stgit repo, since it would remove all the objects that it thinks aren't 
reachable..

> git repack -a -n
> 
> seems to work fine with StGIT,

Well, it "works", but not "fine". Since it doesn't know about the stgit 
objects, it won't ever pack them.

But maybe that's what stgit wants (since they are "temporary"), but it 
does mean that if you see a big advantage from packing, you might be 
losing some of it.

		Linus
