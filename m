From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 00/10] Use a structure for object IDs.
Date: Fri, 13 Mar 2015 23:39:26 +0000
Message-ID: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZBg-0008J9-BA
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbbCMXkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50099 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbbCMXkK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0EDC42808F;
	Fri, 13 Mar 2015 23:40:09 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265425>

This is a patch series to convert some of the relevant uses of unsigned
char [20] to struct object_id.

The goal of this series to improve type-checking in the codebase and to
make it easier to move to a different hash function if the project
decides to do that.

There should be no functional change from this patch series.

I've tried to adopt most of the suggestions where possible without major
reworking.

Changes since v1:
* Call the struct member "hash".
* Convert some additional magic numbers to be based off the constants
  GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ.  Introduce variables where this
  makes sense.
* Define GIT_SHA1_HEXSZ in terms of GIT_SHA1_RAWSZ.
* Move the definition of struct object_id to cache.h.  No new #includes
  are required as a result.
* Use better names for arguments to oidcmp.
* Convert one or two structs that were missed last time.

You can see this series on the object-id branch (may be rebased) at

  https://github.com/bk2204/git.git
  https://git.crustytoothpaste.net/git/bmc/git.git

Both repositories are pushed at the same time.

brian m. carlson (10):
  Define a structure for object IDs.
  Define utility functions for object IDs.
  bisect.c: convert leaf functions to use struct object_id
  archive.c: convert to use struct object_id
  zip: use GIT_SHA1_HEXSZ for trailers
  bulk-checkin.c: convert to use struct object_id
  diff: convert struct combine_diff_path to object_id
  commit: convert parts to struct object_id
  patch-id: convert to use struct object_id
  apply: convert threeway_stage to object_id

 archive-zip.c      |  4 ++--
 archive.c          | 22 ++++++++++-----------
 bisect.c           | 40 +++++++++++++++++++-------------------
 builtin/apply.c    | 14 +++++++-------
 builtin/patch-id.c | 34 ++++++++++++++++-----------------
 bulk-checkin.c     | 12 ++++++------
 cache.h            | 40 ++++++++++++++++++++++++++++++++++----
 combine-diff.c     | 56 +++++++++++++++++++++++++++---------------------------
 commit.c           | 56 +++++++++++++++++++++++++++++-------------------------
 commit.h           |  4 ++--
 diff-lib.c         | 10 +++++-----
 diff.h             |  5 +++--
 hex.c              | 16 +++++++++++++---
 log-tree.c         |  2 +-
 send-pack.c        |  2 +-
 shallow.c          |  8 ++++----
 tree-diff.c        | 10 +++++-----
 upload-pack.c      |  2 +-
 18 files changed, 192 insertions(+), 145 deletions(-)

-- 
2.2.1.209.g41e5f3a
