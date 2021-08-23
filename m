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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949DC4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FD66124B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhHWLhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbhHWLhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269B5C0617AF
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso13845996wmj.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80KTX3V2r9szeWBOA+8iBUpO+6nDYEI6IfW++wZejF8=;
        b=euhuCkzOZJsyau45aQrv+o0jNm4W354zkOHJ79/8Vp0Nvr0KzgDSdBHC63Hpbo+/Rd
         ng+DBTmTu372TQ+ibhDDoUUawc+6y3uyKSxmwhLDmUck/eTeizAJIuukMHPOZO1ObBQU
         fUfiUA2YZVqIdguBG02oLwZPZUr3t7sbKkTBPv/mc4sdvqkNOPvzbBUBfJ1K0hTal5A2
         yKjzx1u9JHWM0eEYfT/PEO4ILWnz7n5GWQvf6ac5aAh/kq4i5HyureHlU+FqLbOeGNQV
         w18nSUgOGsuL4k9F8xaHI1i74jIep8K59+UKEDDBv06bkr9ftq1YJZcKNRStYMjPRemA
         Qjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80KTX3V2r9szeWBOA+8iBUpO+6nDYEI6IfW++wZejF8=;
        b=JV5P/cYuXPsjnusoImTaVRD6mhTdgI83bJwu5HGLH9/cOE3xqf91CriY8YcOTsm7zE
         +/x74hkLngBSsV+JScA2Cz0JaYcpxRP0s3RGcw5J7WBBJ7RzRoai1RWotvOTFeLH60kY
         bfQAzDxHmE8CxWcn0bO0JfqNqzGNnNlNAioWUd8tBuTRnR1EPBTHeC4jb3pDTmaPBoGz
         BOzP6iIlzQBnYs05OrUxpWW9U7jC7XwsdqN3C8aqonxJV/wdJfCMXwXNjnTpntGZMwEL
         9S9f1BNAEooeZL06cnON7H1PSQH1HAOInhJAqzIhFII3uS0g9HN9G8pP2HLyI7Q38Ife
         sfdA==
X-Gm-Message-State: AOAM532Z9APlEsJ33vXuaZehww5w0NqRmF+8OR8qHLn6NrZpbCfIQSt3
        IPaXesbIv6cAtK7T0nag+/6GxNTQy00sZqMJ
X-Google-Smtp-Source: ABdhPJwa7h7HXgGD/V5IuvZsZeWfrNyKvqhQjBdJs3T8IRHjjlMmhJJMp6mWLU+TVepGRyMFyvErcA==
X-Received: by 2002:a1c:4686:: with SMTP id t128mr8119437wma.183.1629718583526;
        Mon, 23 Aug 2021 04:36:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/13] refs/files: add a comment about refs_reflog_exists() call
Date:   Mon, 23 Aug 2021 13:36:09 +0200
Message-Id: <patch-v5-08.13-51abe459e70-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about why it is that we need to check for the the
existence of a reflog we're deleting after we've successfully acquired
the lock in files_reflog_expire(). As noted in [1] the lock protocol
for reflogs is somewhat intuitive.

This early exit code the comment applies to dates all the way back to
4264dc15e19 (git reflog expire, 2006-12-19).

1. https://lore.kernel.org/git/54DCDA42.2060800@alum.mit.edu/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 997e021c1c4..fbcd0c790bc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3061,6 +3061,19 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
+
+	/*
+	 * When refs are deleted, their reflog is deleted before the
+	 * ref itself is deleted. This is because there is no separate
+	 * lock for reflog; instead we take a lock on the ref with
+	 * lock_ref_oid_basic().
+	 *
+	 * If a race happens and the reflog doesn't exist after we've
+	 * acquired the lock that's OK. We've got nothing more to do;
+	 * We were asked to delete the reflog, but someone else
+	 * deleted it! The caller doesn't care that we deleted it,
+	 * just that it is deleted. So we can return successfully.
+	 */
 	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.33.0.662.g438caf9576d

