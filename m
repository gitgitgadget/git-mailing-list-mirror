Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA899C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616D9208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmFoZq4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKKUdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKKUdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:33:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC171C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:33:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c17so3764420wrc.11
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vqbm/YN2lHxCdaQfPL2/d5HBDMnCmEapquoJ1GKs5nY=;
        b=UmFoZq4vbYxmb2O3rcUDFkWLQIVWHqt5lD3aSsqnVQSRFjLUip0L9XsU0s/XPj190e
         ebapR6X6YwJB7NAt08y5V2V3az235J64h5K2tkZYO5PBj7GYjnDKill5xqMuqbTKhdE4
         A2gWNElovHbm8Jl28ElBasOgF0c6j/H8LZ4oX5ToXT+bW/qu36O9FrEslXe0Em9KuEBK
         od24/grRs4W2oQIf0FXYiD3gPpWZyNCfW/JLfLPK3pp145egKXnQsMinWAPARJExoHs+
         1zJ28qeqYTDjPmGszPh2Z29PsRHhI030NC1sdbUC/DirtAqETARpSgTCr1Uyjk+jkgjf
         oXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vqbm/YN2lHxCdaQfPL2/d5HBDMnCmEapquoJ1GKs5nY=;
        b=DhZ/uC8aeUqknbfRw5zXeT1ZKUYmJC1DoFhbuVIi6R0P7vFRFf+wfJxZKgNb8IkSkU
         s4IX40oiTPtxq/M3WGD4CY+TWilYz+OGVAaYWzNCgY65VtJuBcW2OWUafyCuaODDY2DI
         zcAIJfDKl94kzJ/q1zAddRz6mWjRkJbpI02RQsB7P4tsB7jfqQfRhDuIwmUB4A3WWk70
         xbhC2GdJiCSUXfG95XMfe/kgKzVWjjXN1RYFVwkoLYssoBYfXMl9p6eRebZe8RqR8Wu5
         opKYg3HL1WfHgkwbVvZB+5e6CgV+ect8h9JuXzHTMtflTyD74H0VsExkpdlyf7Oa7hGq
         8lSw==
X-Gm-Message-State: AOAM532FcLJxPDcJIvekMFC43DUJrYd0ySrpgdrGRRl1EO+RSZw+hrYl
        OQps4z3GWg7iBKJ/H2S6hYZqm4oIbUM=
X-Google-Smtp-Source: ABdhPJzUadtMMHzJtSEo9p4TzgbjV82D7r4TSZVtxot2WYTtKqi8Qv4lSM7MksnutnbN7bZNtfoloQ==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr34017531wrn.340.1605126800736;
        Wed, 11 Nov 2020 12:33:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y63sm3657091wmg.28.2020.11.11.12.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:33:20 -0800 (PST)
Message-Id: <c157c07d5d4917e6eef6717894f61c54cbc9af22.1605126798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.787.git.1605126798.gitgitgadget@gmail.com>
References: <pull.787.git.1605126798.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:33:18 +0000
Subject: [PATCH 2/2] mergetool: avoid letting `list_tool_variants` break
 user-defined setups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 83bbf9b92ea8 (mergetool--lib: improve support for vimdiff-style tool
variants, 2020-07-29), we introduced a `list_tool_variants` function
in the spirit of Postel's Law: be lenient in what you accept as input.
In this particular instance, we wanted to allow not only `bc` but also
`bc3` as name for the Beyond Compare tool.

However, what this patch overlooked is that it is totally allowed for
users to override the defaults in `mergetools/`. But now that we strip
off trailing digits, the name that the user gave the tool might not
actually be in the list produced by `list_tool_variants`.

So let's do the same as for the `diff_cmd` and the `merge_cmd`: override
it with the trivial version in case a user-defined setup was detected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-mergetool--lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 2defef28cd..7225abd811 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -138,6 +138,10 @@ setup_user_tool () {
 	merge_cmd () {
 		( eval $merge_tool_cmd )
 	}
+
+	list_tool_variants () {
+		echo "$tool"
+	}
 }
 
 setup_tool () {
-- 
gitgitgadget
