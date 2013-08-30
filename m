From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 0/8] Multiple simultaneously locked ref updates
Date: Fri, 30 Aug 2013 14:11:58 -0400
Message-ID: <cover.1377885441.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 20:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTD3-0007qi-LQ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab3H3SOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:14:06 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:50947 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755786Ab3H3SNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:13:46 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id C95739FB87; Fri, 30 Aug 2013 14:12:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233458>

Hi Folks,

Here is the second revision of a series to support locking multiple
refs at the same time to update all of them consistently.  The first
series can be found at $gmane/233260.  This revision is ready to
consider for integration.

Updates since the previous revision of the series:

* Incorporated style fixes and cleanups suggested by Junio.

* In patch 6, the new update_refs function now sorts the updates
  so that locks are acquired in a consistent order by competing
  processes.  Then it uses a simple linear scan to reject input
  containing duplicate refs (which are adjacent after sorting).
  Also, struct ref_update now has a symmetric representation
  for new_sha1 and old_sha1.

* In patch 7, I propose a new format for instructions read from
  standard input that is much more robust and extensible.

* Patch 8 is new and adds test cases covering new features
  and error cases.

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

 Documentation/git-update-ref.txt |   21 +++-
 branch.c                         |    2 +-
 builtin/commit.c                 |    2 +-
 builtin/fetch.c                  |    3 +-
 builtin/receive-pack.c           |    3 +-
 builtin/reflog.c                 |    2 +-
 builtin/replace.c                |    2 +-
 builtin/reset.c                  |    4 +-
 builtin/tag.c                    |    2 +-
 builtin/update-ref.c             |  121 +++++++++++++++++++++-
 fast-import.c                    |    2 +-
 refs.c                           |  203 +++++++++++++++++++++++++++++++++----
 refs.h                           |   16 ++-
 sequencer.c                      |    3 +-
 t/t1400-update-ref.sh            |  206 ++++++++++++++++++++++++++++++++++++++
 15 files changed, 558 insertions(+), 34 deletions(-)

-- 
1.7.10.4
