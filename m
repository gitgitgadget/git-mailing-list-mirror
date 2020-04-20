Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4141C54FCF
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25FD20A8B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdheBUiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTIy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTIy5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:54:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47173C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so756179qvz.8
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wfxmUCNHsYwhfP0jz3kebhckh4R4wMQOqHpWFT7Iuic=;
        b=NdheBUiG+KiXnUjCGrjuiWfB0xDVf01lqHVAeA2IVtYcZ5x0mo+Xv1F+KUIJH2vRZ8
         k8iRFXhDNfj5dsAQsfjD/AQy4c8IqGP/iPTvCYAoRORAHL/2WDTA3pkWqbPX/1d2Q1Nj
         yC14fHeI6MBqE0xsX/UaDq8c0TSBbgXj6Z9iCEtCKGaTaNnW7bEdFxfIl3H8HBp/aDVM
         rYNRnxUliqrwDu8zhR2fQ2Pves3QwFuIBlheB0e2H91X3aM/Cf1I0uk84j/Z8aBFLugq
         sAhbXIDzNpgVOs7jagQnheLg1esD82H1Qj/ll0t8j3WsU1BTUBU5ZF1iXInURxSgkNls
         0zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfxmUCNHsYwhfP0jz3kebhckh4R4wMQOqHpWFT7Iuic=;
        b=kNTHjvhMzmIYy5p7qNTXWZRC3rqB6XSV2jR38W7HL7H97uWhnQrtAm1Oi1vEPk5y99
         YgiAaJ+Z+O0XRXqV45aSjJEz/rATqzJMlPj9530YpEAEIzmiXplfCnb+9B7Vrf1M60tN
         JAuoXsSbKeLTqEHt2OhsTl9IdEweSIhVvro3TTgS/onj1ZNteWAuE8r+2gJa/onvAn8B
         SPusOpCwYtjaEbnRSr2dftG5wLFbFKoCKlb54vECGKQzdvRbF/1T8i4r/0wlGat4GgYY
         DQjn1g9zjVLit8lA2ghLAd/iDCP2zAV8SEF4KAodDtpWHuwxRbSqU+DKOpUscIKJBZ5/
         8lTA==
X-Gm-Message-State: AGi0PuZaDjnoWqkS5EWXSrG4zICtZFcmgHO8ccxo7/pw4xghhry5yK45
        KLvOzFFO51V89VAO+30ebTPiJkVI
X-Google-Smtp-Source: APiQypK4dXjpFoPiXaX47iqQO2jl6QJfh/vUIZSqSo7FvTLwE3+LyNwt2PBq6a2B2E4QKMIqlIcb2A==
X-Received: by 2002:a05:6214:17ca:: with SMTP id cu10mr8566457qvb.166.1587372894977;
        Mon, 20 Apr 2020 01:54:54 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:54 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/8] t6030: use test_path_is_missing()
Date:   Mon, 20 Apr 2020 04:54:39 -0400
Message-Id: <f0b6b8916a2eac7aafdd9afe5d59306a7720b217.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we should assume that external commands work sanely. Replace
`test_must_fail test -e` with `test_path_is_missing`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 821a0c88cf..1313142564 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -148,7 +148,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" created if junk rev' '
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
-	test_must_fail test -e .git/BISECT_START
+	test_path_is_missing .git/BISECT_START
 '
 
 test_expect_success 'bisect start: existing ".git/BISECT_START" not modified if junk rev' '
@@ -166,7 +166,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken rev' '
 	test_must_fail git bisect start $HASH1 $HASH4 -- &&
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
-	test_must_fail test -e .git/BISECT_START
+	test_path_is_missing .git/BISECT_START
 '
 
 test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
@@ -175,7 +175,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 	git branch &&
 	git branch > branch.output &&
 	grep "* other" branch.output > /dev/null &&
-	test_must_fail test -e .git/BISECT_START &&
+	test_path_is_missing .git/BISECT_START &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
 	git checkout HEAD hello
 '
@@ -485,7 +485,7 @@ test_expect_success 'optimized merge base checks' '
 	git bisect bad &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log4.txt &&
-	test_must_fail test -f ".git/BISECT_ANCESTORS_OK"
+	test_path_is_missing ".git/BISECT_ANCESTORS_OK"
 '
 
 # This creates another side branch called "parallel" with some files
-- 
2.26.0.159.g23e2136ad0

