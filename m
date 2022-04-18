Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE12CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiDRR25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347099AbiDRR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB923465F
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8635437wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=En8wQzMm5eZVk0nwFilGhD/m++D8ZZntA3qeIP2F2Fg=;
        b=lOaO/GnLyT/Ze9SKLpTlsUaqw0iGIXt7RREdkcWgZo2suLiZyWm+/3oLWtgmLw6fw2
         BoGtx+DLXr2alZblfDNGLxZZhzRMU76d7gNtgzKjZzf99ob6gfpTCgBBuVfHN33NrVBz
         DDya/lGXt5rVIBvUDK56Md6a62ebGahWzD/Qwoh/ZcL+jHhUsj1/NnG25EU2bI1u0FIh
         Vqg2dIGPy5PLG0hqjvhSFXOWd8gjm1hJNuW0f5b7uWxqeSUW3DCideoZ56cFlRlaaz+F
         nI4vi1DEsZYgH1zoZW/6+gUHUF+UtXD9JNJ/mdIBA05eqzGY9Ges67wDIcinfqfc5Qtx
         aC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=En8wQzMm5eZVk0nwFilGhD/m++D8ZZntA3qeIP2F2Fg=;
        b=DG9kK5cr2WkOQa7l4B1/4weOa9hZnPRH5GpdGYHKBF9tBnYkAjgYCtj/1WuAq4OUHn
         q5wqU4hDU4ijv+HYmEYnck1IIW9mniHubmTBtuJgtRYQbCz8B4xPpAlKhjnEJiB5NRUY
         hsJ1QNb7bVs3hQ4R1V6SlCd1bApYW6LaNvMjjK4hCdy/7tXe9a0alqO0cd+Za8JOJG6V
         4B23vzR5Glm8fPDR/d9S1vPLaZAa3QW/PEZOcUaXPWLklL3XCjmhdJfT7UYF4XmiMzD2
         FFSQS+rC9AI7iUqC8pQEL9XdZ1MindPcFKnNHjJWl0cNWs+fEOjKYHUOqxlh3/toTt4y
         0PKw==
X-Gm-Message-State: AOAM531YPItmoPnJUvVl/1V+Nkv/timV57ciTmLccoEMk8ER2Ak9ZHvU
        1foowH6BiIYN6gqcU8TwUhNbQNkWUF82Gw==
X-Google-Smtp-Source: ABdhPJw+EL9CSfHGZpOcS8W9rVQ3jbkXqhVlebqVvlTpfTF6pic0MxU7acmJjPwnWZ3Bqq+zWauz0g==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr12081829wmc.5.1650302673835;
        Mon, 18 Apr 2022 10:24:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:33 -0700 (PDT)
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
Subject: [RFC PATCH v2 33/36] t5601: basic bundle URI test
Date:   Mon, 18 Apr 2022 19:23:50 +0200
Message-Id: <RFC-patch-v2-33.36-52ee1e08dec-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This test demonstrates an end-to-end form of the bundle URI feature
given by an HTTP server advertising the 'features' capability with a
bundle URI that is a bundle file on that same HTTP server. We verify
that we unbundled a bundle, which could only have happened if we
successfully downloaded that file.

RFC-TODO: Create similar tests throughout the series that perform
similar tests, including examples with table of contents and partial
clones.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5601-clone.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4a61f2c901e..e6119f78aea 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -767,6 +767,21 @@ test_expect_success 'reject cloning shallow repository using HTTP' '
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
 '
 
+test_expect_success 'auto-discover bundle URI from HTTP clone' '
+	test_when_finished rm -rf repo "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/everything.bundle" --all &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		serve.bundleuri $HTTPD_URL/everything.bundle &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo2.git repo &&
+	cat >pat <<-\EOF &&
+	"event":"child_start".*"argv":\["git","bundle","unbundle"
+	EOF
+	grep -f pat trace.txt
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
2.36.0.rc2.902.g60576bbc845

