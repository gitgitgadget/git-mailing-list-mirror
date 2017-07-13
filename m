Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140912027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbdGMXtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:36 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59650 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752776AbdGMXte (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BEFBE280AD;
        Thu, 13 Jul 2017 23:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989773;
        bh=C81DHabeiqXBz4VEjP0CUzExGao7wrLRDILRmoIu+OI=;
        h=From:To:Cc:Subject:Date:From;
        b=fugOrQCZI14w7Eritkvy1Ihf8pp8dtnQRwsj2LxYhxpWbCz7JEzq/phfqBJl8S+pI
         gqZPOqBcbbvtTBdT+/Nv0BhTEstzfJ2z1Dhr/Gdvf94qrCZm2wLyq0lbx0gW3PVlSn
         4hPI1jt7bR1H19cqqgCXql48b21iDkXky1gl8UmS366ReAfFfhaBz91So7ZxGnc/FP
         xw8jb3LgAPrdYGmOpXAWZHskVlinsVlpF88jRFyOK2a4lBlys3Zt2OlCfQByVaXupt
         zPb++kAPRrVFFp5BiMEIOgXa4e3bPRrFDGaUgAYyKM2gYtpIwhDSJh38grgB+y1W67
         q2YUScGiPe2EL+bxEf6PKdUfd62DHeK4lAjYO+CSuZyISsbOy7j9mJNxTblbgkqCQH
         W7I7YmEFM7z2TIjaj4670Lb4QFc6b5lerHnVCy1Xfes6JwoztBD4IS/PtzGDtTI5n+
         RS6YTuTHoK0P7PnR71VDVtaw946hGcHh6i2kTkziwQmMRptsRgT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 00/13] object_id part 9
Date:   Thu, 13 Jul 2017 23:49:17 +0000
Message-Id: <20170713234930.949612-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the ninth in a series of series to convert Git to use struct
object_id.  This series converts the remaining callers of get_sha1 and
friends to take and use struct object_id, and in doing so, renames them
to get_oid and friends.

This patch should probably be based Stefan Beller's series, in which case
patch 9 can be dropped.

Changes from v1:
* Restore the check for length in get_sha1_basic.
* Add a patch converting some uses of 40 to GIT_SHA1_HEXSZ as suggested.  This
  is a separate patch because I wanted to minimize the non-automated portions of
  the patch in question.

brian m. carlson (13):
  builtin/fsck: convert remaining caller of get_sha1 to object_id
  builtin/merge-tree: convert remaining caller of get_sha1 to object_id
  submodule: convert submodule config lookup to use object_id
  remote: convert struct push_cas to struct object_id
  sequencer: convert to struct object_id
  builtin/update_ref: convert to struct object_id
  bisect: convert bisect_checkout to struct object_id
  builtin/unpack-file: convert to struct object_id
  builtin/verify-tag: convert to struct object_id
  Convert remaining callers of get_sha1 to get_oid.
  sha1_name: convert get_sha1* to get_oid*
  sha1_name: convert GET_SHA1* flags to GET_OID*
  sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ

 apply.c                          |   4 +-
 archive.c                        |   2 +-
 bisect.c                         |  18 +--
 builtin/am.c                     |   6 +-
 builtin/cat-file.c               |   8 +-
 builtin/commit-tree.c            |   4 +-
 builtin/commit.c                 |   8 +-
 builtin/fsck.c                   |   8 +-
 builtin/grep.c                   |   8 +-
 builtin/log.c                    |   4 +-
 builtin/merge-tree.c             |   6 +-
 builtin/receive-pack.c           |   4 +-
 builtin/replace.c                |   4 +-
 builtin/reset.c                  |  10 +-
 builtin/rev-parse.c              |   8 +-
 builtin/show-branch.c            |   8 +-
 builtin/submodule--helper.c      |   8 +-
 builtin/unpack-file.c            |  12 +-
 builtin/update-ref.c             |  69 ++++++-----
 builtin/verify-tag.c             |   8 +-
 cache.h                          |  45 ++++----
 commit.c                         |   4 +-
 config.c                         |  12 +-
 config.h                         |   4 +-
 mailmap.c                        |   6 +-
 notes.c                          |   2 +-
 refs.c                           |   2 +-
 remote.c                         |   8 +-
 remote.h                         |   2 +-
 repository.c                     |   2 +-
 revision.c                       |  16 +--
 sequencer.c                      |  65 +++++------
 sha1_name.c                      | 240 +++++++++++++++++++--------------------
 submodule-config.c               |  38 +++----
 submodule-config.h               |  12 +-
 submodule.c                      |  32 +++---
 submodule.h                      |   2 +-
 t/helper/test-submodule-config.c |  10 +-
 transport-helper.c               |   2 +-
 39 files changed, 351 insertions(+), 360 deletions(-)

