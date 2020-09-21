Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BEAC43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F57820684
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp/28MEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIUKk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgIUKkX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FF4C0613D0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so12104945wmm.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzehNjJ+U1CfCIjwuaPsZiKYV2LIjL2m/OfDO5nc5Ec=;
        b=Qp/28MEEbASgmekmUoTHojnBYCgaN7ElarhajI1Xz+6hY1Gl/2HSIiNO+kJPW2UXsf
         ysWhj/XCT/W0ne1soyXHT1qP771dlwALapWS//h8+KhpQeqENBr9QvDf9CxfcJTATa+0
         TgTkkSHIgK0vkEE+JBf416l5ooJInjodpp3ts2Izd/0rIwwFGsnRuEEInO8N4M17jA38
         6W+WW2m9blOBRIjDJDuQMcDUm94IA60lNRnYncK7TGXwMOeoNb2C/ClY4MgRcpMw7ApC
         TjXF/DEyeTpBSyJXvJQm/J2V08orca/rC/NF5opIoZrQNRdT6SfN8IBBLHYvxfdYAQxZ
         fpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzehNjJ+U1CfCIjwuaPsZiKYV2LIjL2m/OfDO5nc5Ec=;
        b=BSWS0U89kKzL3uEvXCd66URnKjBQ/GKLx2qkRFiBxiyWdsXf4XZZa87XKZgjNPqwP1
         aigSiQV+PKboHzYMPNXSywNodem3qnNtnMl/1R+6Rb7zAEW/rrZOgoasGy41ZiX6itNe
         lRJUz4wQGJwP8c2VjfWqoEvAKy15ibwpd2dIXA3u5k48Ebwx/9utCgizgY877hlTKtqa
         uoPNhZ+wSuVgTMtrewNVYnVU9PwEcDOdMKhSNoXs572olGNMmsPjcS6WecUNhC7IUJvN
         LmiQAyHvRKv9egb97HDM11iZ/05847VYzqiAf9NXCBS60dE/yfCGQCnFIit6KTIQsKig
         uU3A==
X-Gm-Message-State: AOAM531uuWUFuNaoZ8Pm5g9puD4LOaHpLCOTyMt9qRICefKpk1+Tbt3G
        n2CFH2QamHfPlJk8Jq6q9/UgEqK8Nhw22w==
X-Google-Smtp-Source: ABdhPJyUC1loa5eXspHyig0rilRMkuuIxVYCqW4znpFX9NwDJcg03V3pSpstZjoZp5Ec7VVdDrpE/A==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr28823794wmi.173.1600684821002;
        Mon, 21 Sep 2020 03:40:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/18] remote-mediawiki tests: use test_cmp in tests
Date:   Mon, 21 Sep 2020 12:39:48 +0200
Message-Id: <20200921104000.2304-7-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that used an ad-hoc "diff -b" invocation to use our
test_cmp helper instead. I'm also changing the order of arguments to
be the standard "test_cmp <expected> <actual>".

Using test_cmp has different semantics since the "-b" option to diff
causes it to ignore whitespace, but in these cases the use of "-b" was
just meaningless boilerplate. The desired semantics here are to
compare "git log" lines with know-good data, so we don't want to
ignore whitespace.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
index 9106833578..4c39bda7bf 100755
--- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -28,7 +28,7 @@ test_expect_success 'Git clone creates the expected git log with one file' '
 		git log --format=%s HEAD^..HEAD >log.tmp
 	) &&
 	echo "this must be the same" >msg.tmp &&
-	diff -b mw_dir_1/log.tmp msg.tmp
+	test_cmp msg.tmp mw_dir_1/log.tmp
 '
 
 
@@ -50,8 +50,8 @@ test_expect_success 'Git clone creates the expected git log with multiple files'
 	echo "this must be the same" >>msgDaddy.tmp &&
 	echo "identical too" >msgDj.tmp &&
 	echo "identical" >>msgDj.tmp &&
-	diff -b mw_dir_2/logDaddy.tmp msgDaddy.tmp &&
-	diff -b mw_dir_2/logDj.tmp msgDj.tmp
+	test_cmp msgDaddy.tmp mw_dir_2/logDaddy.tmp &&
+	test_cmp msgDj.tmp mw_dir_2/logDj.tmp
 '
 
 
@@ -135,7 +135,7 @@ test_expect_success 'Git clone works with one specific page cloned ' '
 		cd mw_dir_8 &&
 		echo "this log must stay" >msg.tmp &&
 		git log --format=%s >log.tmp &&
-		diff -b msg.tmp log.tmp
+		test_cmp msg.tmp log.tmp
 	) &&
 	wiki_check_content mw_dir_8/Namnam.mw Namnam
 '
-- 
2.28.0.297.g1956fa8f8d

