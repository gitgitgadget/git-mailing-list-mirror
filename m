From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 00/12] object_id part 2
Date: Tue, 10 Nov 2015 02:22:18 +0000
Message-ID: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvyaG-0000jx-VW
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbbKJCWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:22:53 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58379 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066AbbKJCWu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:50 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CDDDB28094;
	Tue, 10 Nov 2015 02:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122169;
	bh=m8pPVtQBU68vaRfmCudBKFR76DuCOmnVZyzTVLikgx8=;
	h=From:To:Cc:Subject:Date:From;
	b=vP1FlesT8b6zV2zSk1dOEeUg3++Dcq8LsGHFQ5+9FLYLHXw6prTKY4+eIPUu4IDaU
	 ayWvitMeTWKeV5fqdGinrt4Rn6BQv2RB+Wpyz8dfjMYwfLezcF59Zh0ABNsbW5ebSl
	 awaZ66k1R/ouLasFXZxjCC2lP/y4Ct7+6DlKWn1+pNdPhRwVHGE08Yoep4nxwepoXi
	 B1b1i05bW6CwJvu32u/1O9MknOwvOv9TktFQoE/s35sRGGp+n9lpP/04waHTE7G47M
	 931YMc1pn6FfnglGTeB3X0JoQjnZtxkZwGQ7sAzRV9SRU28fpRfd/HNKHmoSe2s0QX
	 iS23leesghZf1w5S5kz6wACnaL03ovVIH6p+Xbp67/Y3Z/FkCsh1ahLZ7bJEULrvL6
	 3G+cOSNceNYphI9sUBIz3hcdUc7Aqg2bvOMtSHG8kQXsMX5ZDycYbNInVjGt3+Vv4T
	 m6VLL9ySNSHgXxr3+NPMMysimRnr7IiP4nk2u1xHtlmaXRXqFGY
X-Mailer: git-send-email 2.6.2.409.gb049f0a
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281090>

This is the second in a series of conversions to struct object_id.

This series converts more of the refs code and struct object to use
struct object_id.  It introduces an additional helper function,
has_object_file, which is the equivalent of has_sha1_file.  The name was
chosen to be slightly more logical than has_oid_file, although it can be
changed if desired.

This series splits out the conversion of struct object into the
introduction of a helper macro, the use of that macro in several areas,
the conversion of other struct object uses and update of the macro, and
the removal of the macro.  The final patch of that set (patch 11) was
implemented entirely by the use of a Perl script, which will be included
for inspection.

Patches 1 through 7 remain unchanged except for the rebase and the
necessary changes due to other topics.  Necessary changes were minimal.

I think this series is ready to be picked up, although I'm happy to make
changes or refinements if people have comments.

This series is also available in the object-id-part2 branch from

https://github.com/bk2204/git.git
https://git.crustytoothpaste.net/git/bmc/git.git

Changes from v3:
* Rebase on latest master.
* Drop the first patch.
* Re-run the script to expand get_object_hash.

brian m. carlson (12):
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
 builtin/blame.c          |  56 +++++++++++------------
 builtin/branch.c         |   2 +-
 builtin/checkout.c       |  22 ++++-----
 builtin/clone.c          |  18 ++++----
 builtin/commit-tree.c    |   4 +-
 builtin/commit.c         |   8 ++--
 builtin/describe.c       |  20 ++++----
 builtin/diff-tree.c      |  12 ++---
 builtin/diff.c           |  12 ++---
 builtin/fast-export.c    |  34 +++++++-------
 builtin/fetch-pack.c     |  14 +++---
 builtin/fetch.c          |  54 +++++++++++-----------
 builtin/fmt-merge-msg.c  |   6 +--
 builtin/fsck.c           |  36 +++++++--------
 builtin/grep.c           |   6 +--
 builtin/index-pack.c     |  10 ++--
 builtin/log.c            |  36 +++++++--------
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
 builtin/rev-list.c       |  18 ++++----
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
 http-push.c              |  86 +++++++++++++++++------------------
 http.c                   |   2 +-
 line-log.c               |   6 +--
 list-objects.c           |   4 +-
 log-tree.c               |  40 ++++++++--------
 merge-blobs.c            |   4 +-
 merge-recursive.c        |  26 +++++------
 merge.c                  |   2 +-
 notes-merge.c            |  24 +++++-----
 object.c                 |   8 ++--
 object.h                 |   2 +-
 pack-bitmap-write.c      |  16 +++----
 pack-bitmap.c            |  34 +++++++-------
 patch-ids.c              |   6 +--
 pretty.c                 |  18 ++++----
 ref-filter.c             |  14 +++---
 refs.c                   |   2 +-
 remote-curl.c            |  20 ++++----
 remote.c                 | 116 +++++++++++++++++++++++------------------------
 remote.h                 |   8 ++--
 revision.c               |  48 ++++++++++----------
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
 upload-pack.c            |  26 +++++------
 walker.c                 |  18 ++++----
 wt-status.c              |   2 +-
 88 files changed, 715 insertions(+), 703 deletions(-)

-- 
2.6.2.409.gb049f0a
