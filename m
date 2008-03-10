From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can
	it be done in Git?
Date: Mon, 10 Mar 2008 18:58:21 -0400
Message-ID: <20080310225821.GS13660@fieldses.org>
References: <200803091459.21354.jnareb@gmail.com> <3838F28A-DB0C-4678-BA57-3344E2225889@adacore.com> <20080310224318.GC8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 23:59:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYqxo-0001xn-W5
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 23:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbYCJW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbYCJW6e
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 18:58:34 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41564 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbYCJW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 18:58:34 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JYqwn-0006YN-MM; Mon, 10 Mar 2008 18:58:21 -0400
Content-Disposition: inline
In-Reply-To: <20080310224318.GC8410@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76767>

On Mon, Mar 10, 2008 at 06:43:18PM -0400, Shawn O. Pearce wrote:
> I think the reason Git has never had such an "extension" is we are
> just that freaking fast when it comes to comparing the working tree
> to the index.

NFS is an exception there; a git diff takes about 12 seconds for me.
It's easy to see why--ping time to the server is about a quarter of a
millisecond, so with some 24000 files to stat, and a roundtrip to the
server required for each, it would take at least 6 seconds even if there
was no other contribution to the stat latency.

But of course there's not much by way of file change notifications in
the current NFS protocol either, so that doesn't help.

At some point I tried patching git to do the stat's in parallel (the
totally lazy way--instead of modifying the existing code I just did an
extra parallel stat of everything first, then threw the results away, so
the real work would be done with a hot cache on the client).  I could
get it down to about 3.5 seconds that way, better though still annoying.

--b.
