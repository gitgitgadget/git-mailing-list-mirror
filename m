From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 00/16] Convert parts of refs.c to struct object_id
Date: Fri, 20 Mar 2015 19:28:20 +0000
Message-ID: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bE-0001TX-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbbCTT2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:28:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50633 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033AbbCTT2q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:46 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 354322808F;
	Fri, 20 Mar 2015 19:28:44 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265939>

This is part 1 of n in converting code to use struct object_id.

refs.c, and the for_each_ref series of functions particularly, is the
source for many instances of object IDs in the codebase.  Therefore, it
makes sense to convert this series of functions to provide a basis for
further conversions.

This series is essentially just for_each_ref and friends, the callbacks,
and callers.  Other parts of refs.c will be converted in a later series,
so as to keep the number of patches to a reasonable size.

There should be no functional change from this patch series.

This series is based on top of the bc/object-id series in pu.  The
series will be rebased on next once bc/object-id makes it into next.

Available from the following repositories in either object-id-part1 or
object-id-part1-pu (will be rebased):

  https://github.com/bk2204/git.git
  https://git.crustytoothpaste.net/git/bmc/git.git

brian m. carlson (16):
  refs: convert struct ref_entry to use struct object_id
  refs: convert for_each_tag_ref to struct object_id
  refs: convert remaining users of for_each_ref_in to object_id
  refs: convert for_each_ref_in_submodule to object_id
  refs: convert head_ref to struct object_id
  refs: convert for_each_ref_submodule to struct object_id
  revision: remove unused _oid helper.
  refs: convert for_each_ref to struct object_id
  refs: convert for_each_replace_ref to struct object_id
  refs: convert namespaced ref iteration functions to object_id
  refs: convert for_each_rawref to struct object_id.
  refs: rename do_for_each_ref_oid to do_for_each_ref
  refs: convert for_each_reflog to struct object_id
  refs: rename each_ref_fn_oid to each_ref_fn
  Remove unneeded *_oid functions.
  refs: convert struct ref_lock to struct object_id

 Documentation/technical/api-ref-iteration.txt |   2 +-
 bisect.c                                      |   8 +-
 builtin/branch.c                              |   4 +-
 builtin/checkout.c                            |   4 +-
 builtin/describe.c                            |  12 +--
 builtin/fetch.c                               |   6 +-
 builtin/for-each-ref.c                        |   4 +-
 builtin/fsck.c                                |  18 ++---
 builtin/name-rev.c                            |   6 +-
 builtin/pack-objects.c                        |  14 ++--
 builtin/receive-pack.c                        |   4 +-
 builtin/reflog.c                              |   8 +-
 builtin/remote.c                              |  14 ++--
 builtin/replace.c                             |  14 ++--
 builtin/rev-parse.c                           |   8 +-
 builtin/show-branch.c                         |  24 +++---
 builtin/show-ref.c                            |  16 ++--
 builtin/tag.c                                 |   8 +-
 fetch-pack.c                                  |  18 ++++-
 help.c                                        |   2 +-
 http-backend.c                                |  14 ++--
 log-tree.c                                    |  10 +--
 notes.c                                       |   2 +-
 reachable.c                                   |   4 +-
 refs.c                                        | 104 +++++++++++++-------------
 refs.h                                        |   6 +-
 remote.c                                      |   8 +-
 replace_object.c                              |   4 +-
 revision.c                                    |  18 +++--
 server-info.c                                 |   6 +-
 sha1_name.c                                   |   4 +-
 shallow.c                                     |   8 +-
 submodule.c                                   |   6 +-
 transport.c                                   |  10 +--
 upload-pack.c                                 |  28 +++----
 walker.c                                      |   4 +-
 36 files changed, 224 insertions(+), 206 deletions(-)

-- 
2.2.1.209.g41e5f3a
