Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA4C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D0D610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhHBQyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhHBQx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A55C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c16so22217066wrp.13
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CDVW6sUer+N3exZhLdDXIl1bpkzjCR6J5xk26HR3AoQ=;
        b=KJ9ekfyTUosfe7B7EM4DKea4/PDCn1unYWnvBSnkHVCGJS8Lk29K3V3H+qhjZov8LV
         eRAuOo0JTWlXCrwXtqsUZhvXB3ArsCEKRtFPDa16CLVlX3dHJLXGbqkUjQcOpZseW5L7
         kdnLjdokHvsw9VzPnx1KiLA4MurDqXikLAg8Ofpi02uv7YPJXhKmU1bnEUh+e/ZVD7NH
         yvwd7928vyTZy8iP+dBQj09zOLEQEYaDoISZBD/LOcBEZdujL26Z0jznPeQNua+jQXc0
         q485xwlPNAlyzHmlnIOskMihvIvqZAaTs+QjiK/Bu/Qk5JC+GdiTJXoxtOl+O3tw4ScW
         lS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CDVW6sUer+N3exZhLdDXIl1bpkzjCR6J5xk26HR3AoQ=;
        b=f4xO+w/3XIBaDt+FhQ3YUUTVbdyScBqFV4XO2yEx8FxrGb6izKT7zMNml1doY4eJai
         X80o53gbGbAdQPPIvjm4bTY8aoe3z6BRcYH3k7SENVf/QjcrzgV+IugcgyI1A+NED/C9
         zL+aRYai8Hh2jgvFcvhJ1k+pgz/LwxNvrzTpRByDvn7ym84gR7XDfi/cFWSaI8YYkMds
         EqAuP8fmrkiEIsKzty+RLmg0ThidJPQZDpwHY+g68CYS9t7EtP6hvftqDLvf0ep963Am
         PkzGVbGlev3lzRIHfkcHvgX2aOtqZcd90UXbVcpBEEDiFzBq4CEJNSdeTf4FFl+Hq5SR
         74xg==
X-Gm-Message-State: AOAM533lL0+U5pncSsh+O3FcE8ES8KYhBnKVxaBNkmBLN60cSw5XuZpl
        bmnJ+osQwXvXVWGUiRYFN7zsu4sIsnc=
X-Google-Smtp-Source: ABdhPJyQUBYaf+as/SGs80FHEbWVm5Cnvjf2OACQd3gyCX8pDbsgytF3hF7VyVs/L+aswFHtbXaBnQ==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr12688156wrw.310.1627923224223;
        Mon, 02 Aug 2021 09:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm11972656wro.30.2021.08.02.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:43 -0700 (PDT)
Message-Id: <55eb2094811cfdc7a9387f1b582784f11a1d16eb.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:35 +0000
Subject: [PATCH v3 10/11] t6500: use "ls -1" to snapshot ref database state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

By doing ls -1 .git/{reftable,refs/heads}, we can capture changes to both
reftable and packed/loose ref storage.

This relies on the fact that git-pack-refs (which we're looking for here)
changes the number (loose/packed storage) and/or names (reftable) files used for
ref storage.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6500-gc.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 10c7ae7f09c..c2021267f2c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -241,7 +241,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# create a ref whose loose presence we can use to detect a pack-refs run
 	git update-ref refs/heads/should-be-loose HEAD &&
-	test_path_is_file .git/refs/heads/should-be-loose &&
+	(ls -1 .git/refs/heads .git/reftable >expect || true) &&
 
 	# now fake a concurrent gc that holds the lock; we can use our
 	# shell pid so that it looks valid.
@@ -258,7 +258,8 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# our gc should exit zero without doing anything
 	run_and_wait_for_auto_gc &&
-	test_path_is_file .git/refs/heads/should-be-loose
+	(ls -1 .git/refs/heads .git/reftable >actual || true) &&
+	test_cmp expect actual
 '
 
 # DO NOT leave a detached auto gc process running near the end of the
-- 
gitgitgadget

