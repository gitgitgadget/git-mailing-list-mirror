From: Theodore Tso <tytso@mit.edu>
Subject: Re: git rebase interactive: usability issue
Date: Thu, 26 Jun 2008 08:13:03 -0400
Message-ID: <20080626121303.GF8610@mit.edu>
References: <20080625233208.GE5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqMX-0000yH-LO
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYFZMNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 08:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbYFZMNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:13:09 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:52268 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750997AbYFZMNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:13:08 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBqLa-0002QC-9y; Thu, 26 Jun 2008 08:13:06 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBqLX-0005B8-NM; Thu, 26 Jun 2008 08:13:03 -0400
Content-Disposition: inline
In-Reply-To: <20080625233208.GE5737@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86444>

On Thu, Jun 26, 2008 at 03:32:08AM +0400, Dmitry Potapov wrote:
> Though the user realized his mistake after my explanation of how git
> rebase works, I still believe it is a serious usability issue, because
> the same command: "git commit --amend" produces drastically different
> results depends on whether the rebase process stopped due to conflict
> or on the "edit" mark. Moreover, the commit message of second patch is
> getting lost as result of using "git commit --amend" in the former case.

This is true whether it a conflict is getting addressed during a
git-rebase or a git-merge.  The observation I would make is that git
has stopped a rebase or a merge with a conflict that the user needs to
fix up, a "git commit --amend" is almost always the wrong thing.  So I
could imagine a safety where after git discovers a merge conflict, it
sets a flag (probably a file in the .git directory) which causes "git
commit --amend" stop withan error message "this probably wasn't what
you wanted", and telling the user to use a --force command if this is
what they wanted.  This flag would be cleared on the next "git commit"
or "git reset".

In fact, we do this already for git-merge.  Why not just do the same
thing in the middle of a merge conflict with git-rebase?

      	     	       	       		- Ted
