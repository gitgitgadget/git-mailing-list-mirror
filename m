Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3892EC6FA8B
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiITB4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiITBzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E024BA4C
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g2so750730qkk.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=HuHQrm4K0Ly/hpg6asg4LEieBDD/6icpRzjMT0riij0=;
        b=M+n99uy5vZfzscM1JoD1O0dzvzrBgjss7IT2g+NmCC6gxcUOlcv2DV278GEE/fT1/F
         x4Fm/39wg8hhv7sZL8xphTVp95cRjQp8CKNe+ZVvPOkiY+utTitJW5i4jnYkSgGS8bAj
         oLMFULLU0lKx47rwmpJdH8mmimZkq1rm+41FIknYiRI0fQhU5ceX+7KXzAiD25r4eVAZ
         OlSOL61eA4RvaMoveio7U+2gN/zJNsITWTn56wJc0OKs41oq+so5AUPo6JnJo6uLXC3q
         c6vOqy4oUyHyvMEkX0al6KNfWep4QhGKn+fdpuywI+pAdB4HMn7JvXt7bx/SX9NVJ5Z6
         DYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HuHQrm4K0Ly/hpg6asg4LEieBDD/6icpRzjMT0riij0=;
        b=MleqiaxYm1lhZue3ZJP0rhYYdvvDGB6tUuVe2yYNXCrbXC7/a3YE7ykRhVTpTS+tEn
         2Sly/Bn0HMfVoy3YKu/Ceyqoc1RWFIhjoogsYaS6GWPphrcU7D5xgrxSz7JbPsRrq8aF
         I2/7gggY0TMS5LkqeNiuoOx2whhVxP0ORZbrUpMDFvoRbMzuq/KIx74+8URvOo7LgbYS
         pmLdJUT3yUIiEwsJqTA75RlvFS9K+8F8gLdYjApQD75U1h4KQ5tj8G0poMrzkANRqwMc
         ZM7R5z0UByp6/EZOvUnJBIhMAtFmx8A9bSxyw/Sj1V8Y3abrlc0faYtNow3z0yePjpFk
         1vxA==
X-Gm-Message-State: ACrzQf0nCwyEgpFAyOU84CQTgwwyI/0qH86VcBc8P+dzPUcfqJapSYXs
        2DD3C9FSyX6IQhvkee3DKVMSdi0damb/pw==
X-Google-Smtp-Source: AMsMyM56NWB9msEAmJLQuhs0KO5CAvcIVtB93qFiD9I0nY1EyvbJ8q19tl+9D/wiwQPi5azkoUdzcg==
X-Received: by 2002:a05:620a:1404:b0:6ce:1602:d46d with SMTP id d4-20020a05620a140400b006ce1602d46dmr14817839qkj.409.1663638951981;
        Mon, 19 Sep 2022 18:55:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q10-20020a05620a0d8a00b006b9c6d590fasm87732qkl.61.2022.09.19.18.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:51 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 5/7] midx.c: replace `xcalloc()` with `CALLOC_ARRAY()`
Message-ID: <cdc57439c7a827d63dbbc62c094323a19a745c3b.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a direct invocation of Git's `xcalloc()` wrapper with the
`CALLOC_ARRAY()` macro instead.

The latter is preferred since it is more conventional in Git's codebase,
but also because it automatically picks the correct value for the record
size.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 05bcfc6f02..d703fc5a16 100644
--- a/midx.c
+++ b/midx.c
@@ -1912,9 +1912,11 @@ static int fill_included_packs_batch(struct repository *r,
 {
 	uint32_t i, packs_to_repack;
 	size_t total_size;
-	struct repack_info *pack_info = xcalloc(m->num_packs, sizeof(struct repack_info));
+	struct repack_info *pack_info;
 	int pack_kept_objects = 0;
 
+	CALLOC_ARRAY(pack_info, m->num_packs);
+
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
-- 
2.37.0.1.g1379af2e9d

