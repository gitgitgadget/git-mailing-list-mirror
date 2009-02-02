From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v3 0/4] Extend mailmap functionality
Date: Mon,  2 Feb 2009 15:32:06 +0100
Message-ID: <cover.1233584536.git.marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 15:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTzsz-000779-Rq
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 15:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBBOd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 09:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbZBBOd1
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 09:33:27 -0500
Received: from hoat.troll.no ([62.70.27.150]:37585 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbZBBOd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 09:33:27 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 4105120F47;
	Mon,  2 Feb 2009 15:33:21 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 2E3BC20F04;
	Mon,  2 Feb 2009 15:33:21 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.257.g84fd75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108090>

  v3:
  ---
  * Make log.mailmap augment repo "/.mailmap" rather than override
  * Remove second argument of read_mailmap(<map>, <file>, <abbrev>);
  * Wrap commit messages within column 70
  v2:
  ---
  * Folded in documentation fixup from patch 4 into patch 3.


This patch series extends the mailmap functionality to:
  1) Allow the mailmap file in any location (also outside repo)
  2) Enable mailmap to match on both Name and Email

So, why would this be a good thing?

2) Lets you replace both name and email of an author/committer, based
on a name and/or email. So, should you have done commits with faulty
address, or if an old email simply isn't valid anymore, you can add
a mapping for that to replace it. So, the old style mapping is
    Proper Name <commit@email.xx>

while this patch series adds support for
    Proper Name <proper@email.xx> <commit@email.xx>
    Proper Name <proper@email.xx> Commit Name <commit@email.xx>

1) Lets you keep a private mailmap file, which is not distributed with
your repository.


This extended mapping is necessary when a company wants to have their
repositories open to the public, but needs to protect the identities
of the developers. It enables you to only show nicks and standardized
emails, like 'Dev123 <bugs@company.xx>' in the public repo, but by
using an private mailmap file, map the name back to
'John Doe <john.doe@company.xx>' inside the company.


Patch serie applies cleanly on master branch, and test run shows no
regressions.

Marius Storm-Olsen (4):
  Add log.mailmap as configurational option for mailmap location
  Add find_insert_index, insert_at_index and clear_func functions to
    string_list
  Add map_user() and clear_mailmap() to mailmap
  Change current mailmap usage to do matching on both name and email of
    author/committer.

 Documentation/config.txt         |    8 ++
 Documentation/git-shortlog.txt   |   61 ++++++++---
 Documentation/pretty-formats.txt |    2 +
 builtin-blame.c                  |   52 ++++++----
 builtin-shortlog.c               |   25 ++++-
 cache.h                          |    1 +
 config.c                         |   10 ++
 mailmap.c                        |  210 ++++++++++++++++++++++++++++++++++----
 mailmap.h                        |    6 +-
 pretty.c                         |   59 ++++++-----
 string-list.c                    |   43 +++++++-
 string-list.h                    |    9 ++
 t/t4203-mailmap.sh               |  202 ++++++++++++++++++++++++++++++++++++
 13 files changed, 593 insertions(+), 95 deletions(-)
 create mode 100755 t/t4203-mailmap.sh
