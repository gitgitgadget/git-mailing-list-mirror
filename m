From: Chris Mason <mason@suse.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 11:38:45 -0400
Message-ID: <200504261138.46339.mason@suse.com>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Mike Taht <mike.taht@timesys.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 17:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQS4F-00016u-H9
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 17:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDZPix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 11:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDZPix
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 11:38:53 -0400
Received: from ns.suse.de ([195.135.220.2]:54166 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261527AbVDZPit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 11:38:49 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 13A47160BD58;
	Tue, 26 Apr 2005 17:38:49 +0200 (CEST)
To: Magnus Damm <magnus.damm@gmail.com>
User-Agent: KMail/1.8
In-Reply-To: <aec7e5c305042608095731d571@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 26 April 2005 11:09, Magnus Damm wrote:
> On 4/26/05, Chris Mason <mason@suse.com> wrote:
> > This agrees with my tests here, the time to apply patches is somewhat
> > disk bound, even for the small 100 or 200 patch series.  The io should be
> > coming from data=ordered, since the commits are still every 5 seconds or
> > so.
>
> Yes, as long as you apply the patches to disk that is. I've hacked up
> a small backend tool that applies patches to files kept in memory and
> uses a modifed rabin-karp search to match hunks. So you basically read
> once and write once per file instead of moving data around for each
> applied patch. But it needs two passes.
>
> And no, the source code for the entire Linux kernel is not kept in
> memory - you need a smart frontend to manage the file cache. Drop me a
> line if you are interested.

Sorry, you've lost me.  Right now the cycle goes like this:

1) patch reads patch file, reads source file, writes source file
2) update-cache reads source file, writes git file

Which of those writes are you avoiding?  We have a smart way to manage the 
cache already for the source files...the vm does pretty well.  There's 
nothing to manage for the git files.  For the apply a bunch of patches 
workload, they are write once, read never (except for the index).

-chris

