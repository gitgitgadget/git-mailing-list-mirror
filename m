Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70981C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbiFCLP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiFCLPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167893C484
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so9991290wrg.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQBtMmx8BmSPG0QbtDqvr1tByPr8JXqjKVtVvXZ0xvo=;
        b=lsLXEfFC/q3qw760faHXsVV8dGSnKsoXd06DIQcCL7XqAwWg3O6qIx8UtwRM3NK8MH
         yjxP0+WaL7cl/L0uTYaW9xaLVEIfwezoewHGTeW4/veJ1Cl9xqR4G3oi+H5cLMQrGDne
         QQYPZe654/TQZzLnVvpsWmQUzbgnisZpbDFXHiCLi+/ZIhak2t9dFl0xrHmp+b1jD/zV
         kx1Ftv7B+Hkf48wvBmGs4P83XPXSsEIPCdJEmkhR3uJR8SbQbp2C6lQaDqdUOcMVR0P4
         BtLq0KbcQFMB1VwmU8aqYIdkUeh8X3xBv6y0hM0AA0o8/nLUDVL3USftwBDNGPMU80eo
         7/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQBtMmx8BmSPG0QbtDqvr1tByPr8JXqjKVtVvXZ0xvo=;
        b=7r8ft/0/PT4B0DRaUhjFekcU5l2LkcERASheTwjtG4l/nfE9FY3SfLLW5d6QE9WnlT
         q+8CBVxQLSJLmapnZhKs+tZgEZqBWPjkUn7l6q3hWrQxd+MchYDkdKA9MbXuGgUYraEb
         MdyxXtSPvRkAxKXPDcV9OGyrjdhPh+RgALGyMyJb2InvcPeebAKQgePSCP05X7mxD3Xv
         JHvNuBx9NdG6eBDeAgGPquMxQs52N7+L++DDADb4nv2jBfp9O9fdOAcP8jXTfS6f8yGD
         BWz6Ocl5qtz7OitSMGkwc8x7B2JuMCVSyTJkM0k2mU2Cs3NxfRlHAcOJ+mh5lTiekAKX
         EOpg==
X-Gm-Message-State: AOAM530Fkw79ZblbiQlYiX98pDa1LXRdNLyNzH1Pxbj/rQMU0Yf0ivJr
        HgQJAzDqHBs0k8F6m1Zq+0greBdM/4Yq5w==
X-Google-Smtp-Source: ABdhPJz3xuKTzRQuvtb4IZ9RASjTfm+jZQoaSgAkMRlGZ2mfMZRpa5JNq3ubuXmP1vcPoMTFArQSxg==
X-Received: by 2002:a05:6000:186f:b0:213:4ece:4086 with SMTP id d15-20020a056000186f00b002134ece4086mr6334788wri.438.1654254934304;
        Fri, 03 Jun 2022 04:15:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] tests: don't assume a .git/info for .git/info/refs
Date:   Fri,  3 Jun 2022 13:15:07 +0200
Message-Id: <patch-v2-5.7-b9f667bf292-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those tests that assumed that a .git/info directory would be
created for them when writing .git/info/refs to explicitly create the
directory by using the "--template=" argument to "git init".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1301-shared-repo.sh     | 3 ++-
 t/t5550-http-fetch-dumb.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 84bf1970d8b..93a2f91f8a5 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -48,7 +48,7 @@ done
 test_expect_success 'shared=all' '
 	mkdir sub &&
 	cd sub &&
-	git init --shared=all &&
+	git init --template= --shared=all &&
 	test 2 = $(git config core.sharedrepository)
 '
 
@@ -57,6 +57,7 @@ test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
 	git add a1 &&
 	test_tick &&
 	git commit -m a1 &&
+	mkdir .git/info &&
 	umask 0277 &&
 	git update-server-info &&
 	actual="$(ls -l .git/info/refs)" &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index f0d9cd584d3..3ca621f33b5 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -422,7 +422,8 @@ test_expect_success 'set up evil alternates scheme' '
 	sha1=$(git -C "$victim" rev-parse HEAD) &&
 
 	evil=$HTTPD_DOCUMENT_ROOT_PATH/evil.git &&
-	git init --bare "$evil" &&
+	git init --template= --bare "$evil" &&
+	mkdir "$evil/info" &&
 	# do this by hand to avoid object existence check
 	printf "%s\\t%s\\n" $sha1 refs/heads/main >"$evil/info/refs"
 '
-- 
2.36.1.1119.g5a713b43bd4

