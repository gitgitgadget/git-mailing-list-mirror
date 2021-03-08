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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA02C43381
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B5E6521F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhCHPHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCHPHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C5C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l11so8416769wrp.7
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8SJpdZXvhjz3KvI81hs3I4U3avYYllXpPlcxHz3RtI=;
        b=lYR/GbWGX97K1X5Xi9DMZ+/GyflxR02ewqQ7w0D28sCr5SpVAROh1RcMKhROWBz/6H
         9y/utZytnLlM6nLcFX0CzWK5BKM/KK9oYyOoZYyZQfbERqHty9WMmeY4nOTbebZGGGwN
         rbPTbs9RTslQB+5ZRqq/LwUN3HCSglPfiGdQAM3hPRsrbRIBWO7+C3mzfJFMbwIs0mFK
         DjZlT/dMFSN0/id5hBhaCM9k48lcrR6I2qTBBo460B61KymrPorPPVPKUdlpLRcmFxUs
         4PHjjpGOpqy54spwd1jZTTr/q27b1SQmww21K5u+6azpz5EVqeo3CxWxqjASgVVwT+Pe
         vUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8SJpdZXvhjz3KvI81hs3I4U3avYYllXpPlcxHz3RtI=;
        b=Cs4FnebqoNF7GvD7QEkfezdRYAOXA8XP9cvX8GPfbf25WaBkD0wYIuuNg5PGW0E6g0
         YHrlHt6k2LixVzvMGjoeX6FbFFYLpkSxTt8kWy75nZ5Tiop6xMNkBMzYYyx51BgzTQwp
         jsEyc8il4r2JBkTaB1yfsRaX2FTLZl/Ojp431q+WI0QyIy0RHNjg2d6FSzhFeVScksu7
         nrQCVrgTAdgZo/FqEfCjld4AOxx+5mzldBCZPpLhDJsZP6hqiDUow7x4hPbKp5uAuIHF
         /z3MqRxan0KvR3i4vRlOcBquJ9V84SBGXa/K2xDvuRVyjukf4CloJ/HY3b7P7QuXGXXC
         yfyg==
X-Gm-Message-State: AOAM533ZB0pkaB+CTmIAHWGKuwPyhGEfGtYEU5hIN2UA8123F4osvQI7
        g3+RhK3OadH4Qcg+EUMc3MesuLmEoT+MwQ==
X-Google-Smtp-Source: ABdhPJxTE9G1rcGb3BFxAbn0+rMcXWVldyYUsk8j+8hSjqKUlO1D/aRgrcy8ElQ+p+K1pwO0ILkDHg==
X-Received: by 2002:adf:8341:: with SMTP id 59mr22552012wrd.130.1615216029663;
        Mon, 08 Mar 2021 07:07:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/30] diff.c: remove redundant canon_mode() call
Date:   Mon,  8 Mar 2021 16:06:21 +0100
Message-Id: <20210308150650.18626-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a call to canon_mode() from fill_filespec(). This has been
redundant since the tree-walk.c API supplies it pre-canonicalized
since 7146e66f086 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06).

This call to the predecessor of canon_mode() was added back in
4130b995719 ([PATCH] Diff updates to express type changes,
2005-05-26).

This was the only such call in the codebase. The rest are all either
one of these sorts of forms:

    canon_mode(st.st_mode); /* a stat(2) struct */
    canon_mode(S_IFREG | 0644) /* A compile-time literal */

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 6956f5e335c..bf46e6a4d8c 100644
--- a/diff.c
+++ b/diff.c
@@ -3846,7 +3846,7 @@ void fill_filespec(struct diff_filespec *spec, const struct object_id *oid,
 		   int oid_valid, unsigned short mode)
 {
 	if (mode) {
-		spec->mode = canon_mode(mode);
+		spec->mode = mode;
 		oidcpy(&spec->oid, oid);
 		spec->oid_valid = oid_valid;
 	}
-- 
2.31.0.rc0.126.g04f22c5b82

