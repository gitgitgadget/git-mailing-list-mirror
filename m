From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 11:55:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141152210.3324@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141416540.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 20:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTi0u-00028Y-Ih
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 20:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYHNS4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 14:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbYHNS4d
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 14:56:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54489 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752321AbYHNS4c (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 14:56:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EItUGF005532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 11:55:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EItTH8023986;
	Thu, 14 Aug 2008 11:55:30 -0700
In-Reply-To: <alpine.LFD.1.10.0808141416540.4352@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92387>



On Thu, 14 Aug 2008, Nicolas Pitre wrote:
> 
> I disagree.  Well, right _now_ it is not a simple operation.  But if you 
> remember, I'm one of the co-investigator of the pack v4 format which 
> goal is to make history and tree walking much much cheaper, while making 
> their packed representation denser too.

See my other email with profile data and explanation.

Yes, zlib is high up, but it's not dominant to the point where a packfile 
format change would maek a huge difference. You'd still need deltas for 
trees, so even if you replaced zlib with something else, you'd still get a 
large hit.

You do realize that a lot of the zlib costs are due to cache misses, not 
zlib being fundamentally expensive in itself, right? Even if you made the 
zlib CPU costs be zero, you still couldn't avoid the _biggest_ cost.

			Linus
