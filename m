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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E06AC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A026138B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhHWLxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbhHWLxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:53:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54BFC0613C1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so10583700wma.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4gcPPuG2g0togwK1CRtX5RPklILwP9gyGXZqErg0iA=;
        b=J1z5gv34icqM7Gb8iDaLoEwrmv5Z1va3bZTgTpe/wy6glyxaxsXkhlHxn/3MMfQqjl
         mO+IiyT1UpybZy/Yds/D9RPaOLAlY/dtAME87P2Jcl3tNvNDP8kALkELFbqKZmuE7TEG
         RQrrHtwbb5adIoSKTawgIM4lPilmG7srcPYwuXvvyvzPkUKpGr8aT0wCZIS5c7je2cJ6
         zl3KJDrzBKqRgg1m1kHHqVrPmP8WVTVjIgrBHtH5fKu/DAhBEIvLy/4ZceQQnDv6Oki4
         wMqFWKrpX0K3I29uMcTEGbGaewgks7WUPNUMxnl+P3oTSDu/XCl01jCrYX/h7rYb2cRs
         BEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4gcPPuG2g0togwK1CRtX5RPklILwP9gyGXZqErg0iA=;
        b=SQAaoMaTXupTFBR/gsxrI3+yxPZRKNyBZ/TmZbypcjsZkjxxx1wDhcP4cqqPqX+dpx
         EDDBFCvm0xb/YJH3QVtzzDcOcSWZKgPz+Q2jwviUKmQrC/1Lyibrunqz/1Ct5e1w+xRq
         izvbvAHxUagjA26EUhqsj3Gka/0OWiQXHjP3iOckIkDouTRYVvTtN9QGNTSHW5StpRhd
         zXsYS108IwB6qvIGCOllG5e/NkYjgwgDrmI9YkIWYY7OM7GhKmJb7doVKyU2QVBxjol1
         7brjoq1onftrLEv2pDSZZhKmodRyR5qtAkLzJpY4bZleWUyhz06/qobwwScgk5POqXUb
         FX4w==
X-Gm-Message-State: AOAM5339xQ7+GeUIrq0IUI1mjVTh3dSljUJly4wStBZHdTx4AO5aZgIa
        3bDFosU+TevThyOOSvU/7ii8Kq6VVyUYZCQ0
X-Google-Smtp-Source: ABdhPJy3j1I5YB1jSwvp2wKyVNN+f7cI9ismnR5cKlnXhJb7HIGjhbR3CZJqprCgTy7HjWC50AxhrA==
X-Received: by 2002:a05:600c:2e48:: with SMTP id q8mr15466031wmf.38.1629719576979;
        Mon, 23 Aug 2021 04:52:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm12350713wmi.1.2021.08.23.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:52:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 6/8] branch tests: test for errno propagating on failing read
Date:   Mon, 23 Aug 2021 13:52:42 +0200
Message-Id: <patch-v10-6.8-6dae8b643ad-20210823T114712Z-avarab@gmail.com>
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

Add a test for "git branch" to cover the case where .git/refs is
symlinked. To check availability, refs_verify_refname_available() will
run refs_read_raw_ref() on each prefix, leading to a read() from
.git/refs (which is a directory).

It would probably be more robust to re-issue the lstat() as a normal
stat(), in which case, we would fall back to the directory case, but
for now let's just test for the existing behavior as-is. This test
covers a regression in a commit that only ever made it to "next", see
[1].

1. http://lore.kernel.org/git/pull.1068.git.git.1629203489546.gitgitgadget@gmail.com

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3200-branch.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e2..9fae13c2dea 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -731,6 +731,26 @@ test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for
 	test_must_fail git branch -m u v
 '
 
+test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
+	test_when_finished "rm -rf subdir" &&
+	git init subdir &&
+
+	(
+		cd subdir &&
+		for d in refs objects packed-refs
+		do
+			rm -rf .git/$d &&
+			ln -s ../../.git/$d .git/$d
+		done
+	) &&
+	git --git-dir subdir/.git/ branch rename-src &&
+	git rev-parse rename-src >expect &&
+	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
+	git rev-parse rename-dest >actual &&
+	test_cmp expect actual &&
+	git branch -D rename-dest
+'
+
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-- 
2.33.0.662.g438caf9576d

