Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C97C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1756138E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhHWLxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhHWLxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:53:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91299C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so25870988wrn.3
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Use2JGkvk4kFUYGomJpJTzQpUhppHR9ErwMc67NdoP4=;
        b=Xtvb73rQvEs/Hy/SvR4F10JTvRp4q3BgXLvqNBqeYHNuawpk3JUYH9SPgYFwXla/9+
         CD+TJuKRa0bBNhBv5xqBkPVsGjURd4gWBoUcjpsZl1+z6ZKwbp04kdwfXWJbOR7xHydj
         3aKnisN8wT28gjvnsqAgLD4SZH4DKfUjRw5JKqwnkpUh8wQkwnQUh6Ig1psiv2K22y0L
         5Ilwjl4HlCqKNgD8I9MbP/sa9KA2VFCe6Q4Wju44xjPWSQ8NJqJlIz0SNCUfug1OmW4E
         5UYYBAZdNUHAPAiNQY6gJE64Lyg5n9QQAADQH2Foe0y9Tt+/8mbzvCERysMEX6v1JnDW
         Ovdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Use2JGkvk4kFUYGomJpJTzQpUhppHR9ErwMc67NdoP4=;
        b=lLMaxv2/Y1d+WiQJYZ0UX7+YHmqypODaik48ZpODeYSSFUnv1hKfrTdulkUEURo/Na
         TYe0rPYzfVVox42fvEldN1DtbWwNllEyzH4f022W0moRptnPunbdWrS/AOMpWqAKAzYw
         r3OhjCVRxQl3EAbNdzRPBISSXs+2etShhpfw3WFMZs6GGeKXs3HUIaRM0J/DI7vlcile
         kKH1nqVLX3iecaX1B4xrHgskHoJ498udPxEsctLhxDRvGI6/dhzsa4WyROHgDxeC0EY2
         x+OjcmjNQV1VEiRxLRBRbEe0cxtfeIUJsSzb9IeG+pFq0FjGB7oiJgjfU77jqqSxiXHs
         qFiA==
X-Gm-Message-State: AOAM531QDIGXyoSsuwnWVWKEx3N+iceIMIvPCNzK3cHf9+BGUl9Uj+5k
        Mdp0O4d7tCp1/IMyH3tPq8k/Y7CJ7BTSCjNe
X-Google-Smtp-Source: ABdhPJzDgsNqaF+/thd4dt9jlCcZhIZnwosNqMCr34hEpLqy+38DZfk1m+vF6Rdgdh6e7A3ZzkDEfA==
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr12874579wro.107.1629719574005;
        Mon, 23 Aug 2021 04:52:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm12350713wmi.1.2021.08.23.04.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:52:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 2/8] refs: remove EINVAL errno output from specification of read_raw_ref_fn
Date:   Mon, 23 Aug 2021 13:52:38 +0200
Message-Id: <patch-v10-2.8-ba0f5f5fb0a-20210823T114712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com> <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This commit does not change code; it documents the fact that an alternate ref
backend does not need to return EINVAL from read_raw_ref_fn to function
properly.

This is correct, because refs_read_raw_ref is only called from;

* resolve_ref_unsafe(), which does not care for the EINVAL errno result.

* refs_verify_refname_available(), which does not inspect errno.

* files-backend.c, where errno is overwritten on failure.

* packed-backend.c (is_packed_transaction_needed), which calls it for the
  packed ref backend, which never emits EINVAL.

A grep for EINVAL */*c reveals that no code checks errno against EINVAL after
reading references. In addition, the refs.h file does not mention errno at all.

A grep over resolve_ref_unsafe() turned up the following callers that inspect
errno:

* sequencer.c::print_commit_summary, which uses it for die_errno

* lock_ref_oid_basic(), which only treats EISDIR and ENOTDIR specially.

The files ref backend does use EINVAL. The files backend does not call into
the generic API (refs_read_raw), but into the files-specific function
(files_read_raw_ref), which we are not changing in this commit.

As the errno sideband is unintuitive and error-prone, remove EINVAL
value, as a step towards getting rid of the errno sideband altogether.

Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/refs-internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d496c5ed52d..1c6e5ab51d7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -622,9 +622,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  *
  * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
  * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
- * EINVAL, and return -1. If there is another error reading the ref,
- * set errno appropriately and return -1.
+ * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
+ * (errno should not be ENOENT) If there is another error reading the
+ * ref, set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
-- 
2.33.0.662.g438caf9576d

