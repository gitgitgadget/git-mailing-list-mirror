Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5147020193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbcIDQKd (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61504 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753574AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074413-aa3ff70000000955-6c-57cc4715a98b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 94.21.02389.5174CC75; Sun,  4 Sep 2016 12:08:56 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5M026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:08:50 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/38] Virtualization of the refs API
Date:   Sun,  4 Sep 2016 18:08:06 +0200
Message-Id: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqCvhfibc4OteRYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGTP/LmUv+CFT8e1GM1MD41XxLkZO
        DgkBE4kPE/YydTFycQgJbGWUuD7zDBuEc5JJ4vPhN4wgVWwCuhKLepqZQGwRATWJiW2HWECK
        mEGKZk2cyQ6SEBawkFjT/oINxGYRUJW4/uI7M4jNK2AusWZFLyPEOjmJS9u+ME9g5FrAyLCK
        US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIySIhHcw7jopd4hRgINRiYd3gu6Z
        cCHWxLLiytxDjJIcTEqivLMOngwX4kvKT6nMSCzOiC8qzUktPsQowcGsJMKr7QJUzpuSWFmV
        WpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4L3uCtQoWJSanlqRlplTgpBm4uAE
        Gc4DNPwmSA1vcUFibnFmOkT+FKOilDjvS5CEAEgiozQPrhcW5a8YxYFeEeZNcAOq4gEmCLju
        V0CDmYAGr9t9GmRwSSJCSqqBMW2eZG4l53mmxozTwdN7dS2cTkyT6NrTXSweXWT84Lnst/BQ
        y+LGEzkv724683LPqvQTPWlsu2ve8Lp32DdF7pZ7r3eVJ6qew13ez/Dh+i+2deKHr6y9EvDq
        i9eGKT+vh4nJ7hX3Mbvvq1K4zrjhe4mwmdK9R/3rUk7ytyw+f+XHjIhpfyInK7EUZyQaajEX
        FScCAK6V6DfNAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of the patch series to virtualize the references API
(though earlier patch series similar in spirit were submitted by
Ronnie Sahlberg and David Turner). Thanks to Junio, Eric, and Ramsay
for their comments about v1 [1].

Nobody pointed out any fundamental problems with v1, but this version
includes the following improvements:

* In "rename_ref_available(): add docstring":

  * Improve docstring as suggested by Junio.

* In "refs: create a base class "ref_store" for files_ref_store":

  * Let main_ref_store and submodule_ref_stores be initialized
    implicitly rather than initializing them explicitly to NULL.

  * Add docstrings for those two variables.

  * Eliminate a temporary variable in `files_downcast()`.

* In "resolve_gitlink_ref(): avoid memory allocation in many cases":

  * Instead of keeping track of `orig_len`, after stripping off any
    trailing slashes check whether `path[len - 1]` is NUL.

* In "refs: add methods for reflog":

  * Don't export `files_reflog_iterator_begin()` (suggested by
    Ramsay).

In addition, given that v1 was pretty old, I have rebased the patch
series against the current upstream master. (The rebase was
unproblematic.)

This patch series is also available from my GitHub fork [2] as branch
"ref-store".

Michael

[1] http://public-inbox.org/git/cover.1464983301.git.mhagger@alum.mit.edu/t/
[2] https://github.com/mhagger/git

David Turner (8):
  rename_ref_available(): add docstring
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: make delete_refs() virtual
  refs: add methods to init refs db
  refs: add method to rename refs
  refs: make lock generic
  refs: implement iteration over only per-worktree refs

Michael Haggerty (28):
  resolve_gitlink_ref(): eliminate temporary variable
  refs: rename struct ref_cache to files_ref_store
  refs: create a base class "ref_store" for files_ref_store
  add_packed_ref(): add a files_ref_store argument
  get_packed_ref(): add a files_ref_store argument
  resolve_missing_loose_ref(): add a files_ref_store argument
  {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
  refs: reorder definitions
  resolve_packed_ref(): rename function from resolve_missing_loose_ref()
  resolve_gitlink_packed_ref(): remove function
  read_raw_ref(): take a (struct ref_store *) argument
  resolve_ref_recursively(): new function
  resolve_gitlink_ref(): implement using resolve_ref_recursively()
  resolve_gitlink_ref(): avoid memory allocation in many cases
  resolve_gitlink_ref(): rename path parameter to submodule
  refs: make read_raw_ref() virtual
  refs: make verify_refname_available() virtual
  refs: make pack_refs() virtual
  refs: make create_symref() virtual
  refs: make peel_ref() virtual
  repack_without_refs(): add a files_ref_store argument
  lock_raw_ref(): add a files_ref_store argument
  commit_ref_update(): add a files_ref_store argument
  lock_ref_for_update(): add a files_ref_store argument
  lock_ref_sha1_basic(): add a files_ref_store argument
  split_symref_update(): add a files_ref_store argument
  files_ref_iterator_begin(): take a ref_store argument
  refs: add method iterator_begin

Ronnie Sahlberg (2):
  refs: add a backend method structure
  refs: add a transaction_commit() method

 builtin/init-db.c    |  21 +-
 refs.c               | 309 +++++++++++++++++++++++++++-
 refs.h               |  13 +-
 refs/files-backend.c | 566 +++++++++++++++++++++++++++------------------------
 refs/refs-internal.h | 220 +++++++++++++++++---
 5 files changed, 812 insertions(+), 317 deletions(-)

-- 
2.9.3

