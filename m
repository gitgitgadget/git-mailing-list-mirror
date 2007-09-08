From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Branching clarifications
Date: Sat, 8 Sep 2007 00:49:44 -0700
Message-ID: <20070908074944.GC24166@muzzle>
References: <46E18095.60501@gmail.com> <20070908052126.GB28855@soma> <85r6l9zlt4.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russ Brown <pickscrape@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 09:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITv4h-0003Fj-Kd
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 09:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbXIHHtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 03:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXIHHtq
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 03:49:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35409 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbXIHHtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 03:49:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BC16A2DC08D;
	Sat,  8 Sep 2007 00:49:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <85r6l9zlt4.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58107>

David Kastrup <dak@gnu.org> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > git-svn sets "master" to the most recently committed-to branch
> > in SVN the first time it fetches.  "git-log master" will tell
> > you (look at the git-svn-id: lines).
> 
> Sigh.  Another "surprise the user by an arbitrary looking choice that
> might possibly correspond to what he wants done because it something
> obscure in the commit history suggests so" design decision.
> 
> I don't want my master set according to something that a coworker (or
> even myself) happened to commit last to.
> 
> Please.  git-svn is told how to find the trunk on its command line.
> Nothing makes sense (short of an _explicit_ wish otherwise for which
> it might make sense to create a command line option) than to map
> master to the trunk.

Keep in mind that command-line arguments for trunk, branches and tags
are _all_ optional to git-svn.

If only trunk or nothing is specified, the current behavior will always
be correct.

There's also a case if only branches and/or tags are specified, with no
trunk given.  That would need to be handled, somehow...

I've also tracked several (both OSS and closed) projects that have a
policy of doing all work on branches with a trunk that's almost never
up-to-date.

Tracking the last-committed branch was the easiest to code, and we even
tell the user which branch they're on.  I guess I could add a message
telling them all the other refs they can "git reset --hard" to if they
don't like their current one.

> As a design rule: don't second-guess the user, _ever_, and
> particularly not on decisions with large consequences.  A tool should
> not have a mind of its own but do what it is told.  And if it can't
> figure out what it is told, by simple, user-understandable criteria,
> barf.  And of course have a way to _direct_ it when it can't figure it
> out on its own, or if the simple and obvious default would not do the
> right thing.

git-svn used to never check anything out and leave HEAD dangling.  I was
happy with that, but I got a lot of user complaints from that, too.

-- 
Eric Wong
