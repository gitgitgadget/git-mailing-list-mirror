From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 09:42:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504260939440.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org> <200504260713.26020.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261693AbVDZQlR@vger.kernel.org Tue Apr 26 18:42:17 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261693AbVDZQlR@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQT6a-0005fC-Sh
	for glk-linux-kernel@gmane.org; Tue, 26 Apr 2005 18:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVDZQlR (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Tue, 26 Apr 2005 12:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:41:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:42193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261680AbVDZQkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:40:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QGeZs4001163
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 09:40:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QGeXUW025308;
	Tue, 26 Apr 2005 09:40:34 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504260713.26020.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Apr 2005, Chris Mason wrote:
> 
> This agrees with my tests here, the time to apply patches is somewhat disk 
> bound, even for the small 100 or 200 patch series.  The io should be coming 
> from data=ordered, since the commits are still every 5 seconds or so.

Yes, ext3 really does suck in many ways.

One of my (least) favourite suckage is a process that does "fsync" on a
single file (mail readers etc), which apparently causes ext3 to sync all
dirty data, because it can only sync the whole log. So if you have stuff
that writes out things that aren't critical, it negatively affects
something totally independent that _does_ care.

I remember some early stuff showing that reiserfs was _much_ better for 
BK. I'd be willing to bet that's probably true for git too.

		Linus
