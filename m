Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D21C63777
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 11:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A2822277
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 11:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJTm9U91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKTLzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTLze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 06:55:34 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E9C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 03:55:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a186so7316029wme.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3BPAJjztBU05UMTZFtwSEJ+EaGulxnYpdsqC2dPBfY=;
        b=tJTm9U91ZNOVJr4xNam6fPsQ+oHSskVFdVR050oNRy18s+6ayAZUHGEqLnijMLzLX+
         svlAMZybcT6B1NOWgVM5s8hDF2DKwEfxheV9SmYQx0hg5ymKXyJe3ZdwHdn9xsKUjn4Y
         BahFhj5gic83I30RsCxWhafo3MJc0R6oIi38b+VzRHE6UVTJrsyLIYJb8nQfO0B7Q9IL
         PhAbeIGwjSIF9iuK2Ld1wR9BrIeAwv4qkWTBQL/wMPVeAAjFGZCxWrJxnE8kdxc0F7p1
         Jm2+mV+TL0LTD9jmhKS4G1jRYBh6Zvx8naVxIzSmIzxm/T65AI1LZrDdVJO7J7MmF0Z6
         Ae6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3BPAJjztBU05UMTZFtwSEJ+EaGulxnYpdsqC2dPBfY=;
        b=WWrFrsB7Ryt14e1+gbsuD2OdMCp0RzgwS1CxT94DYyul6zYmuvl/jD4NoBnHTqcitF
         sYug4gK4+KreLCppebHY8xR7cU3LNN+XwmTUHI0vc6EIQK+oaD4vdZONBt7Xg3IBjZYZ
         FpC+2Vk1C59iSo8+rOOlvFaJMor2VB1OovEM8nUH4bsAimgW+3uFLoqTKHwrcqi0ebf9
         gDMzzPxPuDHtHndIlYX1XSnfWh1yCxCi63C4/coNkdSqiMmh6ZV5rVv2Lqg6vMpTj2Hw
         OCSNRFkS44gznJ2xu8duhSr+AlCHRPl+TzLsjysBq9NOuUyET42YOjGrbqCRcqm5nkRS
         rIdg==
X-Gm-Message-State: AOAM532fn84KSZ1n8bCSoAr2IAw0RjB3qmC8MCLPeEALX/DuOyWlFk87
        TSdQ1dIaV2CgdE/gpKob7K6Sw3Ppybk=
X-Google-Smtp-Source: ABdhPJySs8VJKbCIWubHMFPxONk8RqDd1T0NEVdr89BXmSW8gibS4LAOB5mpPhxGO1yzu1WueUO3+w==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr9778422wmh.110.1605873328047;
        Fri, 20 Nov 2020 03:55:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t7sm4773275wrp.26.2020.11.20.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:55:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] gc docs: change --keep-base-pack to --keep-largest-pack
Date:   Fri, 20 Nov 2020 12:55:21 +0100
Message-Id: <20201120115522.23617-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20200806214929.22qgjg3o2noosjuo@ltop.local>
References: <20200806214929.22qgjg3o2noosjuo@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --keep-base-pack option never existed in git.git. It was the name
for the --keep-largest-pack option in earlier revisions of that series
before it landed as ae4e89e549 ("gc: add --keep-largest-pack option",
2018-04-15).

The later patches in that series[1][2] weren't changed to also refer
to --keep-largest-pack, so we've had this reference to a nonexisting
option ever since the feature initially landed.

1. 55dfe13df9 ("gc: add gc.bigPackThreshold config", 2018-04-15)

2. 9806f5a7bf ("gc --auto: exclude base pack if not enough mem to
   "repack -ad"", 2018-04-15)

Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 00ea0a678e..c834e07991 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -44,9 +44,9 @@ gc.autoDetach::
 
 gc.bigPackThreshold::
 	If non-zero, all packs larger than this limit are kept when
-	`git gc` is run. This is very similar to `--keep-base-pack`
+	`git gc` is run. This is very similar to `--keep-largest-pack`
 	except that all packs that meet the threshold are kept, not
-	just the base pack. Defaults to zero. Common unit suffixes of
+	just the largest pack. Defaults to zero. Common unit suffixes of
 	'k', 'm', or 'g' are supported.
 +
 Note that if the number of kept packs is more than gc.autoPackLimit,
@@ -57,7 +57,7 @@ gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 If the amount of memory estimated for `git repack` to run smoothly is
 not available and `gc.bigPackThreshold` is not set, the largest pack
 will also be excluded (this is the equivalent of running `git gc` with
-`--keep-base-pack`).
+`--keep-largest-pack`).
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
-- 
2.29.2.222.g5d2a92d10f8

