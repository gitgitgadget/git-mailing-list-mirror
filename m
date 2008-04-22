From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mark parsing in fast-import
Date: Tue, 22 Apr 2008 19:15:15 -0400
Message-ID: <20080422231515.GJ29771@spearce.org>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de> <20080414232958.GE20979@spearce.org> <20080420234438.GC12865@alea.gnuu.de> <20080421002626.GJ29771@spearce.org> <20080421084151.GA31344@alea.gnuu.de> <20080421235940.GQ29771@spearce.org> <20080422093942.GA3752@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:16:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoRib-00011V-0Y
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 01:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763197AbYDVXPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 19:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbYDVXPU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 19:15:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33702 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762767AbYDVXPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 19:15:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JoRha-0006DB-Ak; Tue, 22 Apr 2008 19:15:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2604320FBAE; Tue, 22 Apr 2008 19:15:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080422093942.GA3752@alea.gnuu.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80171>

Jrg Sommer <joerg@alea.gnuu.de> wrote:
> 
> Another question: Is :0 a valid mark? In import_marks() is a check for
> !mark, but I haven't seen it anywhere else.

No, in fast-import ":0" is _not_ a valid mark.  We burn the first
entry in the marks table (always leaving it empty) as then we can
use the idiom "!mark" to say "no mark was requested/given" and
"mark" to say "mark was requested/given".  Hence we do not need an
extra flag to tell us either way.

Given that a mark is just a pointer, and that extra flag would
likely have been a global "static int have_mark" or some such it
works out to be about the same amount of memory - 4 or 8 bytes.
No big deal, and the code is probably easier to follow as a result.

-- 
Shawn.
