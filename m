From: Andi Kleen <andi@firstfloor.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 04:50:27 +0200
Message-ID: <20080813025027.GG1366@one.firstfloor.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <a6b6acf60808111215y45b261d2ra667ea8d9f5f76d2@mail.gmail.com> <alpine.LFD.1.10.0808122220500.9984@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ken Pratt <ken@kenpratt.net>, Andi Kleen <andi@firstfloor.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 04:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6RG-0006fB-Mx
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 04:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYHMCtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbYHMCtP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 22:49:15 -0400
Received: from one.firstfloor.org ([213.235.205.2]:50754 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbYHMCtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 22:49:14 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id BE76918900B8; Wed, 13 Aug 2008 04:50:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808122220500.9984@xanadu.home>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92167>

> If you have only 256 MB of RAM, I'm afraid the machine dives into swap 
> the moment it attempts to process that single 150-MB object during 
> repacking.  Objects are always allocated entirely, including the 
> deflated and inflated copy at some point.  Making git handle partial 
> objects in memory would add complexity all over the map so I don't think 
> it'll ever be implemented nor be desirable.

If the access pattern is sequential and not much reuse it might be possible
to madvise() strategically to do prefetch and early unmap of not used
anymore data. I used that successfully in a few programs in the past that did
aggressive mmap on very large files.

-Andi
