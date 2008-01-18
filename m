From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 08:42:01 +0000
Message-ID: <20080118084201.GA14763@hashpling.org>
References: <20080118035700.GA3458@spearce.org> <alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:43:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmoZ-0001jp-Bm
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbYARIme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 03:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYARIme
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:42:34 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:40886 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYARImd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:42:33 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JFmnf-0005b5-J0; Fri, 18 Jan 2008 08:42:07 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0I8g14S015185;
	Fri, 18 Jan 2008 08:42:01 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0I8g1qk015184;
	Fri, 18 Jan 2008 08:42:01 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70977>

On Thu, Jan 17, 2008 at 08:27:08PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 17 Jan 2008, Shawn O. Pearce wrote:
> >
> > fast-import was relying on the fact that on most systems mmap() and
> > write() are synchronized by the filesystem's buffer cache.  We were
> > relying on the ability to mmap() 20 bytes beyond the current end
> > of the file, then later fill in those bytes with a future write()
> > call, then read them through the previously obtained mmap() address.
> > 
> > This isn't always true with some implementations of NFS, but it is
> > especially not true with our NO_MMAP=YesPlease build time option used
> > on some platforms.
> 
> In fact, even with mmap(), it's not guaranteed. There are really crappy 
> mmap implementations out there, partly due to bad CPU design (virtual CPU 
> caches without coherency), but more often due to total crap OS.
> 
> (Yeah, Linux did count in that area at some point. Long ago. Early 90's. 
> Maybe)
> 
> I think HP-UX used to have non-coherent mmap for the longest time, due to 
> carrying around some totally crap memory management based on some ancient 
> BSD version that everybody else (including the BSD's) had long since 
> jettisoned.
> 
> That said, I suspect any unix you can run today (without calling it a 
> retro setup) probably has coherent-enough mmap. The possible virtual cache 
> coherency issue is unlikely to be able to trigger this (and not relevant 
> on any sane hardware anyway).
> 
> 				Linus

I've just checked the Mac OS X build and it looks like there is a mmap
and git is indeed using it, so this is obviously an example of a
"really crappy" mmap implementation.

This adds more ammunition to the fight against the whole Mac OS X is
powered/built/based on UNIX myth.

Charles.
