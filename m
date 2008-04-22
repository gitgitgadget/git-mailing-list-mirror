From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui hangs on read
Date: Mon, 21 Apr 2008 20:13:11 -0400
Message-ID: <20080422001311.GS29771@spearce.org>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Benjamin Collins <ben.collins@acm.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:14:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo693-0003Iw-Px
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 02:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbYDVANP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758079AbYDVANO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 20:13:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34063 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062AbYDVANO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 20:13:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jo686-00060T-2Z; Mon, 21 Apr 2008 20:13:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3DF3820FBAE; Mon, 21 Apr 2008 20:13:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80047>

Benjamin Collins <ben.collins@acm.org> wrote:
> I just upgraded a few machines (RHEL 4.4) to the latest stable, and
> git-gui stopped working.  It just hangs forever if it's in a git
> repository.
...
> [pid 16903] write(1, "@(#) International Ispell Versio"..., 68 <unfinished ...>
> [pid 16897] <... read resumed> "@(#) International Ispell Versio"..., 4096) = 68
> [pid 16903] <... write resumed> )       = 68
> [pid 16903] fstat(0, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
> [pid 16903] mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a983cf000
> [pid 16903] read(0,  <unfinished ...>
> [pid 16897] write(5, "!\n$$cr master\n", 14) = 14
> [pid 16903] <... read resumed> "!\n$$cr master\n", 4096) = 14
> [pid 16897] read(6,  <unfinished ...>
> [pid 16903] read(0,
> 
> Has anyone seen this before?

Nope.  This was a new feature of git-gui 0.10; we now launch an
aspell session in the background via a bi-directional pipe and
use it to spell check the commit message area on the fly.  The
reason Git 1.5.4 doesn't have this problem is because it ships
with git-gui 0.9.x, which doesn't have this spell check.

I'm not sure why your system is hanging.  I've used git-gui 0.10
on Mac OS 10.4, 10.5 and Windows without any issues for many weeks
prior to the 1.5.5 release.  Doesn't mean there isn't possibly
something wrong here, I just had thought this was pretty stable
code at this point.

>From the strace it looks like your aspell is not giving us a
reply to the "$$cr master" command.  What does this give you?

	aspell --mode=none --encoding=UTF-8 pipe <<EOF
	!
	$$cr master
	EOF

-- 
Shawn.
