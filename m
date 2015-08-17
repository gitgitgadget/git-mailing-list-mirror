From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 0/6] implement notes.mergeStrategy
Date: Mon, 17 Aug 2015 14:33:28 -0700
Message-ID: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2U-0003aM-UB
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbHQVdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:43514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbbHQVdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:37 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910985"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276098>

From: Jacob Keller <jacob.keller@gmail.com>

This series implements mergeStrategy configuration options which take
the same value as --strategy. This series does not change the allowed
refs to merge from or to. There is a known limitation that you cannot
merge from refs outside of refs/notes (precluding the use of such refs
as refs/tracking/origin/notes/ and so forth).

- Changes since v8 -
* drop the rewrite and merge option patches, since rewrite names are not
  really equivalent to merge names (ours/theirs is flipped)
* change docs on notes.<name>.mergeStrategy

This series does *not* deal with:
* changes to which refs can be merged, init_notes_check already prevents
  git-notes-merge into refs outside of refs/notes*
* use of rewrite names for merge strategies, including even concatenate

Hopefully a future contributor will have some time to look at making
re-write just use the notes merge instead of doing re-write by hand.
This would also potentially allow for manual merges. This series does
not begin down this road, since we do not want to limit what this future
author is allowed to do with regards to rewrite and merge strategy
names.

I think finally this series is good. It may be worth adding some
test_expect_failures around merging from refs/tracking/origin/notes if
we intend to ever allow notes merges from these sources.

Jacob Keller (6):
  notes: document cat_sort_uniq rewriteMode
  notes: extract enum notes_merge_strategy to notes-utils.h
  note: extract parse_notes_merge_strategy to notes-utils
  notes: add tests for --commit/--abort/--strategy exclusivity
  notes: add notes.mergeStrategy option to select default strategy
  notes: teach git-notes about notes.<name>.mergeStrategy option

 Documentation/config.txt              | 16 ++++++-
 Documentation/git-notes.txt           | 25 +++++++++--
 builtin/notes.c                       | 43 +++++++++++++------
 notes-merge.h                         | 10 ++---
 notes-utils.c                         | 18 ++++++++
 notes-utils.h                         |  9 ++++
 t/t3309-notes-merge-auto-resolve.sh   | 79 +++++++++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++
 8 files changed, 187 insertions(+), 25 deletions(-)

-- 
2.5.0.280.g4aaba03
