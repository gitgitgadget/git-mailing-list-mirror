From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/6] post-rewrite hook and copying notes
Date: Sun, 14 Feb 2010 17:17:05 +0100
Message-ID: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngh9t-0003AW-7H
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab0BNQRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:14 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:37742 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab0BNQRN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:13 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:13 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:11 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139919>

This series implements a post-rewrite hook.  This has been on my todo
list since we first got notes, but I never got around to it.

My original intended use-case was to add a note for the source of the
rewritten commit, but recent discussion on git-notes was that we
should add some feature that lets users copy over their notes when
rewriting commits.  The hook in the last patch, together with the 'git
notes copy' command now in 'pu', can achieve this.

I'm not sure whether we should stop here and declare it the user's
responsibility to enable the hook though.  My idea of a "full
integration" approach would be to instead teach 'git notes copy' to
read the same type of lists that I'm handing to post-rewrite, and then
wire calls to it into the scripts in the same places that call
post-rewrite.  Opinions?

Thomas Rast (6):
  Documentation: document post-rewrite hook
  commit --amend: invoke post-rewrite hook
  filter-branch: invoke post-rewrite hook
  rebase: invoke post-rewrite hook
  rebase -i: invoke post-rewrite hook
  contrib: add a hook that copies notes over rewrites

 Documentation/githooks.txt            |   36 +++++++
 builtin-commit.c                      |   43 ++++++++
 contrib/hooks/post-rewrite-copy-notes |   37 +++++++
 git-am.sh                             |   10 ++
 git-filter-branch.sh                  |   10 ++
 git-rebase--interactive.sh            |   41 +++++++-
 git-rebase.sh                         |    5 +
 t/t5407-post-rewrite-hook.sh          |  180 +++++++++++++++++++++++++++++++++
 8 files changed, 361 insertions(+), 1 deletions(-)
 create mode 100644 contrib/hooks/post-rewrite-copy-notes
 create mode 100755 t/t5407-post-rewrite-hook.sh
