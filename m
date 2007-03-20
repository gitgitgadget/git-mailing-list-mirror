From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 01:56:11 -0400
Message-ID: <20070320055611.GD29288@spearce.org>
References: <1174361424.3143.42.camel@dv> <Pine.LNX.4.64.0703192148430.6730@woody.linux-foundation.org> <1174367312.3143.75.camel@dv> <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTXKb-0003QJ-Hs
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXCTF4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbXCTF4W
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:56:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38818 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbXCTF4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:56:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTXKP-0001UG-0N; Tue, 20 Mar 2007 01:56:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F265E20FBAE; Tue, 20 Mar 2007 01:56:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42718>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 20 Mar 2007, Pavel Roskin wrote:
> > 
> > .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 is the same 9
> > bytes:  30 78 9c 03 00 00 00 00 01
> 
> Ahh.. You have
> 
> 	[core]
> 		legacyheaders = false
> 
> don't you? If you didn't, you should see a 15-byte object, not a 9-byte 
> one.
> 
> And yes, I can reproduce this with that "core.legacyheaders=false" 
> setting. It seems that config option is simply broken, and we never 
> noticed, because almost nobody uses it.

For what it is worth, I have been running core.legacyheaders=false
on both my PowerBook (my main dev system) and on my x86 Cygwin
POS.  I guess I've been lucky, as I've never noticed any sort
of corruption.

Oh, wait, yes I did.  Just the other day.  A loose object got the
same zlib error as Pavel asked about.  But git-prune whacked the
damn thing.  I figured it was just a short write by Cygwin during
some sort of operation that I may have aborted; e.g. aborting an
update-index and running it again later, thus never actually using
that particular blob.

I didn't think twice about the error (until now), especially since
`git-fsck --full` did not whine after the corrupt loose object
was gone.

-- 
Shawn.
