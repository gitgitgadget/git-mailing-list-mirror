From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 0/8] Multiple simultaneously locked ref updates
Date: Mon,  2 Sep 2013 13:48:48 -0400
Message-ID: <cover.1378142795.git.brad.king@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 19:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGYHE-00066z-Ei
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab3IBRuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:50:54 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:55771 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758805Ab3IBRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 13:50:44 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 95AA79FB87; Mon,  2 Sep 2013 13:48:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377885441.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233647>

Hi Folks,

Here is the third revision of a series to support locking multiple
refs at the same time to update all of them consistently.  The
previous revisions of the series can be found at $gmane/233260 and
$gmane/233458.

Updates since the previous revision of the series:

* Incorporated style fixes suggested in patches 6-8.

* In patch 3, the local "lock" variables in update_ref_lock and
  update_ref now drop the existing "static" declaration.

* In patch 4, delete_ref_loose internals have been cleaned up
  as Michael suggested.

* In patch 6:

  - struct ref_update has been documented
  - update_refs now takes an array of pointers to struct ref_update
    as Michael and Junio both suggested
  - update_refs return cases were simplified with a label and goto
  - update_refs now stops immediately if any ref write fails
  - ref_update_compare now compares only the ref name

* In patch 7, another new input format is proposed.  It now uses
  quoting based on unquote_c_style.

* In patch 8, more new test cases have been added.  Failure cases
  are now covered in separate steps to simplify diagnosis.

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

 Documentation/git-update-ref.txt |   20 ++-
 branch.c                         |    2 +-
 builtin/commit.c                 |    2 +-
 builtin/fetch.c                  |    3 +-
 builtin/receive-pack.c           |    3 +-
 builtin/reflog.c                 |    2 +-
 builtin/replace.c                |    2 +-
 builtin/reset.c                  |    4 +-
 builtin/tag.c                    |    2 +-
 builtin/update-ref.c             |  103 ++++++++++++++-
 fast-import.c                    |    2 +-
 refs.c                           |  191 ++++++++++++++++++++++++----
 refs.h                           |   22 +++-
 sequencer.c                      |    3 +-
 t/t1400-update-ref.sh            |  256 ++++++++++++++++++++++++++++++++++++++
 15 files changed, 578 insertions(+), 39 deletions(-)

-- 
1.7.10.4
