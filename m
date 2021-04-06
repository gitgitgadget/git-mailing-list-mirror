Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59423C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E37613D2
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhDFSsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbhDFSsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:48:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741EC06175F
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 11:47:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso7819503wmi.0
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PgJ0YgR2NLW/QaUBFc2FgMQq0xZYgM9FeOj+wD03FLg=;
        b=iHsH1ucyOGEQAoDxt+F4PfFwNTeIRxMJ7G/SB3bLb4VJNGYKn5juTFmevv4oRPxzUP
         h2Wx/AoGx+BV+4hzYOmnQl1sgEQlMZyV+iaT3RACV0Ts4QDsEWBXCx+rEamsDGnO5sV5
         BqDgXgRFeO98Nrkpqc00cUuLEWp8y0eAWLQgN5rdBqZjKEvjxvLSuNHacMEaMq03zKon
         b+O70eafeCmTTG/e0uvu7CquWSZETwdTueKcdWTswnC2x+0HHvPLxBHGANAdDfc15PTN
         jxwzOz6Ej4ZY66bYwAnrO/3Vy+fYCadsFxKn5L7zHjuCIVdLFn8QEeZuiI12+MnJK9hH
         Qf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PgJ0YgR2NLW/QaUBFc2FgMQq0xZYgM9FeOj+wD03FLg=;
        b=XEjvV85A3eFdqbku+bAvAraVJGwfjsiyifkenXw5OuSikD/hWLiRdgs5Rizv5y4Gnk
         zprk9E5LSd4/EgZVV/VJ/OqjEVklQRHNT/1lvZgzpbNiQ28QCZs0K2dyWjR2tXYh0ICt
         JtF0c+Kzj6/ssa2X9JebrzL0eGOQ7byhB6+BL9vG/HBLp4dbWRtC3neWbeebYXhl7ZN4
         888cVLqjCBYWabiU7B6M5CumSkmtyoJsGQgvgipVliptvipu06nwqBMnXQtCyRNyiGKF
         07KCbLAf9ZAxw5CCAxvcwf6kdLkZN0rrOv1KAOhKVpLnXl51KH5UYAbW4aU6gnG1A9km
         aHeQ==
X-Gm-Message-State: AOAM531E10UYNN6zbpjvN9ns0wtwA+UNwcgQOavLBy6omp58YlLcdeh5
        fo+ef1N/KjitpRKaUPeRHoHwbeillZE=
X-Google-Smtp-Source: ABdhPJxKjU5TGZyKRdBnqn8qXn5aURpX9Dc8PKc1Dbx8eQhD2CxAEM3Mg+2KO1zU7kyVb8xBL5+hlw==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr2052757wmj.2.1617734873255;
        Tue, 06 Apr 2021 11:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o62sm5149497wmo.3.2021.04.06.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:47:52 -0700 (PDT)
Message-Id: <d58a3e042ee84641290b15496e96f959ef86a122.1617734870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Apr 2021 18:47:47 +0000
Subject: [PATCH v2 2/5] test-lib: use exact match for test_subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The use of 'grep' inside test_subcommand uses general patterns, leading
to sometimes needing escape characters to avoid incorrect matches.
Further, some platforms interpret regular expression metacharacters
differently. Furthermore, it can be difficult to know which characters
need escaping since the actual regular expression language implemented
by various `grep`s differs between platforms; for instance, some may
employ pure BRE, whereas others a mix of BRE & ERE.

Sidestep this difficulty by using `grep -F` to use an exact match. This
requires removing escape characters from existing callers. Luckily,
this is only one test that expects refspecs as part of the subcommand.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7900-maintenance.sh  | 4 ++--
 t/test-lib-functions.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c006..37eed6ed3aa3 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -142,8 +142,8 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
+	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remote1/*" <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&
 	test_path_is_missing .git/refs/remotes &&
 	git log prefetch/remote1/one &&
 	git log prefetch/remote2/two &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339c..a5915dec22df 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1652,9 +1652,9 @@ test_subcommand () {
 
 	if test -n "$negate"
 	then
-		! grep "\[$expr\]"
+		! grep -F "[$expr]"
 	else
-		grep "\[$expr\]"
+		grep -F "[$expr]"
 	fi
 }
 
-- 
gitgitgadget

