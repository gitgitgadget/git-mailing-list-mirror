Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763FCC7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCSQ5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCSQ46 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:56:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A113D61
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v16so8382470wrn.0
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679245015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEk3Z/mNFwXDXywz8Mz38bVJjb78TxMXdBUHWQterv4=;
        b=pB2PE1DZkmIFSo9I289W5FTSG2eVtqmVk7upi7L731rPuBswPatzqyyFxO5898lmR6
         kTC+NM4jMekN+iDmiO0NrvwdWUoUTAS3ZfrgkbWnSIOhhZ1Yq8kVRgraEJvNT8j1Ply6
         kTTrB3/kMPOQGjsAmC0v0LkXknPeEME6MutJpumyqN2ex5Bx9Sd0UvTSWw/5896X/g2A
         j+1zTN5d35jcIpd3Xgd1LSKCACwN0J89C9f1hDrUFIfW21wPcUK4x0OxCaPxhhpzHYxS
         tAkXLxqhQ6gx2DBaDEpjkLWxENnmhE2ncSkdIGhXPOwBpIrktUTg1MRM7uoxSRQQxLpG
         nzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679245015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEk3Z/mNFwXDXywz8Mz38bVJjb78TxMXdBUHWQterv4=;
        b=4kLdPXPWZvIl8mrZsJaIPQdOut5urMhUL86tWmf40bbZOUe+KHplEk82sin2ROKdWY
         D9b197CZiKi/yIOsOUel9cezoM4yATFcwVJ40cIlfLe+m7zcfrpP+L02AeJEujTNk/c5
         BXy+J60JgH0gx33aLeuXJ63Mtxm/P4VTLf2jxC5JDW+JmfTyGiVcQYUnUGIjzMkk1zbl
         HYHF7+FDwE/0X4MbOpGmeUsai1FpsrWrY3w2MR05pbYnDHbbYcqXR7eUrjzu3AosBYH+
         cSSFPkRYgTsWLqKQxCPienUt7d/O9oB2+7vRwxPF5+6CAYw7F1ueER0lv0iXG0/Sv2An
         Ql1g==
X-Gm-Message-State: AO0yUKUvveoTIc6eKhob1ngkSfJt5nYeY9r5XptmPuqJXarGmsE3NCxU
        SnWsnbhLBhhvxwmp/zRVx5WJk4NtjjE=
X-Google-Smtp-Source: AK7set9Rkoq0aejuOi6OBnyIyPBv9S7QJNnCpOeCwxvADwTifPV25Mu6qVsRjiBj0/JdFOxW+0KhYA==
X-Received: by 2002:adf:e2c3:0:b0:2c7:adb:db9 with SMTP id d3-20020adfe2c3000000b002c70adb0db9mr11195164wrj.63.1679245015673;
        Sun, 19 Mar 2023 09:56:55 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm6888377wrh.21.2023.03.19.09.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:56:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] parse-options.h: rename _OPT_CONTAINS_OR_WITH()'s parameters
Date:   Sun, 19 Mar 2023 17:56:47 +0100
Message-Id: <20230319165648.656738-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
In-Reply-To: <20230319165648.656738-1-szeder.dev@gmail.com>
References: <20230319165648.656738-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the 'help' parameter as it matches one of the fields in 'struct
option', and, while at it, rename all other parameters to the usual
one-letter name used in similar macro definitions.

Furthermore, put all parameters in the replacement list between
parentheses, like all other OPT_* macros do.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 34f8caf369..7e99322bab 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -381,9 +381,9 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru }
 #define OPT_PASSTHRU_ARGV(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv }
-#define _OPT_CONTAINS_OR_WITH(name, variable, help, flag) \
-	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
-	  PARSE_OPT_LASTARG_DEFAULT | flag, \
+#define _OPT_CONTAINS_OR_WITH(l, v, h, f) \
+	{ OPTION_CALLBACK, 0, (l), (v), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT | (f), \
 	  parse_opt_commits, (intptr_t) "HEAD" \
 	}
 #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
-- 
2.40.0.499.g88fa0b00d2

