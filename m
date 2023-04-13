Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12031C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 23:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjDMXcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 19:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDMXcC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 19:32:02 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E804422F
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe3cd445aso7947647b3.5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681428715; x=1684020715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DzunMpXbpcg9jv9QPgZ6Aum2+UnYUBJ80s31+jU5nc=;
        b=zAyw4ubwUM/d5G9vAizOc8+qHkuNCPnSawz+LfiYYqLRdVUSDI/92wojMvXq/PMVeu
         tMYUO2xGMgQiZa0u4NBD4Y/jGIO46ALfdBwgLRQS62E4vUXcRlLbYpERPIEHb4usWRsP
         T9QtfdiQfX76duqb1ZVhZL5LXX/D0CQxrP0G5pLJvQMAJp03LGmiVkiLpJYsebt/KNXl
         9b5v2phYk+uTXAB5tmxdKG/1sXFKEa5px/k/2LC137cvBJHu/GNxj6oAIMZBV0FNQStn
         xkW/TsOUiw1N03hFrO49go+P5jYoE3drCTCCzOmvPJ1kXTtvAFTJ/p+JsoOXF48fERw5
         b+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681428715; x=1684020715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DzunMpXbpcg9jv9QPgZ6Aum2+UnYUBJ80s31+jU5nc=;
        b=JjsydE/g0/fUr0pxJ6mssVY04X9Zn2xaPYgRgl1p6XJrAVE3iCibmKZJz8v/fbfE9D
         FR9Splr4zc0Dan0BU1NVegsmE7VG6/lDDqZMdkaO7anm8BqKc7EzndUGmBpuuF8T/wgt
         KtOZaOeJHYjh/HPk8NtLBGjL6bZClqNK3CjY5gVR1cC03jNscELOn56UnhCjlzaGRa9e
         qKgVx2pP1weMpDl/ffWYUHzwXcdK6Vhzj7XMAPyR+R1mayuyAVxHfnQh7jSwf7ofUmpZ
         9v1+AfyLiR9/9Ahk9ZtNTAQcKBsbzPmnRTzpKhFXudJMxCtcdKwl0hpJc/0vLFohapQa
         41HQ==
X-Gm-Message-State: AAQBX9euZjQmPqsLKT5s3UrBshllU/hflFjKHHxABU+sc8O+RPNwmcv7
        KXmvhqMoeXM4R2ZEyWXaQe9eRExFGVUuiH2vYuFp/g==
X-Google-Smtp-Source: AKy350Ykh7rbPSJUQXa9/WOlbcrx0YI5Ys/HPVZagfaF01JPM7KACYr3TBdWbKnkA2pLpbr2Lyl6Wg==
X-Received: by 2002:a81:6ac3:0:b0:54f:1185:b57f with SMTP id f186-20020a816ac3000000b0054f1185b57fmr3850201ywc.29.1681428715420;
        Thu, 13 Apr 2023 16:31:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6-20020a814d06000000b0054ee8426468sm810346ywb.21.2023.04.13.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:31:55 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:31:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] banned.h: mark `strtok()`, `strtok_r()` as banned
Message-ID: <1d955f8bc6d2797def516897d019a186e461b648.1681428696.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681428696.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`strtok_r()` is reentrant, but `strtok()` is not, meaning that using it
is not thread-safe.

We could ban `strtok()` and force callers to use its reentrant
counterpart, but there are a few drawbacks to doing so:

  - `strtok_r()` forces the caller to maintain an extra string pointer
    to pass as its `saveptr` value

  - `strtok_r()` also requires that its `saveptr` value be unmodified
    between calls.

  - `strtok()` (and by extension, `strtok_r()`) is confusing when used
    across multiple functions, since the caller is supposed to pass NULL
    as its first argument after the first call. This makes it difficult
    to determine what string is actually being tokenized without clear
    dataflow.

So while we could ban only `strtok()`, there really is no good reason to
use either when callers could instead use the much friendlier
`string_list_split_in_place()` API, which avoids the above issues.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 banned.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/banned.h b/banned.h
index 6ccf46bc197..9bd23ce5732 100644
--- a/banned.h
+++ b/banned.h
@@ -18,6 +18,12 @@
 #define strncpy(x,y,n) BANNED(strncpy)
 #undef strncat
 #define strncat(x,y,n) BANNED(strncat)
+#if 0
+#undef strtok
+#define strtok(x,y) BANNED(strtok)
+#undef strtok_r
+#define strtok_r(x,y,z) BANNED(strtok_r)
+#endif
 
 #undef sprintf
 #undef vsprintf
-- 
2.38.0.16.g393fd4c6db
