From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 14:39:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271431510.18901@ppc970.osdl.org>
References: <20050426135606.7b21a2e2.akpm@osdl.org><20050426135606.7b21a2e2.akpm@osdl.org>
 <20050427063439.GA22014@elte.hu> <426FFFAB.1030005@tmr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Magnus Damm <magnus.damm@gmail.com>, mason@suse.com,
	mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:33:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQu9B-000716-Ds
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 23:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVD0Vhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVD0Vhq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 17:37:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:36332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262036AbVD0Vh3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 17:37:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RLb4s4017570
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 14:37:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RLb36w010868;
	Wed, 27 Apr 2005 14:37:03 -0700
To: Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <426FFFAB.1030005@tmr.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Bill Davidsen wrote:
> 
> I said much the same in another post, but noatime is not always what I 
> really want.

"atime" is really nasty for a filesystem. I don't know if anybody noticed, 
but git already uses O_NOATIME to open all the object files, because if 
you don't do that, then just looking at a full kernel tree (which has more 
than a thousand subdirectories) will cause nasty IO patterns from just 
writing back "atime" information for the "tree" objects we looked up.

So you can do (and git does) selective atime updates. It just requires a 
small amount of extra care. 

> How about a "nojournalatime" option, so the atime would be 
> updated at open and close, but not journaled at any other time.

Probably a good idea. 

		Linus
