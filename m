Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03E720401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdFOOro (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:47:44 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56121 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752161AbdFOOrn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:47:43 -0400
X-AuditID: 12074414-d17ff7000000283f-60-59429e0de3ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B2.C0.10303.D0E92495; Thu, 15 Jun 2017 10:47:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbQs014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:39 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/28] Create a reference backend for packed refs
Date:   Thu, 15 Jun 2017 16:47:05 +0200
Message-Id: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqMs3zynS4EWfqMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBnf2w4zFXxTrtjyvIulgfGjbBcj
        B4eEgInEh42OXYxcHEICO5gkvi+cxQzhnGSSmHy+m6WLkZODTUBXYlFPMxOILSKgJjGx7RAL
        SBGzwCRmibfXFoIlhAUcJZ4/amUHsVkEVCX2fu4Es3kFzIEGfWMGsSUE5CV2tV1kncDItYCR
        YRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSBCJ7GA8clLuEKMAB6MSD++J
        WqdIIdbEsuLK3EOMkhxMSqK8/HJAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8U+cA5XhTEiur
        UovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHiN5wI1ChalpqdWpGXmlCCkmTg4
        QYbzAA3/Cza8uCAxtzgzHSJ/ilFRSpzXAyQhAJLIKM2D64VF+StGcaBXhHnngVTxABMEXPcr
        oMFMQIODLjiADC5JREhJNTCqZwmFTGua8GnPTqWVH4/H3mXlWLTD/33k99AHp1rVf30+w37R
        7mTOL40JLc6RHD1rIs3+/hU0Ob7xh1rxnrau8Lr29BnC71d7XP5xS7FO9djtyXWqta4bsmwm
        bXpndWyijHfgmaPRtRfubFu46n/Uj+TAq9EznWc9Pf4sqN50s7NkLMNTxYJ8JZbijERDLeai
        4kQAD9n+380CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series continues the saga of picking apart the code for
handling packed references from the code for handling loose
references, all in preparation for making big changes to how the
packed-ref reading and writing works as described in [1]. As a
reminder, the final goal is to read the "packed-refs" file using mmap,
parsing it on the fly instead of storing it into an in-memory
`ref_cache`, and to read and parse only the parts of the file that are
actually needed, giving a big speedup for many operations in
repositories that have lots of refs.

In this episode, we create a `packed_ref_store` class, implementing
part of the `ref_store` API, that represents the packed references
within a repository. The `files_ref_store` now contains an instance of
`packed_ref_store` and delegates to it for the operations that have to
touch the packed refs.

After this patch series, `packed_ref_store` supports:

* Iteration
* `peel_ref`
* `pack_refs` (they're already packed, so it's a NOOP)
* `read_raw_ref`

A future patch series will add support for:

* Reference transactions (`transaction_prepare`, `transaction_finish`,
  `transaction_abort`, `initial_transaction_commit`)
* `delete_refs`

Operations that `packed_ref_store` will probably never support:

* `create_symref`
* `rename_ref` (could be supported, but is probably not useful)
* Reflog-related operations

In addition, all of the packed-refs related code has been moved to a
new module, "refs/packed-backend.{c,h}". This includes some functions
that are still called by `files_ref_store` directly to update the
packed refs.

The patch series is long, but I think relatively straightforward. In
particular, patches 2-14 are quite mechanical. Its main point is to
separate concerns, but it does bring one end-user advantage: if there
is a problem parsing the "packed-refs" file, we now report an error
and die. The old code just ignored lines that it didn't understand.

I've developed these patches on top of master plus the following
patches, which are followups to mh/packed-refs-store-prep:

* lock_packed_refs(): fix cache validity check
* for_each_bisect_ref(): don't trim refnames

The patches can also be obtained from my GitHub fork [2] as branch
"packed-ref-store".

Michael

[1] http://public-inbox.org/git/cover.1490026594.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Michael Haggerty (28):
  add_packed_ref(): teach function to overwrite existing refs
  packed_ref_store: new struct
  packed_ref_store: move `packed_refs_path` here
  packed_ref_store: move `packed_refs_lock` member here
  clear_packed_ref_cache(): take a `packed_ref_store *` parameter
  validate_packed_ref_cache(): take a `packed_ref_store *` parameter
  get_packed_ref_cache(): take a `packed_ref_store *` parameter
  get_packed_refs(): take a `packed_ref_store *` parameter
  add_packed_ref(): take a `packed_ref_store *` parameter
  lock_packed_refs(): take a `packed_ref_store *` parameter
  commit_packed_refs(): take a `packed_ref_store *` parameter
  rollback_packed_refs(): take a `packed_ref_store *` parameter
  get_packed_ref(): take a `packed_ref_store *` parameter
  repack_without_refs(): take a `packed_ref_store *` parameter
  packed_peel_ref(): new function, extracted from `files_peel_ref()`
  packed_ref_store: support iteration
  packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
  packed-backend: new module for handling packed references
  packed_ref_store: make class into a subclass of `ref_store`
  commit_packed_refs(): report errors rather than dying
  commit_packed_refs(): use a staging file separate from the lockfile
  packed_refs_lock(): function renamed from lock_packed_refs()
  packed_refs_lock(): report errors via a `struct strbuf *err`
  packed_refs_unlock(), packed_refs_is_locked(): new functions
  clear_packed_ref_cache(): don't protest if the lock is held
  commit_packed_refs(): remove call to `packed_refs_unlock()`
  repack_without_refs(): don't lock or unlock the packed refs
  read_packed_refs(): die if `packed-refs` contains bogus data

 Makefile              |   1 +
 refs.c                |  18 ++
 refs/files-backend.c  | 619 ++++-------------------------------
 refs/packed-backend.c | 868 ++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.h |  25 ++
 refs/refs-internal.h  |  10 +
 6 files changed, 981 insertions(+), 560 deletions(-)
 create mode 100644 refs/packed-backend.c
 create mode 100644 refs/packed-backend.h

-- 
2.11.0

