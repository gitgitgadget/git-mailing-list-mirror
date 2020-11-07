Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC6AC388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 22:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4759820719
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 22:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBKXtIaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgKGWVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 17:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGWVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 17:21:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A44C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 14:21:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i6so7006802lfd.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwUxUds5XbYeJW0xsqQlEqlMvd+w57cmd6TE9nmupFs=;
        b=eBKXtIaTkjWh8lzw04rhQ5RH8h/lYzKKZWWfeqAOyeKBjmfqfAEKU7gZFpqIgIa5WB
         ONoWwQaCCTI18Eq0jNvSgCwJuXc32AiT4bpAdzOR02xAIP4xreGLGTBrc6ORliZOWlX8
         dHtBbuhFuJ4GLPTQpb8vLZjm+INDgQCKQ5cUDRZc3r+58UHvkT4Olb4YUD+Mt+wZinFf
         QyBZNupQC8r+dc35MyMrV91HTPGhwub1NCdB4u8IzkwAh83vwsBVhH1L/CW+8lx2IglN
         eQlfoI0Sjb36fkYN9zhNhKetJjvLpPcoQoF3JNBp1aaYVLyAoWamy1NutYsvQ+xIzxb4
         l/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwUxUds5XbYeJW0xsqQlEqlMvd+w57cmd6TE9nmupFs=;
        b=o5FxaHBfVBpMjWbxQ64+dgdXhbXkUIwlJHLA0OYaVlY0K6pUU+PsAR/e8cpTcEWP0r
         5ZX+eL1bi9ptSFp4Av/A0HzChjwSSHLnRDHQvQbGZYJcffr5gUFjzT0lhj8vk2e3GuAH
         Btk9hCaD3gk4ywq4kkJ3GLszKQ65ApH16Oa9zkXWautK65dnoCeSGA9HZ+CCtzl2niS+
         LHqg5SvsQHVVO973DZfpufZHKXxkkbTX2UWV2XRcS6oILaGUHRUFBO9giGfaTei4HMZY
         wfhGkjcixtkSDXDJ+mCkISw41EtwJ1bvva/pbleQwgzc3A9VnaiNeyhTa5k1iUnKo+Oa
         3MQw==
X-Gm-Message-State: AOAM531Ay66RsWLnSKQdK01+PKHnragEQ+73arvLmQPLQfE3HXGBe2LJ
        +Djre54POY2FMon7wzNzsFhFMNFvPgY=
X-Google-Smtp-Source: ABdhPJyldwSeBvH1uTBl4YgIoeQ27IoeSnPm/yK7Lvdk0ySEuTar2wvuhwKz32ctQwB06eKE00aR4w==
X-Received: by 2002:ac2:41da:: with SMTP id d26mr2802581lfi.233.1604787696021;
        Sat, 07 Nov 2020 14:21:36 -0800 (PST)
Received: from desktop.lan.gurney.dev ([185.204.1.184])
        by smtp.gmail.com with ESMTPSA id c22sm741613lfm.45.2020.11.07.14.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 14:21:35 -0800 (PST)
From:   Daniel Gurney <dgurney99@gmail.com>
To:     git@vger.kernel.org
Cc:     Daniel Gurney <dgurney99@gmail.com>
Subject: [PATCH] compat/bswap.h: detect ARM64 when using MSVC
Date:   Sun,  8 Nov 2020 00:19:16 +0200
Message-Id: <20201107221916.1428757-1-dgurney99@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
---
 compat/bswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index c0bb744adc..512f6f4b99 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 }
 #endif
 
-#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
+#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined(_M_ARM64))
 
 #include <stdlib.h>
 
-- 
2.29.2

