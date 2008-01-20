From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 09:14:19 +0300
Message-ID: <20080120061419.GL14871@dpotapov.dyndns.org>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801192256480.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 07:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGTSR-0006K5-Nl
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 07:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYATGOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 01:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbYATGOZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 01:14:25 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:50943 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbYATGOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 01:14:24 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 858D62C870;
	Sun, 20 Jan 2008 09:14:20 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-190-198.pppoe.mtu-net.ru [85.141.190.198])
	by smtp02.mtu.ru (Postfix) with ESMTP id 730112C010;
	Sun, 20 Jan 2008 09:14:19 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JGTRk-0002Fe-0n; Sun, 20 Jan 2008 09:14:20 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801192256480.5731@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71157>

On Sat, Jan 19, 2008 at 10:58:08PM +0000, Johannes Schindelin wrote:
> 
> I think a better approach would be to try to match the name to what we 
> have in the index.  Then we could implement case-insensitivity and MacOSX 
> workaround at the same time.

I thought about that, but the problem is that HFS+ _already_ mangled
names from what the user entered (and what is used by anyone else)
to some sub-standard form, which no one outside of Mac likes or uses.
Thus, bringing filenames back to the NFC form (which is what almost
anyone uses) is the only sane thing do, because no one outside of Mac
really needs to know about this HFS+ specific craziness.

So I really dislike the idea that due to some HFS+ specific conversion,
we may end up having some strangely encoded names in a Git repository.
Sane people enter names only in NFC, so why should they suffer because
of some insane conversation made by filesystem behind everyone's back?
And I am not entertaining the idea of having this Mac OS/X specific
workaround outside of Mac OS/X.

Besides, writing a wrapper around readdir() is not difficult. We
already have git-compat-util.h, which redefines some functions for
some platforms, so I don't see any problem with writing a wrapper
around readdir().

Dmitry
