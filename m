Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FAA20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdGASbT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:19 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:61217 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751911AbdGASbT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:19 -0400
X-AuditID: 1207440d-e7dff70000000a46-4f-5957ea722a0d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.E6.02630.27AE7595; Sat,  1 Jul 2017 14:31:17 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBD010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:13 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/30] Create a reference backend for packed refs
Date:   Sat,  1 Jul 2017 20:30:38 +0200
Message-Id: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqFv6KjzSoPGakcXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBnrJzezFbyXqFgy/wxrA+MpkS5G
        Tg4JAROJ3jXPGLsYuTiEBHYwSfxvnwDlnGSS+Pb5BgtIFZuArsSinmYmEFtEQE1iYtshFpAi
        ZoFJzBJvry0ESwgLuEg83TMVzGYRUJX41H0bzOYVMJfo3bKDHWKdvMSutousExi5FjAyrGKU
        S8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICSPeHYz/18kcYhTgYFTi4d0QEhYp
        xJpYVlyZe4hRkoNJSZR35bXQSCG+pPyUyozE4oz4otKc1OJDjBIczEoivLnPwyOFeFMSK6tS
        i/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvJNeAjUKFqWmp1akZeaUIKSZODhB
        hvMADV94F2R4cUFibnFmOkT+FKMux6sJ/78xCbHk5eelSonztoIMEgApyijNg5sDi/9XjOJA
        bwnzRrwAquIBpg64Sa+AljABLRGeEQKypCQRISXVwJjO8XK/2Zc5F3ZONTNx2/ry8aZ1m4MW
        86/f90HHsunPbw/PCvGNLrzn/v7mPfOnXZRzTX2F6ZPHC0vfLpHew96whKv3jPGTydZ+cbdd
        VzxWrDB3T3gofcaG3eLelOVaG154GZl/v/xTXobZedOh527Gx05P63R0r1HL+Hj2UvijI5Hn
        ZsUEmyQosRRnJBpqMRcVJwIA9cil79oCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3 of a patch series creating a `packed_ref_store` reference
backend. Thanks to Peff and Junio for their comments about v2 [1].

Changes since v2:

* Delete some debugging `cat` commands in t1408.

* Add some tests of reading packed-refs files with bogus contents.

* When reporting corruption in packed-refs files, distinguish between
  unterminated lines and other corruption.

* Fixed a typo in a commit message.

This patch series can also be obtained from my GitHub fork [2] as
branch packed-ref-store.

Michael

[1] v1: http://public-inbox.org/git/cover.1497534157.git.mhagger@alum.mit.edu/
    v2: http://public-inbox.org/git/cover.1498200513.git.mhagger@alum.mit.edu/
[2] https://github.com/mhagger/git

Junio C Hamano (1):
  t1408: add a test of stale packed refs covered by loose refs

Michael Haggerty (29):
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
  t3210: add some tests of bogus packed-refs file contents
  read_packed_refs(): die if `packed-refs` contains bogus data

 Makefile               |   1 +
 refs.c                 |  18 +
 refs/files-backend.c   | 631 ++++-------------------------------
 refs/packed-backend.c  | 872 +++++++++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.h  |  25 ++
 refs/refs-internal.h   |  10 +
 t/t1408-packed-refs.sh |  42 +++
 t/t3210-pack-refs.sh   |  27 ++
 8 files changed, 1066 insertions(+), 560 deletions(-)
 create mode 100644 refs/packed-backend.c
 create mode 100644 refs/packed-backend.h
 create mode 100755 t/t1408-packed-refs.sh

-- 
2.11.0

