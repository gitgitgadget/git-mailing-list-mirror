Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541ADC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiBBHe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiBBHeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A1C061744
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a13so36590852wrh.9
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Hd+gHGQwZ5LygnSwiXiwkGrK0fyJvSF73snz4VsFvU=;
        b=BP+61sE4fQ7qF6hiaopb5hgbLJhuG3aeqO4RxBAyGGJW8YPWB1dBNeGOu1o5aAtGQB
         dlhpLuZ5HIw5qcTUgHtV0lkeLlzHp3aMti0vky0MqoYeoKLOwZu3U7go+TOj7oUDee21
         pfIB8QMvXUGU5ywtsGkUYDToFr0IuCt4SW5dy48FplC3K8fmYDg9tNMFVSBU9ySDHFZF
         VsWLeHcAT/sBojbyCsXRmd2cc19nowaB24sOvWC0pAmYuBNd8DD+2IlM58/EhKLrUjCu
         5L/wmIMsp2haOHVEFQ6/iiZGvHNVu8dMpXG6mXddq/gaXUeXewaVri2rnwislYsWRN7u
         /kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Hd+gHGQwZ5LygnSwiXiwkGrK0fyJvSF73snz4VsFvU=;
        b=Iq00eAOLI51vSHUHVjoKwI6FrU8Ejw6tsR4sCgJ3Kxa4wWAGTJqKETtCnmr23anAIv
         baXTQzmnInsE/dmAZ5nbUOmnZon03WjK/YBMoWnl2DChtrv24OF26BUZ9KBweq4HcDpC
         t70X4sS/8z3ou+1YhDF+5jEIY7w9i0b072UmYZg+t4Za/pVAlyGl6+r5Hqy71e4S3ph2
         MdE3z3WcO/zR7azaWMLAulfKcAoALLiINI6GrQOZUWBVdnrwajTNHr3vaVDs524w8mim
         6eMshNeeRMMRrZwh0uGAew8OHi3qCyyZvXhbXgzxKhfNGMefO8pKBFwjCSVktKwMiJS1
         J8hg==
X-Gm-Message-State: AOAM532WhgJEOVBPBPREKYIkuzGxo6QXKdguGuUrR4GJqYFy9s5xY33u
        GGYU4a1DFqpCPOaVMy73SrBSxwMCV3A=
X-Google-Smtp-Source: ABdhPJyUi8Msd5k9+zRQZfQpuD+f1+uQunkUgR6iSlNvsSHJLbhvbh3/EPKp/Dxh+l1zkEXl3zm7YQ==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr24244957wrp.330.1643787287434;
        Tue, 01 Feb 2022 23:34:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm16525796wru.28.2022.02.01.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:47 -0800 (PST)
Message-Id: <290b42846b5557055b84e4237ddc8c3532752d5d.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:31 +0000
Subject: [PATCH v3 05/15] Introduce a variant of the `warning()` function that
 takes a `FILE *`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to teach `diff_warn_rename_limit()` to write into a file
instead of `stderr`. That function wants to call `warning()` when
writing to `stderr`, though, allowing for the `warn_routine` to be
overridden.

Let's introduce a helper for that.

Note: Since there is currently no need to provide similar functions for
`error()` or `die()`, let alone for the `_errno` variants, we will leave
that to a date when the need for those should arise, if ever.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-compat-util.h |  1 +
 usage.c           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index d70ce142861..64ba60e5c71 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -475,6 +475,7 @@ int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning_fp(FILE *out, const char *warn, ...) __attribute__((format (printf, 2, 3)));
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index c7d233b0de9..0bfd2c603c0 100644
--- a/usage.c
+++ b/usage.c
@@ -253,6 +253,20 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
 
+void warning_fp(FILE *out, const char *warn, ...)
+{
+	va_list params;
+
+	va_start(params, warn);
+	if (out == stderr)
+		warn_routine(warn, params);
+	else {
+		vfprintf(out, warn, params);
+		fputc('\n', out);
+	}
+	va_end(params);
+}
+
 /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
 int BUG_exit_code;
 
-- 
gitgitgadget

