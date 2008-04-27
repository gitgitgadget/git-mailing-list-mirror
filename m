From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: More on --pretty with git-diff-tree
Date: Sun, 27 Apr 2008 14:16:51 -0700
Message-ID: <7vzlrfdmm4.fsf@gitster.siamese.dyndns.org>
References: <200804271940.44940.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 23:18:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqEFy-0004HL-Ok
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 23:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbYD0VRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYD0VRK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 17:17:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbYD0VRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 17:17:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DEF604CC3;
	Sun, 27 Apr 2008 17:17:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 238A44CC0; Sun, 27 Apr 2008 17:17:02 -0400 (EDT)
In-Reply-To: <200804271940.44940.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 27 Apr 2008 19:40:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80487>

Jakub Narebski <jnareb@gmail.com> writes:

> Mention that --pretty=<format> option is used by git-diff-tree only
> if both --stdin and -v options are provided.

Interesting.

    $ git diff-tree --pretty=fuller --stat v1.5.5
    commit 1d2375ddfee18bd3effd2c1f98527cc2f8b1df0a
    Author:     Junio C Hamano <gitster@pobox.com>
    AuthorDate: Mon Apr 7 21:57:43 2008 -0700
    Commit:     Junio C Hamano <gitster@pobox.com>
    CommitDate: Mon Apr 7 21:57:43 2008 -0700

        GIT 1.5.5

        Signed-off-by: Junio C Hamano <gitster@pobox.com>

     Documentation/RelNotes-1.5.5.txt |    8 +-------
     Documentation/git.txt            |    5 +++++
     GIT-VERSION-GEN                  |    2 +-
     3 files changed, 7 insertions(+), 8 deletions(-)

Also:

    $ git rev-parse v1.5.5^0 | git diff-tree --pretty=short --dirstat --stdin
    commit 1d2375ddfee18bd3effd2c1f98527cc2f8b1df0a
    Author: Junio C Hamano <gitster@pobox.com>

        GIT 1.5.5

      89.2% Documentation/

There are two distinct uses for diff-tree, and by understanding it you
would be freed from the confusion.

 * You can compare two arbitrary tree-ish, and because a commit is a
   tree-ish, comparing two commits is a special case of this.  There is no
   reason to expect commit logs to be shown in such a use, and formatting
   options would naturally be ineffective.

 * You can give a commit and ask the command to give difference ``for the
   commit'', in other words, the diff between its parent and the given
   commit.  --stdin is a special case to drive this mechanism repeatedly,
   one commit at a time.  This is showing the diff as one of the
   characteristic of the commit, and allowing to show other attributes of
   the commit such as its message and timestamp makes sense, so formatting
   options take effect.

   As you can see from the above two examples, -v does not have much to do
   with this.
