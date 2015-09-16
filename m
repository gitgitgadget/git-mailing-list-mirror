From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/2] notes: allow read only notes actions on refs outside of refs/notes
Date: Wed, 16 Sep 2015 15:06:32 -0700
Message-ID: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 00:06:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKqn-00007K-I6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbbIPWGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:06:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:14404 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbbIPWGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:06:38 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP; 16 Sep 2015 15:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,542,1437462000"; 
   d="scan'208";a="646257358"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.123])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2015 15:06:37 -0700
X-Mailer: git-send-email 2.6.0.rc2.248.g5b5be23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278076>

From: Jacob Keller <jacob.keller@gmail.com>

The primary purpose of this series is to allow fetching remote notes
into a namespace such as "refs/remote-notes/<remote>/foo". Currently,
git-notes refuses to operate on refs outside of refs/notes/* including
merging from them, listing or showing them. This makes it difficult to
share notes from a remote repository.

Fix expand_notes_ref to not always prepend refs/notes to fully qualified
refs. Allow git-notes actions which do not specify NOTES_INIT_WRITABLE
to be performed on refs outside of refs/notes/*

Future work will include more coupling of "refs/remote-notes/<remote>"
into git-notes so that you can specify refs as "<remote>/foo" similar to
how remotes work for branches.

In addition, long term goal is to make it default to fetch notes into
refs/remote-notes/<remote>/*, and possibly to add some status for
tracking similar to how tracking branches work.

The one downside currently is that a test case for prevention of merge
from "refs/heads/master" had to be removed as "git notes merge
refs/heads/master" now works. I am not sure how this could be fixed.. I
did not find any way to tell if a treeish actually was a notes tree or
not...

This topic depends on mh/notes-allow-reading-treeish and actually
expands what this topic allowed before. Previously, treeishes such as
notes@{1} were made allowable, but the ref still had to be found under
refs/notes.

No documentation changes were made as from the looks of it,
documentation for --ref and core.notesRef is already correct despite the
previous behavior of expand_notes_ref. In that sense, documentation was
wrong before.

Jacob Keller (2):
  notes: don't expand qualified refs in expand_notes_ref
  notes: allow non-writable actions on refs outside of refs/notes

 builtin/notes.c        | 11 ++++++-----
 notes.c                |  4 ++--
 t/t3308-notes-merge.sh |  1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.6.0.rc2.248.g5b5be23
