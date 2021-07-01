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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9474C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32E661414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhGAOuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhGAOuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF9C0613DB
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v5so8607558wrt.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g237GL0OfwbXvqxmbpOXauDHEgil7enRJ/PKcAc4nOc=;
        b=mZdWxdjSbllHDphsmXNYE17R236n/eofGPJP/f1wyV94oqAKb6/TQKJr4I0QHNUKVe
         SRISQiFi7heWk1aEg+rR+4+e5SgrQIxtMvpT21kxIPKQBtE0hT4HbWVE8XzdsdRLkLJD
         KcOjD5BKxBEY8+xQe3kZaAnIEMWhU0I/ctztHyTn9eDdX9TQ/tCxzLdvadNCnwnIO2ac
         ylX4wno3L8fmwL7RQfexEUW76jsoi9WZOmvbN2VxSWuTTlYl4TPFoyBhV3TbfNlXVXEQ
         O98jMVrr1QT1zy89d50ZFQfz2pn82pVRQOXhnOAbGNl0XXX7XiR4NFz16C4o0ywKEIOk
         kdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g237GL0OfwbXvqxmbpOXauDHEgil7enRJ/PKcAc4nOc=;
        b=hQalvMCosHBWDxFK/2jjYFclrLmGIN7wnLdXPEWJ/xr3yVfSlXvPsha6gD3MDK/AU+
         ruNBrShaTEh+ALsFgMc7TRjgOLMt6XQHAB+4qGJwYhpAqELS1GHKu3hikJA8wmmpQxSm
         ELAbXzlCC45xjBYgUbfpo2WuMV9p7iWTidRhL+Ldus8fZbkZiu99M3+WY0kZk4mUNjlj
         rUD/Ep54hkUa3C7/EEFmlh2v5Yc39AV1G9yMriG4uOKf2J4c28uHzdXAhzOvPxt1IbZr
         qAf+h+LtcpIKNvyhyjp34HJ728LXGlZons4lUHboz2RO64lUbF/+fx0TlpqHfM5S06gX
         Woxg==
X-Gm-Message-State: AOAM532GSmxR/NkVqA5qX5Aafy7YWj2fOqfYSDkWF0oiAHHOi6XuxWsV
        wcmiFUrAZR+zzSmcwaLUVkytNHmUuOs=
X-Google-Smtp-Source: ABdhPJy3d5+oqzH1zCxe0J2YGlduSmVRk7BDvcP6F+RwkMoh2v8sQ0IC3EvC8guS6bbTVdTOEpvIIQ==
X-Received: by 2002:a05:6000:1361:: with SMTP id q1mr23492789wrz.179.1625150880096;
        Thu, 01 Jul 2021 07:48:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm201663wmi.47.2021.07.01.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:59 -0700 (PDT)
Message-Id: <a83485fb10f57326a725579f329b73ebf9240ac6.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:35 +0000
Subject: [PATCH v3 25/34] t/perf: avoid copying builtin fsmonitor files into
 test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Do not try to copy a fsmonitor--daemon socket from the current
development directory into the test trash directory.

When we run the perf suite without an explicit source repo set,
we copy of the current $GIT_DIR into the test trash directory.
Unix domain sockets cannot be copied in that manner, so the test
setup fails.

Additionally, omit any other fsmonitor--daemon temp files inside
the $GIT_DIR directory.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 601d9f67ddb..3b97e3fc0f2 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -74,7 +74,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
gitgitgadget

