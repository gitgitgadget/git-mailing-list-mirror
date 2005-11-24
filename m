From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 10:44:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511241037400.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ed Tomlinson <tomlins@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750733AbVKXSoe@vger.kernel.org Thu Nov 24 19:45:36 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750733AbVKXSoe@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfM5v-0006jv-Le
	for glk-linux-kernel-3@gmane.org; Thu, 24 Nov 2005 19:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVKXSoe (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 24 Nov 2005 13:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVKXSod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:44:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbVKXSoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:44:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAOIiFnO030174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 24 Nov 2005 10:44:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAOIiE7c006913;
	Thu, 24 Nov 2005 10:44:15 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4385BAFC.7070906@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12710>



On Thu, 24 Nov 2005, Andreas Ericsson wrote:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6
> 
> which works flawlessly for me although it takes quite some time to transfer
> all the data.

The initial clone is very expensive for the native git protocol: the 
protocol is designed to scale well for incremental updates (ie you have a 
_huge_ repository that has changed just a bit, and the protocol should 
work well for that), and that makes the initial clone quite expensive as 
it marshalls the whole damn repository into this nice packed format.

So it's often nicer (certainly on the remote server) to use "rsync" for 
the initial clone, and then only after that start using the git protocol.

(This is in no way really fundamental, and the server could cache the 
packs it generates for initial clones, but that isn't implemented yet, and 
probably won't be for some times).

Of course, especially if you're mostly bandwidth-constrained and the 
server side is not under a big load, using the native git protocol may 
actually be faster anyway. Because it's always going to generate the 
nicest packing, while rsync:// will just use whatever packing that the 
server happens to have at that point (but I do repack every few weeks, so 
rsync for the initial clone should never be horribly bad - and since I 
just repacked, it should get that "perfect" pack too).

		Linus
