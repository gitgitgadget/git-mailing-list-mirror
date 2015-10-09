From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 00/13] object_id part 2
Date: Fri,  9 Oct 2015 01:43:46 +0000
Message-ID: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkH-0001MB-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790AbbJIBpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:10 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58045 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755625AbbJIBpI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AA9FA28094;
	Fri,  9 Oct 2015 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355107;
	bh=5O3d5DMPEzmTtwKOgvjZC7lq2tV8qboMk/QzwarTIEw=;
	h=From:To:Cc:Subject:Date:From;
	b=fiO6omgb31pXUZjpBlC6RbatLlwBdxl/TrOjY7/Au/H6xMLXYYsoWbjGKW/+rIQXo
	 /muzKGzSiCSZhl270YbtlPTks1iNSC0ok/0Fxx+6NHzMPElnUVbtjynjXlBbg7KuCb
	 Smx642VSqXXwP9C3HFukA18B4AWIIj5uZEHGpCP8xPza4fL4F2dnYrJkcbusooea3N
	 +GEX8HwYOmntFVbhSOfvwdLPulkVui2TzyXwlEECYPJzURsC5lA8iKzPFwNQKuo83G
	 Ax69nkgJ9dfD20iWWAu4RLJhpIePoxd47Dw+4DoQoczvokrVP3zME9oB6cEboReh+R
	 j0vebADb0K82KtuYNUlBzsMtMuu4I2RfGJvhz+09I0EkGLoruAZvBuI15osPz7LGiJ
	 /VgieYlVdws1Weatm///89BCE1u1+lDZUeDxK6RcRBSW0fKNadQ/6Mpp197kccGFXa
	 tJ0xtaHwCghXyebButpnfn6+yDOyNKtB399pb2r23IEYFVhimGK
X-Mailer: git-send-email 2.6.1
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279285>

This is another series of conversions to struct object_id.

This series converts more of the refs code and struct object to use
struct object_id.  It introduces an additional helper function,
has_object_file, which is the equivalent of has_sha1_file.  The name was
chosen to be slightly more logical than has_oid_file, although it can be
changed if desired.

Unlike previous iterations, this series of patches should make it
entirely to the list.  It split out the conversion of struct object into
the introduction of a helper macro, the use of that macro in several
areas, the conversion of other struct object uses and update of the
macro, and the removal of the macro.  The final patch of that set
(patch 12) was implemented entirely by the use of a Perl script, which
will be included for inspection.

Patches 1 through 8 remain unchanged except for the rebase and the
necessary changes due to other topics.  Necessary changes were minimal.

This series is also available in the object-id-part2 branch from

https://github.com/bk2204/git.git
https://git.crustytoothpaste.net/git/bmc/git.git

Changes from v2:
* Rebase on latest master.
* Split out the conversion of struct object into multiple patches.

brian m. carlson (13):
  refs: convert some internal functions to use object_id
  sha1_file: introduce has_object_file helper.
  Convert struct ref to use object_id.
  add_sought_entry_mem: convert to struct object_id
  parse_fetch: convert to use struct object_id
  get_remote_heads: convert to struct object_id
  push_refs_with_export: convert to struct object_id
  ref_newer: convert to use struct object_id
  object: introduce get_object_hash macro.
  Add several uses of get_object_hash.
  Convert struct object to object_id
  Remove get_object_hash.
  remote: convert functions to struct object_id

 archive.c                |   6 +--
 bisect.c                 |  10 ++--
 branch.c                 |   2 +-
 builtin/am.c             |   2 +-
 builtin/blame.c          |  52 ++++++++++----------
 builtin/branch.c         |   2 +-
 builtin/checkout.c       |  22 ++++-----
 builtin/clone.c          |  18 +++----
 builtin/commit-tree.c    |   4 +-
 builtin/commit.c         |   8 ++--
 builtin/describe.c       |  20 ++++----
 builtin/diff-tree.c      |  12 ++---
 builtin/diff.c           |  12 ++---
 builtin/fast-export.c    |  34 +++++++-------
 builtin/fetch-pack.c     |  14 +++---
 builtin/fetch.c          |  54 ++++++++++-----------
 builtin/fmt-merge-msg.c  |   6 +--
 builtin/fsck.c           |  36 +++++++-------
 builtin/grep.c           |   6 +--
 builtin/index-pack.c     |  10 ++--
 builtin/log.c            |  36 +++++++-------
 builtin/ls-remote.c      |   2 +-
 builtin/merge-base.c     |   8 ++--
 builtin/merge-tree.c     |   6 +--
 builtin/merge.c          |  60 ++++++++++++------------
 builtin/name-rev.c       |  12 ++---
 builtin/notes.c          |   2 +-
 builtin/pack-objects.c   |  16 +++----
 builtin/pull.c           |   2 +-
 builtin/receive-pack.c   |   2 +-
 builtin/reflog.c         |   4 +-
 builtin/remote.c         |  12 ++---
 builtin/replace.c        |   6 +--
 builtin/reset.c          |  30 ++++++------
 builtin/rev-list.c       |  18 +++----
 builtin/rev-parse.c      |   4 +-
 builtin/shortlog.c       |   2 +-
 builtin/show-branch.c    |   8 ++--
 builtin/unpack-objects.c |  10 ++--
 builtin/worktree.c       |   2 +-
 bundle.c                 |  20 ++++----
 cache-tree.c             |   2 +-
 cache.h                  |   3 ++
 combine-diff.c           |   4 +-
 commit.c                 |  32 ++++++-------
 connect.c                |  22 +++++----
 decorate.c               |   2 +-
 diff-lib.c               |   2 +-
 fetch-pack.c             |  24 +++++-----
 fsck.c                   |  14 +++---
 http-backend.c           |   2 +-
 http-push.c              |  88 +++++++++++++++++-----------------
 http.c                   |   2 +-
 line-log.c               |   6 +--
 list-objects.c           |   4 +-
 log-tree.c               |  40 ++++++++--------
 merge-blobs.c            |   4 +-
 merge-recursive.c        |  26 +++++-----
 merge.c                  |   2 +-
 notes-merge.c            |  24 +++++-----
 object.c                 |   8 ++--
 object.h                 |   2 +-
 pack-bitmap-write.c      |  16 +++----
 pack-bitmap.c            |  34 +++++++-------
 patch-ids.c              |   6 +--
 pretty.c                 |  18 +++----
 ref-filter.c             |  18 +++----
 refs.c                   | 106 ++++++++++++++++++++---------------------
 remote-curl.c            |  20 ++++----
 remote.c                 | 120 +++++++++++++++++++++++------------------------
 remote.h                 |   8 ++--
 revision.c               |  48 +++++++++----------
 send-pack.c              |  16 +++----
 sequencer.c              |  40 ++++++++--------
 server-info.c            |   2 +-
 sha1_file.c              |   5 ++
 sha1_name.c              |  20 ++++----
 shallow.c                |   6 +--
 submodule.c              |   8 ++--
 tag.c                    |  10 ++--
 test-match-trees.c       |   2 +-
 transport-helper.c       |  24 +++++-----
 transport.c              |  32 ++++++-------
 transport.h              |   8 ++--
 tree.c                   |  10 ++--
 upload-pack.c            |  26 +++++-----
 walker.c                 |  20 ++++----
 wt-status.c              |   2 +-
 88 files changed, 771 insertions(+), 759 deletions(-)

-- 
2.6.1
