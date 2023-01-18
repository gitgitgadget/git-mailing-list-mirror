Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83C5C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjARQOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjARQNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:37 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688C32E5D
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id az20so65334081ejc.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0IwC/QvznkVbsg+2+t8x4z6DeiWD7kSq78LzrmvRuo=;
        b=J2WXE7gbsT3M3C455SNC9XZrZYyWNysEu36PJPu3BsQjylMRX2R3NIWZdJcsocxmFi
         Z04C4hgRFYVVFhl/1LUP9wOlNxtNmt89CuawTW9Lex9UEaTU28FTIj02hMj5CdVzRbRg
         9Lj1uZhBqkUFS7scXMSewVn4DwwNQ0R+LDtIvoST1dGmEr41ooAIdd1QCme/ZyQL5Mo4
         FPcgdp4sFcUzWuBOwhAqb9Wvkl00+N6etdn6gwfRyczvWR8eQH0RGGQduaM8vephIq46
         7Imh5UC9SvAVhSpKxeevagFHc4Gp+d6y+jQQQc43KDs01uov9O9w1j5BByCVZzmSpuQ+
         Mddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0IwC/QvznkVbsg+2+t8x4z6DeiWD7kSq78LzrmvRuo=;
        b=faq0GDg+wCedhJCq1Tzyfwy6QXsdneEnqioFZ/zy/KQaBenzh5Sy1y/DdfCYMT0m0N
         HO2qhbZuQLf0Pbr5z4DuGtVMSVkhGAS1l0rrVAlUPfvqmwqcgU1W5COhBstalQN7vYn+
         Em85RZZaXoWBWp+sBVcURzfb6BIKBkR13FWlgsU7AUHH6AwLde3wXwO8IR7DPU+vQ8Ql
         DDXjNEvFVu8h5coAJj4FMx56HzV4+kiJgcRadsOhtP83yhu4aPLtPo38Rs8iSbNQ94nG
         jOoWdz7QHTyeGKop4HF4BUwCWQwn4kFg/knzLkAn9VcqRsCwTQRkX+b2xr9/ILwI+RUM
         b7qA==
X-Gm-Message-State: AFqh2kpzKq4/N7frrHA5c7j0yDKGL7RTypiJKQuRs2plqap5aYmxEuHl
        Zb/0PHgMVGqxM4rrTxY+VplNEFUgwvPicw==
X-Google-Smtp-Source: AMrXdXtHUKZm1PRjPCZR6RRgK0LOujOwlAHaOHx8jgO4WqRBSYSfE7wQD03RCTBxLJYnBzr7W4P2sQ==
X-Received: by 2002:a17:906:d937:b0:7fc:4242:fa1d with SMTP id rn23-20020a170906d93700b007fc4242fa1dmr8059306ejb.54.1674058172283;
        Wed, 18 Jan 2023 08:09:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/8] commit.c: free() revs.commit in get_fork_point()
Date:   Wed, 18 Jan 2023 17:09:16 +0100
Message-Id: <patch-v3-8.8-84343ea6bf6-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since d96855ff517 (merge-base:
teach "--fork-point" mode, 2013-10-23).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c                       | 1 +
 t/t3431-rebase-fork-point.sh   | 1 +
 t/t3432-rebase-fast-forward.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/commit.c b/commit.c
index 14538a811ae..e433c33bb01 100644
--- a/commit.c
+++ b/commit.c
@@ -1033,6 +1033,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	ret = bases->item;
 
 cleanup_return:
+	free(revs.commit);
 	free_commit_list(bases);
 	free(full_refname);
 	return ret;
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 70e81363569..4bfc779bb87 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -8,6 +8,7 @@ test_description='git rebase --fork-point test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---E    (main)
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 5086e14c022..7f1a5dd3deb 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -8,6 +8,7 @@ test_description='ensure rebase fast-forwards commits when possible'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.39.0.1225.g30a3d88132d

