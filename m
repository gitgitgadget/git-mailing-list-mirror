From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 0/4] add notes strategy configuration options
Date: Tue, 11 Aug 2015 13:57:17 -0700
Message-ID: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 22:57:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPGc0-0003pT-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 22:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbbHKU52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 16:57:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:9837 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbbHKU51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 16:57:27 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 11 Aug 2015 13:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,655,1432623600"; 
   d="scan'208";a="782214940"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2015 13:57:27 -0700
X-Mailer: git-send-email 2.5.0.482.gfcd5645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275725>

From: Jacob Keller <jacob.keller@gmail.com>

This series of patches implements notes.merge and notes.<ref>.merge
options for configuring notes merge strategy such that user may avoid
typing "-s". It is (probably) most useful if the user wishes to always
enforce cat_sort_uniq strategy.

This series now uses git_config_get_string_const() instead of trying to
change the git_default_config setup. In addition, the 4th patch is much
smaller and avoids a lot of heavy cruft due to this change.

I tried to re-work everything I noticed from the email list, but please
shout if I did not manage to recall your suggestion.

The new version should be much simpler to understand.

Changes since v3:
* don't use hash table, instead just call "git_config_get_string_const"
* notes.<ref>.merge must always be fully qualified, (since notes doesn't
  enforce the refs to be always in refs/notes, so we shouldn't either)
* fixed documentation to reduce confusion over which strategies are
  accepted for options
* ensure tests cover "notes.<ref>.merge" overrides "notes.merge"

I also tried to make sure the reviewers were all Cc'ed on every patch
not just the first one this time.

Jacob Keller (4):
  notes: document cat_sort_uniq rewriteMode
  notes: add tests for --commit/--abort/--strategy exclusivity
  notes: add notes.merge option to select default strategy
  notes: teach git-notes about notes.<ref>.merge option

 Documentation/config.txt              | 17 +++++++--
 Documentation/git-notes.txt           | 23 ++++++++++--
 builtin/notes.c                       | 49 ++++++++++++++++---------
 notes-merge.h                         | 16 +++++----
 t/t3309-notes-merge-auto-resolve.sh   | 68 +++++++++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 +++++++
 6 files changed, 157 insertions(+), 28 deletions(-)

-- 
2.5.0.482.gfcd5645
