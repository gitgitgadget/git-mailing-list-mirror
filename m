From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: suggest gc only when counting at least 2
	objects
Date: Sun, 13 Sep 2009 20:39:58 -0700
Message-ID: <20090914033958.GT1033@spearce.org>
References: <20090909195158.GA12968@localhost> <20090913160637.GA15256@localhost> <7vr5uasp4a.fsf@alter.siamese.dyndns.org> <20090913184150.GA19209@localhost> <20090913204433.GA8796@coredump.intra.peff.net> <20090913211916.GA5029@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 14 05:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn2QA-0006DJ-PV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 05:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZINDj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 23:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbZINDj4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 23:39:56 -0400
Received: from george.spearce.org ([209.20.77.23]:55335 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbZINDjz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 23:39:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A9E74381FE; Mon, 14 Sep 2009 03:39:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090913211916.GA5029@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128436>

Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Sep 13, 2009 at 04:44:33PM -0400, Jeff King wrote:
> > On Sun, Sep 13, 2009 at 08:41:50PM +0200, Clemens Buchacher wrote:
> > > On Sun, Sep 13, 2009 at 10:58:45AM -0700, Junio C Hamano wrote:
> > > > Somebody cares to explain why this threashold number has to be different
> > > > per platform in the first place? 
> > > 
> > > I really don't know. I vaguely remember someone claim that performance on
> > > Windows suffered from many loose objects more than on other platforms. I
> > > can't find any discussion of it though.
> > 
> > Maybe 8ff487c?

Yes, it was 8ff487c.  Back then I was using Windows on a daily
basis and this was put into git-gui because Aunt Tillie couldn't
remember do run a git-gc every so often, and performance would just
drop in the bucket.  It also quite a bit predates `git gc --auto`
being sprinkled throughout the code base on various operations.

As to why its been 200 as the loose count estimate, that was just
a WAG based on what I observed on my desktop.  2000 on UNIX is
usually fine, 2000 on Windows meant you waited an extra 30 seconds
to perform an operation.
 
> Ok. But it's been 2 years since then and if I'm not mistaken, there have
> been a number of performance improvements to msysgit. So maybe it's time to
> revisit that threshold.

msysgit may have improved, but at the time I was running Git on
Cygwin, and I doubt NTFS has really improved that much.
 
> If, on the other hand, requiring 2 objects really is too many, we should
> maybe check at least two or four directories, which would greatly improve
> the statistic.

I'm concerned about the FS cost of checking more directories, but
this is a one-time penalty on startup of git-gui so it might not
be too bad if it gets us a better estimate.
 
-- 
Shawn.
