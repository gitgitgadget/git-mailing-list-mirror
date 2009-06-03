From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 2 Jun 2009 19:15:18 -0700
Message-ID: <20090603021518.GB3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906022339.08639.jnareb@gmail.com> <20090602232724.GN30527@spearce.org> <200906030250.01413.jnareb@gmail.com> <20090603012940.GA3355@spearce.org> <7vab4qdq2j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 04:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBg0k-00011v-Jz
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 04:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbZFCCPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 22:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZFCCPR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 22:15:17 -0400
Received: from george.spearce.org ([209.20.77.23]:57014 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbZFCCPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 22:15:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E54B2381FE; Wed,  3 Jun 2009 02:15:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vab4qdq2j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120575>

Junio C Hamano <gitster@pobox.com> wrote:
> One thing that I did not see mentioned in this thread is that the
> implementation is allowed to buffer non-flush packets and send multiple of
> them out with a single write(2).  In other words, packet_write() could
> buffer instead of directly calling safe_write(), while packet_flush() must
> do safe_write() and make sure it drains.

Good point.

That's one reason why in JGit I call the flush packet of "0000"
end(), and flush() triggers the drain.  JGit buffers everything
its writing, but only by one standard "have" window IIRC.

JGit server code triggers a flush() after side-band channel 2 packet
ends, but not an end(), because we only want to drain to the network,
not inject a bad "0000" packet in the stream.

-- 
Shawn.
