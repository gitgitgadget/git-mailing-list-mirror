From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 17:18:30 -0400
Message-ID: <20080825211830.GH2213@fieldses.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251445090.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjTO-0007rv-4o
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbYHYVSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbYHYVSd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:18:33 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34536 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511AbYHYVSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 17:18:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KXjSJ-0002FV-0s; Mon, 25 Aug 2008 17:18:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808251445090.1624@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93680>

On Mon, Aug 25, 2008 at 02:58:05PM -0400, Nicolas Pitre wrote:
> On Mon, 25 Aug 2008, J. Bruce Fields wrote:
> 
> > Today I got this:
> > 
> > fatal: failed to read delta base object at 3025976 from
> > /home/bfields/local/linux-2.6/.git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack
> > 
> > This has happened once before recently, I believe with a pack that had
> > just been created on a recent fetch.  (If I remember correctly, this was
> > soon after a failed suspend/resume cycle that might have interrupted an
> > in-progress fetch; could that possible explain the error?)  In that case
> > I reset origin/master, deleted a tag or two, and fetched, and the
> > problem seemed to be fixed.
> 
> The above error is indicative of a corrupted pack on disk.  To confirm 
> it you could use 'git verify-pack' with the given pack file.

That gives:

	error: Packfile .git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack SHA1 mismatch with itself

No surprise, I assume.

> With a sufficiently recent git, you only need to copy over another pack 
> containing the corrupted object, or the object itself in loose form, 
> into your object store to "fix" it.

Yeah, I just did a git repack -a -d in a known good repository and
copied the resulting pack over.  Seems OK.  Thanks.

--b.

> As to the source of disk corruptions... that's up to you to find the 
> cause amongst many (including a failed suspend).
