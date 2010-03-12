From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 00/13] tr/display-notes
Date: Fri, 12 Mar 2010 18:04:24 +0100
Message-ID: <cover.1268413246.git.trast@student.ethz.ch>
References: <201003111103.22671.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8JV-00018m-CY
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab0CLRFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:04 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:18753 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756984Ab0CLRFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:03 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:01 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:04:39 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <201003111103.22671.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142046>

Here's a hopefully last replacement for the series.  I implemented
Johan's requests for changes and collected his acks; the only
behavioral change is that format_display_notes() no longer calls
init_display_notes() implicitly.

Thomas Rast (13):
  test-lib: unset GIT_NOTES_REF to stop it from influencing tests
  Support showing notes from more than one notes tree
  Documentation: document post-rewrite hook
  commit --amend: invoke post-rewrite hook
  rebase: invoke post-rewrite hook
  rebase -i: invoke post-rewrite hook
  notes: implement 'git notes copy --stdin'
  notes: implement helpers needed for note copying during rewrite
  rebase: support automatic notes copying
  commit --amend: copy notes to the new commit
  notes: add shorthand --ref to override GIT_NOTES_REF
  notes: track whether notes_trees were changed at all
  git-notes(1): add a section about the meaning of history

 Documentation/config.txt         |   53 +++++-
 Documentation/git-notes.txt      |   46 ++++-
 Documentation/githooks.txt       |   38 ++++
 Documentation/pretty-options.txt |   11 +-
 builtin.h                        |   18 ++
 builtin/commit.c                 |   45 +++++
 builtin/log.c                    |    5 +
 builtin/notes.c                  |  197 ++++++++++++++++++++-
 cache.h                          |    3 +
 git-am.sh                        |   13 ++
 git-rebase--interactive.sh       |   52 +++++-
 git-rebase.sh                    |    6 +
 notes.c                          |  191 +++++++++++++++++++-
 notes.h                          |   66 +++++++
 pretty.c                         |    6 +-
 refs.c                           |    4 +-
 refs.h                           |    5 +
 revision.c                       |   21 ++
 revision.h                       |    5 +
 t/t3301-notes.sh                 |  377 +++++++++++++++++++++++++++++++++++++-
 t/t3400-rebase.sh                |   17 ++
 t/t3404-rebase-interactive.sh    |   24 +++
 t/t5407-post-rewrite-hook.sh     |  183 ++++++++++++++++++
 t/t7501-commit.sh                |   12 ++
 t/test-lib.sh                    |    4 +
 25 files changed, 1369 insertions(+), 33 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh
