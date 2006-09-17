From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-repack: Outof memory
Date: Sat, 16 Sep 2006 22:25:35 -0400
Message-ID: <20060917022534.GB7512@spearce.org>
References: <450CA561.9030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 04:25:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOmLl-0008AP-NR
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 04:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWIQCZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 22:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWIQCZj
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 22:25:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50117 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964926AbWIQCZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 22:25:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GOmLU-0007ic-O3; Sat, 16 Sep 2006 22:25:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 283B720FB1F; Sat, 16 Sep 2006 22:25:35 -0400 (EDT)
To: Dongsheng Song <dongsheng.song@gmail.com>
Content-Disposition: inline
In-Reply-To: <450CA561.9030602@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27155>

Dongsheng Song <dongsheng.song@gmail.com> wrote:
> I'm import from subversion. The problem appears to be git-repack phase using too many memory:
> 
> $ git-repack -a -f -d --window=64 --depth=64
> Generating pack...
> Done counting 123497 objects.
> Deltifying 123497 objects.
>   24% (29677/123497) done
> 
> $ top
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  3572 www-data  18   0 2591m 1.9g  528 R   13 94.8  81:48.98 git-pack-object

*ouch* You are probably running out of address space if you are on
a 32 bit architecture.  A 2.5 GiB virtual address space is pretty
close to the maximum allowed on most OSes.

The code that I'm sitting on but haven't yet completed rebasing
onto current Git would probably help here.

Do you have any existing .pack files in .git/objects/pack?  How big
are they and their corresponding .idx files?

git-repack will need to mmap every .pack and .idx in
.git/objects/pack, plus it needs working memory for each object
(123,497 of 'em) but as I recall its pretty frugal on its per-object
allocation.  It can easily work with as many as 2 million objects on
a 32 bit system, assuming the .pack and .idx files aren't too large.
 
-- 
Shawn.
