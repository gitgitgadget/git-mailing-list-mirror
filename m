Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A78C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiCAAJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiCAAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:29 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC3D4C98
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:45 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y1-20020a17090a644100b001bc901aba0dso7371081pjm.8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o5nkxgDZrdwzBZ20XpsGRZ4cU+SIy1n8uBmoDWH1UMs=;
        b=lpkf6ZO79Kqy3GfF6ni3U10m1v8WbNTMDYIJ7essKIqwkhw+8qKg8ut3XCF5PRah1O
         voqTUMzfv6CCSiV6eJVEwEoaWVkNGMZ4RkMcq/4ULVfyIaGgEBU8t167pjbIozgEA0IZ
         Dzm4UWr2huW5dK/cbJpqffxnq3vnokVUAkyBW0JqtQnAcNqh1/kfR2g4NdvRnIG3DpLD
         FnnXx5qb12LuIIt4W00oTLhRKa1oMAQ0bq3eVAKnpYgfIHR6+iXrHg1Ou7spbFK5kQw8
         zGAawH8iKvrIPLt8cX2UZm66EPg45C7EOdY2/sCHBiGSMR9/CARRAaNlgHa3jL80fsI6
         tnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o5nkxgDZrdwzBZ20XpsGRZ4cU+SIy1n8uBmoDWH1UMs=;
        b=BTGH2aW5nLXXSUjAknEI4rQARIUJYKPKZZNAPj3Rte7PPSnbMukt55BhPIofl84CIs
         bSSnIS8fwdPTaVywVBEnd6p1JsxO2sbdo6PAmqoYNYo3+rkBCLMj88yh14p+AjfG0tLs
         A+0YOURCC/JSTnOJVmAmH7J9Jmo3ajiw7QnwIqpbYOY6Np7d9GmdhoOhGAp0JoqiAHt9
         h5v4xnlM6d3BblRErCOwjG4kLiRuSHMo03TAKKFNbpcN7AYYAWP4asjMc13gxHLNwMhP
         zFWIOeTyoBO8uJaBQgboClC2PTHwsTVfH4NXR4NnVy8Gv3jhBZL2EvBuNN7xT6vJsK0W
         7mQg==
X-Gm-Message-State: AOAM530SVakZ5SY2SVYtmB+Qv02mBGDNsMKFjYOOfwNMgXbTQpQe4Ova
        +RNXvRnd3NqioabH2cO9W+WQaHMKB8vpj8KLxkirXoytd/l2qlGDelKQhl3GEQqIyVKW57i99+Z
        DPT3KSW0a6jX5ToeS8h0wmfsjl7Y0kIVAQ/sXyvp2iQha+Co9CwHz4YJHguDkRCs=
X-Google-Smtp-Source: ABdhPJz8QxdNStJHKNd+n/6JKoRMw8XIaN20hbU8nGRJUL3RBd+ntcjZADvcL9aixzZMFuJIk298g6uiJVFt0w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:1a51:0:b0:34d:c269:566 with SMTP id
 a17-20020a631a51000000b0034dc2690566mr19165417pgm.305.1646093325168; Mon, 28
 Feb 2022 16:08:45 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:15 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-13-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 12/13] submodule update: add tests for --filter
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the "--filter" option to make sure we don't break it while
refactoring "git submodule update".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t7406-submodule-update.sh | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7764c1c3cb..86616bf8c7 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1071,4 +1071,44 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds superproject gitdir to older repos' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitdir &&
+	 git submodule update &&
+	 test-tool path-utils relative_path \
+		"$(git rev-parse --absolute-git-dir)" \
+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update uses config.worktree if applicable' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitDir &&
+	 git -C submodule config extensions.worktreeConfig true &&
+	 git submodule update &&
+	 test-tool path-utils relative_path \
+		"$(git rev-parse --absolute-git-dir)" \
+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual &&
+
+	 test_file_not_empty "$(git -C submodule rev-parse --absolute-git-dir)/config.worktree"
+	)
+'
+
+test_expect_success 'submodule update --filter requires --init' '
+	test_must_fail git -C super submodule update --filter blob:none 2>err &&
+	grep "usage:" err
+'
+
+test_expect_success 'submodule update --filter sets partial clone settings' '
+	test_when_finished "rm -rf super-filter" &&
+	git clone cloned super-filter &&
+	git -C super-filter submodule update --init --filter blob:none &&
+	test_cmp_config -C super-filter/submodule true remote.origin.promisor &&
+	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
+'
+
 test_done
-- 
2.33.GIT

