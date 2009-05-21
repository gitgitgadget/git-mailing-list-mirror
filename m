From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/6] Make sure we get the right storage for
	loose/pack/loose and packed refs
Date: Thu, 21 May 2009 08:48:31 -0700
Message-ID: <20090521154831.GV30527@spearce.org>
References: <20090507155117.GS30527@spearce.org> <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com> <20090520214359.GQ30527@spearce.org> <200905211722.33995.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 21 17:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7AVc-0005E3-Dt
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 17:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZEUPsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 11:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbZEUPsa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 11:48:30 -0400
Received: from george.spearce.org ([209.20.77.23]:35631 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbZEUPsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 11:48:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DC571381FD; Thu, 21 May 2009 15:48:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905211722.33995.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119693>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> onsdag 20 maj 2009 23:43:59 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> 
> I agree. For decorating the history it's convenient, but it's inconsistent. For some reason
> it was harder to see without the unit tests. All kinds of things slip by when testing is
> done on the surface only.
> 
> I'll update, and and even more tests. 

Thanks.
 
> Should we use multiple Ref objects for symrefs? I.e. a Ref referring to another in a chain,
> with all symrefs in between visible?

Yea, I'm starting to think that we should expose a symref as a Ref that
contains a nested Ref.  The getObjectId() / getPeeledObjectId() of any
of those Refs in that chain should return the leaf node value, but the
name of each Ref should be the name of the symref.

So readRef(HEAD) yields:

  Ref {
    name = "HEAD"
    next = Ref {
      name = "refs/heads/master"
      next = null
      objectId = ....
    }
  }

That may break some callers though, as they'd now get HEAD instead
of master as the name of the return value.

-- 
Shawn.
