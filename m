From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 0/4] notes mergestrategy configuration option
Date: Fri, 14 Aug 2015 10:50:16 -0700
Message-ID: <1439574620-25249-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 19:50:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQJ7i-0004Lk-PR
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 19:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbbHNRu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 13:50:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:18933 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbbHNRuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 13:50:24 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 14 Aug 2015 10:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,678,1432623600"; 
   d="scan'208";a="542028546"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2015 10:50:24 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275916>

From: Jacob Keller <jacob.keller@gmail.com>

I have tried to cover all of the comments since the last sending of
this series. I am not 100% sure if I got everything, so please feel free
to respond again if I missed something.

This series implements the notes.mergestrategy option, as well as a
notes.<ref>.mergestrategy option which can be used to customize what
strategy is used to merge into a particular ref. I chose to use the
local ref instead of the remote reference, as it is most likely that you
will merge into a given ref with the same strategy rather than always
using the same strategy to merge from a ref.

The notes.<ref>.mergestrategy option uses the short name under
refs/notes/ and does not allow arbitrary references. Today git-notes
does not allow *any* arbitrary ref as a notes ref for either merge or
any other operation, (see init_notes_check!). Due to this, we can force
the config to use the shorthand name instead of the full name.

In the future we may wish to allow non-write operations to reference an
arbitrary ref (such as refs/remote-notes/* or refs/tracking/*/notes/)
but this is not today supported, and in anycase merge is a destructive
write operation so it should always require refs/notes/ references.


Changes since v4
* renamed option to mergestrategy for both per-ref and general option
  for consistency and to keep the notes.merge and notes.<ref>.merge
  available as keys for future notes enhancements

* use shortrefs for notes.<ref>.mergestrategy

Jacob Keller (4):
  notes: document cat_sort_uniq rewriteMode
  notes: add tests for --commit/--abort/--strategy exclusivity
  notes: add notes.mergestrategy option to select default strategy
  notes: teach git-notes about notes.<ref>.mergestrategy option

 Documentation/config.txt              | 18 ++++++++--
 Documentation/git-notes.txt           | 23 ++++++++++--
 builtin/notes.c                       | 46 +++++++++++++++++-------
 notes-merge.h                         | 16 +++++----
 t/t3309-notes-merge-auto-resolve.sh   | 68 +++++++++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh | 12 +++++++
 6 files changed, 159 insertions(+), 24 deletions(-)

-- 
2.5.0.280.g4aaba03
