From: Junio C Hamano <junkio@cox.net>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 13:18:05 -0700
Message-ID: <7vwt0lxpxe.fsf@assigned-by-dhcp.cox.net>
References: <11760951973172-git-send-email-nico@cam.org>
	<20070409171925.GS5436@spearce.org>
	<alpine.LFD.0.98.0704091328130.28181@xanadu.home>
	<20070409174305.GU5436@spearce.org>
	<7vtzvpz5tu.fsf@assigned-by-dhcp.cox.net>
	<20070409195322.GB5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb0JY-0005zn-Px
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 22:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbXDIUSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbXDIUSJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 16:18:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45979 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbXDIUSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 16:18:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409201807.XNIW25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 16:18:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id l8J51W00Y1kojtg0000000; Mon, 09 Apr 2007 16:18:05 -0400
In-Reply-To: <20070409195322.GB5436@spearce.org> (Shawn O. Pearce's message of
	"Mon, 9 Apr 2007 15:53:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44082>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sure, fine.  But I think you missed my point above - right now if
> we move the SHA-1 table out of the .idx file I'm not sure we know
> how to support the dumb clients *at all*.  Even if they understand
> the latest-and-greatest file formats...

We do an incremental .keep pack for packs 100 objects or more.
If .idx omits SHA-1 values but keeps the crc and offset, that
would be around 12 bytes per object (but you may need an index
into the real SHA-1 table in the .pack file, I dunno) so that
would be 1200 bytes.  If we duplicate SHA-1 table also in .idx
that would make it 32-byte per object, totalling 3200 bytes,
which admittedly is near 3-fold increase, but it may be worth if
we want to avoid the hassle.
