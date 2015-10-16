From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v2 0/4] stripspace: Implement and use --count-lines option
Date: Fri, 16 Oct 2015 17:16:41 +0200
Message-ID: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 17:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn6kZ-0002vo-Bs
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 17:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbbJPPQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 11:16:51 -0400
Received: from mail.zhinst.com ([212.126.164.98]:36621 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbbJPPQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 11:16:49 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Fri, 16 Oct 2015 17:16:45 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279742>

(1) Move the stripspace() function to the strbuf module adding a prefix
    and changing all users accordingly. Also introduce a wrapper in case
    any topic branches still depend on the old name.

(2) Switch git stripspace to use parse-options in order to simplify
    introducing new command line options (as in the following patch). In
    v1 this was folded into patch (3) and is now split out for v2.

(3) Introduce option --count-lines to git stripspace and add the
    corresponding documentation and tests.

(4) Change git-rebase--interactive.sh to replace commands like:

	git stripspace ... | wc -l

    with:

	git stripspace --count-lines ...

This patch set implements some of the project ideas around git stripspace
suggested on https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

v1 -> v2:

  - Thanks to Junio and Matthieu for the review.
  - Split patch 2/3 into two patches: patch 2/4 switches git stripspace
    to use parse-options and patch 3/4 introduces the new option.
  - Implement line counting in cmd_stripbuf() instead of (ab-)using
    strbuf_stripspace() for it.
  - Drop -C short option
  - Correct example command output in documentation.
  - Adjust commit messages to not include links to the wiki, fully
    describe the motivation in the commit message instead.

Tobias Klauser (4):
  strbuf: make stripspace() part of strbuf
  stripspace: Use parse-options for command-line parsing
  stripspace: Implement --count-lines option
  git rebase -i: Use newly added --count-lines option for stripspace

 Documentation/git-stripspace.txt |  14 +++-
 builtin/am.c                     |   2 +-
 builtin/branch.c                 |   2 +-
 builtin/commit.c                 |   6 +-
 builtin/merge.c                  |   2 +-
 builtin/notes.c                  |   6 +-
 builtin/stripspace.c             | 137 +++++++++++++--------------------------
 builtin/tag.c                    |   2 +-
 git-rebase--interactive.sh       |   6 +-
 strbuf.c                         |  66 +++++++++++++++++++
 strbuf.h                         |  11 +++-
 t/t0030-stripspace.sh            |  36 ++++++++++
 12 files changed, 181 insertions(+), 109 deletions(-)

-- 
2.6.1.148.g7927db1
