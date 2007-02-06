From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 15:09:24 -0500
Message-ID: <20070206200924.GA5352@spearce.org>
References: <20070206023111.GB9222@spearce.org> <Pine.LNX.4.64.0702052248070.19212@xanadu.home> <20070206054808.GA10508@spearce.org> <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org> <20070206165630.GB4949@spearce.org> <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702061329090.19212@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 21:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEWdH-0001Oa-Uy
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 21:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965406AbXBFUJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 15:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965404AbXBFUJe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 15:09:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50286 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965406AbXBFUJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 15:09:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEWcv-0003Xy-Sq; Tue, 06 Feb 2007 15:09:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F38620FBAE; Tue,  6 Feb 2007 15:09:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702061329090.19212@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38872>

Nicolas Pitre <nico@cam.org> wrote:
> This is therefore a damn good idea if gfi can make things right out of 
> crap because frontends will not get much attention after the first "hey 
> it works" level.  And the GIT date format, albeit being perfectly 
> unambigous, is not inline with the statement above.

Done.  I just pushed a change to gfi which adds `--date-format=<fmt>`.
For <fmt> you have the choice of:

  raw: Standard Git format.  This is the default, as its what
  the existing frontends by Chris Lee, Simon Hausmann, Jon Smirl,
  and Simon 'corecode' Schubert expect.

  rfc2822: Run whatever crap you give us through parse_date(),
  and cross your fingers.  If parse_date() returns < 0 we bomb
  out, but otherwise take it at its word.

  now: This is a toy, but useful if you really want now, dammit.
  We just call datestamp() and tack that in.  Note that the frontend
  must also supply the literal string `now` in the committer line
  (e.g. "committer A U Thor <at@example.com> now") to prevent us
  from bombing out.

The last one will probably get more useful when I fix gfi so it can
safely commit against active refs without losing commits (make it
do a strict fast-forward check before updating).  In this case it
may be useful for something like git-cvsserver, as it avoids the
need for a temporary directory, index, etc.
 
-- 
Shawn.
