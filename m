Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26F7C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbhLVD77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbhLVD7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFCC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so2045481wrg.7
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNiXDWMrDZB2xAvAJhT6o2OGXyA2gfFIOenjoHoWt/Q=;
        b=lKFAwwHX83Bw12bd7a2TxAZSzypfwuzX7JiG2tX9N4vtPDSvcK5JdZscntqtuth42n
         VeVfXNtI2GdXrGhPT1BRxXfuY6SSGmlkg8YKwvfUtNMA+W9OanX2UWHAnuDaXRSKYKTE
         k1KIPQvS3mDWCMcZ++6KVwDG0olL+PpDxwIFpWMkd6asUtYllRltZsobRafrgdGDGzcz
         7haW8yk6MuZ2lLAUpd7wYwrb5cLMJYFaTqBieRYVeDe9tWT6vc0KHF+SLfDsB92y7VMq
         zi9inJsb10fMEuGs+cW5icMrztbeHepGBKdTWKPo5QkedkB1amZyui+6iT6x3uu2/TNP
         SUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNiXDWMrDZB2xAvAJhT6o2OGXyA2gfFIOenjoHoWt/Q=;
        b=DKHrVjtHUb8onSG7IEuRn6CCo28F5fohrNKIL7o7xf0gZLpKh/75uCk4+0kxmfSA9s
         w9WB0v+MCS7+GdSSUiqZehqXtzMtj53ilSpZXal9UTYPj1VqK0jmYvcjCUBfTi/5s6fp
         TW8UUeRjqkR85jFnCg8AZ56q5oYjIY+IL8jDLqRzgdUjOLjhDxG6SyzME7PayWpgmxfZ
         GmpbUSccfiTeKMWPAhjEXkF7V/NBBO8tYoTAsmFM3k2hh7NmpO6PX8Bn2KTJJS+NUl5c
         HtgC5329Wa4qkVPdy2kj5zmlmwsJt0jdanY0Zr0OGjkbY6MnOI6e+2uRd7oZmoMpwSAJ
         F0zw==
X-Gm-Message-State: AOAM533G4YPyDLYEIis21C7DNbfn0hUtebmzCCxXRu/suGl9iUvOoJge
        DAF/SucPbuWW5N28AcXAeLyAWtzrg9e5Lw==
X-Google-Smtp-Source: ABdhPJyDCYNPcbtgVjkKS6n7dX6IZjMNT5jFfMfqgYSqcibIlBiNdPE1p/zfxRAhQQM4F/lDFluJbA==
X-Received: by 2002:a05:6000:2cc:: with SMTP id o12mr734386wry.285.1640145592523;
        Tue, 21 Dec 2021 19:59:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/17] am: convert applypatch-msg to use hook.h
Date:   Wed, 22 Dec 2021 04:59:33 +0100
Message-Id: <patch-v6-07.17-d8aa5e8345f-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach applypatch-msg to use the hook.h library instead of the
run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4b334cb7b12..ae0c484dcba 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -448,7 +448,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	int ret;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
-- 
2.34.1.1146.gb52885e7c44

