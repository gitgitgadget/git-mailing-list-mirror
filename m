Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466CC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D88761131
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbhIID0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350080AbhIID0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0DC061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:24:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so347728wmq.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jVjmHPs9Vzn+FL0BItXKX43L71zgap2RPxsgO9/F3J4=;
        b=UaWYTo8HE3QjcfLp28+zpPCdTYQoC77vffeuHV5z7ZeTj02DRn9rXamu6lxMggSIGw
         xkJrMmctWIh0TA0Qw+gt2nmw8wWu3m6YzTXItxL1Uwzfvr2jJwEZU2n3kX2hxjbISF4U
         ebUdaR79QX+0wf+L8wSjrfLcwIMt54melJQnhpZYb7zLJ9I2e2w3+uKs6/47FnIPzaa7
         kXbmvU/Qd+WTWcn5Ic1h/9e+WW5YtjJESD4sUbLsquFoyz0zHAi7cpVOQDJBnVJwyJ3a
         jK6BhaydA9oXyCnm+o9OM4KAxGUMgwJknuglWv2mM46A7vCLFrI3UAYimb0BN4fP6/RO
         7OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jVjmHPs9Vzn+FL0BItXKX43L71zgap2RPxsgO9/F3J4=;
        b=tDVqZ2wCRwKZjzeJbNaiaLuddNYml4or5gHXreupe8o52JYAr+i7sUTKw4htulQr6U
         N2ayg6TdAhq1fZhHd5Z6/NGmIO/ioVqKKOs2NufC9M751fRnvIu4on36MkZsPNqMUFOu
         dZgOhx3gAEghJSYabGJknrxHZZa7afTcBsMDOB2iTSJuPC+eMuGMwdUwjxz8Y8g/psx3
         IQ3why5lZzLSWIJSrdasdZe5BIRh65CS6hOr88svStrykCvUaXPYZTP3gb1O/fQwKCJs
         dSote0xuljRhX6CQeFMpXzSTh1P1fRaJRhpTaPFj8gkwv7+5MLGU175Gclf0DdSSgB5w
         rDrA==
X-Gm-Message-State: AOAM530UFeNlG7jcOeidNDlPTjWkXD3ugOaYFN47yVbmXV2LzXeZW9ue
        NaZ+/lzWz0h407a6GKNoUHAVBdhTlacpmhBY
X-Google-Smtp-Source: ABdhPJwH7Sz/Hs6kPXWXrS5nZxHQYPmWh7YK3lRuHDTrxMJSPT+MzlPmOMQRmx8Zpjm5qQLG25/Lzw==
X-Received: by 2002:a05:600c:3588:: with SMTP id p8mr597301wmq.20.1631157889959;
        Wed, 08 Sep 2021 20:24:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n66sm324249wmn.2.2021.09.08.20.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:24:49 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:24:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 1/9] pack.h: line-wrap the definition of finish_tmp_packfile()
Message-ID: <0b07aa4947caff53878a9000e2866f98146e2ccd.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Line-wrap the definition of finish_tmp_packfile() to make subsequent
changes easier to read. See 0e990530ae (finish_tmp_packfile(): a
helper function, 2011-10-28) for the commit that introduced this
overly long line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pack.h b/pack.h
index fa13954526..1c17254c0a 100644
--- a/pack.h
+++ b/pack.h
@@ -110,6 +110,11 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+void finish_tmp_packfile(struct strbuf *name_buffer,
+			 const char *pack_tmp_name,
+			 struct pack_idx_entry **written_list,
+			 uint32_t nr_written,
+			 struct pack_idx_option *pack_idx_opts,
+			 unsigned char sha1[]);
 
 #endif
-- 
2.33.0.96.g73915697e6

