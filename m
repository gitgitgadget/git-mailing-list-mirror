From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 3 Nov 2009 17:18:03 -0800
Message-ID: <20091104011802.GE10505@spearce.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com> <7v4opbp1fa.fsf@alter.siamese.dyndns.org> <20091104005614.GD10505@spearce.org> <7vljinnllj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:18:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UVl-0007jm-7o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbZKDBR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbZKDBR6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:17:58 -0500
Received: from george.spearce.org ([209.20.77.23]:57605 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbZKDBR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:17:57 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B1AD381FE; Wed,  4 Nov 2009 01:18:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljinnllj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132019>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > I don't think we ever send an empty packet.  If we have no data to
> > send, why the hell did we create the packet header?
> 
> Oh, I do not disagree that it is pointless, but the example that followed
> the part we are discussing also had "0004".  I think it is Ok to allow it.

If its pointless, why encourage it?  Why not discourage it with SHOULD NOT?
 
> The original intent of packet_flush() was that everything else could be
> kept buffered in-core without going to write() until packet_flush() is
> called.  The protocol was defined in a way that we won't wait for
> listening a response from the other end to an earlier message we "sent"
> with packet_write() but haven't called packet_flush() yet hence could
> still be in our buffer.  We still have this comment:
> 
>     /*
>      * If we buffered things up above (we don't, but we should),
>      * we'd flush it here
>      */
>     void packet_flush(int fd)

The smart-http series causes fetch-pack to buffer.  :-)

> And once we start buffering, allowing "0004" packet_write() wouldn't even
> be a problem; it can be optimized out in the buffering layer.

Sure, but can't packet_write just return early without write()
if format_packet returned 4 (aka vsnprintf returned 0)?

-- 
Shawn.
