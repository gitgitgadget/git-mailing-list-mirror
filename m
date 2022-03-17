Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B635C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiCQKPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiCQKPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:15:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D0DBD33
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j26so6659229wrb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMkMn42VpAhmuH0uc3IjhrptgxyVzLaq8O5+zOrEovk=;
        b=TuEo+A+ZX6RzXWYhyUqEIalLrwtgUCSYtbrpT4j/nntuLhhrDJjMuKGHqzKG0nEao9
         oyOWo6VWGSqmWUf4zYv7YKGCuIuponMtNDTUmzPbG5ptgW7/hFpAwCO+L8i9G8cM6FZ0
         e/CKOZGzgk+l/14zfyVJEr/EO9NcMnmZ7ohyPTghgrWJgGBkxXuMPdUHYamrhIs+Ilp4
         jKnSqiJ0NNSeHtw5xhIYwD/V/ZrDolNyBZ0mIVB4DeYHEeFjB79BJkmw57tVCcy94Pq7
         VvOt/Ls0z1rKcH8tCzAvos6p6LZPboHI2Lz1ceig1A6ISK+xeNEvcfRh66Iv7UDwBFzN
         pM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMkMn42VpAhmuH0uc3IjhrptgxyVzLaq8O5+zOrEovk=;
        b=xNE/NtE4W63ljCOIiUrsXdghWRWBh2oDBA/3yZj+Bms29JHFJQhoyCdoCdss9+IARA
         aV9/cEeIlCwBePeOWniYLC3lUa5G7n5w48lXy4tQXv2apX2v3vZ+Mb5iJqAkBchePrbw
         kubpqF3UxSdsJ3Y2hNp0zNuEmOGRBmTcGIAoZptWU3Ym5a6yFJkk5GU3dWn3hA6tv/rf
         jJG04+5rQmWyRpf4vK0lOMNf+SrzpRMoa5k3QzfYcaNl9S8sydOQT46c3uHT6+GS+KjM
         qVwlUC2lDhJLGgpkPHasXT6gz9uGlpT6VyuJPdm6R6oQmQofjVlS2ewvbvtYsyw0o5Aa
         KmAQ==
X-Gm-Message-State: AOAM533DLrb8IfNYw1BXjgSaVunlxIzXG7CuTgLU65wYwmkJNqCrYk9R
        18fJ1CYLZWOvVJF1ubKlXvEBRcm5dkg=
X-Google-Smtp-Source: ABdhPJy15Mkv0y85ptqFk8Lgyn3qPhD4Up7VnYILPyTyBM7ID7NQbuX7IYFN6UDc1/5SFEhJ2Y6Oug==
X-Received: by 2002:a05:6000:18a2:b0:203:d2de:d6dc with SMTP id b2-20020a05600018a200b00203d2ded6dcmr3396008wri.550.1647512014991;
        Thu, 17 Mar 2022 03:13:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/13] http tests: use "test_hook" for "smart" and "dumb" http tests
Date:   Thu, 17 Mar 2022 11:13:18 +0100
Message-Id: <patch-v3-13.13-2dffde32036-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the http tests to use "test_hook" insteadd of
"write_script". In both cases we can get rid of sub-shelling. For
"t/t5550-http-fetch-dumb.sh" add a trivial helper which sets up the
hook and calls "update-server-info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5541-http-push-smart.sh | 10 ++++------
 t/t5550-http-fetch-dumb.sh | 25 ++++++++++---------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index ab4b5cfcd11..2f09ff4fac6 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -419,10 +419,7 @@ test_expect_success CMDLINE_LIMIT 'push 2000 tags over http' '
 '
 
 test_expect_success GPG 'push with post-receive to inspect certificate' '
-	(
-		cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-		mkdir -p hooks &&
-		write_script hooks/post-receive <<-\EOF &&
+	test_hook -C "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git post-receive <<-\EOF &&
 		# discard the update list
 		cat >/dev/null
 		# record the push certificate
@@ -437,8 +434,9 @@ test_expect_success GPG 'push with post-receive to inspect certificate' '
 		NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
 		NONCE=${GIT_PUSH_CERT_NONCE-nononce}
 		E_O_F
-		EOF
-
+	EOF
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 		git config receive.certnonceseed sekrit &&
 		git config receive.certnonceslop 30
 	) &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 259203926a9..f0d9cd584d3 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -25,16 +25,17 @@ test_expect_success 'setup repository' '
 	git commit -m two
 '
 
+setup_post_update_server_info_hook () {
+	test_hook --setup -C "$1" post-update <<-\EOF &&
+	exec git update-server-info
+	EOF
+	git -C "$1" update-server-info
+}
+
 test_expect_success 'create http-accessible bare repository with loose objects' '
 	cp -R .git "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	 git config core.bare true &&
-	 mkdir -p hooks &&
-	 write_script "hooks/post-update" <<-\EOF &&
-	 exec git update-server-info
-	EOF
-	 hooks/post-update
-	) &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config core.bare true &&
+	setup_post_update_server_info_hook "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git push public main:main
 '
@@ -62,13 +63,7 @@ test_expect_success 'create password-protected repository' '
 
 test_expect_success 'create empty remote repository' '
 	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/empty.git" &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH/empty.git" &&
-	 mkdir -p hooks &&
-	 write_script "hooks/post-update" <<-\EOF &&
-	 exec git update-server-info
-	EOF
-	 hooks/post-update
-	)
+	setup_post_update_server_info_hook "$HTTPD_DOCUMENT_ROOT_PATH/empty.git"
 '
 
 test_expect_success 'empty dumb HTTP repository has default hash algorithm' '
-- 
2.35.1.1384.g7d2906948a1

