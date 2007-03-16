From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 21:10:29 -0400
Message-ID: <20070316011029.GG29547@spearce.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS0xw-0003N4-02
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbXCPBKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbXCPBKe
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:10:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58788 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbXCPBKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:10:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HS0xY-00059R-Ky; Thu, 15 Mar 2007 21:10:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 58D5420FBAE; Thu, 15 Mar 2007 21:10:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42309>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I looked at git profiles yesterday, and some of them are pretty scary. We 
> spend about 50% of the time under some loads in just zlib uncompression, 
> and when I actually looked closer at the zlib sources I can kind of 
> understand why. That thing is horrid.

Yes.  This is actually one of the motivations behind pack v4.
We don't store the "important bits" of commits and trees in zlib
compressed format at all; allowing us to completely bypass the
inflate() penalty you describe.

We're already much faster on the linux-2.6 kernel tree, and that's
*with* converting the pack raw data into text, then reparsing
that text into a struct commit* or a struct name_entry using the
current code.  We're also planning on reworking those parsers to
parse the raw pack data, allowing us to save some very unnecessary
raw->string->raw conversion time.

But Nico and I still looking to use zlib for commit messages and
blob content, so any improvements to inflate (or its replacement)
would still be most helpful.

-- 
Shawn.
