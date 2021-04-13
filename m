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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D4C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED79F61206
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbhDMOC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhDMOCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8903C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so16601831wrr.2
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bDJHZj1SEW4NF6/qiK9Pt7qfHcqQUwE1hZUVJoNYJFI=;
        b=vPt83GjB5k8HynTZQh+ytanxvf5EHQz2t6hIOhgsgcDInpcz9P662REP1ybO2VkviJ
         s7M4scxkjqnxT4cL9IWkzLLVDyR6Bpx9JCoeFbWFkIvPYqtF+VkB1OAP+ghfYA/0sbbj
         UfP5j7JPfoVX88K/SplBBMXkUguuk4AUnupS859zIgdWfIpq352ZAiCAf08bQtzz8Co5
         T7Z/tgjlPy48/ygmjw6RzJ5IdzDFquTOM/2+a7Og1H46Hc3msLEBgXNgM9LG97ZCqHrV
         gPt9NESoBmLQ0OYxwuiQMYSVYuIvppApKLem7dz8+x2w9h8RSbbtYzXzvbZNuprcZPgF
         myzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bDJHZj1SEW4NF6/qiK9Pt7qfHcqQUwE1hZUVJoNYJFI=;
        b=bLMaVA2cP7Yv7htYf5S4LViQY18rhvFdYQg0NLkmS8fuMgtKf5IrHx0d1o8Bzimbth
         nrOaEE+tO8GZh7Kc21qGlWJbgn5pNtKdQvapfq1C1+e4yrt14OyDPQ7duVwpIX0g3YnF
         oLozVFTLcH+gM5pSkeBa6EWmCydrbBpaqWkJ0eVXKUHJS4L0TUCSnQSrNJQnLV5wRx5c
         cIYQ2s9z5Gt+PYGXrMwNu3Rhrq/3wOHQxLhr86LkxHBLtxOoZZWZ4AKwroeWdn1ath3D
         5Iq5x5iwC/L1oRAVkg/YPCXxl2Swqte7yEd9cQqqNTYaP3bUo+SztYZT0vUemZivfNkr
         DfAw==
X-Gm-Message-State: AOAM531H7X/wCl5gQ/zuVIhLYBRDHGhDT+maYmT5dF7UYjNJPV9HkTtS
        QvotfTMuyTKoGBokHDUMUKIghWjhiVY=
X-Google-Smtp-Source: ABdhPJwj72BQlw180TYGXUmjRtsqlM0lxHsmntEtpWbIMqRiFXOiPDMjaukMZjV8OFMtBP7lV0+awg==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr37235590wrq.88.1618322505267;
        Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm21846541wrn.50.2021.04.13.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
Message-Id: <75199bbe8ca179b7d2e2b09831af0d479bd28e6e.1618322498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:36 +0000
Subject: [PATCH 09/10] t7519: add sparse directories to FS monitor tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The File System Monitor (FS Monitor) tests in t7519 demonstrate some
important interactions with the index and the response from the FS
Monitor hook. Later changes will integrate the FS Monitor extension in
the index with the existence of sparse directory entries in a sparse
index. To do so, we need to include directories outside of the sparse
checkout definition.

Add a new directory, dir1a, between dir1 and dir2 in the test repo used
by this script. By inserting it in the middle, we are more likely to
trigger incorrect behavior when the fsmonitor_dirty bitmap is involved
with sparse directories changing the position of cache entries.

I could have modified the test to create two repos, one sparse and one
not, but that causes confusion in the expected output. Further, it makes
the test take twice as long. With this approach, we can validate that FS
Monitor works with the sparse index feature using the
GIT_TEST_SPARSE_INDEX=1 environment variable. The test currently fails
with that environment variable because FS Monitor is disabled when a
sparse index exists. The following changes will update this behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 45d025f96010..23879d967297 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -62,11 +62,16 @@ test_expect_success 'setup' '
 	mkdir dir1 &&
 	: >dir1/tracked &&
 	: >dir1/modified &&
+	mkdir dir1a &&
+	: >dir1a/a &&
+	: >dir1a/b &&
 	mkdir dir2 &&
 	: >dir2/tracked &&
 	: >dir2/modified &&
 	git -c core.fsmonitor= add . &&
 	git -c core.fsmonitor= commit -m initial &&
+	git sparse-checkout init --cone --no-sparse-index &&
+	git sparse-checkout set dir1 dir2 &&
 	git config core.fsmonitor .git/hooks/fsmonitor-test &&
 	cat >.gitignore <<-\EOF
 	.gitignore
@@ -99,6 +104,8 @@ test_expect_success 'update-index --no-fsmonitor" removes the fsmonitor extensio
 cat >expect <<EOF &&
 h dir1/modified
 H dir1/tracked
+S dir1a/a
+S dir1a/b
 h dir2/modified
 H dir2/tracked
 h modified
@@ -121,6 +128,8 @@ test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bi
 cat >expect <<EOF &&
 H dir1/modified
 H dir1/tracked
+S dir1a/a
+S dir1a/b
 H dir2/modified
 H dir2/tracked
 H modified
@@ -139,6 +148,8 @@ test_expect_success 'update-index --no-fsmonitor-valid" clears the fsmonitor val
 cat >expect <<EOF &&
 H dir1/modified
 H dir1/tracked
+S dir1a/a
+S dir1a/b
 H dir2/modified
 H dir2/tracked
 H modified
@@ -158,6 +169,8 @@ cat >expect <<EOF &&
 H dir1/modified
 h dir1/new
 H dir1/tracked
+S dir1a/a
+S dir1a/b
 H dir2/modified
 h dir2/new
 H dir2/tracked
@@ -182,6 +195,8 @@ cat >expect <<EOF &&
 H dir1/modified
 h dir1/new
 h dir1/tracked
+S dir1a/a
+S dir1a/b
 H dir2/modified
 h dir2/new
 h dir2/tracked
@@ -201,6 +216,8 @@ test_expect_success 'all unmodified files get marked valid' '
 cat >expect <<EOF &&
 H dir1/modified
 h dir1/tracked
+S dir1a/a
+S dir1a/b
 h dir2/modified
 h dir2/tracked
 h modified
-- 
gitgitgadget

