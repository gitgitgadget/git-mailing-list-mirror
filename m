Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF7EC6FA86
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiIEI1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiIEI1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5152AF8
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b5so10289596wrr.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X3H7KrwZE8gmn56H0fSdaWl2UXhGFLu6B4Sfs1Ye2aY=;
        b=mXXKoBu8/9GnsLSf55CxlN8JSU0bvs4vXPiYZ2AA13D+KO5JNkpmoJ+JRu32RKuJz1
         k4Q6pGTLDEIdsimJVZpONZX5edoZqdDMTJkQBrQJhD3tyz//3GYzki1ccbv9nw3zrrKS
         mTf8Qc0f+6xizvsXeuPIPtvWvaYC3HMbDngBOPWmUkHdhppqdYiNlUCA3Ouke3rlKRxV
         UFW9VKctIamaPZoyameDJaBqOLFntvm5YQ4n5KN3ds5GXLr7CPJJpSNnshXeBqaxFTdY
         63XVl8/s1z1zT0TNVUOYI+iJSkLX64GQVWZv80RzJSezF4TM+pPtmcd+faUjLwWwflPD
         W+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X3H7KrwZE8gmn56H0fSdaWl2UXhGFLu6B4Sfs1Ye2aY=;
        b=wi01CuY3qHPL6Sd678krnuwnOgu25xhLoMbvfjLYM7tNb5O5/2jl7vrPmErgcvkSwe
         hbRsPO9IEowBqhRiXvHiw80a7IOdVcKjCWmoOqTuryhG1wf9Xj3OuAl/61aZmNdHnqHz
         Inrwql1TjROweKZNdWVw+35bZlHwFfFBH3qiBPqyrU6dcX3tDWm9s66ws9zq8dwAMaaR
         75OFLXlvNpKAnbqL+bz9v2o17L7YWgRniT1/q/NZjk/Q+y8vPZ3ixqSl3l4yKY1l3G3R
         0kPDgdXSdhwOY8HOHNiQ7bgr8RHHAub+y6vfPCvfUk/phV2n3gfxPfKVH8Y8zSAZOnPV
         0UrA==
X-Gm-Message-State: ACgBeo04PffM1c0kEYhejDSfly4YU8RMJM7QwdRJBIAjGr7eXigr00HQ
        g+vLKRIILefjdrlzDccnLKm8Kv/EWICwJw==
X-Google-Smtp-Source: AA6agR6M4R7cUjMCTyQqZaDlsx7qPy4mzB5eXxCiB2BWul9fbGMrN9tOyEdiUe721rtr/W5jcDQ95w==
X-Received: by 2002:a5d:6e8c:0:b0:225:5f3f:1d8f with SMTP id k12-20020a5d6e8c000000b002255f3f1d8fmr25169090wrz.610.1662366422093;
        Mon, 05 Sep 2022 01:27:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/34] doc txt & -h consistency: add "-z" to cat-file "-h"
Date:   Mon,  5 Sep 2022 10:26:22 +0200
Message-Id: <patch-11.34-698d8d3d53a-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in db9d67f2e9c (builtin/cat-file.c: support NUL-delimited
input with `-z`, 2022-07-22), before that change the SYNOPSIS and "-h"
output were the same, but not afterwards.

That change followed a similar earlier divergence in
473fa2df08d (Documentation: add --batch-command to cat-file synopsis,
2022-04-07). Subsequent commits will fix this sort of thing more
systematically, but let's fix this one as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4c..fa7bd891692 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -893,7 +893,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters]"),
+		   "             [--textconv | --filters] [-z]"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
-- 
2.37.3.1425.g73df845bcb2

