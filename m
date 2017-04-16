Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A9820A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbdDPGmZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:25 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54521 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdDPGmX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:23 -0400
X-AuditID: 12074411-4d7ff700000005a9-7c-58f3124c574b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 25.0D.01449.C4213F85; Sun, 16 Apr 2017 02:42:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN1025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/20] Separate `ref_cache` into a separate module
Date:   Sun, 16 Apr 2017 08:41:22 +0200
Message-Id: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqOsn9DnC4Gm3vMXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugStjUnMPU8E/oYpFx1vZGhhP8ncxcnJICJhI
        nL+wgRHEFhLYwSRxZYpRFyMXkH2CSWL1ih8sIAk2AV2JRT3NTCC2iICaxMS2QywgRcwCj5kk
        /i7rBisSFnCVaDm2nhXEZhFQlZi3/SsziM0rYC7xaOlBRoht8hK72i6yTmDkWsDIsIpRLjGn
        NFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJHQEdzDOOCl3iFGAg1GJh9fC/1OEEGti
        WXFl7iFGSQ4mJVFemf9AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8ySyfI4R4UxIrq1KL8mFS
        0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8HwSAGgWLUtNTK9Iyc0oQ0kwcnCDDeYCG
        bwWp4S0uSMwtzkyHyJ9i1OU4tPn3eyYhlrz8vFQpcd4fIEUCIEUZpXlwc2Ax/4pRHOgtYd5a
        QaAqHmC6gJv0CmgJE9AShskfQJaUJCKkpBoYhYRm+50L3/h307IJ2YZ2ClqdljcFcr6FMR98
        vSeku+irajCrjtZJX72OBT2PtNM8PVNLuCY8zbDdW9vbf2RSUJKb7FHrSVU5Uv2R/NryxSpn
        pC/83XHSOnLvszcb9yQvMat9v97jgs19s4V/14vW/0/ib3khm33juoFDzjbraXkTHq5k0ohQ
        YinOSDTUYi4qTgQA7KS/1dQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3 of a patch series to separate the reference caching code
into a separate module that interacts with `files_ref_cache` more at
arm's length. Thanks to Stefan and Duy for their feedback about v2 [1].

This version has only minor changes since v2 (and indeed since v1 [2]):

* Rebased onto the current nd/files-backend-git-dir (there were no
  conflicts).

* Removed redundant assignment in

    refs_verify_refname_available(): implement once for all backends

* Improved two commit messages.

This patch series is also available from my GitHub fork [3] as branch
"separate-ref-cache". These patches depend on Duy's
nd/files-backend-git-dir branch.

[1] http://public-inbox.org/git/cover.1490966385.git.mhagger@alum.mit.edu/
[2] http://public-inbox.org/git/cover.1490026594.git.mhagger@alum.mit.edu/
[3] https://github.com/mhagger/git

Michael Haggerty (20):
  get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
  refs_read_raw_ref(): new function
  refs_ref_iterator_begin(): new function
  refs_verify_refname_available(): implement once for all backends
  refs_verify_refname_available(): use function in more places
  ref-cache: rename `add_ref()` to `add_ref_entry()`
  ref-cache: rename `find_ref()` to `find_ref_entry()`
  ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
  refs: split `ref_cache` code into separate files
  ref-cache: introduce a new type, ref_cache
  refs: record the ref_store in ref_cache, not ref_dir
  ref-cache: use a callback function to fill the cache
  refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
  do_for_each_entry_in_dir(): eliminate `offset` argument
  get_loose_ref_dir(): function renamed from get_loose_refs()
  get_loose_ref_cache(): new function
  cache_ref_iterator_begin(): make function smarter
  commit_packed_refs(): use reference iteration
  files_pack_refs(): use reference iteration
  do_for_each_entry_in_dir(): delete function

 Makefile             |    1 +
 refs.c               |  111 ++++-
 refs.h               |    2 +-
 refs/files-backend.c | 1229 +++++++-------------------------------------------
 refs/ref-cache.c     |  523 +++++++++++++++++++++
 refs/ref-cache.h     |  267 +++++++++++
 refs/refs-internal.h |   22 +-
 7 files changed, 1066 insertions(+), 1089 deletions(-)
 create mode 100644 refs/ref-cache.c
 create mode 100644 refs/ref-cache.h

-- 
2.11.0

