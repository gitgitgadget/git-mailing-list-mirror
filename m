From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 3/3] Rescan for packs and retry once if object
	lookup scan fails
Date: Mon, 20 Apr 2009 07:32:56 -0700
Message-ID: <20090420143256.GX23604@spearce.org>
References: <200904181905.55119.robin.rosenberg.lists@dewire.com> <1240165809-16703-1-git-send-email-robin.rosenberg@dewire.com> <1240165809-16703-2-git-send-email-robin.rosenberg@dewire.com> <1240165809-16703-3-git-send-email-robin.rosenberg@dewire.com> <1240165809-16703-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuZr-0007ed-Qi
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbZDTOc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbZDTOc5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:32:57 -0400
Received: from george.spearce.org ([209.20.77.23]:36361 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZDTOc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 10:32:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DEE9A38211; Mon, 20 Apr 2009 14:32:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1240165809-16703-4-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116995>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>  .../src/org/spearce/jgit/lib/Repository.java       |   76 ++++++++++++++++----
>  1 files changed, 63 insertions(+), 13 deletions(-)

NAK.

I see a number of things I don't like about this implementation
as it stands.  I'll try to work up a counter patch today.

At a glance, the new logic for openObject is pretty twisted
to follow.  It mostly makes sense, but I had hoped for something
cleaner to read.

I'm really worried about the case where a pack file stays with
the same name, but its contents and index have been recreated,
and thus our existing PackFile object is invalid for access to it.
Your implementation as written would keep the same PackFile in
memory, and we'd lose access to those objects.

You also pointed out some concerns about windows stuck in the
WindowCache.  I'm equally worried about that.
 
-- 
Shawn.
