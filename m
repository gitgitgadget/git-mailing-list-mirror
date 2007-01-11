From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 04:50:46 -0500
Message-ID: <20070111095046.GA28309@spearce.org>
References: <200701110941.22024.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4waD-0002Wa-Ru
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbXAKJuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965359AbXAKJuv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:50:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37556 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965341AbXAKJuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:50:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4waB-0004NM-IQ; Thu, 11 Jan 2007 04:50:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F333620FBAE; Thu, 11 Jan 2007 04:50:46 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701110941.22024.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36570>

Andy Parkins <andyparkins@gmail.com> wrote:
> The best solution is probably to use the line ending of the conflicted lines.  
> I've had a look, but I can only fine builtin-rerere.c that generates the 
> markers - would that be the place to make this change?

builtin-rerere may need to change but the code that's actually
creating the conflict markers isn't there.  Its somewhere in
xdiff/xmerge.c.  I say somewhere as I haven't dredged down into
that code myself, but I know that's where xdl_merge() is and I
know its xdl_merge() that actually created the content of the
conflict file during the merge.

That said I don't really care about this problem that much.
The problem that I care about is its far too easy to convert the
lineendings in a file (e.g. CRLF->LF, LF->CRLF).  This causes the
entire file to differ, making merges very difficult.  I really
should just fix it (in the one place where it matters to me) by
modifying the pre-commit hook to look for such a case and abort.

-- 
Shawn.
