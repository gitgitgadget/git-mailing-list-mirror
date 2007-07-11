From: Scott Lamb <slamb@slamb.org>
Subject: git-cvsimport newbie question
Date: Wed, 11 Jul 2007 00:20:10 -0700
Message-ID: <469484AA.7040701@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 09:20:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8WV2-0007l7-CH
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 09:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbXGKHUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 03:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbXGKHUc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 03:20:32 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:54129 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbXGKHUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 03:20:31 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id ED292980D0
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 00:20:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52135>

I'm trying to automatically maintain a git mirror of a (very) remote CVS
repository which is suitable for a few people to clone. I'm creating and
updating it now by running this periodically:

    $ mkdir ~/git/racoon2.git; cd ~/git/racoon2.git && git-cvsimport -d
:pserver:anoncvs@anoncvs.racoon2.wide.ad.jp:/anoncvs/racoon2 -r wide -i
racoon2

and cloning/pulling it in the simplest possible way:

    $ git clone racoon2.git myracoon2
    $ cd myracoon2
    $ stg init
    ...work work work...
    $ stg pull

But my clones don't see all the upstream branches:

    $ git remote show origin
    * remote origin
      URL: /home/slamb/git/racoon2.git/.git
      Remote branch(es) merged with 'git pull' while on branch master
        master
      Tracked remote branches
        master

In fact, the only branch I see is the one which isn't even updated,
which confused into thinking upstream wasn't changing. (I can't say the
manpage didn't warn me, though - "By default initial import will create
and populate a "master" branch from the CVS repository's main branch
which you're free to work with; after that, you need to git merge
incremental imports, or any CVS branches, yourself.")

Okay, it seems like what I actually want is this:

    $ git-cvsimport -d $CVSROOT -o master -i racoon2

which essentially creates a repository that is a mirror of upstream
rather than one which pretends to be tracking a nonexistent upstream git
repository. Now on the cloned branches "git branch -r" does what I want,
as does a simple "git pull".

But from the manpage, it appears I'm reverting to a much older way of
doing things. Maybe I should be giving the newer way a shot? Was this
"-r" way meant to be used with cloning the mirrored repository? If so,
what's the workflow there? maybe I should reset racoon2.git's "master"
branch to the beginning of time (to avoid confusion), update head to
point to remotes/wide/master (so simple "git clone" and "git pull"
commands get CVS HEAD), and then update remote.origin.fetch on each
cloned repository to pull in other branches as needed? But even after
doing that, "git remote show origin" on a cloned repository still won't
give me the list of branches I want. So this seems doesn't seem as good
as the old way.

Is there any way to make a repository cloned from a new-style
cvsimported one show the list of branches? It looks like I can't have a
remote in one repository refer to a remote in another repository - it
wants a direct reference. Most things seem to ignore origin's remotes,
at least unless I explicitly name one like "git pull origin
refs/remotes/wide/master".

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
