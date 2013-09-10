From: Brad King <brad.king@kitware.com>
Subject: [PATCH v6 0/8] Multiple simultaneously locked ref updates
Date: Mon,  9 Sep 2013 20:57:38 -0400
Message-ID: <cover.1378773895.git.brad.king@kitware.com>
References: <cover.1378732710.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 02:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJCJB-00073U-G6
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 02:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab3IJA7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 20:59:53 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:41669 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756126Ab3IJA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 20:59:52 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 8A5D39FB8C; Mon,  9 Sep 2013 20:57:46 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378732710.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234406>

Hi Folks,

Here is the sixth revision of a series to support locking multiple
refs at the same time to update all of them consistently.  The
previous revisions of the series can be found at $gmane/233260,
$gmane/233458, $gmane/233647, $gmane/233840, and $gmane/234324.

Updates since the previous revision of the series:

* The entire series was rebased on master at bb80ee09; it was
  previously based on v1.8.4.

* A conflict in refs.c with 47a59185 was resolved by preserving
  the elimination of find_ref_by_name while adding our new content.

* A conflict in builtin/update-ref.c with d5d09d47 (Replace deprecated
  OPT_BOOLEAN by OPT_BOOL, 2013-08-03) was resolved by integrating
  both changes.  The new options added in patch 7 now use OPT_BOOL.

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

 Documentation/git-update-ref.txt |  54 +++-
 branch.c                         |   2 +-
 builtin/commit.c                 |   2 +-
 builtin/fetch.c                  |   3 +-
 builtin/receive-pack.c           |   3 +-
 builtin/reflog.c                 |   2 +-
 builtin/replace.c                |   2 +-
 builtin/reset.c                  |   4 +-
 builtin/tag.c                    |   2 +-
 builtin/update-ref.c             | 252 ++++++++++++++-
 fast-import.c                    |   2 +-
 refs.c                           | 195 ++++++++++--
 refs.h                           |  22 +-
 sequencer.c                      |   3 +-
 t/t1400-update-ref.sh            | 639 +++++++++++++++++++++++++++++++++++++++
 15 files changed, 1146 insertions(+), 41 deletions(-)

-- 
1.8.4.rc3
