From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 0/3] stripspace: Implement and use --count-lines option
Date: Thu, 15 Oct 2015 14:18:41 +0200
Message-ID: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 14:19:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmhUo-0001Q4-0B
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 14:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbbJOMSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 08:18:52 -0400
Received: from mail.zhinst.com ([212.126.164.98]:35427 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbbJOMSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 08:18:48 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Thu, 15 Oct 2015 14:18:44 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279664>

This patch set implements some of the project ideas around git stripspace
suggested on [1].

[1] https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

The first patch moves the stripspace() function to the
strbuf module (adding a prefix and changing all users accordingly, also
a wrapper is introduced in case any topic branches still depend on the
old name). The second patch introduces option --count-lines to git
stripspace and also adds documentation and tests accordingly, Finally,
the third patch changes git-rebase--interactive.sh to replace commands
like:

	git stripspace ... | wc -l

with:

	git stripspace --count-lines ...

Tobias Klauser (3):
  strbuf: make stripspace() part of strbuf
  stripspace: Implement --count-lines option
  git rebase -i: Use newly added --count-lines option for stripspace

 Documentation/git-stripspace.txt |  13 ++++-
 builtin/am.c                     |   2 +-
 builtin/branch.c                 |   2 +-
 builtin/commit.c                 |   6 +-
 builtin/merge.c                  |   2 +-
 builtin/notes.c                  |   6 +-
 builtin/stripspace.c             | 122 ++++++++++-----------------------------
 builtin/tag.c                    |   2 +-
 git-rebase--interactive.sh       |   6 +-
 strbuf.c                         |  72 +++++++++++++++++++++++
 strbuf.h                         |  14 ++++-
 t/t0030-stripspace.sh            |  36 ++++++++++++
 12 files changed, 177 insertions(+), 106 deletions(-)

-- 
2.6.1.145.gb27dacc
