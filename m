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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E963C43603
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7DD61370
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387672AbhELUjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386800AbhELUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 16:22:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E81C061763
        for <git@vger.kernel.org>; Wed, 12 May 2021 13:16:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so13166033plz.0
        for <git@vger.kernel.org>; Wed, 12 May 2021 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6fvDLVTd4EeowZdjayryosfZljNW2fhFs3d4qpDLbU=;
        b=VcVfqXLUlZkBokR65qqEkV322xOyBZ3HnUWdO9s9Re5hhlAKuOCohK81DcXzdAlQrB
         dtnztvc2L62zr5PJkvG0XU8c1JdNpx4EJyUyQDUytDsBXR/dYZ3zG9/t0EoJs/H8dwZF
         aSSoQbqdqDorMfxHIWwSrLJeoaJvORG5ZrdAMXGqDLrsM4aAesfTvLssbyIIfRDAE0Sj
         gmIXk+fDfjSHzZv3wRPnZwPu8D4FNLWlpuf+ZtwQrnSrwVv1f9Dt/iB4bezVt+chXLmS
         QV1bUWING0v0F7snjPCLu+AZLmzJLYQHO4h21PoF0U/d2jFfImBDb4x3HnxvGvk2qpC1
         LP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6fvDLVTd4EeowZdjayryosfZljNW2fhFs3d4qpDLbU=;
        b=p6uSWz33x5Fsulb+oWBRksGIb3FJkwLNqkoRN5c+XamfITCKx2qMwlLB6RdHxoIC9A
         cLj1+/QXwy9aE2dJT6w5e6FOv2w4mNNfxU0SWzUt4jDJS7+2rs/Lw7a5nishILj+rTNb
         qI5w2sSAcDh1o5aSHMomH8A6Fnv38w1qikjk9+QmmiW4N7wG6iKZzgYrXPwF+Q236dA1
         ygHUf50yXDdkg9xTrJWJ8V7Vlfh4Ii6k8obrmOY0x9Nqk9gcwOEdR35zq2YHWl9oiJfx
         YTKq+pVz4P+YTjjpGAnFz/P+hhJUkQHZk6BtndjrANTficjcr+01okVVCGau+EOpTrfk
         W4gw==
X-Gm-Message-State: AOAM533+w0IFG1w70JpGuhZSJcmiYXLjjEP8XU2I4AUYgRQHpIC4+PaN
        Qy4yFpbeuCmpnRdMYP/ZwtF1QOaMSEY=
X-Google-Smtp-Source: ABdhPJwEMImNzv9BkQ7BoeKDsm4fS1NMcawEseNVmxPjTlgzI0JyBwo5uHFJ6QJMpmO4GAZxh1briw==
X-Received: by 2002:a17:902:e84c:b029:ee:d129:3b1c with SMTP id t12-20020a170902e84cb02900eed1293b1cmr36421019plg.73.1620850582208;
        Wed, 12 May 2021 13:16:22 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id bx12sm5109133pjb.1.2021.05.12.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:16:21 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] stash show: fix segfault with --{include,only}-untracked
Date:   Wed, 12 May 2021 13:16:13 -0700
Message-Id: <24de72b34de45980196ed6df8b64782887e94f36.1620850247.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620850247.git.liu.denton@gmail.com>
References: <cover.1620850247.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git stash show --include-untracked` or
`git stash show --only-untracked` is run on a stash that doesn't include
an untracked entry, a segfault occurs. This happens because we do not
check whether the untracked entry is actually present and just attempt
to blindly dereference it.

Ensure that the untracked entry is present before actually attempting to
dereference it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/stash.c                    |  8 ++++++--
 t/t3905-stash-include-untracked.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8922a1240c..82e4829d44 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -900,10 +900,14 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
 		break;
 	case UNTRACKED_ONLY:
-		diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
+		if (info.has_u)
+			diff_root_tree_oid(&info.u_tree, "", &rev.diffopt);
 		break;
 	case UNTRACKED_INCLUDE:
-		diff_include_untracked(&info, &rev.diffopt);
+		if (info.has_u)
+			diff_include_untracked(&info, &rev.diffopt);
+		else
+			diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
 		break;
 	}
 	log_tree_diff_flush(&rev);
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 2e6796725b..1c9765928d 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -405,4 +405,19 @@ test_expect_success 'stash show --include-untracked errors on duplicate files' '
 	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
 '
 
+test_expect_success 'stash show --{include,only}-untracked on stashes without untracked entries' '
+	git reset --hard &&
+	git clean -xf &&
+	>tracked &&
+	git add tracked &&
+	git stash &&
+
+	git stash show >expect &&
+	git stash show --include-untracked >actual &&
+	test_cmp expect actual &&
+
+	git stash show --only-untracked >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.31.1.751.gd2f1c929bd

