From: Theodore Tso <tytso@mit.edu>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 5 Feb 2009 16:45:36 -0500
Message-ID: <20090205214536.GB9814@mit.edu>
References: <200902021948.54700.jnareb@gmail.com> <200902051223.38992.jnareb@gmail.com> <20090205131611.GJ8945@mit.edu> <200902051836.44973.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:47:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVC47-00046k-Ri
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZBEVpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 16:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbZBEVpj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:45:39 -0500
Received: from THUNK.ORG ([69.25.196.29]:48676 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbZBEVpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:45:39 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LVC2T-00005P-SY; Thu, 05 Feb 2009 16:45:38 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LVC2S-0003MB-Eh; Thu, 05 Feb 2009 16:45:36 -0500
Content-Disposition: inline
In-Reply-To: <200902051836.44973.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108626>

On Thu, Feb 05, 2009 at 06:36:42PM +0100, Jakub Narebski wrote:
> What I wonder is how directory-id solution deals with situation
> where (for example die to some reorganization) where once was single
> directory (e.g. lib/) now there are two (include/ and src/); how it
> would deal with the new file at old directory, hmmm...?

In that case, it wouldn't be a directory rename, it would be a series
of file moves.  So in a hypothetical scm that recorded all of these
sorts of things, you'd have something like this:

scm mv lib/*.c src
scm mv lib/*.h include
scm rmdir lib

Now if you try merging in a commit that creates a files in lib (e.g.,
creates lib/foo.c and lib/foo.h and modifies lib/Makefile), presumably
either a super smart hueristic algorith might be able to figure out
the pattern and drop the new files in src and include --- or, more
likely, it would flag a merge conflict and ask the user to figure it
out by hand.

So yes, there will always be cases where directory-id won't be able to
handle a hypothetical source tree reorganization.  It really only
helps in the case where you are doing a true, full move of the
directory, i.e.:

scm mvdir src/plugin/innodb src/plugin/innodb-legacy
scm mvdir src/plugin/innodb-experimental src/plugin/innodb

							- Ted
