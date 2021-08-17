Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E16C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 12:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2228860F38
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 12:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhHQMcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhHQMcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 08:32:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD868C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 05:31:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x10so22048328wrt.8
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ltn+CBUmkYNEvmC5rvs+vtvC1apGKKsrvPAfdeeED+c=;
        b=VMJkCC+QJfbcO+Y4m3pU8T0XAVWQTzrFFOP9oFOOdJfoSK2kT23LXDtNAhevepdVtF
         uc9zEm5oi2wu2QW/+MtRcMnxQ3C4dLoYDI3doAXnYP9E5egX5yNwjkTdOk2E+h1bIAPM
         kPEocSmKDLkgdbVxVdIOdAICbekR6u7slZJT5Tzml3fk6oSXPgHl6kH8Sb59YZCDoFcv
         YzIZAdFcppw1c7sLZRQKmwX0bWfv16lHbjMt62W3A0vrDCS5sTUAd2t9FcLFawOixHw5
         4ubzu5eXPh6OkTjkPB5eMiLQOY806GkpyusXlyI/8agqCr9jJNTxSAA0CyNfjAdwi4vo
         XTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ltn+CBUmkYNEvmC5rvs+vtvC1apGKKsrvPAfdeeED+c=;
        b=WH5XpzNjwQND/WqRLPem25QgvofWD1iq7zZldttB61EVilQBpv/njXGheLq+YwpCdP
         NYDYVgJUqNbTdK0KwNe8gIiiBnBmLLoBo95St6UcR5ef42ZdYLcgoz6rhNQmxhXhpFGS
         Ydp6XySSYpbk3kBWu+K/JiOFtOsXhrBJgkYxVVgJaX/C8IhtFD9jjkA7Fn74oE0x5X1V
         MKVanvynEeKQpioELd8cdly5lGm0SnZaF57/XK5RO+WCcd/q74e6VQEb0iqjGYN4xaia
         xtnrOV6kESBTlHafY/Z++LJ6z7Sa7K0BkAA+afJJlEDg0Vtk6xR7n5hwy8pwM+1xfYlm
         V3bw==
X-Gm-Message-State: AOAM533OSSPifpQ+UDeSGYNhdbpnU90FuRGRlagrZ6b/92S8nbk6MAnJ
        xHdhyaHbWLweuDRJFe172+3OqxCmO3g=
X-Google-Smtp-Source: ABdhPJyb0Q6xFdySOgGkuu4dHTid9Q/21l0MGhLkpppmQhHnHxRIrQvT88Cu4hwt3cTPwc1wa5Iavw==
X-Received: by 2002:adf:de83:: with SMTP id w3mr3826829wrl.342.1629203491164;
        Tue, 17 Aug 2021 05:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x19sm1896472wmi.30.2021.08.17.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 05:31:30 -0700 (PDT)
Message-Id: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 12:31:29 +0000
Subject: [PATCH] fixup! propagate errno from failing read
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This fixes a crash triggered by the BUG() statement.

This can occur with symlinked .git/refs. To check availability,
refs_verify_refname_available will run refs_read_raw_ref() on each prefix,
leading to a read() from .git/refs (which is a directory).

When handling the symlink case, it is probably more robust to re-issue the
lstat() as a normal stat(), in which case, we would fall back to the directory
case.

For now, propagating errno from strbuf_read() is simpler and avoids the crash.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    fixup! propagate errno from failing read
    
    This fixes a crash triggered by the BUG() statement.
    
    This can occur with symlinked .git/refs. To check availability,
    refs_verify_refname_available will run refs_read_raw_ref() on each
    prefix, leading to a read() from .git/refs (which is a directory).
    
    When handling the symlink case, it is probably more robust to re-issue
    the lstat() as a normal stat(), in which case, we would fall back to the
    directory case.
    
    For now, propagating errno from strbuf_read() is simpler and avoids the
    crash.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1068%2Fhanwen%2Ffiles-fixup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1068/hanwen/files-fixup-v1
Pull-Request: https://github.com/git/git/pull/1068

 refs/files-backend.c |  1 +
 t/t3200-branch.sh    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0d96eeba61b..f546cc3cc3d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -454,6 +454,7 @@ stat_ref:
 	}
 	strbuf_reset(&sb_contents);
 	if (strbuf_read(&sb_contents, fd, 256) < 0) {
+		myerr = errno;
 		close(fd);
 		goto out;
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e2..dd17718160a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -109,6 +109,20 @@ test_expect_success 'git branch -m n/n n should work' '
 	git reflog exists refs/heads/n
 '
 
+test_expect_success 'git branch -m with symlinked .git/refs' '
+	git init subdir &&
+	test_when_finished "rm -rf subdir" &&
+	(cd subdir &&
+		for d in refs objects packed-refs ; do
+		rm -rf .git/$d &&
+		ln -s ../../.git/$d .git/$d ; done ) &&
+	git --git-dir subdir/.git/ branch rename-src &&
+	expect=$(git rev-parse rename-src) &&
+	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
+	test $(git rev-parse rename-dest) = "$expect" &&
+	git branch -D rename-dest
+'
+
 # The topmost entry in reflog for branch bbb is about branch creation.
 # Hence, we compare bbb@{1} (instead of bbb@{0}) with aaa@{0}.
 

base-commit: f000ecbed922c727382651490e75014f003c89ca
-- 
gitgitgadget
