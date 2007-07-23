From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fast-import and core.autocrlf option
Date: Sun, 22 Jul 2007 23:45:14 -0400
Message-ID: <20070723034514.GZ32566@spearce.org>
References: <a1bbc6950707221559m63fb1295jc26b1327e71687e3@mail.gmail.com> <Pine.LNX.4.64.0707230039560.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICorV-0006EM-U3
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 05:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbXGWDpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 23:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbXGWDpU
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 23:45:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40927 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbXGWDpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 23:45:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICor1-0006lo-N6; Sun, 22 Jul 2007 23:45:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C9A8620FBAE; Sun, 22 Jul 2007 23:45:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707230039560.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53380>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 22 Jul 2007, Dmitry Kakurin wrote:
> 
> > It looks to me that CR/LF conversion does not happen during
> > fast-import even if I have core.autocrlf set to 'input'.
> > Is this a bug or is there a reason for that?
> 
> fast-import works on blobs only.  So it is expected.  Besides, it would 
> slow down fast-import tremendously if you wanted to introduce that 
> behaviour.  Therefore I suggest just rolling your own dos2unix instead of 
> trying to play cute games with fast-import.

Right, in fast-import we only process blobs as raw blobs.
Its rare that we have a file path associated with the blob data
at the time that we are actually processing the blob itself.  E.g.
applications can send us blobs up front, before they even start to
send us commits and path information.

So if we were to offer the CRLF->LF conversion feature in fast-import
it would need to be an option supplied at the time the 'data'
command issued, rather than based upon the gitattributes system
that is normally used for working tree operations.

It wouldn't be to difficult to add such an option to the data
command, but I'm not going to be able to get around to it anytime
soon.  This might be an easy change for someone else to attempt if
they were interested in some Git hacking.  Should all be isolated
to the cmd_data() routine in fast-import.c, and just needs to call
crlf_to_git() in convert.c, which is uh, static.  :-)

-- 
Shawn.
