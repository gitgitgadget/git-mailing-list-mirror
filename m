Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E5C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 14:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjCaOgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjCaOgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 10:36:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955F01A2
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 07:36:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t10so90288161edd.12
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680273366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbpo3kwtMGOPrFw962inEOty5xHQYI0/gupwZkXtDKI=;
        b=b+r+Nbz8mQoIh6P2yWUhygEvoyXUJYgHv3vFuRWHTnn5253/IVqORjDZX64vtRxTBm
         juuMH/iBcrLVE0t0dalRcvZEE0EQmeNLc19IV5h9bCC9Y0URUs5GD+fMkVoe+ofBl8Bm
         5EuuaXev5JOLa+ZAFTs/xLso8oAsIPb4W5hpzXsvGC8///Gb9IaYerECVrZ/eEmjZC3h
         WIS7OcN27z/SrbOj2Oz2iPT4MEc8Ud+4MQVyp6EfWsD+TNtWymmk3T9Si8CKSZCqaaC6
         uFLVKXvT+8OCidqZmGnyQdJGOE4YGprsJ9NdgwrJdP0cM4Jn20dW9TSG1u799M5KbbW2
         HB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680273366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbpo3kwtMGOPrFw962inEOty5xHQYI0/gupwZkXtDKI=;
        b=3FfHOamYpp17F+SCzlzp7tEYCxapTXnRG4q9Xr9S1VwDI8sI8806kU3WgFemWBDrs3
         V6qk7f1d2gt0krPrpBAGxmI10wP8YOyN+cx2ow1kBAeP5FX3/c88mtedIZV+AMRfHgtJ
         ZPBYNO081w7jfvPxQs5bPXUxUPgUxqHRC2oKi9MEeyMWMK0k9LSfrOKDnojfwh8ZamgS
         zLr3MeD6aX4/hkIVmQ40cnCy6sdUUtEnUjmrz2Fh4KG3OhVLu6i5TaN9TGQH0knnutvT
         064ULo6tQhIFrjkfqKK4GT7U/gAahx8kpjffi9rbqZHwQs+TEv/Cvfb4Y9ZWrlJaufpV
         6JQg==
X-Gm-Message-State: AAQBX9cW2bS2IwNpuT6hcEBgSJxXjyi7eZnIaxSW1OxunpgWV8fct5Qj
        gu/YeVVhrStK3twxAspRA3e49mbzoeuzX2dQ
X-Google-Smtp-Source: AKy350bDk+6WfM2K6l9jfRyBDNftii51Q4K6OlC7uBHIeKTV0Yx4k3a+fJn7fdCi5IM2QTHYaEml6Q==
X-Received: by 2002:a05:6402:e:b0:4fa:d75c:16cd with SMTP id d14-20020a056402000e00b004fad75c16cdmr23510490edu.34.1680273366510;
        Fri, 31 Mar 2023 07:36:06 -0700 (PDT)
Received: from titov.fritz.box ([45.88.97.21])
        by smtp.gmail.com with ESMTPSA id h27-20020a50cddb000000b004c19f1891fasm1114353edj.59.2023.03.31.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 07:36:06 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliams.eng@gmail.com>,
        Carl Worth <cworth@cworth.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] t3060: fix mention of function prune_index
Date:   Fri, 31 Mar 2023 16:36:03 +0200
Message-Id: <20230331143604.82040-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit [1] added tests which trigger function prune_cache.  The comments
in these tests, however, incorrectly call it "prune_path".  Since then,
function "prune_cache" has been renamed to "prune_index" in commit [2].
Later still in commit [3], the_index singleton, which is also mentioned
in a comment, stopped being used directly with function "prune_index".

Fix mentions of function "prune_index" and the struct it changes in
comments in file "t3060-ls-files-with-tree.sh".

[1] 54e1abce90 (Add test case for ls-files --with-tree, 2007-10-03)
[2] 6510ae173a (ls-files: convert prune_cache to take an index,
    2017-06-12)
[3] 188dce131f (ls-files: use repository object, 2017-06-22)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Found this by accident while working on an unrelated topic.

 t/t3060-ls-files-with-tree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index c4a72ae446..5a06732ca7 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 	git commit -a -m "remove them all" &&
 
 	# The bug also requires some entry before our directory so that
-	# prune_path will modify the_index.cache
+	# prune_index will modify the_repository->index.cache
 
 	mkdir a_directory_that_sorts_before_sub &&
 	>a_directory_that_sorts_before_sub/file &&
@@ -56,7 +56,7 @@ test_expect_success 'usage' '
 '
 
 test_expect_success 'git ls-files --with-tree should succeed from subdir' '
-	# We have to run from a sub-directory to trigger prune_path
+	# We have to run from a sub-directory to trigger prune_index
 	# Then we finally get to run our --with-tree test
 	(
 		cd sub &&
-- 
2.40.0

