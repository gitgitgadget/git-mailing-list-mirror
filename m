Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CCC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FE623A00
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLSRYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgLSRYC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:24:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E64C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 09:23:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i9so6430268wrc.4
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TBStUldPuKDBUGgVQO+yMmYea6guFwJh7rRjA6nXlSs=;
        b=I5IR2yml6QuTFsH/o96BVqshTTP/6uPXUA7mgGwaJOjGOxiITnJAy7jNc/QU0Pgb6v
         0elMFMLdu78Et+eUq4ll0jF+8UmEtQ6i4RElgCWbZtir6Xgb5Df2LJ6oSSz6OhvQtXX4
         1ro7QVQUKPSSNuGycqDhAsTRZkKQEjqj3Dqw0Kv0kArOFdJ0F9FC5eyrC0jzX571uGPh
         OTkRDYOP/3PqqKfoQtieU59yT+0l4FVRK4Ur8g68feuv7bMKajt9sLPOAsq2WVx9dSXy
         Am+SSPA/w5PjpqAS9mRyv6VWrjKSn0SUn3fwqddQ81OljSrOpSrOq33XxK7Iz/p1DQsG
         Ywhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TBStUldPuKDBUGgVQO+yMmYea6guFwJh7rRjA6nXlSs=;
        b=F8IbNPh2ZEkOq+G0DrEekECmxKwS29dAYPcRCaa6F2QENAftlRP1oWrwHG+s4oB3a+
         d1Ptuncn7hqJhjS5YNNWkxIugKn6LD30iYfWcbCL1kAUf1wcpyv4MxrHWBDIO4RWdXr8
         vnRQmw88DP93iQZnXF2GitW+uOfwS0q04NBUjAyiGKUF9tGRPwhTbyumIsunNaShIJEB
         t4KOzy8kkx9jvXPF6cX7iiEkiFMtJp40cRuCiQ8pHH/qs0V8kzxNj9adLtI5MhVEDPjy
         vO0/a/kJ7j70ebZU7ajl7RwCrKUXUhCwWAHTG1QA1sWBI948cS628A6lByXroBZ3C/ft
         GPJw==
X-Gm-Message-State: AOAM5319V96Yuo0GqiXx9m/tteYOUO6+diTgCbPXLjj7bJfi7gwcAFdm
        bvJBNMPePrM2H1IE7/ciNEE/4XzMY8c=
X-Google-Smtp-Source: ABdhPJzRj4+IYX4EYmZvhCkQNkXgPEYQjOyej1p7JCA2X0BvZkFvDwHCJJZG0xEiAj0wCANormeplg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr10347241wrn.122.1608398600105;
        Sat, 19 Dec 2020 09:23:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 34sm18692211wrh.78.2020.12.19.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 09:23:19 -0800 (PST)
Message-Id: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 17:23:18 +0000
Subject: [PATCH] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Previously, if remote.origin.push was set to ":",
git would segfault during a push operation, due to bad
parsing logic in query_matches_negative_refspec. Per
bisect, the bug was introduced in:
c0192df630 (refspec: add support for negative refspecs, 2020-09-30)

Added testing for this case in fetch-negative-refspec

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
    negative-refspec: fix segfault on : refspec
    
    Previously, if remote.origin.push was set to ":", git would segfault
    during a push operation, due to bad parsing logic in
    query_matches_negative_refspec. Per bisect, the bug was introduced in:
    c0192df630 (refspec: add support for negative refspecs, 2020-09-30)
    
    We found this issue when rolling out git 2.29 at Dropbox - as several
    folks had "push = :" in their configuration. I based my diff off the
    master branch, but also confirmed that it patches cleanly onto maint -
    if the maintainers would like to also fix the segfault on 2.29

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-820%2Fnipunn1313%2Fnk%2Fpush-refspec-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-820/nipunn1313/nk/push-refspec-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/820

 remote.c                          |  5 ++---
 t/t5582-fetch-negative-refspec.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 9f2450cb51b..8ab8d25294c 100644
--- a/remote.c
+++ b/remote.c
@@ -751,9 +751,8 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 
 			if (match_name_with_pattern(key, needle, value, &expn_name))
 				string_list_append_nodup(&reversed, expn_name);
-		} else {
-			if (!strcmp(needle, refspec->src))
-				string_list_append(&reversed, refspec->src);
+		} else if (refspec->src != NULL && !strcmp(needle, refspec->src)) {
+			string_list_append(&reversed, refspec->src);
 		}
 	}
 
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 8c61e28fec8..4960378e0b7 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -186,4 +186,14 @@ test_expect_success "fetch --prune with negative refspec" '
 	)
 '
 
+test_expect_success "push with empty refspec" '
+	(
+		cd two &&
+		git config remote.one.push : &&
+		# Fails w/ tip behind counterpart - but should not segfault
+		test_must_fail git push one master &&
+		git config --unset remote.one.push
+	)
+'
+
 test_done

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
