Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FBC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiBORYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiBORYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560EDB847
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id bj11-20020a17090b088b00b001b8ba3e7ce7so2919503pjb.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YtWsRIqNBsOpYmuM8tTo+UFh4Ku4XbbMHXY/iecDSKQ=;
        b=NdJYDdX2SpV4L4nEN4uu70GexvPYF7QnFirdwF4yVcjotb/4jNMQw/y2urCcbm87bU
         ITdoOrqgAgGXxeA6eL28ZiTnMLLK0LKUSoZpaR9ti/l6YvhQ9wjWxhhtjq/G7fU3ouCA
         YEm9N5Yb+3bcOGtAZoypVt4l3roQhuhiPVY2en6NCU6Hrxni5RwBNA9KEglgVm4hUbMp
         KqKRG7IQODH1c5RgIQBViHXPjWpWIYkFZxb3ET3CkoTmwQRfAzvxK+w/a6hofZwou0AU
         Hbigv2ralsl+r6B+3q55+vgfDCRpFwC8ZaMKc2Gi5GOCI0qYplta+STah9Xm9dNz/KSf
         JhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YtWsRIqNBsOpYmuM8tTo+UFh4Ku4XbbMHXY/iecDSKQ=;
        b=cZT0lI4D9MyK9gu7hg8aPMTt4Pt9uKYz/LKTvp1QbwF75iuUwAyA6WH9KDX+XcyV+Z
         4j9dny9rqL+oikLWs9b+UuhggkgrZmSkFHR+y3rlCXZkfc8Hy8TqCphI41we0w0BDVcN
         fpt4Wr/RQPRV/pzrxv58GC5vfBCFR48FOZtJY+M/HxAJ2qcwrN/+fyCW6E83boSlM7ZG
         DvfweB0PTMUhHV1Ssr6ASLmAaxWvGF7szuFtKXagHzL7ErBoIlIBvsS5H4jmleYyg/6X
         7aYOrZJAkGvzAS5o3Wzq5h0QFDPe3P+CyGlRaXD9nTD4wYlFpObwRtqTgbQ4buACuDdx
         Dx1Q==
X-Gm-Message-State: AOAM530zde5dAACKQoDrOcBwqOoHQ2EvFp0TwQWCTOIQrgvEzCrFIBsc
        xBNBrQDL+21Qz+Ip4ifSr25CbnLd3lTM6h0miQ17WAf0ovjqeD3cXWxjhOy2WI55KOKSaZ1Xq1A
        4SC+U9K40ty//FuiWzHRYgKpI2q+vBf5EgRxrTq4pN/0XXKTJhJxZsMa6+z/Qc9o=
X-Google-Smtp-Source: ABdhPJzHhgHpDoVYKqTWzMLN+bo7+/7jjI5hHCLWOLblCjYjGQxaYJE7DZDE0Gx/lXBBSwyqAWcsxYftnzAlFg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b189:: with SMTP id
 s9mr5249777plr.112.1644945844563; Tue, 15 Feb 2022 09:24:04 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:17 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 8/9] submodule: read shallows when finding changed submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a repository with submodules, "git fetch --update-shallow" can fail.
This happens because "git fetch" does not read shallows when rev walking
the newly fetched commits to find changed submodules, thus the rev walk
may try to read the parent of a shallow and fail. This can occur when
--recurse-submodules is not passed, because the default behavior is
to fetch changed submodules i.e. --recurse-submodules=on-demand.

Fix this by reading shallows before the rev walk, and test for it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c                 |  4 ++++
 t/t5526-fetch-submodules.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/submodule.c b/submodule.c
index 3558fddeb7..e62619bee0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 #include "parse-options.h"
 #include "object-store.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
@@ -901,6 +902,9 @@ static void collect_changed_submodules(struct repository *r,
 
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
+	/* make sure shallows are read */
+	is_repository_shallow(the_repository);
+
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
 	warn_on_object_refname_ambiguity = save_warning;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index df44757468..ea70c3646f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1031,4 +1031,14 @@ test_expect_success 'recursive fetch after deinit a submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'recursive fetch does not fail with --update-shallow' '
+	git clone --no-local --depth=2 --recurse-submodules . shallow &&
+	git init notshallow &&
+	(
+		cd notshallow &&
+		git submodule add ../submodule sub &&
+		git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* --recurse-submodules
+	)
+'
+
 test_done
-- 
2.33.GIT

