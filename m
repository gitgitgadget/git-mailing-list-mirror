From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Mon, 12 Jan 2009 07:42:24 -0800
Message-ID: <20090112154224.GD10179@spearce.org>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org> <7vfxjpmhow.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0901120041260.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 16:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMOxB-0001mV-5b
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 16:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbZALPm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 10:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZALPm0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 10:42:26 -0500
Received: from george.spearce.org ([209.20.77.23]:57541 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZALPm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 10:42:26 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 60D4338210; Mon, 12 Jan 2009 15:42:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0901120041260.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105353>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Sun, 11 Jan 2009, Junio C Hamano wrote:
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > > This supports a useful subset of the usual fetch logic, mostly in the
> > > config file.
> > 
> > I like the direction this series is going.  In the longer term, it would
> > be nice if we can have git-svn and git-cvsimport replaced with something
> > like this.

The series seems to require that the foreign tool speak fast-import.  I've
tried to get git-svn to use it, but its currently not possible because the
git-svn process needs to be able to read objects it has written during this
session.  Those objects are stored in the output pack, where only the active
fast-import process can get to them.  Thus git-svn can't use fast-import.

As import as the git-p4 stuff is, git-svn is our "killer feature" when it
comes to foreign system integration.  I think we need to make SVN work for
this foreign vcs thing to work.
 
> > Is the current foreign vcs interface sufficiently rich to support git as a
> > foreign scm by using fast-import and fast-export?
> 
> I think so, although it would be pretty strange, since it would generally 
> have a whole lot of local data (a complete clone of any remote 
> repository).

It might not be that bad.  If the foreign system is git and the
local system is git, we should have a massive amount of object reuse.
At least all of the blobs from the foreign system should be reused
by the local system, and that's like 80-90% of most project's
object state.

If the import is flawless (no mangling of commit messages or history)
then you should get 100% object reuse and the git-git import would
give you the same SHA-1, but just slower than going over git://.

Its strange only because it would be sucking more CPU time on the
client than is necessary to do the fetch.  But if something like
a filter-branch tool existed to massage a fast-import stream, it
might be useful to fetch someone else's tree, massage it a bit,
and then import it with a subtree merge.  :-)

-- 
Shawn.
