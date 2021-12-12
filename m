Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC018C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhLLUPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:15:00 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40499 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhLLUOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:43 -0500
Received: by mail-wr1-f53.google.com with SMTP id t9so23855118wrx.7
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OcVt8IzeRsovGJ6FNMww+vfhZyepUG6cdE2VS/CetM=;
        b=DV7WdHEGNNBKjlHlEyYOQRyDmky8QoTUWp1BoIdm2H5wkDAgI1/DfXRRMkT+kcZEEq
         nUXUFaVdtymVdo2tuA8HpMn4jAoVTHCwrPt9rnAkLbOP41jtQkn/ZgcYaFvjwbTS+FpS
         tfqWUJ2AgLJ/FyppxkB89quB8Jkh+OW95rOdDMsysd/7H2c7SsMitmd4dKwOgTZY5lW2
         qQuez0wgbTFdxZC3QcOgnPBCZiEqSONorju4iY7LhI3JD4P9cfxGsSfCqa+9v2OXQQRl
         /GD9t/23iaKNtvxZUMZ4ZSbBXjF+uSmBWhNfOVtdDaqleotY5M5kzykuNAZG+FficdwY
         MMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OcVt8IzeRsovGJ6FNMww+vfhZyepUG6cdE2VS/CetM=;
        b=GifcJhqrviIO8MsCBq4viRuEDEMnMPKivOrzrUMjYlNg+FCEU/gb2K5oKZlZio+sGr
         mfOOBV6pEfz4t3E+0bIE+CVYxh8YgUSCBfabNbQGOrEv6ortGGE/CsJMVXlohnR7HF4y
         ATTeL85UAmmU5VpFUbyAf7VDZGFrYrZQQKUVBHDVIzgfC1I433XQM1S012ccvAmbMSRz
         DqiJD+a6+tEzs2Z9EVRBkWFCY1uGAYWyW8iO0wJ3YTP7JAG2oIolNHvOVFobzncjO6/J
         OCK7KOOh/nFYPGIQADVnMX/X4/Sp8rNMGPJRiMRFFoKZ69Q8vqpdT4n+gSwWk84Gvxx4
         lmbQ==
X-Gm-Message-State: AOAM531xNDRcEdvzh6xiHcosOWpI3a1QZnOxGi2s1lxefM1jMHHrjC8c
        ESr9n7cKJ16mURmWjgaJjwQe1gTWiejp9A==
X-Google-Smtp-Source: ABdhPJzItms0T3hywV/y6pQibki44VcTRYIgchu9bQqCozglTSIxbcp085+lLriYSS1LlSvb0ltzrA==
X-Received: by 2002:adf:f001:: with SMTP id j1mr27553211wro.351.1639340021913;
        Sun, 12 Dec 2021 12:13:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/13] t5540: don't rely on "hook/post-update.sample"
Date:   Sun, 12 Dec 2021 21:13:19 +0100
Message-Id: <patch-09.13-d97122f5fd8-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in a87679339c0 (test: rename http fetch and push
test files, 2014-02-06) to stop relying on the "exec git
update-server-info" in "templates/hooks--post-update.sample", let's
instead inline the expected hook in the test itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5540-http-push-webdav.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 8b68bb38a44..8b1f76fb3b8 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -36,7 +36,9 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	mv hooks/post-update.sample hooks/post-update &&
+	write_script "hooks/post-update" <<-\EOF &&
+	exec git update-server-info
+	EOF
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
-- 
2.34.1.1020.gb1392dd1877

