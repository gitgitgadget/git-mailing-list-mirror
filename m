Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50654C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiBAPuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiBAPuC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:50:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947BC061401
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:50:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m26so6788955wms.0
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X26VxDwgr31yM2BaB0b1VUG1Cvw1yQFiLBk//vY9/sU=;
        b=B3eQo5iNfBwkCGs8bdyfjB8X1M2Gqk+VgMqCJrU9AGgkdIQRvEKYmGT132hv9rcbz2
         bWboIt0l5JJMqNZ8Mk8fu55GjxviMaimY2i5z1D5GPqly6y8/ixtE8t07G8Rj/1sxlan
         ibBkqcKtPLo7xFmkqLpvfAOXunsghdytcGRA55/TvnzgzQw5idVIDICIx7hkxr0vxF+6
         4S2oExixJoWIP/IA84D5jrkgGH8NAW6PykuJV3gX/8bojKy/GFuroqkM0nDIR7xFlWMN
         AERTcQdqIEN1vPlkPXdoIXbJw1PNoBeKHIq+k1rSRLMuoKou6RuHXAMLvG2YtWRp1p+e
         /Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X26VxDwgr31yM2BaB0b1VUG1Cvw1yQFiLBk//vY9/sU=;
        b=hKCnGxjRMCwrj/4nRgOipjtqAM5DENHUSYVjdg53mc3Xbikzsu8EetsdWOuQIfHH34
         woqUaWXRCTh9aqfxgUCIKWUW2tEX/Hk/bPWW+SxySEALOxOo9ICNZcgIyaIdizzUFWIu
         WnyeqSYMymt+DtAo/ChuaVdAZG8eBe8cIHZF/dtwmJSpsKsHM2JY6JSX5qETeAU/jE31
         m2hWW4Hpo3kP3qFAJDZd+wMuI3NsAaHuC7NItiW0zqenVJt4xdnVTNNPXkDkxgnK+cqp
         idHK/LW/f+OUk27qtPORubKsoTTgEhgczTqw4HQ/0W0cKJ1TusvX1/UqpsqXN/TgnUJX
         oDig==
X-Gm-Message-State: AOAM5338zl+tdcgM242WwzBrr45mP0oprTFlvhaefWNUGzmLqNYxwwZ3
        4WqxzOqg9ogihC8oTjWOyuQ02A/1eK8=
X-Google-Smtp-Source: ABdhPJx1HoaXLbS5hKTlsta729T46dZlPbYja6lEsetTTyB4KZUtNRnuhxjQxUHnpnRp+0e8CFI1XQ==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr2290867wml.183.1643730599834;
        Tue, 01 Feb 2022 07:49:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm15043710wrw.116.2022.02.01.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:49:59 -0800 (PST)
Message-Id: <66c18850aadb636a922e7bf08c671d4e96998b12.1643730593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:52 +0000
Subject: [PATCH 5/6] t5615-partial-clone: add test for --refilter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a test for partial clone refiltering under protocol v0 and v2.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 t/t5616-partial-clone.sh | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 34469b6ac10..87b8095258f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -166,6 +166,46 @@ test_expect_success 'manual prefetch of missing objects' '
 	test_line_count = 0 observed.oids
 '
 
+# create new commits in "src" repo to establish a history on file.4.txt
+# and push to "srv.bare".
+test_expect_success 'push new commits to server for file.4.txt' '
+	for x in a b c d e f
+	do
+		echo "Mod file.4.txt $x" >src/file.4.txt &&
+		if list_contains "a,b" "$x"; then
+			printf "%10000s" X >>src/file.4.txt
+		fi &&
+		if list_contains "c,d" "$x"; then
+			printf "%20000s" X >>src/file.4.txt
+		fi &&
+		git -C src add file.4.txt &&
+		git -C src commit -m "mod $x" || return 1
+	done &&
+	git -C src push -u srv main
+'
+
+# Do partial fetch to fetch smaller files; then verify that without --refilter
+# applying a new filter does not refetch missing large objects. Then use
+# --refilter to apply the new filter on existing commits. Test it under both
+# protocol v2 & v0.
+test_expect_success 'apply a different filter using --refilter' '
+	git -C pc1 fetch --filter=blob:limit=999 origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 4 observed &&
+
+	git -C pc1 fetch --filter=blob:limit=19999 --refilter origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 2 observed &&
+
+	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
+		--refilter origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 0 observed
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
 	test_create_repo submodule &&
 	test_commit -C submodule mycommit &&
@@ -225,7 +265,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 
 	# Auto-fetch all remaining trees and blobs with --missing=error
 	git -C dst rev-list --missing=error --objects main >fetched_objects &&
-	test_line_count = 70 fetched_objects &&
+	test_line_count = 88 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
-- 
gitgitgadget

