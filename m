Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83457C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 06:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5252E204EC
	for <git@archiver.kernel.org>; Thu, 21 May 2020 06:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlMw0pGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgEUGGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUGGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 02:06:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1FC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 23:06:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so5440887wra.7
        for <git@vger.kernel.org>; Wed, 20 May 2020 23:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XT5qe5BNmqboonYiMALEDs9+utGbynnfRbyoRrys+5k=;
        b=XlMw0pGVxazwd+3QBXKe3/HAW/7hUI1R9alYbGFwxaojlZcfoS7edi36KAe5H/i0Di
         IPgtZx128dYmH1H1iN1+vkojTgmYdft8nQwn/iu1U6myyfeO7cpnfB0vxxWJRIskGG2v
         OC6qsivNi5XH7gZPCH30FsU6Q9RWEkccWkoGwN6tBEy27YY8v5Qo1jxg0CYZ5Bj3RebW
         wbKXg31u0i87m7lzzTtxgRtcMFzhcF0stY1OMECQZnDCeiRxzy8p1O1AxaVre47VAG2M
         FVAwvG4RVxPdtFVqJr64RhbHmqEa2MFOFZsc/kCHjgRVY1Ikhfcw9i/kjL1Ks3dGJCPe
         zk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XT5qe5BNmqboonYiMALEDs9+utGbynnfRbyoRrys+5k=;
        b=T79C3m3d+633j3gvT+CMglkd/ci0Gnhq5qe/7WhtJd2rPvWzuECVWktPqnUH1sbOy+
         SY+2kCo28cmOq73xiQhOWwjXgvYGguYAVg/w0WJxHSJ8VpOBRWKH1n/F1UmlbBWArnbh
         t+2ZfM09Upr6xjqiGLsCrZr5hvME9vSUrWCJ05uVNAPlsMHBf/Nkf9qhBAihcDgWzxZS
         ivctcSCtUGBGtAKnpwBO+hto/uxZ6452a4s0GX2dQZ1yb0EJhxv1LPcTHGHlpN1HusQh
         l21/ZpHN93SlxMO+RQFwUHm8qmBrd6JXBxVMyHqpw+Fun0Fn7to/xzfByT6kPymtqm2v
         7JBA==
X-Gm-Message-State: AOAM533VqS5WtmW+wzs8c2YpwSHiaDRXl+hh6bXh42cGhWaUiZpab+xQ
        sEUirx+f2S4OG3Bd24nG9mGLxlRa
X-Google-Smtp-Source: ABdhPJxZ55OlWymB+3coLcM1ETUdUy+Bab3C6LEmd5gsXKScayO5V0+B+5NYQXneJ1s0rhf5CTnJPw==
X-Received: by 2002:a05:6000:10d:: with SMTP id o13mr5354542wrx.328.1590041166114;
        Wed, 20 May 2020 23:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm5004450wrc.41.2020.05.20.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:06:05 -0700 (PDT)
Message-Id: <pull.641.git.1590041164665.gitgitgadget@gmail.com>
From:   "starlord via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 May 2020 06:06:04 +0000
Subject: [PATCH] doc: sparse-checkout: fix mismatched sq
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, starlord <bojun.cbj@gmail.com>,
        "bojun.cbj" <bojun.cbj@alibaba-inc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "bojun.cbj" <bojun.cbj@alibaba-inc.com>

Signed-off-by: bojun.cbj <bojun.cbj@alibaba-inc.com>
---
    doc: sparse-checkout: fix mismatched sq

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-641%2FBerger7%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-641/Berger7/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/641

 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 1a3ace60820..7c8943af7af 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,7 +70,7 @@ C-style quoted strings.
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
 	as directory names as in the 'set' subcommand.
 
-'reapply::
+'reapply'::
 	Reapply the sparsity pattern rules to paths in the working tree.
 	Commands like merge or rebase can materialize paths to do their
 	work (e.g. in order to show you a conflict), and other

base-commit: 87680d32efb6d14f162e54ad3bda4e3d6c908559
-- 
gitgitgadget
