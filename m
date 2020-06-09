Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057EAC433E1
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC2D206C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYByU4NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbgFITAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbgFITA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:00:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B44C03E97C
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:00:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so3839566wmh.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h8MOdG5ScNHrk8SrMGWVSBQUlVk0ldpdLpEf4d/7LXw=;
        b=hYByU4NIWc6KizGUzBS1RzV3XmOSf5DWybPwF2O8AOfA7x9PQSY4nLteY1Ls5Ou95x
         qBYVYApEU+cgKjB14xnCMbxpI89zZC5ThBM2AUBhVbaKg2/wxu2zD84wXJa6w6R9tfUL
         AholetYvXSOpVMcgwCecJck5arLvfse48T3aw8PPEndOVdbNHCDghjeNf1WJHnKzI38c
         K62P4rSBuIOmVspSHD1Pba7/96MbrTNPN/Z7Q9A3o5csPr9wBFB9eHCKEvB+ggb8z3UP
         hTOi0FTR1FtgYpY1VRcgVSJd4UlpngOjTJqZs1cr7P8HbM7d34fM0G+q+TApJL08HS2z
         o0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h8MOdG5ScNHrk8SrMGWVSBQUlVk0ldpdLpEf4d/7LXw=;
        b=gwzE8LXzD7mOR1FpuYjecT8ojH9VgL+W6Ln14V7yrab82sPxGE7G71YRng7D/TOnrF
         BVxYLGCgFno78F0SUPuAcCMf5SuKGjNwH3Tqc1gs0ORkewuvphHPKVgxOAktRX4uWjjK
         tyZvKUha8eQQpf7qxzr766+vPNn3hBDU89iTs8+hJWPiBA2hv2IEvghmT+qaIyfgyKtQ
         j5aTNQ77UdaxN+fg0AnfMhMKY/JYcFieTY3nuVqByd3hrtmsuLdLD5QBmJrphTz4DOXR
         frbO2Klw/SEv0HCv3lRe12kWEfPTAj6PHedsOQcKRBq0N++8lziAdXel8Kl6kiiqLq5E
         SsPg==
X-Gm-Message-State: AOAM530N5YdjjgwyA/KmwC+HRStnxrNJIfbwsWrRP3yteaKl+3dfGpwd
        9yJYfVxzWFtd0C+YSlmFjUxRjZ/Y
X-Google-Smtp-Source: ABdhPJzXIVZgLDE3WG5NBwkdf0NQcayFnMQIjZ+/yXlqwCgmCFv59nni+Bo5Cb/Z15vIEFfbon4X0A==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr5361948wma.101.1591729226500;
        Tue, 09 Jun 2020 12:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm3985515wmd.42.2020.06.09.12.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:00:26 -0700 (PDT)
Message-Id: <2ccaad645ff01b786e76dc63210d75da633389a6.1591729224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 19:00:21 +0000
Subject: [PATCH v2 1/3] t/t3430: avoid undefined git diff behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

The autosquash-and-exec test used "git diff HEAD^!" to mean
"git diff HEAD^ HEAD".  Use these directly instead of relying
on the undefined but actual-current behavior of "HEAD^!".

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 t/t3430-rebase-merges.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index a1bc3e20016..b454f400ebd 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -420,7 +420,7 @@ test_expect_success 'with --autosquash and --exec' '
 	git commit --fixup B B.t &&
 	write_script show.sh <<-\EOF &&
 	subject="$(git show -s --format=%s HEAD)"
-	content="$(git diff HEAD^! | tail -n 1)"
+	content="$(git diff HEAD^ HEAD | tail -n 1)"
 	echo "$subject: $content"
 	EOF
 	test_tick &&
-- 
gitgitgadget

