From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Wed, 20 Aug 2008 13:00:26 -0700
Message-ID: <20080820200026.GK3483@spearce.org>
References: <20080819234433.GJ24212@spearce.org> <20080820193557.GB16626@blimp.local> <20080820194407.GJ3483@spearce.org> <20080820195401.GD16626@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVts3-00035q-RJ
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbYHTUA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbYHTUA2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:00:28 -0400
Received: from george.spearce.org ([209.20.77.23]:38693 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbYHTUA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:00:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E8E8F38376; Wed, 20 Aug 2008 20:00:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080820195401.GD16626@blimp.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93025>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Shawn O. Pearce, Wed, Aug 20, 2008 21:44:07 +0200:
> > 
> > We could pick any number for the limit, just so long as its so
> > large that the size of the reflog for it to be a valid @{nth}
> > request would be something like 1 TB, and thus be highly unlikely.
> > 
> > I was just trying to be cute by using the original commit timestamp
> > of Git itself.  Perhaps 12936648 (1TB / 83)?
> 
> How about the maximum value the platform's size_t can handle?

So on 64 bit platforms we need to wait for another 2.92277266
x10^10 years before we will ever see a seconds-since-epoch which
can't possibly be mistaken for a position in the relfog file?
 
> Not because it is "highly unlikely", but because you and me frankly
> have no idea exactly how unlikely for example a "12936648 terabytes" is?

I have half a brain.  Creating 12 million reflog entries would
typically require 12 million git-update-ref forks. Anyone who is
doing that many since reflog was introduced and has not yet truncated
their reflog _really_ should reconsider what they are using it for.

Evaluating foo@{12936648} will be _horribly_ expensive.  Anyone who
is waiting for that result and _cares_ about it would have already
started asking on the list for a reflog which is not based on a
flat file.  If they have already patched their Git to use something
else (e.g. gdbm) I have no pity for them when this changes/breaks
as they clearly have already patched their Git rather heavily.

-- 
Shawn.
