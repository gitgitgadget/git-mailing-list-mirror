Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA0BC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbiCBNXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242135AbiCBNXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E11137
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b5so2794313wrr.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiT/ZFJzI5gxqe7i0GcAGxq0NF6Q6YjCHESnLDeHntc=;
        b=gGgEaV7y2qonPyW7Bi56HTrNfF6Oo/cr3mwZdPA1mnkWicR8Qkh5q+WYdZHn+lQ+IA
         pJFmyosZV4/0gYUOnWZ8dLFlBEesb9K8Sy8CTC5XZstT9YVnN9bSfjdPbVM1imj/bwAV
         Fwk5wSN3xt9s+vesW03IYTpJZkd70uju68bE7OpVbSauZyf+aGOBgrjesX8Hk6Pe/KUV
         gpwHHLGh5cawF+OZtowxZOCggt0onFNAIxUJwHseSMvw8o1V38enbamdCJyOGsHh/zqg
         x2eJMa5duJnytWdJPKPDBclyoc4bXzcnE0AIX/58Pl+jm7uTqyjIagZl1TY0T3Iqan1c
         z5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qiT/ZFJzI5gxqe7i0GcAGxq0NF6Q6YjCHESnLDeHntc=;
        b=ZZ6vVX7gJgvtUTJXtlfA84cP5pwLDiXjcJkpoYJdfzbWA05eK3NthU+eiMoIRwj4P5
         unNLfv+LaxeJnhJZGo+uhd2dOGc76DQnAOIxeVlB5q2WXahnSi52F0bDH+9pk8ckLSM/
         IuLSsmMXvgRyXbhN2/NfSFTQaxz4QXuWTveuxuWxziLaCdKz/0+p2u4n7LoP+0tcMcMw
         ++FTg5mtvcEkTkHnFWAxX/fQfgLiQg+3/hRvmFM+jbjvT73MQfNY+Au5tXV8Eea3ss0c
         esMHYFlxrRUbHrVJ86E8WCcOTJIRrwRfM/bdg/0B+YEYRyo0+3zeapFz9Z3A06SxyZA9
         z37g==
X-Gm-Message-State: AOAM531QZiliRyTlukzhh4Jn4gzuz3lilaBf6BuPF5GixWIu6WzwvivE
        zC6JO+UnrZn2eLpiTSwY7vqBgU0fqPr/0g==
X-Google-Smtp-Source: ABdhPJw1M+Lb1DM+kluRnCXj1JFWXLDTAcn0sCdHL6QcX8+Zs3UjHvf0h8XiTXqDImop4h7a7GD0PQ==
X-Received: by 2002:adf:e5d0:0:b0:1f0:22ee:5828 with SMTP id a16-20020adfe5d0000000b001f022ee5828mr4357130wrn.516.1646227356251;
        Wed, 02 Mar 2022 05:22:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] t5540: don't rely on "hook/post-update.sample"
Date:   Wed,  2 Mar 2022 14:22:21 +0100
Message-Id: <patch-02.10-4bee939a894-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
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
index b0dbacf0b9b..380e97c1762 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -42,7 +42,9 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	mv hooks/post-update.sample hooks/post-update &&
+	write_script hooks/post-update <<-\EOF &&
+	exec git update-server-info
+	EOF
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
-- 
2.35.1.1228.g56895c6ee86

