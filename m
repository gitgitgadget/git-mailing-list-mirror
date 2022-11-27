Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8BC4332F
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 14:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiK0Ovs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK0Ovr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 09:51:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877CFAC1
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b11so7299810pjp.2
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoVKrJO0pYuCyTNyU844RV7OS+GgoOb5atv+h4IDKGA=;
        b=ON2IuVYNoHxwgLuO3l2+0C3Ytypwd8xGxRsGQ12D2hCCQ6K0HqpH+gjfeTeHmvJk70
         AJ+KYfrNLihI2qih32lY4Hxl/u3cfyMVe4a4aBHf6T2Uv5/G9OejYCQlfS+yU79c7oeE
         6n83IGVigsHEKQtzDYfB4I5BAC3zOydh18hyH4Xj7KWTWrwkYGTruOqpIlG4kMUk/X2h
         2k83eR+urgeRAAUeu/W374V+GKoImKpWPbShaALdAxw9X4xxebMSzNu7K/hUJt/RvTZw
         wF05LCuQSObKFUKULV72RuRVWJ7OyAWsfdYnn1Fyv7N3JlwF2s+gjzmSrdNKmh+O5eh9
         WTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoVKrJO0pYuCyTNyU844RV7OS+GgoOb5atv+h4IDKGA=;
        b=0CLhGQBYgsOXMTIzAzF97WhqIkYLvZdAk7gh1Z6a6jr5Inq4OOxGUoPp2OpyD8e4n6
         jrEJppfnJ7x66fZ4AbtBg+eDTmNxAxBXVD7TwIlwPZDcZCQiY0S+KA1RhUEuxR+8/1qb
         tgjG0Ix5lpiGYRiuGagTxjxICeTX7bteZd2S5qo37y1FcYfG5D1VsGq8bevwQtCGgonj
         2EAjx9uhOx351tg1IzsaxSCBIUrBN1oM4HpfxJr0nt6uPGhKO6xocry/FxQlvZly6O5x
         h1O6qRGU/GZOik3P8nup4DaUyyQdsP4YkX4aCKWKvV4URuetGulAEzyeYAMWv3ZYEXDD
         b8Iw==
X-Gm-Message-State: ANoB5pmmf+RUBU64eMtouXfAewUP+wzEoBjYPjCBMGBkgY/kPMsaBg97
        TKGIA/d40xR/a+6WaNS/YeCRn4qbCX4=
X-Google-Smtp-Source: AA0mqf5cmmZ1FGeo0pAaBtt3oWmHvGwVUCS4n5O4Mgw+wsbAL6VaRpXhkzTFM6AJLazxRbX64nn4VA==
X-Received: by 2002:a17:902:f114:b0:189:8001:b55b with SMTP id e20-20020a170902f11400b001898001b55bmr4291014plb.130.1669560705872;
        Sun, 27 Nov 2022 06:51:45 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a058800b002137d3da760sm7915050pji.39.2022.11.27.06.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:51:45 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v1 2/4] t1301: use test_when_finished for cleanup
Date:   Sun, 27 Nov 2022 22:51:28 +0800
Message-Id: <20221127145130.16155-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 7578e75d77..1225abbb6d 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -25,6 +25,7 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 for u in 002 022
 do
 	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
+		test_when_finished "rm -rf sub" &&
 		mkdir sub && (
 			cd sub &&
 			umask $u &&
@@ -42,7 +43,6 @@ do
 			;;
 		esac
 	'
-	rm -rf sub
 done
 
 test_expect_success 'shared=all' '
@@ -132,6 +132,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 '
 
 test_expect_success POSIXPERM 'forced modes' '
+	test_when_finished "rm -rf new" &&
 	mkdir -p templates/hooks &&
 	echo update-server-info >templates/hooks/post-update &&
 	chmod +x templates/hooks/post-update &&
@@ -174,6 +175,7 @@ test_expect_success POSIXPERM 'forced modes' '
 '
 
 test_expect_success POSIXPERM 'remote init does not use config from cwd' '
+	test_when_finished "rm -rf child.git" &&
 	git config core.sharedrepository 0666 &&
 	umask 0022 &&
 	git init --bare child.git &&
@@ -193,7 +195,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
 '
 
 test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)' '
-	rm -rf child.git &&
+	test_when_finished "rm -rf child.git" &&
 	umask 0022 &&
 	git init --bare --shared=0666 child.git &&
 	test_path_is_missing child.git/foo &&
@@ -204,7 +206,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 '
 
 test_expect_success POSIXPERM 'template can set core.sharedrepository' '
-	rm -rf child.git &&
+	test_when_finished "rm -rf child.git" &&
 	umask 0022 &&
 	git config core.sharedrepository 0666 &&
 	cp .git/config templates/config &&
-- 
2.39.0.rc0

