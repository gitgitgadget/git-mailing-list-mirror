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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CFBC433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CC960FE7
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhDARx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbhDARtU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:49:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8EC08EC93
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:56:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e18so1920526wrt.6
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTM5X/k5avj5ohBB3J/UAr0QKLyPsqv39X2A1+E5YaU=;
        b=dXW0L9NXJ6JWa+8gXNm1zQKBKXrWj9IGNDbCw6uXxtXraRTGq7hbEDXJdvY689RMxr
         okQaj/m5V0HAPmWEpFitisKBGoRPAkwMO0diUhjGHno+gFO2wapmeLAyhWWtqYabzbai
         pQ7b35dD4QUzDZvUc0drDO5rwHPnBqa7uXkkakJMTKdE3dwI4F23IGKBNgbuBmNkYCGU
         UQrIG2WtwnWmVLfvf2djlLIaeveiCFUVAvSv2a2qbdaQ66JMq58WjDcXgitUVZIX0s7t
         XdEWOBZupQDEv38IWVmlyjvFDvneinv7Kwjd77xM3H2zTRsMA9f3IcGF7UjRstlfZlwt
         6z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTM5X/k5avj5ohBB3J/UAr0QKLyPsqv39X2A1+E5YaU=;
        b=BKlR1BYJtIDFfttcWNvRC5fOQAtVigx9fZMpgXqYrE2G83Wd/oCxSTZNLY9oQWlPQW
         7vlEmicDdbABTin5XgyVSeW3YY0aXEFZDEZ4M1ORWOC6qNKD/99zqO9OguZFKh2z4LBe
         a9O0iECeR6gO/IwjOXL+Y9QSeoCPFmLg4HeMT6PvTF6a2Nrro/xfNlv4JimyIYhrI8Ls
         ORoOmAY4VxTpt9/EaE/8skDQyGvwKXT8u9f8U41BoDhsHqzP8JxyaZ9Up5HPNUY6c+0L
         e+0QqlEuoGLWZdpGuqx8igvwyYh0d46ynMtqXhSmrvYyRwiwGicRsyneM6B2gmWh5gVm
         Mo+g==
X-Gm-Message-State: AOAM533NxLO31EDv2b5Ul2IQkTUk7wHJP2uutDIruTxi6mwQpWxhKCt/
        R8pFJ9vbEaKp/iEpe6E6yGra6nuMaw7IzA==
X-Google-Smtp-Source: ABdhPJyRkOMy6p5UsDnVJRoCP4q97k60yjztL7ckEtqn55L/5vh17pFOAm3JBF83Blz4XX5kprf8yQ==
X-Received: by 2002:adf:9d82:: with SMTP id p2mr9895279wre.234.1617285396756;
        Thu, 01 Apr 2021 06:56:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7sm10145770wrv.71.2021.04.01.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:56:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] mktag tests: test for maybe segfaulting for-each-ref
Date:   Thu,  1 Apr 2021 15:56:29 +0200
Message-Id: <patch-4.6-403024b1cca-20210401T135419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net> <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to check that "for-each-ref" fails on a repository with a
bad tag, this test intentionally uses "! " instead of "test_must_fail
" to hide a segfault. We'll fix the underlying bug in a subsequent
commit and convert it to "test_must_fail".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 4673235b1fd..10e4fde28de 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -58,7 +58,13 @@ check_verify_failure () {
 		# The update-ref command itself might fail, but we are
 		# not testing that
 		echo "$bad_tag" >"bad-tag/.git/$tag_ref" &&
-		test_must_fail git -C bad-tag fsck
+		test_must_fail git -C bad-tag fsck &&
+
+		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
+		git -C bad-tag for-each-ref "$tag_ref" >actual &&
+		test_cmp expected actual &&
+		# segfaults!
+		! git -C bad-tag for-each-ref --format="%(*objectname)"
 	'
 }
 
-- 
2.31.1.474.g72d45d12706

