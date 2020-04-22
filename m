Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BFC5518C
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DAC2077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aaa/HUzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgDVUvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgDVUvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:51:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC26C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g12so4141438wmh.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PIG4FrSxiONOvQRQHfjnQfB0yrDlnxJU+QO1FbhN22g=;
        b=Aaa/HUzDLtd+wWXVB/rHCCkpGBn91GwP60NRUYlCTGqomTy6WvRJOZ31bK19kMWbfe
         3se2/jFO1wGugPYK9Gk7iqXVv8umsebFNd72ee3rzv4x/GOHy2jNmceij0y/BoW5w7u7
         MMpdlVc/1LARF+EoxEcMV79PnNwmble9ePLbWbHYBSOxFQwwjGOgHBUR2G20C2dxtyvG
         HOHxFMvUuOQn/gkGPH9rhowJt33OXtNr9sFZU99Lo4SXAMnP3MhJwmKj9CAIAPGow9Sf
         Hif4zLf4x+8W12kHlEqj3EXa/v6hMOGwF/H/YmO8fULzMAEiHzTsGOQve4Kw4kdklAyH
         qx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PIG4FrSxiONOvQRQHfjnQfB0yrDlnxJU+QO1FbhN22g=;
        b=HxHR1ikMg/YtGSl/1ynPFObARYMViIPhLdwTtCZHHz3/TGZSBnPCKgMitmaH4MQkf6
         9mNNRqkXeGJnh0T9qyu202AOUD4u0+erfWDcxN7iw24txBSStmv/kN4DceE87nb+HlwL
         +Nv8fvMtzCF5Nf8KxNoFtxS7rlEBDCWd0qF3oZQtoy6oyC5YKOUfD2YvCwp8zt5nqirC
         uemZILbV2aRlAyB9CTYcM1KhJpimD1I0+jGy84rfLLiPrx4q7GIUH0LR6qwrQJ2WVK2j
         MPxLvUpXbB9lsTxAb2IIHazyOwjQVDb4hT/K3g6FByIN4bNHaoXMo4Ji0OjXz0bMv4lx
         bdRw==
X-Gm-Message-State: AGi0PuagV31B+1mTFrwzqp0Kk7smTm6EKmmVZAtplpnb8t/8oUX/DYuG
        e6kYakliJUWuqieMvJyE1HqDC4q9
X-Google-Smtp-Source: APiQypJX+TUN4EmdlA1piJ1oXeoNQiREemT2sBHEvSRUcymZijPHa1MaoK+uAHSEbtHJQWDBS0uqdw==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr335712wma.19.1587588668667;
        Wed, 22 Apr 2020 13:51:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18sm635885wmc.45.2020.04.22.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:51:08 -0700 (PDT)
Message-Id: <66823c735b1d5ea2047a29656e82fa6fe895f6f1.1587588665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.git.1587588665.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Apr 2020 20:51:05 +0000
Subject: [PATCH 3/3] credential: handle `credential.<partial-URL>.<key>` again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the patches for CVE-2020-11008, the ability to specify credential
settings in the config for partial URLs got lost. For example, it used
to be possible to specify a credential helper for a specific protocol:

	[credential "https://"]
		helper = my-https-helper

Likewise, it used to be possible to configure settings for a specific
host, e.g.:

	[credential "dev.azure.com"]
		useHTTPPath = true

Let's reinstate this behavior.

Original-test-case-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c           |  7 ++++++-
 t/t0300-credentials.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index c73260ac40f..b9e8daa5406 100644
--- a/credential.c
+++ b/credential.c
@@ -53,7 +53,12 @@ static int credential_config_callback(const char *var, const char *value,
 		char *url = xmemdupz(key, dot - key);
 		int matched;
 
-		credential_from_url(&want, url);
+		if (credential_from_url_gently(&want, url, 0, 0) < 0) {
+			warning(_("skipping credential lookup for url: %s"), url);
+			credential_clear(c);
+			free(url);
+			return 0;
+		}
 		matched = credential_match(&want, c);
 
 		credential_clear(&want);
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index efed3ea2955..9dcba6a7ad9 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -448,4 +448,17 @@ test_expect_success 'credential system refuses to work with missing protocol' '
 	test_i18ncmp expect stderr
 '
 
+test_expect_success 'credential config accepts partial URLs' '
+	echo url=https://example.com |
+	git -c credential.example.com.username=boo \
+		credential fill >actual &&
+	cat >expect <<-EOF &&
+	protocol=https
+	host=example.com
+	username=boo
+	password=askpass-password
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
