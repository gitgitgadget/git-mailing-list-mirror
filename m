From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-repack: Outof memory
Date: Sun, 17 Sep 2006 20:23:57 -0400
Message-ID: <20060918002357.GA19727@spearce.org>
References: <450CA561.9030602@gmail.com> <20060917022534.GB7512@spearce.org> <4b3406f0609161946x52a89dd3q6d74127c376270e7@mail.gmail.com> <20060917031853.GC7512@spearce.org> <4b3406f0609170003t63a2f9f4pf2c42faec9746a73@mail.gmail.com> <4b3406f0609170543p68d96b9x9ba0c5a74d9e89e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 02:24:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP6vf-0002yS-CW
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 02:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWIRAYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 20:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWIRAYE
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 20:24:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:5274 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965167AbWIRAYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 20:24:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GP6vN-0008EN-9u; Sun, 17 Sep 2006 20:23:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E720720FB1F; Sun, 17 Sep 2006 20:23:57 -0400 (EDT)
To: Dongsheng Song <dongsheng.song@gmail.com>
Content-Disposition: inline
In-Reply-To: <4b3406f0609170543p68d96b9x9ba0c5a74d9e89e8@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27213>

Dongsheng Song <dongsheng.song@gmail.com> wrote:
> finished, thanks a lot.
> 
> $ ls -l .git/objects/pack/
> total 1675466
> -rw-r--r-- 1 www-data www-data    2964992 Sep 17 19:17
> pack-b09c57c25e4459f6365b5d27139abfd93bf1c86f.idx
> -rw-r--r-- 1 www-data www-data 1711037142 Sep 17 19:17
> pack-b09c57c25e4459f6365b5d27139abfd93bf1c86f.pack
> 
> If the pack files larger than 2.5g,  how can  I repack it on i686 ?

*youch* A 1.5 GiB pack file?

Your files apparently do not delta compress very well.  I fear that
you are going to bump up against address space limitations soon
on 32 bit systems.  Then you will bump up against the 4 GiB pack
file size limit.  Which means you will need to use several packs
and avoid the '-a' flag when calling git-repack.

Nico was suggesting using the default window size (rather than
--window=64) as larger windows requires more memory during repack.
But you may also need the mmap window code I'm working on.  I better
hurry up and get that into Junio's testing branches.  :-)

-- 
Shawn.
