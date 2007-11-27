From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:25:18 -0500
Message-ID: <20071127012518.GH14735@spearce.org>
References: <200711252248.27904.jnareb@gmail.com> <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwpCn-0000U7-25
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbXK0BZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbXK0BZW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:25:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42340 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbXK0BZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:25:21 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IwpCH-0008Ux-Lj; Mon, 26 Nov 2007 20:25:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9657C20FBAE; Mon, 26 Nov 2007 20:25:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66152>

Dana How <danahow@gmail.com> wrote:
> On Nov 25, 2007 1:48 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > If you would write git from scratch now, from the beginning, without
> > concerns for backwards compatibility, what would you change, or what
> > would you want to have changed?
> 
> Currently data can be quickly copied from pack to pack,
> but data cannot be quickly copied blob->pack or pack->blob

I agree with Nico's comment that you probably don't need pack->loose
object as its just not something you want to do.  But otherwise
above you mean "loose->pack" or "pack->loose" as blob is one type
of loose object but there are others (tree, commit, tag).

> (there was an alternate blob format that supported this,
>  but it was deprecated).  Using the pack format for blobs
> would fix this.  It would also mean blobs wouldn't need to
> be uncompressed to get the blob type or size I believe.

The alternate format for loose objects *was* the packfile format,
but without the packfile header or trailer as that was really
quite unnecessary for a single object storage.

Unfortunately we removed that alternate format from the system.
We can't create it anymore.  We can't efficiently copy it to the
packfile anymore.  But we can still read it in case someone still
has loose objects using that alternate format in their repository.

I was sad when Nico removed the format in 726f852b0ed7e.  I can
understand why he did so but I think it was a move in the wrong
direction.

-- 
Shawn.
