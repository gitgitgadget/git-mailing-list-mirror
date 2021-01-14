Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E07C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199B523A7C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbhANXgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhANXgG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A4C0613C1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d13so7471266wrc.13
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfwoASSzu0AuErOvjiAgsPgDasYzNYUmrfvCyq/v0ME=;
        b=DYTMLp2rgKo1UT8mrq5ZkDsg45hfgsjS39vfnlMbT+bf8TTS38bkQPzgc0UNCNT3u8
         3TA2Crukx/sHt5zsxmC9+EjdlcFj56fm7l4ceO/vf//fwglxa+mv4eOcOyY2Z1dG9de+
         HrUUUUCZUPF7Z9wc+QhAbsG97fETl4fqsHsOnnvcu+uSVTkoZIHD5eV2r6fk2QjT1wQy
         lWOlsuS1AVZAtVUuYF0WsRlhizN75lOWg4M6k23n0G5SkjgcDuSmdLDUk6oIva6ei490
         AYz1PwV8aI04f1iUc71sRFLpvoPmm83yCdhcKMbd/ppwJbX68pG26TTaVI11WeyCGXWR
         TIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfwoASSzu0AuErOvjiAgsPgDasYzNYUmrfvCyq/v0ME=;
        b=lFK86b47CJvB2FahXViYKUy2Hc2Ge/5G9voZKIGy00RWxt+tM+PvRM8cy94MOwgv3l
         fcl8FgqHQ+MwhDBZmJrNeUn6zWgPuRL7UQOGyo4mAhvB2thy8H4cQW7KhT9KD7QSjpsx
         hCwdX8zZ92UXWcK9aS3XaSLZMmK2byXpLciLmdhUo+qTbc6oP/Uet8oZKhn3xQO6ph+n
         EzhEdyzJwho60t/Fvfu0EN2Z9Q7VyThguRdxNxKsrbpMcQcpfxboPppwVKHCt6HHMeOH
         w91WDyuy/jg2g2FRou2N6PMRrzkrjRZdxwri7s9o0oqCpM/HlsUNxrEkb8TegEbTTFzd
         fTaQ==
X-Gm-Message-State: AOAM532+JHnR5EDXFgvKoYbQxNzkYR6K93Yhlpxg1f110gQTqTG4SR6r
        LzmWnRSqE3vVhUQZnQcq0sW3Rlf0CGuDDA==
X-Google-Smtp-Source: ABdhPJy0yuIdH2wqyG1xGPYRdgCd8VG/sPKMelakKRPHn2njpH5ONWfrMzHyPq733H9fbcY7SjduiQ==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr10207292wru.410.1610667324543;
        Thu, 14 Jan 2021 15:35:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] test-lib: add ok=* support to test_might_fail
Date:   Fri, 15 Jan 2021 00:35:11 +0100
Message-Id: <20210114233515.31298-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the same ok=* support to test_might_fail as its test_must_fail
sibling. This will be used to make it accept "sigpipe" failures.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh        |  5 +++++
 t/test-lib-functions.sh | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f90c375fe9..fd6cb8d5d3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1332,4 +1332,9 @@ test_expect_success 'test_might_fail is like test_must_fail ok=' '
 	test_might_fail git version
 '
 
+test_expect_success 'test_might_fail supports an ok=* option like test_must_fail' '
+	test_might_fail git version &&
+	test_might_fail ok=success git version
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a..e01761f7ba 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -918,7 +918,17 @@ test_must_fail () {
 # Accepts the same options as test_must_fail.
 
 test_might_fail () {
-	test_must_fail ok=success "$@" 2>&7
+	case "$1" in
+	ok=*)
+		_test_ok=success,${1#ok=}
+		shift
+		;;
+	*)
+		_test_ok=success
+		;;
+	esac
+
+	test_must_fail ok=$_test_ok "$@" 2>&7
 } 7>&2 2>&4
 
 # Similar to test_must_fail and test_might_fail, but check that a
-- 
2.29.2.222.g5d2a92d10f8

