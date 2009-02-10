From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 09:22:12 -0800
Message-ID: <20090210172212.GR30949@spearce.org>
References: <alpine.LNX.1.00.0902092218050.19665@iabervon.org> <alpine.DEB.1.00.0902101126040.10279@pacific.mpi-cbg.de> <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwKk-0005qL-1A
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbZBJRWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZBJRWO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:22:14 -0500
Received: from george.spearce.org ([209.20.77.23]:46995 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZBJRWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:22:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B621138210; Tue, 10 Feb 2009 17:22:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902101118110.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109279>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> Is there some way to see if the pack it was writing is actually corrupt 
> (beyond not having the hash set)?

Hmm.  If you have the pack fragment, its going to take some editing
to get it through the existing validation tools.

First you need to know how many objects are in the pack just so you
can update the object count, which is a 4 byte network byte order
field starting at offset 8.  Then you need the SHA-1 checksum of
the entire pack appended onto the end, as the last 20 bytes.

Once the pack is "closed" (by applying those fixes), you can run it
through both index-pack and verify-pack.  They pick up most errors,
especially a delta apply sort of error.  They won't find corrupt
tree modes though, or object connectivity errors.

-- 
Shawn.
