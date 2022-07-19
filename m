Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1740C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiGSUr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiGSUrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4315A158
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso65780wma.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5nxvkuN3oqIJ/kb812f25Ausc7XySjLn688Faz9qZs=;
        b=IF7Tn4BUoxLEPqAWTHpd0tHv9v/NxPqcO07zI5dO8QzaKJ6NeUT7mFlRYT9PjY9BrL
         SPMrdGZ/D+qiUkeVmVRbCEtM9EeYrTkNSjXZBqgfRe6h/v+LhHoe8Y8CyzYU6tSC58nz
         M+wnabyrlygYXXG27hgz07jUWrIkC/UjLPjT85laWE1/6Z3Tkz1Zkac4CmxlRwIa85zV
         dkRtiQ/H18abwsIXhBpw0D/TsY99CITPTvsw+N70IV00nv7KKep75k0a25Z9vagWZeT/
         K47jAQiLmkz+vlt1HUNCwwzGzWhP2Gqd1p1tGNRE7ws1NSyzKdaHJUBcOJOQI9TGAUfJ
         deUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5nxvkuN3oqIJ/kb812f25Ausc7XySjLn688Faz9qZs=;
        b=WJgs8Jr31QA4n4dJ6fUP+57mnrscrxDMfwfQ9Rp9B5jnXdz02znp1Z7NkN43tClF5W
         C9/EHQPR7RyJ9exquPQcrpq0r3oJl9sxtNxdmiFsvus8CgKIh610KK0ZRt9sXugnSuQg
         TzUwdiUxpXRyMSOq2uwmJkFKvV5KkcdMksdYh1RBcSUy9h+yTSSc8OnoD+OGRGY0MIkI
         r7Y7caYlNtnoPk4hdCCzvwaG1KpZXtyGOcQkZSkKS0FnvYrSndlfAYzyVsLZAPS+uhNk
         jG2YcFQlSp2yQ9jaNrZBRAbD2ySKeRVgR4ir3i9kRv01sc6Df5BI+u984Bx+fMqTGOPR
         /YYQ==
X-Gm-Message-State: AJIora+OFr81ESeR9jcuZSzBc1onPTu75tvZlO+LoYq0nL3T70wT40KR
        SsaOLFyyJQIrBoUeaIUGXHqo1NMDHTohFQ==
X-Google-Smtp-Source: AGRyM1twTqjkxV+szw/C8OZ7PRVdVQixRF6CokKZgCvkJ/x+Ddcmih16hc41/sksPIZjJ5CvaUNHKw==
X-Received: by 2002:a05:600c:1f16:b0:3a3:214c:a85e with SMTP id bd22-20020a05600c1f1600b003a3214ca85emr876121wmb.95.1658263656656;
        Tue, 19 Jul 2022 13:47:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/24] submodule--helper: fix a leak with repo_clear()
Date:   Tue, 19 Jul 2022 22:47:03 +0200
Message-Id: <patch-v2-12.24-303447bd4f5-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a95231b1698..339ba94e658 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2457,6 +2457,7 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+	repo_clear(&subrepo);
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
-- 
2.37.1.1062.g385eac7fccf

