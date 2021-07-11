Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D4C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710AE61176
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhGKQdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKQdf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D76C0613E5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p8so21150346wrr.1
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+7GT2xFKsv7AOrhfKfiWL8WObGs1ENfr3pJ8yskksI=;
        b=uoyxnR7A/n9KXFxwO9sm+x69N4dqI6i0rGr8LqjMfRMLcqKUVdI13T2FL+prwOX2PS
         05VO/vEms1hkuMoopGbRbGrMYa9pSCsNE46ExzIj+EWWpLNccD7LsE3L/UR1EDJR8f7T
         EHoKEf8HSVWQIIy/72B2RKE/W7ePp9u3diDUbpDsJZWgFSj4qX1rf1KQlI+b/mQ0+EHn
         qec6rfSoNGgjcIkeOUHbPtnFiOs87opfeSQkV9ZSMY3ilsv6HJyPgzkatkofPt6mbrdH
         /runQO9PZXRTnbTYP5XEvVGesddlvVNPVwmzdSkdf6bCnK8G5gcPcFwo2zhjlM1ioJEl
         luvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+7GT2xFKsv7AOrhfKfiWL8WObGs1ENfr3pJ8yskksI=;
        b=qlGy8U8+2fEAkPazjX7lSeG8KiNi+fQlQQqN4ICS3wYsNK/9Ki2PB8YK0tWHNEARRb
         Nd03r3aeLJK9JLF8Ru1HeDOCmhCpnVHiuSAZEtJv46pXJ9YDn60hshje6JA2NYXqlXv1
         WrGa29/QyBBN+2CS54H+Vmvd4b85sdRT/TVAvQa+Cky5VZUOecMdiVjwpuXUYUvM5WeC
         SRQzLmdAFTKBbzqnN/BbENn9HHbBXtJB3dvGkKrMkR6pTZdTPvsgKLBGKsYimbbNoZjz
         LxE64bFczV/aY7o6TpZWlpGNlea5R5eHy3AQH5LzKB/PiSh8zo4qZLvDAytQaXELG3CE
         AhEA==
X-Gm-Message-State: AOAM533oCOlCftAK+4OWPmTFbGLXeRSraJ8m/X1MAzIY5RiBWLNFxSIf
        YHB/L5KLx2JtryxmAqNrUinVEdfze5kHLA==
X-Google-Smtp-Source: ABdhPJwvj0MNiWbptBg7tUALZPXidGKev79/de68VbyIdqBRB+XBchiEOvJdw+F87AW+k8fL3Z2gKg==
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr4732174wrp.351.1626021046663;
        Sun, 11 Jul 2021 09:30:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 01/17] refs: remove EINVAL errno output from specification of read_raw_ref_fn
Date:   Sun, 11 Jul 2021 18:30:25 +0200
Message-Id: <patch-01.17-57517368c34-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
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
index 467f4b3c936..f4445e32904 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -619,9 +619,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
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
2.32.0-dev

