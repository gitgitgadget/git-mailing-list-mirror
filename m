From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 10:06:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200957030.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504201122.35448.mason@suse.com>
 <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org> <200504201237.38374.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 19:01:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIYg-0000lt-Ux
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDTRE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDTRE0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:04:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:8378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261650AbVDTREV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:04:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KH4Hs4012081
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 10:04:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KH4GNL014242;
	Wed, 20 Apr 2005 10:04:17 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504201237.38374.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Chris Mason wrote:
> 
> At any rate, the time for a single write-tree is pretty consistent.  Before it 
> was around .5 seconds, and with this change it goes down to .128s.

Oh, wow.

I bet your SHA1 implementation is done with hand-optimized and scheduled
x86 MMX code or something, while my poor G5 is probably using some slow
generic routine. As a result, it only improved by 33% for me since the
compression was just part of the picture, but with your cheap SHA1 the
compression costs really dominated, and so it's almost four times faster
for you.

Anyway, that's good. It definitely means that I consider tree writing to 
be "fast enough". You can commit patches in a third of a second on your 
machine.

I'll consider the problem solved for now. Yeah, I realize that it still 
takes you half a minute to commit the 100 quilt patches, but I just can't 
bring myself to think it's a huge problem in the kind of usage patterns I 
think are realistic.

If somebody really wants to replace quilt with git, he'd need to spend
some effort on it. If you just want to work together reasonably well, I
think 3 patches per second is pretty much there.

			Linus
