Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D40A1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758959AbdAFQW4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:22:56 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47444 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758950AbdAFQWy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:22:54 -0500
X-AuditID: 1207440d-8cfff700000009ba-bb-586fc45c1427
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.6A.02490.C54CF685; Fri,  6 Jan 2017 11:22:53 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWo023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:22:50 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 00/23] Delete directories left empty after ref deletion
Date:   Fri,  6 Jan 2017 17:22:20 +0100
Message-Id: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqBt7JD/C4Hq3ikXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlzNt+k7HgiEjFlxu3mBoYewW7GDk5JARMJBrWHWDq
        YuTiEBK4zCix9tBGdgjnBJPE5X+d7CBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBT4wSvzqnAVW
        JCzgJfH5/Qw2EJtFQFXi0bOTLCA2r4C5xOZD15gh1slJXNr2hXkCI9cCRoZVjHKJOaW5urmJ
        mTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCEhw7uD8f86mUOMAhyMSjy8EV55EUKsiWXFlbmH
        GCU5mJREecMc8yOE+JLyUyozEosz4otKc1KLDzFKcDArifDaHQLK8aYkVlalFuXDpKQ5WJTE
        edWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeP+ANAoWpaanVqRl5pQgpJk4OEGG8wANFzwMMry4
        IDG3ODMdIn+KUVFKnHcLSLMASCKjNA+uFxbTrxjFgV4R5u0BaecBpgO47ldAg5lABnuCDS5J
        REhJNTCabLGUr3JLNq4/7Xrh/Hrhda++X3HTTbyxjpkxVP+UfaxVbfvKr3xuc55HKXtHqf27
        eWoLS96PxUGORczbq8QyGz30JPNVrV8dm9FxeOvOGyfMLd2z8niVX5fqH6t6ltk25aUi66zo
        BT73LBrdJx3uauI8/9BjWXJDI9Pa9oOrlmfVBZQtblFiKc5INNRiLipOBAAZzNf0xAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v4 of this patch series. Thanks to Peff, Junio, Jake, and
Philip for their feedback about v3. I believe I have addressed all of
the comments about v1 [1], v2 [2], and v3 [3].

Changes since v3:

* Insert a new first patch correcting the docstring of
  `refname_is_safe()`.

* In "raceproof_create_file(): new function", tweak a comment for
  clarity as suggested by Peff.

* In "log_ref_setup(): separate code for create vs non-create", add a
  semicolon to an otherwise empty code block as requested by Junio.

* Drop the patch "try_remove_empty_parents(): don't accommodate
  consecutive slashes", for reasons discussed on the ML [4].

Michael

[1] http://public-inbox.org/git/cover.1455626201.git.mhagger@alum.mit.edu/T/#u
[2] http://public-inbox.org/git/cover.1456405698.git.mhagger@alum.mit.edu/T/#u
[3] http://public-inbox.org/git/cover.1483153436.git.mhagger@alum.mit.edu/T/#u
[4] http://public-inbox.org/git/5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu/
and surrounding thread.

Michael Haggerty (23):
  files_rename_ref(): tidy up whitespace
  refname_is_safe(): correct docstring
  t5505: use "for-each-ref" to test for the non-existence of references
  safe_create_leading_directories_const(): preserve errno
  safe_create_leading_directories(): set errno on SCLD_EXISTS
  raceproof_create_file(): new function
  lock_ref_sha1_basic(): inline constant
  lock_ref_sha1_basic(): use raceproof_create_file()
  rename_tmp_log(): use raceproof_create_file()
  rename_tmp_log(): improve error reporting
  log_ref_write(): inline function
  log_ref_setup(): separate code for create vs non-create
  log_ref_setup(): improve robustness against races
  log_ref_setup(): pass the open file descriptor back to the caller
  log_ref_write_1(): don't depend on logfile argument
  log_ref_setup(): manage the name of the reflog file internally
  log_ref_write_1(): inline function
  delete_ref_loose(): derive loose reference path from lock
  delete_ref_loose(): inline function
  try_remove_empty_parents(): rename parameter "name" -> "refname"
  try_remove_empty_parents(): don't trash argument contents
  try_remove_empty_parents(): teach to remove parents of reflogs, too
  files_transaction_commit(): clean up empty directories

 cache.h               |  48 ++++++-
 refs/files-backend.c  | 371 +++++++++++++++++++++++++-------------------------
 refs/refs-internal.h  |  22 ++-
 sha1_file.c           |  76 ++++++++++-
 t/t1400-update-ref.sh |  27 ++++
 t/t5505-remote.sh     |   2 +-
 6 files changed, 351 insertions(+), 195 deletions(-)

-- 
2.9.3

