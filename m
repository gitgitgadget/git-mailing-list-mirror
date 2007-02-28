From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 12:06:41 -0500
Message-ID: <20070228170641.GC5924@spearce.org>
References: <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com> <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org> <17893.43522.511785.121778@lisa.zopyra.com> <17893.44181.129918.669187@lisa.zopyra.com> <20070228163256.GD5479@spearce.org> <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com> <20070228164922.GB5924@spearce.org> <17893.46083.869042.467318@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSGO-0005V0-88
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbXB1RGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933167AbXB1RGq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:06:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55874 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165AbXB1RGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:06:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMSGC-0006Nc-VH; Wed, 28 Feb 2007 12:06:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4DA0920FBAE; Wed, 28 Feb 2007 12:06:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17893.46083.869042.467318@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40968>

Bill Lear <rael@zopyra.com> wrote:
> % strace -f -o tracefile git clone --bare ~/devel/project
> [...]
> fatal: cannot pread pack file: Success from=39395, packfile size=0
> [...]
> % grep pread tracefile
> 28635 pread(3,  <unfinished ...>
> 28635 <... pread resumed> "", 207, 39395) = 0
> 28635 write(2, "cannot pread pack file: Success "..., 59) = 59

Well, that answers that.  The packfile is 0 bytes long.  Why?
We downloaded the data and are trying to resolve deltas... but
when we go back into the packfile we thought we had, we find it is
nothing but an empty file.  NFS strikes again!

Have you been able to clone onto this drive before?  Maybe with a
different version of Git (1.4.x series, before this pread change
in index-pack)?  Clearly this operation should be working, but
its not, and I'm certainly at a loss for why the file would just
magically truncate itself.

-- 
Shawn.
