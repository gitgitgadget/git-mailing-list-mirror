From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Add an option to git-ls-tree to display also the size of blob
Date: Sat, 19 May 2007 23:54:07 -0400
Message-ID: <20070520035407.GF3141@spearce.org>
References: <11792246701367-git-send-email-jnareb@gmail.com> <200705160119.10802.jnareb@gmail.com> <7vps51hacw.fsf@assigned-by-dhcp.cox.net> <200705192208.11905.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 05:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpcV0-0001kW-Ro
	for gcvg-git@gmane.org; Sun, 20 May 2007 05:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbXETDyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 23:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756256AbXETDyN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 23:54:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54179 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641AbXETDyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 23:54:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HpcUY-0002m8-Ap; Sat, 19 May 2007 23:53:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6A9EC20FBAE; Sat, 19 May 2007 23:54:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200705192208.11905.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47794>

Jakub Narebski <jnareb@gmail.com> wrote:
> Rationale: for non-blob entries size of an object has no much
> meaning, and is not very interesting.  Moreover, in planned
> pack v4 tree objects would be constructed on demand, so tree
> size would need to be calculated... although isn't object size
> stored in the header?

Yes and no.  In pack v4 the object sizes stored within the packfile
are more about what we need to know in order to efficiently unpack
the object than about supplying the canonical format length.  If a
value is redundant, we don't store it.  The canonical format length
is almost always redundant.

For blobs we still need the raw data length to unpack efficiently,
and hence we have the blob's canonical size readily available.
For trees its actually more the tree entry record count, as that
is all we need to know in order to recover the tree.  For commits
we don't even need a length, but we instead have the number of
parent commits.

Since pack v4 is really about faster runtime decoding our ability
to reproduce canonical encoding of objects is reduced slightly.
I think that's OK as we actually only need the canonical encoding
infrequently (index-pack during network transfer, cat-file) and
we're not really considering pack v4 for network transfer.  Yet.
 
> I hope this addresses concerns mentioned in this thread: the
> alternate name --size for -l/--long option, and showing size
> for tree (and commit/submodule) objects.

Yes, thanks!

-- 
Shawn.
