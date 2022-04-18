Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3146C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbiDRR24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347087AbiDRR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3E340CC
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id x3so9100090wmj.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9RNAYYhl96+2HI02DMsfh4sHEzXl1z1U68rAfArr0s=;
        b=O0+XwcppTr5U/xg4SaURSq/EtGecjFLkbIp4WYSv7JKKNR0/528L/NKU7g67lb+nqO
         1HNmbERpP6i916/akIuMjwK98cQT2noa9lrNkqbWRgvUECA7OkM+Lg7XE4pOeF69tq6f
         WfIxXAvhEycNX8EylxzZLtdo1xsLNJUdbi38H8QfQLW8j0UxF7ZI3qU6XLGvFdnkru/+
         qtdyFT2MkMXZ0xxu4Og3F5sTPVq5VXQQ2+/dL6p2zMU7lD78x6sYa0OLYPIphDIwdUIT
         c5+1z2SOKwnqMeCUI5zR9xG7/y5s7IXZ/oVfct1x/iN3croEloSoU7BrnPuzUWVbY55F
         BQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9RNAYYhl96+2HI02DMsfh4sHEzXl1z1U68rAfArr0s=;
        b=XxnN/eA6BMf4HHta4bYXkUIQz/TWh9bLHyfrRrJ7Yt9hYVUuxAD0jOAEIXVLMnq8UX
         n6JmNfytyLr3kMU/pzOERnL64LVkSbI0whNZlutCR6iUkMkJETXIiAU4z+bgn+NXu1Ag
         vnyyKWIwDTMlEci43/dk8h6F8PNL5utaSaZZOSGtmkEnP1aQ5euyvmcsNu20uqRkb+p8
         WtCUVhlnHAUi0Q+MdNy6bPOmQe/HiHPXHh3EKfU7aa5Ynb6+EivudE9sXd/mxOPLqs52
         W57t+0ShKUMgutbvesqOOwaHWAIN3xHJ4jT0/Kq99n1WkiMp2Et+rH2tY5m7eooYtZ2p
         v/ag==
X-Gm-Message-State: AOAM533+5v+MsqgPNoTiVRAJv7mGlq+j8klH3orwPZfhwQQmTwtPL3pf
        d718Mx7mEE28IHabMJiVc/iMw6K112FT5A==
X-Google-Smtp-Source: ABdhPJzHBZvyfyZ6+BR9k4a9jER6lxK2BLxHiXzLw38VPeZ/FoWWTVBhP3pZhF2Fxzg9waeKgeGWmw==
X-Received: by 2002:a1c:cc01:0:b0:37b:dcc8:7dfd with SMTP id h1-20020a1ccc01000000b0037bdcc87dfdmr12328552wmb.134.1650302669988;
        Mon, 18 Apr 2022 10:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 29/36] serve: advertise 'features' when config exists
Date:   Mon, 18 Apr 2022 19:23:46 +0200
Message-Id: <RFC-patch-v2-29.36-2c9886c64ea-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'features' capability allows a server to recommend some Git features
at a high level. Previous changes implemented the capability so servers
understand it, but it was never advertised.

Now, allow it to be advertised, but only when the capability will
actually _do_ something. That is, advertise if and only if a config
value exists with the prefix "serve.". This avoids unnecessary round
trips for an empty result.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 serve.c              | 18 +++++++++++++++---
 t/t5701-git-serve.sh |  9 +++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index 3368d16efda..6237bf63d60 100644
--- a/serve.c
+++ b/serve.c
@@ -19,12 +19,24 @@ static int always_advertise(struct repository *r,
 	return 1;
 }
 
-static int never_advertise(struct repository *r,
-			   struct strbuf *value)
+static int key_serve_prefix(const char *key, const char *value, void *data)
 {
+	int *signal = data;
+	if (!strncmp(key, "serve.", 6)) {
+		*signal = 1;
+		return 1;
+	}
 	return 0;
 }
 
+static int has_serve_config(struct repository *r,
+			    struct strbuf *value)
+{
+	int signal = 0;
+	repo_config(r, key_serve_prefix, &signal);
+	return signal;
+}
+
 static int agent_advertise(struct repository *r,
 			   struct strbuf *value)
 {
@@ -121,7 +133,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "features",
-		.advertise = never_advertise,
+		.advertise = has_serve_config,
 		.command = cap_features,
 	},
 	{
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9d053f77a93..befc800593e 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -33,6 +33,15 @@ test_expect_success 'test capability advertisement' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test capability advertisement' '
+	test_when_finished git config --unset serve.bundleuri &&
+	git config serve.bundleuri "file://$(pwd)" &&
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+	grep features actual
+'
+
 test_expect_success 'stateless-rpc flag does not list capabilities' '
 	# Empty request
 	test-tool pkt-line pack >in <<-EOF &&
-- 
2.36.0.rc2.902.g60576bbc845

