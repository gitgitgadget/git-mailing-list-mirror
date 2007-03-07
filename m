From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mercurial to git
Date: Wed, 7 Mar 2007 10:59:29 -0500
Message-ID: <20070307155929.GD27596@spearce.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 16:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOyYC-0002MC-4K
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 16:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbXCGP7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 10:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbXCGP7d
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 10:59:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41155 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbXCGP7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 10:59:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOyY1-0004Zp-6J; Wed, 07 Mar 2007 10:59:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2EC5420FBAE; Wed,  7 Mar 2007 10:59:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41670>

Rocco Rutte <pdmef@gmx.net> wrote:
> The performance bottleneck is hg exporting data, as discovered by people 
> on #mercurial, the problem is not really fixable and is due to hg's 
> revlog handling. As a result, I needed to let the script feed the full 
> contents of the repository at each revision we walk (i.e. all for the 
> initial import) into git-fast-import.

I thought that hg stored file revisions such that each source file
(e.g. foo.c) had its own revision file (e.g. foo.revdata) and that
every revision of foo.c was stored in that one file, ordered from
oldest to newest?  If that is the case why not strip all of those
into fast-import up front, doing one source file at a time as a
huge series of blobs and mark them, then do the commit/trees later
on using only the marks?

Or am I just missing something about hg?

> This is horribly slow. For mutt 
> which contains several tags, a handfull of branches and only 5k commits 
> this takes roughly two hours at 1 commit/sec.

Not fast-import's fault.  ;-)

> Somewhat related: It would be really nice to teach git-fast-import to 
> init from a previously saved mark file. Right now I use hg revision 
> numbers as marks, let git-fast-import save them, and read them back next 
> time. These are needed to map hg revisions to git SHA1s in case I need 
> to reference something in an incremental import from an earlier run. It 
> would be nice if git-fast-import could do this on its own so that all 
> consumers can benefit and can have persistent marks accross sessions.

Sure, that sounds pretty easy.  I'll try to work that up later
today or tomorrow.
 
-- 
Shawn.
