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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A8C49361
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B46C6140B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhFOONk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhFOONX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:13:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A3BC0613A3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so2140534wma.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q16gBMT1huu7BpCLhZyKDo4zDdTUuJLRUUVAFhN68bY=;
        b=sU/xWnUDHzDXuukPhdcHRoNhQHEmEM+cGQdhuLpfnYjjCAOmODOTDFhMB1aiMl3ChC
         KKosgJVMuzxaJ2j5ISdymDDPpp8Wyu1K2Fl0kfXup6neOxs+2OpKnIs25wOUADV/pSBX
         xbjgom+3BPnGTqv12DFNBYSjvlo/lpj53ujkHDFax5Rv5xbjiiwWrb+OZFKiM5UZHxhY
         10wXPQzfxDP0cOeoWmvCkpV2l5toFqR07MHupIaaKx1A5H2gI7oSyvO0i5iAE51jpDsq
         ukZ5J5Pdlsbd4Pad7tkeXHubGyixyGB87tnVYt1jFMlhviKrl4xR4CO2CBGbqzD3Nzsi
         jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q16gBMT1huu7BpCLhZyKDo4zDdTUuJLRUUVAFhN68bY=;
        b=YgTkQAvyG320EE7dhkZRdyKxMnxOHDxudeid+DvTbPi6ESdsxi18JW6Zs+pdtK2GWM
         cfxrpam1udsBrQFEiHbpueeh07Tar7iw2TMTHhAJkYVW1UbVLGc7SS50GUOW4hRbcuG7
         NajZmkx8G2RCeI600dcDvA/CqES57Lqraab/RJh/5TTW07QOtVTcPZcBGzCfxjalrVFh
         YIM5qcgEnAoqdC2HQ+/S0TgctqTnKALSgXGT7L7Bw+HEGTeaHRsgpmbQ+vyADIFq9r/j
         E9C4yRxxprsFuSqMwGmAb0JdOUTr6ELvDzgpKDGaVX5m9/pcue1vg7PKwHVoGRwktsrd
         9ywA==
X-Gm-Message-State: AOAM53128e4CLy0qjprTKj17C2ssKAu3LMYokmnoXqh4QcIDGXiSINNa
        rqPJlKeI6lE0is5MAhhdKvuAIhv6KQM=
X-Google-Smtp-Source: ABdhPJwl2qYjqC7CzplVT9/aBM7h961EdgYnkmkqxu+Uchn4oNwBlrAS9J79RuYk6HIBOHvg42tO0g==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr23369408wmj.134.1623766275503;
        Tue, 15 Jun 2021 07:11:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm19897297wrf.51.2021.06.15.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:11:15 -0700 (PDT)
Message-Id: <5b942776bb0af2e5d697904a67d6d489bdaf6d2e.1623766273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
From:   "Felipe Contreras via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 14:11:09 +0000
Subject: [PATCH v3 1/4] doc: avoid using the gender of other people
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

Using gendered pronouns for an anonymous person applies a gender where
none is known and further excludes readers who do not use gendered
pronouns. Avoid such examples in the documentation by using "they" or
passive voice to avoid the need for a pronoun.

Inspired-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/SubmittingPatches | 5 ++---
 Documentation/git-push.txt      | 4 ++--
 Documentation/user-manual.txt   | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 55287d72e0ef..3e215f4d8085 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -373,9 +373,8 @@ If you like, you can put extra tags at the end:
 . `Acked-by:` says that the person who is more familiar with the area
   the patch attempts to modify liked the patch.
 . `Reviewed-by:`, unlike the other tags, can only be offered by the
-  reviewer and means that she is completely satisfied that the patch
-  is ready for application.  It is usually offered only after a
-  detailed review.
+  reviewers themselves when they are completely satisfied with the
+  patch after a detailed analysis.
 . `Tested-by:` is used to indicate that the person applied the patch
   and found it to have the desired effect.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c38790..2f25aa3a291b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -244,8 +244,8 @@ Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
 replace the history you originally published with the rebased history.
 If somebody else built on top of your original history while you are
-rebasing, the tip of the branch at the remote may advance with her
-commit, and blindly pushing with `--force` will lose her work.
+rebasing, the tip of the branch at the remote may advance with their
+commit, and blindly pushing with `--force` will lose their work.
 +
 This option allows you to say that you expect the history you are
 updating is what you rebased and want to replace. If the remote ref
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f9e54b867417..96240598e3f5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2792,7 +2792,7 @@ A fast-forward looks something like this:
 
 In some cases it is possible that the new head will *not* actually be
 a descendant of the old head.  For example, the developer may have
-realized she made a serious mistake, and decided to backtrack,
+realized a serious mistake was made and decided to backtrack,
 resulting in a situation like:
 
 ................................................
-- 
gitgitgadget

