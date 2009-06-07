From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 3/3] Add a ref log reader class
Date: Sun, 7 Jun 2009 15:47:54 -0700
Message-ID: <20090607224754.GF16497@spearce.org>
References: <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com> <1244405951-21808-4-git-send-email-robin.rosenberg@dewire.com> <20090607222154.GD16497@spearce.org> <200906080045.26927.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDR9l-0005sm-Te
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915AbZFGWrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbZFGWrw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:47:52 -0400
Received: from george.spearce.org ([209.20.77.23]:44530 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbZFGWrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:47:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4EE27381FD; Sun,  7 Jun 2009 22:47:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906080045.26927.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121020>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> m?ndag 08 juni 2009 00:21:54 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> ...
> > > +			int p1 = RawParseUtils.next(raw, p0 + 1, ':');
> > > +			if (p1 == -1)
> > > +				throw new IllegalArgumentException(
> > > +						"Raw log message does not parse as log entry");
> > 
> > Technically, missing a ':' is legal.  Everything after the '\t'
> > is the comment.  It may be splittable into an action/comment,
> > it might not be.
> 
> Do you think I should just skip parsing out action? I don't really need it. I can
> go with everything after tab as one string for my purposes, i.e. reading reflogs
> in JUnit tests.

Yea, just skip it.
 
> As for optimized reading, I'd rather spend my time on something else. Reading
> reflogs won't likely be a real problem and I think the interface will be stable
> even if it needs to be optimized.
> 
> The other stuff I'll fix.

OK, sounds fine to me.

Maybe we should cap the limit at say 20 MiB of log or something, and
refuse to read anything more than that, rather than allowing 2 GiB.

Or, since we most likely only care about the tail, if its over 5
MiB, skip through to the end and then read the last 5 MiB, and if we
have a partial entry left over at the start of the buffer, ignore it.

-- 
Shawn.
