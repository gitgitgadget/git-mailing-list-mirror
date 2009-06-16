From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not
 request sideband
Date: Tue, 16 Jun 2009 14:03:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906161354010.16467@xanadu.home>
References: <200906142238.51725.j6t@kdbg.org>
 <20090615145716.GW16497@spearce.org> <200906152324.43435.j6t@kdbg.org>
 <7vski1i2ov.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0906152109240.16467@xanadu.home>
 <7vprd4hito.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 20:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGd0u-0003D0-Dw
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 20:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZFPSDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 14:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbZFPSDx
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 14:03:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42843 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZFPSDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 14:03:52 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KLC003VKFHTPT51@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Jun 2009 14:03:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vprd4hito.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121697>

On Mon, 15 Jun 2009, Junio C Hamano wrote:

> I guess both ssh and local would regress, and we do care about regressions
> in general, but I think it is not a grave offense in this case, because
> the combination between such an old fetch and the updated upload-pack will
> still transfer the objects and will update the refs as expected; only the
> progress indication and chatter on the stderr stream will be lost.

My point exactly, although I realize I didn't make myself clear.

> So I would say it is Ok to regress in this particular case, _if_ 
there is
> no easy way to avoid it.  That was why I asked:
> 
> >> I think it is a very good idea to squelch progress output that will never
> >> go to the client (it will be wasted traffic, regardless of the "syslog"
> >> thing), but
> >> 
> >>  (1) Is "not using sideband" the same as "client won't see the progress
> >>      output" for all vintages of clients that work with the current
> >>      server?
> 
> Stated differently, I think "not using sideband _and_ spawned via daemon"
> would be an indication that "the client won't see the progress anyway even
> if it were sent."  So the question becomes "will it be a small enough
> change to detect if the upload-pack is driven by the daemon in the
> codepath J6t added 'if (!use_sideband)' to, and if so shouldn't we do so?"

I don't think it is worth it at all.  The regression is purely cosmetic, 
and I suspect you'll have a really hard time finding someone still using 
those ancient git clients anyway.  Remember that such clients are unable 
to fetch with HTTP from repositories using version 2 of the pack index 
by default already.  That's why we created version 1.4.4.5.


Nicolas
