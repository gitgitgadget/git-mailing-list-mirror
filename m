Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B0C2D0D3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6FD20663
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZy0FT5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfL3PdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:33:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43703 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfL3PdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:33:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so32876710edb.10
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z6xlNyXi3awc+cVfQ+xQmT3OJwwcdmXn/Dg19CskEZA=;
        b=GZy0FT5fA2SAR4QjNVe8VBJYqQhjqBJqJC8RYGdri4e3ZZlwn4N8hd9BspFfV50hmJ
         lFST+2HVctnLkVYfWPIAu0hskO0IMf19sndnmGmbmrcBAi9dzmQTcMzEWFd40GRCjASs
         BGM5goE524UfWx8LxUtJUz2qrkDUW0CdUxw0SuLTM2Hxaaew+dkOzTK3MY1xy7ZYT5lQ
         hi0Y4PQQD4i9gEgFIE+RpUJ1HCU3poxDsHDU7AsX2k+gXjMPm1eCiC0CApsA7nVl0W0E
         Zc6nIitCpIYAi/UUWkFhbTQ+i2dgCKeSUQ5/Yw7lwXPMdX7NaJS0JL6sB3zAuPSqG00y
         h4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z6xlNyXi3awc+cVfQ+xQmT3OJwwcdmXn/Dg19CskEZA=;
        b=LhxfWgBSgsBApRV4d8NifhLAzx3VaC8PuhECYR6X7v9h8v8J+SV8YGlEEL8ME/Jfym
         xqi9IqWJhUaPPXfJz9Nzo1jV7nQIReDZ3oXyPChwJlC0+jzhOyN4XaWw03kawMdkT609
         N4Pe6fb9WHgLB5axd2Rwyw0vG7OpEr8Fvm7eXCf/JmP93GfIWqyox6JOi0Bys1i9d6B9
         cZt1qj8IahlD39Ngj+Vs6gcrI2yZW23fI130KzABTW51ztOlEhJQSsL2edFnOLdYSsZj
         SZUsX5sJik3wcSG5vsdXHCUWPIlytd3ZNngV5/Y04CEAlYK8ME74Yy1hMrCwPro9xYLT
         6j0w==
X-Gm-Message-State: APjAAAW1w40PUqp9sYDTUw4xc1015ay8renOjnn7qKDwtTzqczcUVJOG
        5wMuz5nMxSi39KDc19ml/ggTkzTs
X-Google-Smtp-Source: APXvYqwv9F/EYOg4mXHirKtWealPY8VQNy/cPBuqmEI7JDnJtpTepmkpkZNv4cZG1m0ZzGsz2GhShA==
X-Received: by 2002:a17:906:3299:: with SMTP id 25mr70844752ejw.118.1577719997105;
        Mon, 30 Dec 2019 07:33:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d22sm5354110edp.28.2019.12.30.07.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:33:16 -0800 (PST)
Message-Id: <74bbd0f84d5f0c9eb7cdbd6983cf5c82ac3c7d18.1577719993.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
References: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
        <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:33:13 +0000
Subject: [PATCH v3 2/2] sparse-checkout: document interactions with submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Using 'git submodule (init|deinit)' a user can select a subset of
submodules to populate. This behaves very similar to the sparse-checkout
feature, but those directories contain their own .git directory
including an object database and ref space. To have the sparse-checkout
file also determine if those files should exist would easily cause
problems. Therefore, keeping these features independent in this way
is the best way forward.

Also create a test that demonstrates this behavior to make sure
it doesn't change as the sparse-checkout feature evolves.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 10 ++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 28 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 67be5247b9..3b341cf0fc 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -164,6 +164,16 @@ case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
 directory.
 
+
+SUBMODULES
+----------
+
+If your repository contains one or more submodules, then those submodules will
+appear based on which you initialized with the `git submodule` command. If
+your sparse-checkout patterns exclude an initialized submodule, then that
+submodule will still appear in your working directory.
+
+
 SEE ALSO
 --------
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 37f6d8fa90..ff7f8f7a1f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -340,4 +340,32 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	test_cmp expect dir
 '
 
+test_expect_success 'interaction with submodules' '
+	git clone repo super &&
+	(
+		cd super &&
+		mkdir modules &&
+		git submodule add ../repo modules/child &&
+		git add . &&
+		git commit -m "add submodule" &&
+		git sparse-checkout init --cone &&
+		git sparse-checkout set folder1
+	) &&
+	list_files super >dir &&
+	cat >expect <<-\EOF &&
+		a
+		folder1
+		modules
+	EOF
+	test_cmp expect dir &&
+	list_files super/modules/child >dir &&
+	cat >expect <<-\EOF &&
+		a
+		deep
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget
