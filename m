Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B595C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 06:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBUGBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 01:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjBUGBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 01:01:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0C2332A
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x34so148245pjj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADukaVmIG09urodJnbM4fEZpqZ3Ja9EWOmzSGxV3A0U=;
        b=cArSxQ13kbDARqvNwql3PXmm5QA6R8sExGQSvVQIMH+8BlpK9WKzLHniNuwiYb7q0E
         JkYLR/Hlu4D5ATpR5UEovTvhX9aFIumGPmifr8VSW5OF/xs7TYsr5R0Irou3aIw0n8iF
         MyUG4xESZgvWqAtvcd/YhILkgzYYiYOUXWCdQ/v9+SccIEtX9j4K/qAorbyQFJDoLW1E
         IktfRIoJwWj5zRqlVjWJrCu8NrUZro7CRsGApW2PsdZZnp0FncrXzphlWxbS0iihO+YG
         B6MWRuFPj7tmG6zLT18GcBjzmOopVZ5Cc8FMHY9eMBJ8k7SFgM/gtKfBm2QqU4lbp14N
         qBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADukaVmIG09urodJnbM4fEZpqZ3Ja9EWOmzSGxV3A0U=;
        b=hkkkehQFtjFPcOO0SKX8JAXNMxpeI8/ldL5JTAToL+4ozAs875zQ7Gmq6us/ZZTq1N
         rsKYN+G76a3Ni6PmxaPwG0Gf8fbebDUqsPqZxC8CLx5tN2XCSYr8Y4CjfBJ9qfgd0a1V
         yWsg2tIgBgYfzyhl5gFHIo1zWijp6LAiK+QMRObMKCdi1fZ+brchvKq0pFaUW8MHNdL0
         ++xiGJfog+PFc+hVPZzAU5vcAVkv4RAmrqXd19k5oAAxyWsxzPe9BTHYruHJIn4c3AzE
         IOVbeUn2KHJBTCV5+v69eT8Ty/PAmPBalgA0afEo1WcbYAq0lGwwScfZ62T07XjOeGZ1
         GpdA==
X-Gm-Message-State: AO0yUKVQuKF00SiGPJs8ZWSZa9Nkvxv869MF1jEIUzWUfqIJOs1wcTGx
        nPC70IZsZJFYYwAWCjKligG4FN6hNt8=
X-Google-Smtp-Source: AK7set/sDhSuUneIn/lI5DTyG25f7SzgdBZvKotX5I8MLZo4Y6M5t+nv15NCPVgvEmGpfgoidob8aA==
X-Received: by 2002:a17:90a:7522:b0:22c:6bb1:55a4 with SMTP id q31-20020a17090a752200b0022c6bb155a4mr3878329pjk.45.1676959296198;
        Mon, 20 Feb 2023 22:01:36 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id mv14-20020a17090b198e00b002308e6e645bsm993905pjb.49.2023.02.20.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 22:01:35 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 2/4] rebase: add tests for --no-rebase-merges
Date:   Mon, 20 Feb 2023 22:58:03 -0700
Message-Id: <20230221055805.210951-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221055805.210951-1-alexhenrie24@gmail.com>
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..e0d910c229 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,31 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success 'do not rebase merges unless asked to' '
+	git checkout -b rebase-merges-default E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase --rebase-merges C &&
+	test_cmp_rev HEAD $before &&
+	test_tick &&
+	git rebase C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success '--no-rebase-merges countermands --rebase-merges' '
+	git checkout -b no-rebase-merges E &&
+	git rebase --rebase-merges --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.39.2

