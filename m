From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 0/8] --remerge-diff
Date: Sat,  6 Sep 2014 19:56:58 +0200
Message-ID: <cover.1409860234.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 19:57:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQKEn-0005cx-1o
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbaIFR5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:57:20 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40757 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbaIFR5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:57:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id CF9C94D66AD;
	Sat,  6 Sep 2014 19:57:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jqTgsHddKi9N; Sat,  6 Sep 2014 19:57:06 +0200 (CEST)
Received: from linux.local (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9696D4D6510;
	Sat,  6 Sep 2014 19:57:05 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.72.g9b94086
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256591>

This is a resend of the remerge-diff patch series, previously posted
here:

  http://thread.gmane.org/gmane.comp.version-control.git/242514

Differences to the previous version:

- Rebased onto the new {name,dir}_hash maps (7/8 looks very different
  now).  This also allows freeing index entries that we no longer need
  (in 8/8); previously, the insert-only name-hash kept them alive.

- Adaptations to match Duy's changes to cache_tree handling (in 8/8).
  Please review the cache_tree handling extra carefully, as I'm not
  100% convinced the dance there is all that is needed.



Thomas Rast (8):
  merge-recursive: remove dead conditional in update_stages()
  merge-recursive: internal flag to avoid touching the worktree
  merge-recursive: -Xindex-only to leave worktree unchanged
  combine-diff: do not pass revs->dense_combined_merges redundantly
  Fold all merge diff variants into an enum
  merge-recursive: allow storing conflict hunks in index
  name-hash: allow dir hashing even when !ignore_case
  log --remerge-diff: show what the conflict resolution changed

 Documentation/merge-strategies.txt |   9 ++
 Documentation/rev-list-options.txt |   7 +
 builtin/diff-files.c               |   5 +-
 builtin/diff-tree.c                |   2 +-
 builtin/diff.c                     |  12 +-
 builtin/fmt-merge-msg.c            |   2 +-
 builtin/log.c                      |   9 +-
 builtin/merge.c                    |   1 -
 cache.h                            |   2 +
 combine-diff.c                     |  13 +-
 diff-lib.c                         |  13 +-
 diff.h                             |   6 +-
 log-tree.c                         | 303 ++++++++++++++++++++++++++++++++++++-
 merge-recursive.c                  |  52 ++++---
 merge-recursive.h                  |   3 +
 name-hash.c                        |  13 +-
 revision.c                         |  15 +-
 revision.h                         |  24 ++-
 submodule.c                        |   3 +-
 t/t3030-merge-recursive.sh         |  33 ++++
 t/t4213-log-remerge-diff.sh        | 222 +++++++++++++++++++++++++++
 21 files changed, 673 insertions(+), 76 deletions(-)
 create mode 100755 t/t4213-log-remerge-diff.sh

-- 
2.1.0.72.g9b94086
