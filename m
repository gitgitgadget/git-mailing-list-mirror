Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDAC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113282078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuZgcIyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgFWWrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbgFWWr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF6C0617BE
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so240024wrn.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AcuURcMs3/L/lda8S0YlchF2ZQ1YWzh/Fa9Q4d0BgUM=;
        b=JuZgcIyvY+3nABi654giJfHhecaem3EmS4ejLPUZJixh+jEGox2HC4GBQ3iDzCSDai
         bSKtSEqogE57sL0kBFoRsmxkr4iZPKYAQmzt8oGRsDGDZkVs5tlYH2uPuQu2hPdEoQqd
         3d9ai8B8sl3rh2ZqoNoKy5Yn1nq1fx9cx0UbVpVErNixtOi7xkp1Ljj2FjCeNRCJj/Y2
         bNwbk3u3BjxUWAUcWt5faaZF4ybNiRdgvFf/KCuuiWWTTKcV6o655+CWv/7OYWKqbfpI
         L/oAJK5WajBWepEQy6ZVFOoNsyc2eOMTvJmPnyBAVZLJXlKPt7PIt+H5wGNzPB74k+i1
         VPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AcuURcMs3/L/lda8S0YlchF2ZQ1YWzh/Fa9Q4d0BgUM=;
        b=f0UYAXVyUwHO4gt08zBEMptzW8xGrRzRmCdJ3glA9HkGbco1rML7sXu6mUflnU78OW
         G0yuD4y/0gHmo1c94uQdretif39Dq6eEYyd3s7gkKD4947eZ3V7QYWEN4/yrRzpCXAlD
         wIATNTfZtwYnmFXIeL3XCIaiFUyos5ZRdrkBb3TaXCVVI4ZOrXbBMvtAf/NA01PUfkiU
         EbH1o1wmR5ol1o9oPEzMlnqyfVxmo8kJoaVHgIqb2isw98pmQ6thyeLjUVVnEEgFCFJj
         EFGQFmBENLAIR1Q7CujgU1hQOOyjoMAuQrrr8egfWCvYJS4aFTE0FPXWK38weh7bmux8
         1Ruw==
X-Gm-Message-State: AOAM531qjcIW9uDJ16Fn8K0rgI2PAXD/7XPVf9DpWWDQiDUXE9Ze9gtb
        zfHhor8Yiqk/1v7yVEcp7WRksXL3
X-Google-Smtp-Source: ABdhPJzrgQGszjm3x4CVypWmcZmXnoGY5iLyeWi+vcXDUXlYvA5MW2dpsNLcGDg39wtRirLZwTwqoQ==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr4849497wrr.226.1592951614525;
        Tue, 23 Jun 2020 15:33:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm24506775wrs.95.2020.06.23.15.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:33:34 -0700 (PDT)
Message-Id: <a29943d7bbc11a524089348a4abbd33c7514eee9.1592951611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:33:24 +0000
Subject: [PATCH v3 2/8] send-pack/transport-helper: avoid mentioning a
 particular branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When trying to push all matching branches, but none match, we offer a
message suggesting to push the `master` branch.

However, we want to step away from making that branch any more special
than any other branch, so let's reword that message to mention no branch
in particular.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 send-pack.c             | 2 +-
 t/t5528-push-default.sh | 6 ++++++
 transport-helper.c      | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0abee22283..db79cdac77 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -406,7 +406,7 @@ int send_pack(struct send_pack_args *args,
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+			"Perhaps you should specify a specific branch.\n");
 		return 0;
 	}
 	if (args->atomic && !atomic_supported)
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4d1e0c363e..68b84c4add 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -98,6 +98,12 @@ test_expect_success 'push from/to new branch with upstream, matching and simple'
 	test_push_failure upstream
 '
 
+test_expect_success '"matching" fails if none match' '
+	git init --bare empty &&
+	test_must_fail git push empty : 2>actual &&
+	test_i18ngrep "Perhaps you should specify a specific branch" actual
+'
+
 test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
 	git checkout -b ambiguous &&
 	test_config branch.ambiguous.remote parent1 &&
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69d..b81a3486bd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1046,7 +1046,7 @@ static int push_refs(struct transport *transport,
 	if (!remote_refs) {
 		fprintf(stderr,
 			_("No refs in common and none specified; doing nothing.\n"
-			  "Perhaps you should specify a branch such as 'master'.\n"));
+			  "Perhaps you should specify a specific branch.\n"));
 		return 0;
 	}
 
-- 
gitgitgadget

