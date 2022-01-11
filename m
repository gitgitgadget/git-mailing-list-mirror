Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58491C433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbiAKSGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350372AbiAKSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:05:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1171BC0611FD
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so1957481wmo.5
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Y1eVqZYE9BacgGrfH4O//tMC0Ck7M/KSJNB61BWioo=;
        b=pioMxZbNGIHOkCxbOVZM3K2/VJT+078LZQKTvtnpAKfV6veQ5CW4pjdPhgqr/Zva15
         9AZ0Ckru5Q2rCiXyBreScJQtNsEOwQis4GYNfPyhjcw5fy29guzxzyGdf5MgKH1Q/PXW
         NvWodsQimOcxOXI//TKWouH9DnsQQrG5FalpmYEsb3snuq3kSaAAIo2EJK1yx9NzfgOA
         TMI1b+ObBb8d92DC+GHZ0KkOj4H3ZAWac/QTigRAq0KNTLPm8aZB44z72Q/RZh4sT/Sp
         VHygh8qV9t8Z81vbNdqHOQiY9pPxpPGkaRGDoNyC7F3EyqYxVwpjvFX01wxApCPbYjR0
         L87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Y1eVqZYE9BacgGrfH4O//tMC0Ck7M/KSJNB61BWioo=;
        b=iHxO46xiZO6hP3hv7JjQyJgrbwuivNKol2oLd0kTDKTRUQrRMnYa2O0TZykY2pJUC3
         XGM+8nvI3MUcsPQnOpNrf3CfFJK38HdrWNMVcCnu0Ehisyz4gbxHXZ38HEH6v7FrINQ3
         X6c86joRICrzpSC6sEClKX1duJXK/obiYC2i0iHj9VV+IAtVpTbXPlhXputJuc5txJ7Y
         KHRrBNCS/DNnbQrsKinVjcE1kU67lN0n7eEphB6W2LPdCfDad7kMYLvMHcg5tFE4iwFB
         PLxbMMB0AC3dMeRTs2+FZrEGckYhZZb1B3a7sun4K1X1ps5x44Cme2Q2E17JK3tg+Cgk
         07UA==
X-Gm-Message-State: AOAM532f1+cUgWHQfe1lHTgrMC6oIvrVSZa/TUZQqN/VdW8N5dzsRga/
        tcsSF54YrRkx8HUfWWsV3x8qGyGB4Wc=
X-Google-Smtp-Source: ABdhPJze9Q3OHMaK+c+Ie7PTta1y9AJu/go8pcHM39TX+kmeUwkvU1uGSPQ8QPial0vnSBr+OjQLLQ==
X-Received: by 2002:a7b:c00d:: with SMTP id c13mr3521893wmb.128.1641924311449;
        Tue, 11 Jan 2022 10:05:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm2373848wms.43.2022.01.11.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:11 -0800 (PST)
Message-Id: <0194d894c2f9c5ae4bbaac4cd6fca89933a04789.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:04:59 +0000
Subject: [PATCH v2 2/9] reset: reorder wildcard pathspec conditions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rearrange conditions in method determining whether index expansion is
necessary when a pathspec is specified for `git reset`, placing less
expensive condition first. Additionally, add details & examples to related
code comments to help with readability.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index b1ff699b43a..79b40385b99 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -204,10 +204,16 @@ static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
 			/*
 			 * Special case: if the pattern is a path inside the cone
 			 * followed by only wildcards, the pattern cannot match
-			 * partial sparse directories, so we don't expand the index.
+			 * partial sparse directories, so we know we don't need to
+			 * expand the index.
+			 *
+			 * Examples:
+			 * - in-cone/foo***: doesn't need expanded index
+			 * - not-in-cone/bar*: may need expanded index
+			 * - **.c: may need expanded index
 			 */
-			if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
-			    strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
+			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
+			    path_in_cone_mode_sparse_checkout(item.original, &the_index))
 				continue;
 
 			for (pos = 0; pos < active_nr; pos++) {
-- 
gitgitgadget

