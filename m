From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 0/4] Extend mailmap functionality
Date: Sat, 31 Jan 2009 22:47:57 +0100
Message-ID: <cover.1233438174.git.marius@trolltech.com>
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 22:51:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNk3-0000ux-Ql
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZAaVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZAaVtS
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:49:18 -0500
Received: from hoat.troll.no ([62.70.27.150]:44185 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbZAaVtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:49:13 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id F371A20FD0;
	Sat, 31 Jan 2009 22:49:06 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id DEDAC20FC0;
	Sat, 31 Jan 2009 22:49:06 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.257.g34f62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107947>

So, this patch series extends the mailmap functionality to:
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


This patch serie for extended mapping is necessary when a company
wants to have their repositories open to the public, but needs to
protect the identities of the developers. It enables you to only show
nicks and standardized emails, like 'Dev123 <bugs@company.xx>' in the
public repo, but by using an private mailmap file, map the name back
to 'John Doe <john.doe@company.xx>' inside the company.


Patch serie applies cleanly on master branch, and test run shows no
regressions.

Marius Storm-Olsen (4):
  Add log.mailmap as configurational option for mailmap location
  Add find_insert_index, insert_at_index and clear_func functions to
    string_list
  Add map_user() and clear_mailmap() to mailmap
  Change current mailmap usage to do matching on both name and email of
    author/committer.

 Documentation/config.txt         |    9 ++
 Documentation/git-shortlog.txt   |   61 +++++++++---
 Documentation/pretty-formats.txt |    2 +
 builtin-blame.c                  |   52 ++++++----
 builtin-shortlog.c               |   25 ++++-
 cache.h                          |    1 +
 config.c                         |   10 ++
 mailmap.c                        |  207 ++++++++++++++++++++++++++++++++++----
 mailmap.h                        |    4 +
 pretty.c                         |   59 ++++++-----
 string-list.c                    |   43 +++++++-
 string-list.h                    |    9 ++
 t/t4203-mailmap.sh               |  152 ++++++++++++++++++++++++++++
 13 files changed, 541 insertions(+), 93 deletions(-)
 create mode 100755 t/t4203-mailmap.sh
