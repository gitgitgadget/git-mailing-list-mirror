Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B516FC433E1
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CBE206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Xx9jtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgGICQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGICQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3DC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so259755wme.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3L/G/1HbnzRiHFbeCXvolzkf89dVtY6giZOrHT6+ipc=;
        b=l1Xx9jtjedwXZdl1SJ6DJtr+8e9qICkETKonFrTAbQkw9zTrH8G6rekM2u1yHjIUxQ
         qhBBP3lhKiZ6YuWWfi98dE90wZm86aprL9ilQ2MzjnHv1ywtFliAHzJuvb5z/bu+KBQc
         jOl2MolknmpwqiWwv/D7nvGP/6jH+VnDAmhp7g7MIxwsGdrfdw10KPSRTGGoK6oATb2Z
         pACcAfj2vom/L0F/MsUNQd8r8moEnsBawxYMQl3mZt758PSCD3uqjThX8kP8Ho/0kvwz
         B/BBsJKPjKIqxpaqQhwolFm/Ax78/1v6+k6uf5Q4ADQ5iiDRf37BqtKX1tBkSye1C6jZ
         S00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3L/G/1HbnzRiHFbeCXvolzkf89dVtY6giZOrHT6+ipc=;
        b=RsHHia3BU9uDsa+AHqoiE70I9PXzTmUlTRWiaIVxm9a6sjZ6vI3j/JfSAeGPI/ap4O
         sGj1X8nSfn9fCgUiw+2cUGa6Zcpvydzw541ahOXQcOS/4Ta6DV/R2WqZ4ZZtStB5H6hD
         m1ejsetNzaioYcP6anARR+gcX4zHGSA7eLXbIYLldJeYmW41ztNashkeebeItKuux9ZH
         VEK/aCLI8wYlA4RZLlrfeLboG9xCHErjevpeeeOF1Y9IXZQOkKrWyRBqQoj3nViuvOSp
         s+iFMKEf7T/TTqKALDTp8XlpSkXb7EwGN3f3MFW54OcsTbpRFkrco26QlZAaeAWlQb5L
         D6lw==
X-Gm-Message-State: AOAM531Iff82aCwrEIbRqZGmRSTzuKgabmp/IQ4n4myf59hdoZ9l2SAy
        +vxwraPkrSlRiSpTHbHbkoPUUZVk
X-Google-Smtp-Source: ABdhPJwBm8IzlDvE0AQrCLnQ4XRLl6sNX7U/1KXHP+Fi8TOJMLOKGICwVq/GZxCZOL0ZULS0RTz9+w==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr11701091wmz.124.1594261010456;
        Wed, 08 Jul 2020 19:16:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm3278481wrn.18.2020.07.08.19.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:49 -0700 (PDT)
Message-Id: <59027b0f6a420f4614a072c9c533c826669d3e0b.1594261008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:43 +0000
Subject: [PATCH v3 1/6] git-log.txt: add links to 'rev-list' and 'diff' docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add links to the documentation for `git rev-list` and `git diff`
instead of simply mentioning them, to make it easier for readers to reach
these documentation pages. Let's link to `git diff` as this is the
porcelain command, and the rest of the family (`diff-index`, `diff-tree` and
`diff-files`) are mentioned in the "Raw output format" section of the
`git diff` documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e6d21a74..0fcaf34d62 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -15,9 +15,9 @@ DESCRIPTION
 -----------
 Shows the commit logs.
 
-The command takes options applicable to the `git rev-list`
+The command takes options applicable to the linkgit:git-rev-list[1]
 command to control what is shown and how, and options applicable to
-the `git diff-*` commands to control how the changes
+the linkgit:git-diff[1] command to control how the changes
 each commit introduces are shown.
 
 
-- 
gitgitgadget

