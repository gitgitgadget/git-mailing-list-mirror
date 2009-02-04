From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v3 0/9] git checkout: more cleanups, optimisation,
 less lstat() calls
Date: Wed, 04 Feb 2009 13:52:45 +0100
Message-ID: <cover.1233751281.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 13:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUhHN-0006OR-KW
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363AbZBDMw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757358AbZBDMw7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:52:59 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:45415 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbZBDMw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:52:58 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEJ003IEL47HW70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:52:55 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.216])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEJ004C6L47S210@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:52:55 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108351>

Changes since v2

--- patch */9 ---
- Changed the order of some patches.
- Some updates to the commit log messages.

--- patch 2/9 ---
- New patch which let us later use longest_match_lstat_cache(), now
  renamed to longest_path_match(), inside patch 4/9.

--- patch 3/9 ---
- New patch which update the symlinks.c file to be more in line with
  the GIT source code (s/length,string/string,length/ for function
  arguments).

-- patch 4/9 ---
- The new function schedule_dir_for_removal() is placed inside
  symlinks.c instead of unpack-trees.c

-- patch 9/9 ---
- NOTE/NB: this patch is only a debug patch, not be included in the final
  GIT release version.



Kjetil Barvik (9):
  lstat_cache(): small cleanup and optimisation
  lstat_cache(): generalise longest_match_lstat_cache()
  lstat_cache(): swap func(length, string) into func(string, length)
  unlink_entry(): introduce schedule_dir_for_removal()
  create_directories(): remove some memcpy() and strchr() calls
  write_entry(): cleanup of some duplicated code
  write_entry(): use fstat() instead of lstat() when file is open
  show_patch_diff(): remove a call to fstat()
  lstat_cache(): print a warning if doing ping-pong between cache types

 Documentation/CodingGuidelines |    3 +
 builtin-add.c                  |    2 +-
 builtin-apply.c                |    2 +-
 builtin-update-index.c         |    2 +-
 cache.h                        |   10 ++-
 combine-diff.c                 |    4 +-
 diff-lib.c                     |    2 +-
 dir.c                          |    2 +-
 entry.c                        |  108 ++++++++++++-------------
 symlinks.c                     |  177 ++++++++++++++++++++++++++++++----------
 unpack-trees.c                 |   34 ++------
 11 files changed, 208 insertions(+), 138 deletions(-)
