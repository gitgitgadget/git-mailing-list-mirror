From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 14:03:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511121352500.3263@g5.osdl.org>
References: <20051112155302.GD30496@pasky.or.cz> <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org>
 <20051112194646.GE30496@pasky.or.cz> <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org>
 <20051112212030.GH30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 23:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb3Sp-0008Gy-Ub
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVKLWDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVKLWDJ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:03:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964823AbVKLWDH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 17:03:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jACM33nO014363
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 12 Nov 2005 14:03:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jACM33CC013734;
	Sat, 12 Nov 2005 14:03:03 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051112212030.GH30496@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11712>



On Sat, 12 Nov 2005, Petr Baudis wrote:
> 
>  From kernel.org to machine X, it takes 20s, and from machine X to my
> home machine, it takes 20s. From kernel.org to my home machine, it takes
> 5 minutes.

That's a twilight zone moment ;)

The pack-file writer is even trying to be good about not doing lots of 
small writes (it should chunk things up into 8kB chunks) so it should 
actually be a nice network app and send full-sized TCP frames from the 
very beginning (and nagle should mean that it continues to do so even 
around the chunk boundaries, assuming the server is fast enough at 
generating the data).

But it's entirely possible that one of the paths between the machine has 
some logic that prioritizes known stream types - gives higher priority to 
http/ssh over "unknown" protocols. That's a bad thing to do (the whole 
point of the internet is that the smarts is in the end-points, not in the 
network), but with so much of the packets whizzing by being 
virus-generated crap, some places apparently do things like that.

			Linus
