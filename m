Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FBC1F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdLIUkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35628 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdLIUkY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id f9so8096712wmh.0
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fNzdoKs4C4+N+qbKvDkZzAqwjwTCeeOBCp7XPy3PMxw=;
        b=Ja2IB8GeX+pJXdwpuTefE/SLwEUxurQ1qtDvPvBZ95tRj/dxW4bwp1O01qh5sq3kJw
         KdDKSz0u8pldvLLuvw91hkp5bOVVhXn+7TeWbppUXC6E+n0uonDH0UBHAg0VNu4LaBQ7
         BYY6LtbhobC35/z/tQ2weMR/RDnj8YZXuIy2gr6kMfz5DZHshNFERZEJYjJcRBk5L9RE
         iy1JxOvUs06a/1V/fJtx6YOjfDbnjPbqP8xWRTQKh5LgG3CbUYITjOSs7DZggpLaq92V
         QmKa+VZijwAclkcDh//fyhQgMDfCKkfiYjEYuBl98aB2sCGbBEpNSU58zvBVm5CmkZB2
         GI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fNzdoKs4C4+N+qbKvDkZzAqwjwTCeeOBCp7XPy3PMxw=;
        b=Qm+mMM6mK3DfpX8gCF0dtbPxMK2QDI0ScwY5oJE7OUggT7gOyxH9NpL8/yO7e8hjWk
         uL2gOvzYNLiIQjn3n3NGJhi+to4uJV2y+2TsoUk1NnxMOskPj4HzpDT/Fddd2n6Hn6jG
         8v7vspfWquwzRQmzDiVCegZ776q7vGETcOmMNIB93oKSwv7YL9OmNufzhc+IfJh6RXYF
         Jt4RhWCt8GQPyEHuSbPQQUsN5MqfhumCLa/qBykJS1OfB3ippUoZoAPtk3BQTSJ/mwfc
         v0MvxLFSGHCfGUUjXtYyKG3LreQ/OSARitA6odVWARA8g2RSeXXemYm8UbDFuHuPacIb
         cxsw==
X-Gm-Message-State: AKGB3mL5cnWRSd4Pj5AMyXst7kT6K8JBRxNmd9Av61aIb/KLqgb+9VXt
        JQ2VpB/Dos/U0Lf4SqgSIBhDuzC7
X-Google-Smtp-Source: AGs4zMad1e3PVDtDEps2aaGjsjd3QpFsvvl5aLgHqs2ykWcfjzOU8PaXVIcBOLXR3sOk9apXl43CEA==
X-Received: by 10.28.128.73 with SMTP id b70mr6845841wmd.53.1512852022330;
        Sat, 09 Dec 2017 12:40:22 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:21 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/7] git-compat-util: introduce skip_to_optional_arg()
Date:   Sat,  9 Dec 2017 21:40:07 +0100
Message-Id: <20171209204013.10997-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We often accept both a "--key" option and a "--key=<val>" option.

These options currently are parsed using something like:

if (!strcmp(arg, "--key")) {
	/* do something */
} else if (skip_prefix(arg, "--key=", &arg)) {
	/* do something with arg */
}

which is a bit cumbersome compared to just:

if (skip_to_optional_arg(arg, "--key", &arg)) {
	/* do something with arg */
}

This also introduces skip_to_optional_arg_default() for the few
cases where something different should be done when the first
argument is exactly "--key" than when it is exactly "--key=".

In general it is better for UI consistency and simplicity if
"--key" and "--key=" do the same thing though, so that using
skip_to_optional_arg() should be encouraged compared to
skip_to_optional_arg_default().

Note that these functions can be used to parse any "key=value"
string where "key" is also considered as valid, not just
command line options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h | 23 +++++++++++++++++++++++
 strbuf.c          | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

The changes compared to v2 are:

  - s/_val/_arg/ in the name of the functions
  - s/val/arg/ in the name of the third argument of the functions
  - works with NULL as third argument of the functions
  - "--relative" is handled correctly in a separate new patch from Junio
  - tests are added for "--relative" in a separate new patch from Jake
  - a new test reindenting patch from Junio is added

diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d581..68b2ad531e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -484,6 +484,29 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
+/*
+ * If the string "str" is the same as the string in "prefix", then the "arg"
+ * parameter is set to the "def" parameter and 1 is returned.
+ * If the string "str" begins with the string found in "prefix" and then a
+ * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
+ * (i.e., to the point in the string right after the prefix and the "=" sign),
+ * and 1 is returned.
+ *
+ * Otherwise, return 0 and leave "arg" untouched.
+ *
+ * When we accept both a "--key" and a "--key=<val>" option, this function
+ * can be used instead of !strcmp(arg, "--key") and then
+ * skip_prefix(arg, "--key=", &arg) to parse such an option.
+ */
+int skip_to_optional_arg_default(const char *str, const char *prefix,
+				 const char **arg, const char *def);
+
+static inline int skip_to_optional_arg(const char *str, const char *prefix,
+				       const char **arg)
+{
+	return skip_to_optional_arg_default(str, prefix, arg, "");
+}
+
 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the input
  * buffer, and returns the remaining number of bytes in "out" via "outlen".
diff --git a/strbuf.c b/strbuf.c
index 323c49ceb3..29169b8ef8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,6 +11,28 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
+int skip_to_optional_arg_default(const char *str, const char *prefix,
+				 const char **arg, const char *def)
+{
+	const char *p;
+
+	if (!skip_prefix(str, prefix, &p))
+		return 0;
+
+	if (!*p) {
+		if (arg)
+			*arg = def;
+		return 1;
+	}
+
+	if (*p != '=')
+		return 0;
+
+	if (arg)
+		*arg = p + 1;
+	return 1;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
-- 
2.15.1.361.g8b07d831d0

