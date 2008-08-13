From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Tue, 12 Aug 2008 19:57:49 -0700
Message-ID: <20080813025749.GA5855@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <a6b6acf60808111215y45b261d2ra667ea8d9f5f76d2@mail.gmail.com> <alpine.LFD.1.10.0808122220500.9984@xanadu.home> <20080813025027.GG1366@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 04:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6Zc-0008HC-Mh
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 04:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbYHMC5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 22:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYHMC5u
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 22:57:50 -0400
Received: from george.spearce.org ([209.20.77.23]:34054 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYHMC5u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 22:57:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C93A538375; Wed, 13 Aug 2008 02:57:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080813025027.GG1366@one.firstfloor.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92168>

Andi Kleen <andi@firstfloor.org> wrote:
> > If you have only 256 MB of RAM, I'm afraid the machine dives into swap 
> > the moment it attempts to process that single 150-MB object during 
> > repacking.  Objects are always allocated entirely, including the 
> > deflated and inflated copy at some point.  Making git handle partial 
> > objects in memory would add complexity all over the map so I don't think 
> > it'll ever be implemented nor be desirable.
> 
> If the access pattern is sequential and not much reuse it might be possible
> to madvise() strategically to do prefetch and early unmap of not used
> anymore data. I used that successfully in a few programs in the past that did
> aggressive mmap on very large files.

We actually do something better where we can.  However parts of
Git assume that it can get back a contiguous block of memory which
contains the entire file content, decompressed.  The data is stored
on disk compressed, so we cannot just mmap the data from disk.

-- 
Shawn.
