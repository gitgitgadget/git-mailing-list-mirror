From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 12:44:50 -0700
Message-ID: <7voeb0tnm5.fsf@assigned-by-dhcp.cox.net>
References: <1116626652.12975.118.camel@dhcp-188>
	<Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
	<428E745C.30304@zytor.com>
	<Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
	<4292A08A.5050108@cobite.com>
	<Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<20050524182951.GB9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241146500.2307@ppc970.osdl.org>
	<7vu0kstojw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:44:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafJ8-0003MS-Kh
	for gcvg-git@gmane.org; Tue, 24 May 2005 21:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVEXTo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 15:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEXToz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 15:44:55 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39132 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261974AbVEXTow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 15:44:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524194450.IKUT550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 15:44:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vu0kstojw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 24 May 2005 12:24:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> What _all_ Porcelain layer implementation would benefit from is
JCH> if we had a common output format routine that is similar to the
JCH> spirit of show_date() function.  Have format_commit_fancy()
JCH> function that takes a commit object and have it do the mapping.

Here is a small script called "whodunnit.sh", and its output can
be cleaned up if we had a git-format-commit command that used
format_commit_fancy(), that massages author/committer names (and
probably some other prettyprinting), instead of plain old
"git-cat-file commit".

#!/bin/sh
git-rev-list ${1:-HEAD} |
while read commit
do
	git-cat-file commit $commit |
	sed -ne '/^author \([^>]*>\).*/{s//\1/p;q;}'
done | sort | uniq -c | sort -n

The lines it currently spits out looks like this:

      6 ...
      8 Linus Torvalds <torvalds@ppc970.osdl.org.(none)>
        ...
    155 ...
    229 Linus Torvalds <torvalds@ppc970.osdl.org>

My suggestion for Thomas is not to volunteer changing
cvsps-to-git to munge names at conversion time, but instead to
volunteer doing the format_commit_fancy() on the core-ish side.
It would read from $GIT_DIR/author-names which would be a plain
text file that is a sequence of:

    "bogus name" TAB "good name" LF

where you would put ".(none)" version to "bogus" side and the
corrected one on the "good" side.

