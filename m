From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 00/16] Convert parts of refs.c to struct object_id
Date: Wed, 22 Apr 2015 23:24:05 +0000
Message-ID: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:24:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl40O-0003Uf-VH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568AbbDVXY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44728 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757319AbbDVXY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BA8502808D;
	Wed, 22 Apr 2015 23:24:25 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267652>

This is a conversion of parts of refs.c to use struct object_id.

refs.c, and the for_each_ref series of functions explicitly, is the
source for many instances of object IDs in the codebase.  Therefore, it
makes sense to convert this series of functions to provide a basis for
further conversions.

This series is essentially just for_each_ref and friends, the callbacks,
and callers.  Other parts of refs.c will be converted in a later series,
so as to keep the number of patches to a reasonable size.

There should be no functional change from this patch series.

Changes from v1:
* Rebase onto next to pick up the first set of object_id patches.
* Fix a series of nasty conflicts that occurred due to other topics in
  flight to promote easier testing and integration.

Comments and reviews on this series would be greatly appreciated.

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
 builtin/reflog.c                              |  10 +--
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
 refs.h                                        |   4 +-
 remote.c                                      |   8 +-
 replace_object.c                              |   4 +-
 revision.c                                    |  18 +++--
 server-info.c                                 |   6 +-
 sha1_name.c                                   |   4 +-
 shallow.c                                     |   8 +-
 submodule.c                                   |   6 +-
 transport.c                                   |  10 +--
 upload-pack.c                                 |  30 ++++----
 walker.c                                      |   4 +-
 36 files changed, 225 insertions(+), 207 deletions(-)

-- 
2.3.5
