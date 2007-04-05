From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to control pack size
Date: Thu, 5 Apr 2007 13:14:32 -0400
Message-ID: <20070405171432.GK5436@spearce.org>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com> <alpine.LFD.0.98.0704041750030.28181@xanadu.home> <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com> <20070405065433.GD5436@spearce.org> <Pine.LNX.4.64.0704050831520.6730@woody.linux-foundation.org> <20070405155306.GI5436@spearce.org> <Pine.LNX.4.64.0704050910590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 19:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZVY7-000398-4B
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 19:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767137AbXDEROt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 13:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767143AbXDEROt
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 13:14:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42483 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767137AbXDEROr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 13:14:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZVXY-0007EI-5n; Thu, 05 Apr 2007 13:14:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 05A3820FBAE; Thu,  5 Apr 2007 13:14:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704050910590.6730@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43844>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Thu, 5 Apr 2007, Shawn O. Pearce wrote:
> > 
> > Sure, OK, but that libc function doesn't exist on Mac OS X:
> 
> My bad. It's *not* linux-specific like the OSX man-page apparently says, 
> it's very traditional. But the right name is "lseek64()" (and offt64_t for 
> the size).

Sorry for the confusion, that manpage snippet came from a Gentoo/x86
system.  But I digress, you are right, the right interfaces to be
using here is lseek64 and open64.

Now those also don't eixst on OSX, because as you pointed out, they
have no legacy to deal with and are just using sizeof off_t == 8.

So we'd probably have to do something like:

	#ifndef _LFS_LARGEFILE
	#define open64 open
	#define lseek64 lseek
	#endif

and then start using the open64/lseek64 variants instead.  Or do
the reverse #define's.  ;-)

-- 
Shawn.
