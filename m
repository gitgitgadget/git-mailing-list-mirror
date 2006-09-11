From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 19:49:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609101946330.27779@g5.osdl.org>
References: <20060910190332.17667.qmail@science.horizon.com> 
 <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
 <9e4733910609101400j2604ace1vdb2e363c1296418f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Sep 11 04:50:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMbsD-0006PA-BH
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 04:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWIKCuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 22:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWIKCuH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 22:50:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11214 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbWIKCuG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 22:50:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8B2nenW004886
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Sep 2006 19:49:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8B2nc4w028037;
	Sun, 10 Sep 2006 19:49:39 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609101400j2604ace1vdb2e363c1296418f@mail.gmail.com>
X-Spam-Status: No, hits=-0.516 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26830>



On Sun, 10 Sep 2006, Jon Smirl wrote:
> 
> Is the kernel mapped into user processes using huge pages?

Yup. Huge pages and global. So the kernel should have fairly low TLB 
impact (depending on CPU - the kernel also has less locality than user 
space, since the data structures are all over the place, and some CPU's 
have very few hugepage entries. System code generally tends to have much 
worse I$ and TLB behaviour than most user apps, but at least the hugepage 
mappings tend to mitigate the TLB side somewhat).

> Another thing that should be mapped with huge pages is the video RAM.

I doubt it ends up being a huge deal in most cases. If you don't use the 
graphics chip to access video RAM with accelerated methods, the TLB is the 
_least_ of your worries. Going over the PCI bus (even with PCI-X etc) is 
the real problem.

There's a reason you want to do acceleration even in 2D..

		Linus
