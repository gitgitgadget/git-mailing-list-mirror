Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B11C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbiCBR3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbiCBR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A176DFCE
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a5-20020a05600c224500b003832be89f25so1712517wmm.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVhMduWjY0+ZV5ohOgkGQuyvuX3pmF6ixfLxtAgmbd4=;
        b=lg8dvEwAn3pcMTAvhFnRGadDhQ3ivzSxdRyMxriQTxjIDW1PsfauqvT3HIz92zte3a
         2vySf6mumzgU/vGGs+8sM4BnvmFNaGnprGjy9qJlCawNOsMZU48N9BH5BBgK9AE5fjTG
         j1JSUqL/3Botllj7ozSCbaxADFaN7lCD8EwDdwtQnYm9lpeGC0Nj+7qHku6vNcwvlxf1
         sN9Rb1F6T/0t3zTdO+ksMg5KVD9RSRTZ7vVWIlADx3dO1H8gjJHO82fl2L4wZPQIqjKt
         pSwxV+LM2re8Bj5XglXzo2nw2M8Frk2WkUsmdgVGXm0AVr4xnGjnzh7hXw1aydBxk1bO
         28Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVhMduWjY0+ZV5ohOgkGQuyvuX3pmF6ixfLxtAgmbd4=;
        b=ZBi9DCqoj4lOLFya/82khzzF2V6NLi5M3IvckqXDcDAlSjvPaUxNyuIZ/ULcnsqgcT
         UxnckNIgOXQvcme2/rLRS4YyLopoMSug73YU+Hbmd1yLTTulL2idp2cGKMk3MwMC+hPf
         fMHNGVdWiemqYGXT0WzgbxM/3EEkS8Kj39uK5qUKxOe9bQbz6Pd3zH2q60mwgr9d/skz
         FuoG4l8QKYe60JP66CVC/ldE5y6N0wW8Dsr64Xo32czcRINnDFu87bx9ef+ozjP1IBMQ
         RMXE0HUIUttBKomcapGSvl9y1qSRFRb0vCwnIyWJPT1J9AquLgqwD5suwI3E8a0HrpzB
         b8Sg==
X-Gm-Message-State: AOAM530woCPcbZwQYJLutoQ8Hy2fw/MeNWWjaKC05xbRP7gSeUAoLUav
        Op9Y4eF3fxMz5tTrge65LzqBfS8ZbNu4hw==
X-Google-Smtp-Source: ABdhPJwkXfFHFBSBzQIBBe6pv2zG8JRH13SjsPKpQasRyiWzHu9oSYfk5sN5nRvm3hmsQiTjGbbd7w==
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id m124-20020a1ca382000000b003810cfd5564mr664592wme.103.1646242055204;
        Wed, 02 Mar 2022 09:27:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/15] apply tests: use "test_must_fail" instead of ad-hoc pattern
Date:   Wed,  2 Mar 2022 18:27:15 +0100
Message-Id: <patch-06.15-7952ae1f3b5-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile test pattern introduced in 6b763c424e4 (git-apply: do
not read past the end of buffer, 2007-09-05). Before this we wouldn't
distinguish normal "git apply" failures from segfaults or abort().

I'd previously marked this test as passing under SANITIZE=leak in
f54f48fc074 (leak tests: mark some apply tests as passing with
SANITIZE=leak, 2021-10-31). Let's remove that annotation as this test
will no longer pass.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4123-apply-shrink.sh | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index dfa053ff28e..3ef84619f53 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -2,8 +2,6 @@
 
 test_description='apply a patch that is larger than the preimage'
 
-
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >F  <<\EOF
@@ -41,20 +39,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'apply should fail gracefully' '
-
-	if git apply --index patch
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		status=$? &&
-		echo "Status was $status" &&
-		if test -f .git/index.lock
-		then
-			echo Oops, should not have crashed
-			false
-		fi
-	fi
+	test_must_fail git apply --index patch &&
+	test_path_is_missing .git/index.lock
 '
 
 test_done
-- 
2.35.1.1226.g8b497615d32

