Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FEC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhLPQNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbhLPQNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:13:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8413BC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i22so15319478wrb.13
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SPcmNAFRyeGcydZVsSbRi2Onf9sX9YSSmUTswrDmLZY=;
        b=n/ZKenjfWfqgN0+2Qw+ahjWv/2cTXjlyVlYEBIcUm1bivjyPbdkzpXQL2uHGXnhIfS
         KNVRlCs/48f75WBreDxTnXst9Sk9cqMxWwPC490/Yy0gOIqJYq/jcX8Csu0iJKrZrepg
         KJytqLEMVnHchVAGbWbdxx9gymCaJpCHrfbmJOCgAzoCm7uqWsPYVCi4EiIlGtKCEF1V
         aVd3kjW4SiXQ161g/3Vj7hZgnJWOumh5rPllyOMa2qDI7CSN5K66dURINmNo24RNvQAx
         cQaeWNTsc39nz+3v4X1EyNa+AVBwkMyQheJgMBDZdDKpYTcQH4n2PiF+kOnvFmnAx+G6
         uUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SPcmNAFRyeGcydZVsSbRi2Onf9sX9YSSmUTswrDmLZY=;
        b=ur0YKUZZvj3Gr9p4sKOu1Oc2qFGJ5c+govpTgyUoc6rvIyXvJplBkBkmXzFHh4Pd5j
         h58RN+AC+KHr72IyjqVDVlA3wOmeUFUtqW9v8jIHlF5pc/Gp/BACS1B4k/10WNXgyv2H
         fhrS7WZOBkyRexi+LEFBkDriqBIbcI17yy1iQ1PYJwCZEe6OmTY3akyCG2hfx0y+9UW4
         qEZz/Ne8KhcPz7vJF3iGs9piaHUEgKBvx2YC5zBvtEeErpAz4cZcUEVY7xwTQQHsf91o
         zg+K1lhVgPMW9s4AK5WpLQSL6gIf412S6irs/UDm6GXyKwOxkOIX6jRyNT+zRug1X23Z
         1lQA==
X-Gm-Message-State: AOAM530tUfSg4bMkTKI1qLFMqc/HTnGTwuHXwinOrHj7aTAPW9aJFsbH
        LcqGbSimUpQTasEPpU2WX+MyNIzi3og=
X-Google-Smtp-Source: ABdhPJzSpe6fXD69XLbOyk2Z2KoJQckcO5T6uGifhJBJpA4MfoCqIySH3n12M15ekrVsVCRHch5NFA==
X-Received: by 2002:a5d:4563:: with SMTP id a3mr9939432wrc.130.1639671224882;
        Thu, 16 Dec 2021 08:13:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm4940962wrw.55.2021.12.16.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:13:44 -0800 (PST)
Message-Id: <5353c541d9f72aa0a14cd2b02e5ddcc0b6a4dae1.1639671222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
References: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
        <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 16:13:40 +0000
Subject: [PATCH v4 1/3] sparse-checkout: fix segfault on malformed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
used to populate two hashsets that accelerate pattern matching. If the user
modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
then strange patterns can happen, triggering some error checks.

One of these error checks is possible to hit when some special characters
exist in a line. A warning message is correctly written to stderr, but then
there is additional logic that attempts to remove the line from the hashset
and free the data. This leads to a segfault in the 'git sparse-checkout
list' command because it iterates over the contents of the hashset, which is
now invalid.

The fix here is to stop trying to remove from the hashset. In addition,
we disable cone mode sparse-checkout because of the malformed data. This
results in the pattern-matching working with a possibly-slower
algorithm, but using the patterns as they are in the sparse-checkout
file.

This also changes the behavior of commands such as 'git sparse-checkout
list' because the output patterns will be the contents of the
sparse-checkout file instead of the list of directories. This is an
existing behavior for other types of bad patterns.

Add a test that triggers the segfault without the code change.

Reported-by: John Burnett <johnburnett@johnburnett.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  4 +---
 t/t1091-sparse-checkout-builtin.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 5aa6fbad0b7..7e72958d51d 100644
--- a/dir.c
+++ b/dir.c
@@ -819,9 +819,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		/* we already included this at the parent level */
 		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
 			given->pattern);
-		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
-		free(data);
-		free(translated);
+		goto clear_hashmaps;
 	}
 
 	return;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..3921ea80138 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -708,4 +708,25 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'malformed cone-mode patterns' '
+	git -C repo sparse-checkout init --cone &&
+	mkdir -p repo/foo/bar &&
+	touch repo/foo/bar/x repo/foo/y &&
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/foo/
+	!/foo/*/
+	/foo/\*/
+	EOF
+
+	# Listing the patterns will notice the duplicate pattern and
+	# emit a warning. It will list the patterns directly instead
+	# of using the cone-mode translation to a set of directories.
+	git -C repo sparse-checkout list >actual 2>err &&
+	test_cmp repo/.git/info/sparse-checkout actual &&
+	grep "warning: your sparse-checkout file may have issues: pattern .* is repeated" err &&
+	grep "warning: disabling cone pattern matching" err
+'
+
 test_done
-- 
gitgitgadget

