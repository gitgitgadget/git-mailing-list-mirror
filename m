From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any
	bundle
Date: Thu, 1 Jan 2009 23:15:19 -0800
Message-ID: <20090102071519.GA14472@spearce.org>
References: <20090101234815.GA9049@coredump.intra.peff.net> <878wputvnt.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, johannes.schindelin@gmx.de, nico@cam.org,
	gitster@pobox.com, mdl123@verizon.net, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 02 08:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIeGy-0008Ff-Of
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 08:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbZABHPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 02:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756642AbZABHPW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 02:15:22 -0500
Received: from george.spearce.org ([209.20.77.23]:33713 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbZABHPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 02:15:21 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8AECF38200; Fri,  2 Jan 2009 07:15:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <878wputvnt.fsf@jidanni.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104362>

jidanni@jidanni.org wrote:
> JK> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> OK, I wish you luck in the fruition of the new --dump-delta option, and
> can proofread the man pages involved, otherwise this is no area for
> junior programmer me.

This is rather insane.  There's very little data inside of a delta.
That's sort of the point of that level of compression, it takes
up very little disk space and yet describes the change made.
Almost nobody is going to want the delta without the base object
it applies onto.  No user of git is going to need that.  I'd rather
not carry dead code around in the tree for something nobody will
ever use.

FWIW, most Git deltas are "copy" instructions, they list a position
and count in the base to copy data *from*.  These take up less
space then "insert" instructions, where new text is placed into
the file.  As the delta generator favors a smaller delta, it tends
to create deltas that use the "copy" instruction more often than the
"insert" instruction.  So there is *very* little data in the delta,
just ranges to copy from somewhere else.  Without that other place
(the delta base) all you can do is guess about those bits.  Which you
can do just as well with a few flips of a fair coin.  :-)

-- 
Shawn.
