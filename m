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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25C1C07E9C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9846261C99
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGGKlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGKlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:41:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A348C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:38:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v5so2505437wrt.3
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwErDzTF9YEdjoYYQ42kPopqP1xoVubOeJBTPbzT7oY=;
        b=p6Zg7WPs0nY2iVFIQRGNrVZc4HUd/kUpuKazcySlL67S/JxZz3JbRXg6xXXc0ewFRp
         7LZi/DfvyelbPcHwC3VOXlTsQRnVkH2cLnq5snTSJUxP3UgdHiQas92NdEP3tU9NqKUN
         Wnv8s58w7NY20dOtOV85DX+qre8NxnLThUygNDygLzyZGM2xTnQEylG87PS/SNjpxwCC
         iYXH1BLMwowvDjkQYh8CWEItKxNRCGb+cj6yR7FDNhXGX3KywdI0h9S4yIEJZjtS6VYa
         XuzO25V1AAx6yfCTmIan2PTJN3kzQECmAmpabIXEUqN4sXqUorKvTTA3CgwyJZ48g1ad
         RZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwErDzTF9YEdjoYYQ42kPopqP1xoVubOeJBTPbzT7oY=;
        b=cnd2VFQM2sTMrxMVE6Wm35n95aCvjpzbCyJ5032kT5rxzST77MBWJxhXdQBm6T1p2g
         RbP2Dw3dSAAUyRFNgl4wt3JlEksvQZKM5QYup7A+fk/CzD9TG9YyZghkfaBS73Kg6eV1
         a2QvZW+uyejml9qsDrLJork/mPDcgao+d0rOFzCXhaY1PkDpSccrfSPOPdhvYTZkMSSe
         UuGRlhi1ucpUJQD5i3PO+IY5pvldWOy/A6sPaadrzXhwx1BQHI4b+smQ6r3MXa4ElASN
         4XazRKwOTWAKFSkpdXZOOabJ8ihM+fHgDdqgBuFH66kM5XyHOkXVdcm3YC55cMNYVKTb
         vpUQ==
X-Gm-Message-State: AOAM533XU5IePlmD3TpCGAsjdMaQ6GVA7zrLRByn0wiHiS3X8yWHeQiG
        bWap9JOBfq0tiCXd9irR0jvSnrbFQMYC9w==
X-Google-Smtp-Source: ABdhPJzmp7XmFeZpJK5Fg5VuJl5xHfwkDDaMPf1KJEELCGyqJ7CQgbYmyE4NfZ/WxpgE+dI2+LDmbA==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr27373176wrv.234.1625654328548;
        Wed, 07 Jul 2021 03:38:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p3sm5859104wmq.17.2021.07.07.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:38:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use STRBUF_HINT_SIZE
Date:   Wed,  7 Jul 2021 12:38:41 +0200
Message-Id: <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of users of strbuf_init() that pass a hint of 8192 to
pass STRBUF_HINT_SIZE instead.

Both of these hardcoded occurrences pre-date the use of the strbuf
API. See 5242bcbb638 (Use strbuf API in cache-tree.c, 2007-09-06) and
af6eb82262e (Use strbuf API in apply, blame, commit-tree and diff,
2007-09-06).

In both cases the exact choice of 8192 is rather arbitrary, e.g. for
commit buffers I think 1024 or 2048 would probably be a better
default (this commit message is getting this commit close to the
former, but I daresay it's already way above the average for git
commits).

In any case, if we ever tweak STRBUF_HINT_SIZE we'll probably do so on
the basis of some codease-wide performance tests, so replacing the
hardcoded value with STRBUF_HINT_SIZE should be safe, they're the same
now, and if we change STRBUF_HINT_SIZE in the future this is one of
the main codepaths we'll be testing.

Aside: It's unfortunate that we don't take a "hint" of "0" in
strbuf_init() to mean "default" and e.g. "-1" to mean the
strbuf_slopbuf (a in STRBUF_INIT). I considered adding that, or
splitting them up so you'd do strbuf_init(&buf) for the
strbuf_init(&buf, 0) case, or strbuf_init_alloc() for the
strbuf_init(&buf, N) case, where N > 0. But that would be a big change
across the codebase, so let's punt on that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache-tree.c | 2 +-
 commit.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 45e58666afc..d69f6d1c66f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -335,7 +335,7 @@ static int update_one(struct cache_tree *it,
 	/*
 	 * Then write out the tree object for this level.
 	 */
-	strbuf_init(&buffer, 8192);
+	strbuf_init(&buffer, STRBUF_HINT_SIZE);
 
 	i = 0;
 	while (i < entries) {
diff --git a/commit.c b/commit.c
index 8ea55a447fa..b3aab46072a 100644
--- a/commit.c
+++ b/commit.c
@@ -1521,7 +1521,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
-	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
+	strbuf_init(&buffer, STRBUF_HINT_SIZE); /* should avoid reallocs for the headers */
 	strbuf_addf(&buffer, "tree %s\n", oid_to_hex(tree));
 
 	/*
-- 
2.32.0.636.g43e71d69cff

