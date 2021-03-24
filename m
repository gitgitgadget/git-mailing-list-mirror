Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04D0C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 02:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734AE619E5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 02:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhCXCMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 22:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhCXCL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 22:11:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E34C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 19:11:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so350954wrw.10
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6hVvQr/cjZyW4ZvfYhU2vv9+OswGqpRE8PnXiZt9DM=;
        b=KjSRp1vvxIeALjqetwQxARgUTKlPfFcg6CYdcFcV2QfndXHn1ICU/lAJ8qgH4E4+J0
         BflRCUOVRqZ6HL43un+r6HqQ6mEbbUxJ6MQTMezWxTm2I/woV1Kl8h7eVbrVz4rX07dk
         o4YFf4DAM3hVa+hz1IEkcG+r0zYLThVLRHx9dLZHj/PKT/Szn6HI5QEZopscJfcsqLdw
         M2G74soQzwNHddpstcF5gmpFkP744AjxIHNTPcv2LD1yX1A88gzJD6mVqNfCnAsG3Xy2
         B8wtZ5NcJ7GeBVdINUsOqfG7+WlA813IXUVAStI7Wrfy8kMhbHvMc0SZduMVnSG3pgVf
         nuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6hVvQr/cjZyW4ZvfYhU2vv9+OswGqpRE8PnXiZt9DM=;
        b=FjsdaozoQ4uZB7B2lv0SZuFy+ew+pEesLlf/VUkBUOAjnjBSQoLy0paVooOICP2FaG
         ChhFUjQYzRNaS4TCnpgkYcmAbneg4KHTnfPrvnaYXxbVD0d3qXB06TJqv1wUCe3Z1+9J
         /fgtQu1LhI1DsUr9zafnOav7IoDmKk9KHM+5DXrVPEWJ0WMI6hfqXBDP7g7Q8MTk5owK
         hQuq7p0Z1ZyxL9UX0O0pW/dGPZwpm7ODuSbb8zkgq7LLGRnD5/rWoV06/2wyN2exPpHo
         vOwTAa1oDLcYa9S7kjC6xh72OE6fAK/i5K/dNCFldyyIjiRM5OpHWZN3nxaiCnWAmVTk
         QIUQ==
X-Gm-Message-State: AOAM533YZE7Dc+7nGAafo2w7gYexuk9JOZQnn/3c/atQSi2NDAVFiFB3
        VOd+47k+UE3Ojb2K8LgHtw/ubrxwo207Qg==
X-Google-Smtp-Source: ABdhPJymciKMiYJ6howXfSB4MmvFkSkK5piD7xxecBJn91/rEdxqEml1W288Y0qxr7mIjKLFUGJEvQ==
X-Received: by 2002:a05:6000:1789:: with SMTP id e9mr801361wrg.237.1616551916231;
        Tue, 23 Mar 2021 19:11:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm4876947wmj.1.2021.03.23.19.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:11:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        ric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] mktag tests: fix broken "&&" chain
Date:   Wed, 24 Mar 2021 03:11:52 +0100
Message-Id: <patch-1.1-0b43e43b949-20210324T021049Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.354.gc8cbd507b5a
In-Reply-To: <20210307132905.14212-1-avarab@gmail.com>
References: <20210307132905.14212-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a stray "xb" I inadvertently introduced in 780aa0a21e0 (tests:
remove last uses of GIT_TEST_GETTEXT_POISON=false, 2021-02-11).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A v2 of a stray patch of mine that wasn't picked up during the release window.

Range-diff:
1:  bd8235ead3c ! 1:  0b43e43b949 mktag tests: fix broken "&&" chain
    @@ Commit message
         mktag tests: fix broken "&&" chain
     
         Remove a stray "xb" I inadvertently introduced in 780aa0a21e0 (tests:
    -    remove last uses of GIT_TEST_GETTEXT_POISON=false, 2021-02-11). This
    -    would have been a failed attempt to type "C-x C-b" that snuck into the
    -    code.
    -
    -    The chainlint check did not catch this one, but I don't know where to
    -    start patching the wall-of-sed that is chainlint.sed to fix that.
    +    remove last uses of GIT_TEST_GETTEXT_POISON=false, 2021-02-11).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     

 t/t3800-mktag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 60a666da595..6275c98523f 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -17,7 +17,7 @@ check_verify_failure () {
 		grep '$2' message &&
 		if test '$3' != '--no-strict'
 		then
-			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&xb
+			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
 			grep '$2' message.no-strict
 		fi
 	"
-- 
2.31.0.354.gc8cbd507b5a

