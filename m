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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12318C19F37
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B3661008
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbhH0IEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbhH0IET (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 04:04:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E4C06179A
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so9073250wrn.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/hdB7WJTMXDmJeG+jWOAlJnqvqhIc3wD9Xu4oc5bLQ=;
        b=oRw7d4AQkUwu+9x6Ktzw/qZmzo6rCzKAGmiImaz8zHhng5i1ojJFbRP1pZzthWH6rI
         Gi6XMgbxRQ1F0QU2TRuZ9iZiErb4p+N1JNcRX8dqLHhI3qtAIwkL8/z2/i0BTWzWB5+u
         KteXrBJYgFsoJkMCegj7lCdP06Us4ybag99IUe2dieitQ9hT2ewx3D34c0QcxDKB4bmM
         aZXAQx0cNNb1u1HkrstbSNQdw8uV7FGi8uoFTbj87yKjddcmzZjRYUUEyx6uQnmkBO9a
         mfr3/VH994Ti5PlcMx4x1+0TuWMueofYav3AtNThVMMFa02CNiVjv5+5NJuueNSLMjCS
         INjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/hdB7WJTMXDmJeG+jWOAlJnqvqhIc3wD9Xu4oc5bLQ=;
        b=Dtd2Qam6h+W2x4QwSPxRX9ia8iFSy62DcT7p7mUqSEZgQSDBeaQ+tCXqk91oyLlsO9
         20TyORSwD4n+o3oaAKVb9oOzbSXGOFaKvKIotOWZbJoZaLiOjw94EJWui5HalEGLuN6g
         cSA+ncXt7SmgdLrrblfsgMfQ0gN0w9q0ZikDoCPYkEd/aFKie1pn1jeGU8WpmjcRf9eq
         SMxFrxn2Nu5j6IBN0muuPljMZZVNM3OODvSWlMGocP2ZJQaKcJ3dXSoJWWZGQeQPqRt8
         FeQ1aWrV4tUfJXiburqW0ANyHkUdQa/m1gbpYASkONIiez8ArgIoi+gzRYY653ZbPyj2
         od/A==
X-Gm-Message-State: AOAM5335zI/iOMSCm/jvIYrjkBAaag1bE4kmyYuaBnAmlnbHbYiANOj6
        MQ/N+VDMsaO6c2izLT/2+WH2QHlz2mQAfg==
X-Google-Smtp-Source: ABdhPJxjyqrEx/Y4SOjiteH9ycLzD2P1FgqGbL5M+0stf9J/jWajwV7DL3UhXrPSx6OfK6plvfbVqA==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr8821892wrq.131.1630051345266;
        Fri, 27 Aug 2021 01:02:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z137sm10922636wmc.14.2021.08.27.01.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:02:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] tr2: stop leaking "thread_name" memory
Date:   Fri, 27 Aug 2021 10:02:15 +0200
Message-Id: <patch-v3-3.6-45769da953-20210827T080054Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com> <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in ee4512ed481 (trace2: create new
combined trace facility, 2019-02-22), we were doing a free() of other
memory allocated in tr2tls_create_self(), but not the "thread_name"
"struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 trace2/tr2_tls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 067c23755f..7da94aba52 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
+	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
-- 
2.33.0.736.g68690aaec9a

