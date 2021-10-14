Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B024C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFB161164
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJNAIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJNAIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC74C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m22so13966564wrb.0
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4BONn6rBYvZlYQkN77M+zhw1mX5XxmJwhe1VEK3aUI=;
        b=ZIcP1CP1dlA5nAyCOeB7YOX8fUcmKT83Q9LmRNRIjhf3xs9ZhuEiszvhGDz9q9WZfh
         JZuJeO8bD4p2JXOqf9LvnXl9DL/SdTiwFkTqJHKZ8wmp2dNsbMwGoYvm6m2lPqaE2VmQ
         ZjBoHDvRUuyoDSNbsiayxk4v1inMVOwNSSEevXTfGeMBdQznaTQNwVJcbgzhxQ60L0OM
         Fv/ECnV6HemhUpy7WixVxM5GtmzXl49v9760WdTd80sBR0bYd6WKCwR6k0ImLbmzei4j
         Vou1jOvXARzchCFlHduySHLQS57kS+XQrIUNAIyfOj4jMrIqVmHSIS9gtnre2V2l48By
         Mm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4BONn6rBYvZlYQkN77M+zhw1mX5XxmJwhe1VEK3aUI=;
        b=yf7SYvhzvspmjIqBViybON+9bKbQuiuFV7Gd5hBA7RafP89YP1FkMv86cFvtMW3cAD
         aiGhJiUkDdgtPgRpiHAA+5JbR+1cLn+GUOzTthhNsbv2qpYFCvibsjEYRMIG7o1v1MGt
         GuynMNpH3s3dy2rW6ClySm19wtC1FZavKHftwopQZJ4PpzRFRcctqCMgy3TFtFTjpTCB
         0tt7JSBsw743yULeDdh+t7CH8DQVaeXhxthzppHoljlfbnX2iKWzqj4e3bCULdXcK8rV
         bk6lmvteXJNQutrxrzCWTPXGqRHmeIyYi33YusE393sEmJM/SpthpI4QjosTGPHN/mLf
         woIg==
X-Gm-Message-State: AOAM530utQ2CnVKF9ZnnpuSXvL/fufrmeKgAnl8jpqtMQS4a+EhvjV6s
        kVW9iHhFSS5p73ugm3yHFDbJ2CWoIXVLwQ==
X-Google-Smtp-Source: ABdhPJzR1qVKVh4og6IKnYDPWYTnq36Z6pElmS7doqscQ5T4PrjlB3u1+jEzU96qPW/SgUjloPekRw==
X-Received: by 2002:a05:6000:18aa:: with SMTP id b10mr2692484wri.270.1634169995378;
        Wed, 13 Oct 2021 17:06:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/20] branch tests: test for errno propagating on failing read
Date:   Thu, 14 Oct 2021 02:06:13 +0200
Message-Id: <patch-01.20-bea88e382c0-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
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
index e575ffb4ffb..b5242719159 100755
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
2.33.1.1346.g48288c3c089

