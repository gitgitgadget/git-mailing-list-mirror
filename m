Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B64C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347618AbiFCSjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbiFCSjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBAB13F25
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a10so1971900wmj.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsGsuBMAovNiuP7QvF/Ok9NhvF1e7/FuNyYcE1xH5c8=;
        b=fzkKvqypsnpagZsCUDONwdSltPPrg6dFUBTlLU8TbqI+oHeb4Td9ysgERKR3Plk5/j
         ddMCwDPmFTEhYcWSniXTfKuIqHtr6UYdXk0cK9LLCM7MknnAS8yocBFQOu9VBqN9XH0D
         6dB6WNopxulrIrHf817wts4sAe9aEnrGStTZLyTMbh7oG8Ikz4zic7Fbcf5EPuRbw8CO
         4mKKnlL0LLK/N/nEVgALwMxmdN/uQfRrYJHQVnQRZRgbn8YPV+AzHAZMEwmTqkVC2WV7
         +bkQ3pqxDXqcc4ZrysWDEHOBmu49BzzTV+HjbuRH0TWcMMZ8NF2hxWgUVO1z2ZXjmBt5
         3M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsGsuBMAovNiuP7QvF/Ok9NhvF1e7/FuNyYcE1xH5c8=;
        b=A9RrIGlIXoibvaVclZA8YWDHYsANBR++ttlXlBZQtzi82E6vq/bKygEeVFzP7CGkaI
         Bi7IxNOG0+257/Nmdocustx8kp+BG0fuky77fTr3X7mTrVW5oEWQlI/IS3bt1ISJuyL0
         /4JrsDXN/HooxS3KRhQxe9hL95cZDrH51f87dOCEl8ignXU1LfxN6mNo+q0ELOh9iPxx
         ESd/M9I/t6ibNlodqbZZgPURKMrNNuPokfCuBNAwEmtq/CCva/oB1VKjLp6QGD5fvEp5
         IZMOSKg9+FFo9pY4a6m/skyOWksOrKvt2s2bGpj11MFofK7u4Os8TJPzaohjZaalRxmO
         JifQ==
X-Gm-Message-State: AOAM530KmtXoPTwdsFkFquIJrs30D/8fxQ+w59ESi/YY1F5gwProfvN4
        OGHjcOS2d6l/mOv+YFEj1sAb8uKRFqJZ/A==
X-Google-Smtp-Source: ABdhPJxbXUPpfcHRU6sg+TCKYtOBqfaH20luHy5258b12+OaROiRrdmkTg/0F7p9sUEIg62Niez1KA==
X-Received: by 2002:a05:600c:502a:b0:397:44d1:d5b6 with SMTP id n42-20020a05600c502a00b0039744d1d5b6mr10073458wmr.57.1654281489148;
        Fri, 03 Jun 2022 11:38:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 09/15] add-patch: assert parse_diff() expectations with BUG()
Date:   Fri,  3 Jun 2022 20:37:46 +0200
Message-Id: <RFC-patch-09.15-de0f7722608-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert that this code added in [1], [2] and other related commits
expects that once we see a "diff " line we should have a non-NULL
"file_diff" and "hunk".

In practice this would have always been the case, as we are parsing
our own "diff" output, but e.g. GCC v12's -fanalyzer doesn't know
that, and will alert us that in the "else if" and below in this
function we could be dereferencing NULL if we were processing anything
except our expected input.

1. f6aa7ecc343 (built-in add -i: start implementing the `patch`
   functionality in C, 2019-12-13)
2. 80399aec5ab (built-in add -p: support multi-file diffs, 2019-12-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-patch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 55d719f7845..087bf317b07 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -478,11 +478,16 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	while (p != pend) {
 		char *eol = memchr(p, '\n', pend - p);
 		const char *deleted = NULL, *mode_change = NULL;
+		const char *const diff_l = "diff ";
+		int is_diff_line = starts_with(p, diff_l);
 
 		if (!eol)
 			eol = pend;
 
-		if (starts_with(p, "diff ")) {
+		if (!is_diff_line && (!file_diff || !hunk))
+			BUG("expected '%s' line to follow a '%s' line", p, diff_l);
+
+		if (is_diff_line) {
 			complete_file(marker, hunk);
 			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
 				   file_diff_alloc);
-- 
2.36.1.1124.g577fa9c2ebd

