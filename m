From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to find a revision's branch name
Date: Sat, 18 Mar 2006 00:31:26 -0800
Message-ID: <7v64mcxig1.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603172202ia4b69f2he5562b826e491426@mail.gmail.com>
	<7vfylgz29x.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550603172335v11ea36a8j9cca2ed2df58b45d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 09:32:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKWrJ-0000z3-Sd
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 09:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWCRIb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 03:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCRIb3
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 03:31:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60608 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932186AbWCRIb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 03:31:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318083134.RIUK25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 03:31:34 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603172335v11ea36a8j9cca2ed2df58b45d@mail.gmail.com>
	(Marco Costalba's message of "Sat, 18 Mar 2006 08:35:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17691>

Marco Costalba <mcostalba@gmail.com> writes:

>> ... I wonder why you care.  Wouldn't this work just as well?
>>
>>         $ git rev-list --header --topo-order --parents --remove-empty \
>>           --all -- <path>
>>
>
> Yessss!!!

I think I spoke too early.  I think --remove-empty does not
prevent rev-list from traversing branches that <path> _never_
appears in their history, so if the <path> given was TODO, it
will go all the way back to the very first commit by Linus, and
the very first commit for gitk by Paul, without finding a commit
that touches that file.

One option is "--remove-empty --all" with <path> to omit heads
and tags that do _not_ have given <path>s from the set of
starting points, but then you cannot grab history of rev-tree.c
between v0.99.7 and 9dcc829 (v0.99.7 was the last tagged commit
that had rev-tree.c, but removal of the file happened 39 commits
after that), so that is not really an option.

I guess we need to live with this; git.git repository is quite
special.  If you clone from it, you would get todo, html and man
branches, so it *appears* that these are part of the same
repository, but logically these branches are not part of the
project history proper.

The commits that belong to these three branches do not appear in
my private development repository.  The todo branch is pushed
into git.git from a completely separate repository from my side,
and html and man branches are pushed from other separate
repositories of their own on a kernel.org machine, automatically
built after I push new stuff into the "master" branch of git.git
repository, by the post-update hook.

The only reason I have these three branches in git.git
repository is historical.  I do not have write access on
kernel.org machine in /pub/scm/git itself. I can only write in
/pub/scm/git/git.git/, and I never bothered to ask the operators
to make /pub/scm/git itself writable by me; otherwise I would
have made /pub/scm/git/git-{todo,html,man}.git repositories.
