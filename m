From: Brad King <brad.king@kitware.com>
Subject: [PATCH v4 0/8] Multiple simultaneously locked ref updates
Date: Wed,  4 Sep 2013 11:22:37 -0400
Message-ID: <cover.1378307529.git.brad.king@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEx3-0008E7-J5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935085Ab3IDPYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:24:39 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:60240 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934761Ab3IDPYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:24:37 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 6FD819FB8C; Wed,  4 Sep 2013 11:22:45 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378142795.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233840>

Hi Folks,

Here is the fourth revision of a series to support locking multiple
refs at the same time to update all of them consistently.  The
previous revisions of the series can be found at $gmane/233260,
$gmane/233458, and $gmane/233647.

Updates since the previous revision of the series:

* Patches 1-4 are identical

* Patches 5-7 no longer have ":" at the end of comments, a style I
  "learned" from the context of patch 5 but that I saw Junio squash
  out of patch 5 v2 when he queued it as 53237ae4.

* Patch 7 has a re-organized parser and now defines a -z format for
  stdin that terminates arguments with NUL and lines with LF NUL:

   ... <ref> NUL <newvalue> NUL [ <oldvalue> NUL ] LF NUL

* Patch 8 now has test cases for -z mode and updated error cases for
  the re-organized parser.

Note to maintainer:

* Patch 4 needs to be re-queued to replace c7c80f49 due to the
  tweak suggested in $gmane/233521 and made in v3 and kept in v4.

Thanks,
-Brad

Brad King (8):
  reset: rename update_refs to reset_refs
  refs: report ref type from lock_any_ref_for_update
  refs: factor update_ref steps into helpers
  refs: factor delete_ref loose ref step into a helper
  refs: add function to repack without multiple refs
  refs: add update_refs for multiple simultaneous updates
  update-ref: support multiple simultaneous updates
  update-ref: add test cases covering --stdin signature

 Documentation/git-update-ref.txt |  22 +-
 branch.c                         |   2 +-
 builtin/commit.c                 |   2 +-
 builtin/fetch.c                  |   3 +-
 builtin/receive-pack.c           |   3 +-
 builtin/reflog.c                 |   2 +-
 builtin/replace.c                |   2 +-
 builtin/reset.c                  |   4 +-
 builtin/tag.c                    |   2 +-
 builtin/update-ref.c             | 144 ++++++++++++-
 fast-import.c                    |   2 +-
 refs.c                           | 195 ++++++++++++++---
 refs.h                           |  22 +-
 sequencer.c                      |   3 +-
 t/t1400-update-ref.sh            | 445 +++++++++++++++++++++++++++++++++++++++
 15 files changed, 812 insertions(+), 41 deletions(-)

-- 
1.8.4.rc3
