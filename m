Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA65FC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867FE206FA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvNOgb7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgIAUTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgIAUTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 16:19:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC78C061246
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 13:19:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c18so2898435wrm.9
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9jb40Gp76eexJeMaf5rCu91lOnGbcHdsXaHvdA6AtYs=;
        b=IvNOgb7v+rkVA1UaDjglTf1rRUQnSO5AAi+RyXgSVT/S7X2CjaYl89KPAxTbcZAy/k
         C4xeAFqcGi60IJFTsp6Kgk3BcBE3lzKfn4UoVBLPv0ZR3he4TuVvqbaE0F+Likz7sgEL
         7pvxOm6YCnUyVXVJGXsDkpul7asB3lyj/aEkShFlsD/EZZyNbKXJkoI7m8iuQqhNfYiK
         Dz+17njvr0/kS/6cruUF006F22WU8t/6QzyA+fRX1rxcapO4UOZFoK66Ka87l0Ld3eda
         kZz7/VNrSxjKfIxqz/xy5ZxxusNCk3V9cl0JE8JZ1lmCjZbNAlRx29tLml/5R9qZok3s
         NETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9jb40Gp76eexJeMaf5rCu91lOnGbcHdsXaHvdA6AtYs=;
        b=LLUBC08J9LZh3H0gZBm+ALbOo4hZlxjZgzcLOHDy0pDUIBiIz+ecOGNIsvBWYV7ooi
         sAI+M2ScXzV1oUippRK5IiKVL396RFgd85zWPpWSPyMzIM0AyURchtenNZ2mlmab1Jwt
         2ai7t6Extum1DEtOjl5BmrmjO5s/HbgCDUs5vazCI+2bYjKv4NX3cXXTRDCBRXdHbLu9
         w7MEDMA1+vLfkZTiVB/0ymPj6dXKgVCL5p5of3cmN4iUCf08o3RJPJVnsZ6Tahjx13Iz
         k/ZM29gK5wtEGT8Ohh7Nv/varhzwkQNrlN53/werCbF3RD5wr3WWLRz2ZDPGOSVEyXxN
         f0rg==
X-Gm-Message-State: AOAM530TSceJRx5m9/nTSsJgqftewiHSDJ7Ghg7AGc5P2j0AC8K7Wzzv
        WPf5BLzVpW0Kj5+Ni/Zeq9lAdNBZBs8=
X-Google-Smtp-Source: ABdhPJwHxNDn9DRBauKJ+QTZt22OWtElS2qd3vlhrbOzEf9eWlg7j/56WNxkRhnb8RZR6vKZQolF3w==
X-Received: by 2002:adf:fbc7:: with SMTP id d7mr3715041wrs.208.1598991570891;
        Tue, 01 Sep 2020 13:19:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm3204498wmn.24.2020.09.01.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:19:30 -0700 (PDT)
Message-Id: <b92374e69192d57bcb11fb2573beb4e9aee339a9.1598991568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.719.git.1598991568.gitgitgadget@gmail.com>
References: <pull.719.git.1598991568.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Sep 2020 20:19:27 +0000
Subject: [PATCH 2/2] ci: avoid ugly "failure" in the `ci-config` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the common case where users have _not_ pushed a `ci-config` branch to
configure which branches should be included in the GitHub workflow runs,
there is a big fat ugly annotation about a failure in the run's log:

	X Check failure on line 1 in .github

	  @github-actions github-actions / ci-config

	  .github#L1

	  Process completed with exit code 128.

The reason is that the `ci-config` job tries to clone that `ci-config`
branch, and even if it is configured to continue on error, the
annotation is displayed, and it is distracting.

Let's just handle this on the shell script level, so that the job's step
is not marked as a failure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6fd1d1a2c8..fcfd138ff1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -12,7 +12,6 @@ jobs:
       enabled: ${{ steps.check-ref.outputs.enabled }}
     steps:
       - name: try to clone ci-config branch
-        continue-on-error: true
         run: |
           git -c protocol.version=2 clone \
             --no-tags \
@@ -24,7 +23,7 @@ jobs:
             https://github.com/${{ github.repository }} \
             config-repo &&
           cd config-repo &&
-          git checkout HEAD -- ci/config
+          git checkout HEAD -- ci/config || : ignore
       - id: check-ref
         name: check whether CI is enabled for ref
         run: |
-- 
gitgitgadget
