From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries
 too.
Date: Mon, 4 Jun 2007 17:21:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706041715500.23741@woody.linux-foundation.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> 
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
 <Pine.LNX.4.64.0706041923580.22840@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 02:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvMno-0007gb-Vn
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 02:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561AbXFEAVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 20:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758023AbXFEAVa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 20:21:30 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:53737 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757561AbXFEAV3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 20:21:29 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l550LPvW009892;
	Mon, 4 Jun 2007 17:21:26 -0700
In-Reply-To: <Pine.LNX.4.64.0706041923580.22840@iabervon.org>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.182 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49144>



On Mon, 4 Jun 2007, Daniel Barkalow wrote:
> 
> Actually, I've been playing with using git's data-distribution mechanism 
> to distribute generated binaries. You can do tags for arbitrary binary 
> content (not in a tree or commit), and, if you have some way of finding 
> the right tag name, you can fetch that and extract it.

Yes, I think git should be very nice for doing binary stuff like firmware 
images too, my only worry is literally about "mixing it in" with other 
stuff.

Putting lots of binary blobs into a git archive should work fine: but 
if you would then start tying them together (with a commit chain), it just 
means that even if you only really want _one_ of them, you end up getting 
them all, which sounds like a potential disaster.

On the other hand, if you actually want a way to really *archive* the dang 
things, that may well be what you actually want. In that case, having a 
separate branch that only contains the binary stuff might actually be what 
you want to do (and depending on the kind of binary data you have, the 
delta algorithm might even be good at finding common data sequences and 
compressing it).

> I came up with this at my job when we were trying to decide what to do 
> with firmware images that we'd shipped, so that we'd be able to examine 
> them again even if we lose the compiler version we used at the time. We 
> needed an immutable data store with a mapping of tags to objects, and I 
> realized that we already had something with these exact characteristics.

Yeah, if you just tag individual blobs, git will keep track of them, but 
won't link them together, so you can easily just look up and fetch a 
single one from such an archive. Sounds sane enough.

		Linus
