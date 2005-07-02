From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Sat, 2 Jul 2005 10:16:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com>
 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com>
 <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com>
 <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org> <42C61351.10306@zytor.com>
 <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org> <42C61818.30109@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 19:15:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dolaa-0000ht-K0
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 19:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVGBRPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVGBRPP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 13:15:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261223AbVGBRPE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 13:15:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j62HEljA009982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Jul 2005 10:14:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j62HEe0Q002492;
	Sat, 2 Jul 2005 10:14:42 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C61818.30109@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 1 Jul 2005, H. Peter Anvin wrote:
> 
> It's a log.

..but that's not what we're looking for. I'm not looking for kernel.org to
be my distributed backup tape.

For it to be useful, it must do more than just log all activity and mirror
it out via rsync. It must also be usable for people pulling on it. Which
means that it has to be a valid git archive or at least easily
incrementally unpackable, so that people can actually use the end result.

A log of packs that are just incremented is certainly unpackable: you
teach git-unpack-objects to just unpack several packs after each other.  
But since it's not seekable, you'd have to unpack a 100MB compressed
archive just to get the last tip of it that you don't have unpacked yet.

Also, it means that it's impossible to efficiently do a git-specific 
thing. I want people to be able to do what we used to be able to do with 
BK: just do a

	git pull master.kernel.org:xxxx

and get something useful. And that means _not_ having to pull a 100MB blob 
to get the last objects at the end.

And don't tell me "rsync can efficiently get just the end". That's true 
for _mirrors_, but it's not true for users that don't have every single 
archive on kernel.org. I don't have (and I don't want to have) a copy of 
every single persons log that ever might want to push to me.

So no, a log simply isn't useful. It _has_ to be a valid git archive to be 
useful. Thousands of objects satisfy that. Or a "few packs + few objects". 
Not a log.

		Linus
