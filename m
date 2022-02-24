Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3426C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiBXQmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiBXQmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:42:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18023F1AFD
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:42:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p4so210911wmg.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vwpoq3mdybG/2F7T8Lm1sg1tz0iIc62ROQyiyXSKqiY=;
        b=X3ZeX9s/QZpvrm671PMctRd/pW5QZsW2NV7rXDYwJ/gFVVo53ZtU5qFubBGS1yigmz
         ObHvQYRoOFfyTHDE1xpKuMBz7bJnRmk9oVeMSJ13jpY3oqDJd5Ifvzl8IhttoPgXUwrA
         erW8xW+WUuuntCO8pum7AwajnYz6hwmcnbVPVR6oK6JZouwPpHCB8O00M0UCW1w3JWuv
         4sQFODW5/8fuX6sRZVngVoEeR6BTwDpnCcO2H1E4s9fYT+c8woVZMw3cfxK6ouCj94FQ
         j75Y2DFngEqlWiI+SB7bbCFWQwpf/XpKMwy07LpRyo7hAXPc/6i+Q4PXf64YykmD24Tk
         yV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vwpoq3mdybG/2F7T8Lm1sg1tz0iIc62ROQyiyXSKqiY=;
        b=CcxAoO7jjzqKiy0S6B0wrCUCsHnEDzB9/cOtj8pHorQreIw0jKOGClYl5EtrNz94Yi
         VXnUFr4SmurxztbcR3irmjcOoxT+iiRHkuz1XBuo7MskTJgvRncky5o4iTlSnSLEYARp
         68V8UgkCYapuffhAOHUUj2x0hLGNuSEGieUn1SDfYV/eg95CKGZHaYJfrMJM79l31q0P
         1K32TUJ6uNxCHpWkdOrdJntTPWYstFDimfNr6OG0fcOgZn+5tnf9ZL8Iga8cfE3BMITc
         fChl3d7wD7tf4jjuOAxHRlulWg8fadqIWyqP0woWVHUuMC8exuZNb7+NTJLhMH/fpdlw
         flPw==
X-Gm-Message-State: AOAM5302yA5pznHMjJB4AKkhWzxdIzYDhZBEBwFhlLg2F4D57uCwBdyy
        kgNT08RId9eCYWjZUpT0/uRvrkkGHbg=
X-Google-Smtp-Source: ABdhPJzVgiyJpco86aNyRYagos6rQOpMZmOzgMoG2PhU1iFLeGg9TNqFTRojCs6dYc//e0rO0YteeQ==
X-Received: by 2002:a05:600c:4107:b0:381:1c3:5d3 with SMTP id j7-20020a05600c410700b0038101c305d3mr4027624wmi.107.1645719224509;
        Thu, 24 Feb 2022 08:13:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7sm4181604wrb.43.2022.02.24.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:44 -0800 (PST)
Message-Id: <38af2bbee791c09b33932d87244ddba99f7c3dc2.1645719218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:35 +0000
Subject: [PATCH v2 5/8] t5615-partial-clone: add test for fetch --repair
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a test for doing a repair fetch to apply a changed partial clone
filter under protocol v0 and v2.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 t/t5616-partial-clone.sh | 52 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 34469b6ac10..230b2dcbc94 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -166,6 +166,56 @@ test_expect_success 'manual prefetch of missing objects' '
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
+# Do partial fetch to fetch smaller files; then verify that without --repair
+# applying a new filter does not refetch missing large objects. Then use
+# --repair to apply the new filter on existing commits. Test it under both
+# protocol v2 & v0.
+test_expect_success 'apply a different filter using --repair' '
+	git -C pc1 fetch --filter=blob:limit=999 origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 4 observed &&
+
+	git -C pc1 fetch --filter=blob:limit=19999 --repair origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 2 observed &&
+
+	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
+		--repair origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 0 observed
+'
+
+test_expect_success 'fetch --repair works with a shallow clone' '
+	git clone --no-checkout --depth=1 --filter=blob:none "file://$(pwd)/srv.bare" pc1s &&
+	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
+	test_line_count = 6 observed &&
+
+	GIT_TRACE=1 git -C pc1s fetch --filter=blob:limit=999 --repair origin &&
+	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
+	test_line_count = 6 observed
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
 	test_create_repo submodule &&
 	test_commit -C submodule mycommit &&
@@ -225,7 +275,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 
 	# Auto-fetch all remaining trees and blobs with --missing=error
 	git -C dst rev-list --missing=error --objects main >fetched_objects &&
-	test_line_count = 70 fetched_objects &&
+	test_line_count = 88 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
-- 
gitgitgadget

