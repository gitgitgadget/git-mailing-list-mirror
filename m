From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 22 Oct 2009 10:46:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910221041562.14365@iabervon.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net> <20091015154142.GL10505@spearce.org> <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org> <20091022192149.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 16:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0yvX-0006o0-IV
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 16:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbZJVOp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 10:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbZJVOp6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 10:45:58 -0400
Received: from iabervon.org ([66.92.72.58]:37448 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646AbZJVOp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 10:45:57 -0400
Received: (qmail 29932 invoked by uid 1000); 22 Oct 2009 14:46:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Oct 2009 14:46:01 -0000
In-Reply-To: <20091022192149.6117@nanako3.lavabit.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131021>

On Thu, 22 Oct 2009, Nanako Shiraishi wrote:

> Quoting "Shawn O. Pearce" <spearce@spearce.org>
> 
> > Actually, after some further research, the bug is not Johan's but is
> > actually Daniel's.  Johan, I apologize for claiming it was your bug.
> > ...
> > Long story short, transport_close() is what is supposed to perform
> > the work that disconnect_helper does, as its the final thing right
> > before we free the struct transport block.  Free'ing the data block
> > inside of the fetch or push functions is wrong.
> >
> > Its fine to close the helper and restart it within the single
> > lifespan of a struct transport, but dammit, don't free the
> > struct helper_data until transport_close().
> 
> Ping? Are there any progress on this issue?

Ah, right. Shawn's analysis is correct, and I should have a different 
function to just finish the helper, but leave the rest of the data alone. 
(when I wrote it originally, I didn't have anything other than the 
connection in there, so it was right to clear it, but now there's a real 
helper_data and it needs to do the right things).

	-Daniel
*This .sig left intentionally blank*
