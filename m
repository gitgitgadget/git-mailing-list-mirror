From: Junio C Hamano <junkio@cox.net>
Subject: Re: Do "git add" as a builtin
Date: Wed, 17 May 2006 12:06:13 -0700
Message-ID: <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:06:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRLd-000871-QA
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWEQTGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWEQTGP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:06:15 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10964 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750976AbWEQTGO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:06:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517190613.ESFT19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 15:06:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20225>

Linus Torvalds <torvalds@osdl.org> writes:

> ... I dropped the strange "--error-unmatch" test, because it
> was really ugly and I didn't see the point.

By "not seeing the point", do you mean you do not agree with
what bba319b5 and 45e48120 tried to do to help users?

        $ git add no-such-path-in-the-tree
        $ git add 'this-pattern-matches-nobody*'

More realistically:

	$ git add Documentaiton		;# misspelled


[References]

(bba319b5)
When you say "git commit Documentaiton" to make partial commit
for the files only in that directory, we did not detect that as
a misspelled pathname and attempted to commit index without
change.  If nothing matched, there is no harm done, but if the
index gets modified otherwise by having another valid pathspec
or after an explicit update-index, a user will not notice
without paying attention to the "git status" preview.

This introduces --error-unmatch option to ls-files, and uses it
to detect this common user error.

(45e48120)
This is in the same spirit as an earlier patch for git-commit.
It does an extra ls-files to avoid complaining when a fully
tracked directory name is given on the command line (otherwise
--others restriction would say the pathspec does not match).
