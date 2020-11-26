Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FAC64E8A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDAE21527
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W697CzZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391810AbgKZWXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391803AbgKZWXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67889C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so3713431wrt.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJtcxL8aARA3ie7Ihmdc3YxDALsnvjDeHb3uMrIef3Q=;
        b=W697CzZeKSjuzoDAxY4ff/NZRG3tSMWhUFKhKZkC7X/ThaNQsrQbNBRBngXJrORWIQ
         FeauxZvl2ZHyoTXtaVhnBAjZHWwMtW6ldfHuDVqRE1/oj+ptqWrAuz9uFlg2ormFlsUc
         EMe1GvMdIVak9x29YWtAZM8NR2OuONAvs4aFKydfbu9BFMzGBUKUhjEvdKU9I2Xiy0AX
         AmJjttWiIoAL9mzp5ZYOh8+MjPISSbRLPBUw/c4AdH8qUrJcNn9tAi2/SFAWP6jD5lLh
         dEsWr5jzgDzxls78hez2fYkJhAeObPj/S9hAM6kNgjDMmTn1BGfI4VuIKTcu8MQ/Uy7h
         ODUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJtcxL8aARA3ie7Ihmdc3YxDALsnvjDeHb3uMrIef3Q=;
        b=MYOxHYuIEMWaN8yhtQzscbqTynsiqUJQb18X/SJX/KlSULPOiYqEKB2xrgfDSkSN44
         +NEMomUQUeCcWZUCgWcf0jR5r9tBvlNmDJW2dkg70po8J2LSM8bjn5t7rnvCmPoFCeGn
         +ecRrYujeSqB1go5EaxQBLLoLf0GQ781CQALY6WLGKnn8w4sD7UVQ5w92p6cC0L5/gI8
         O0xfeh2zu2dvAFM3cQzcXrugYnkXHddhV8jPIVGRn2TY/fwR8qvvx9ck11mFiYFhU7hO
         fPzpj8whSSKW7FZKjdQiuYTHMyneLgGq8qiPi/o8AJ1XGl3twWhpG+xYH6kZDb74/f8w
         Unbw==
X-Gm-Message-State: AOAM532aVLSSWRCzxmDjLWr5j7HJYIMGhkZ2Caz+wqoL7CXoEI0vixoL
        jNeXAwC2//Q15SVqz4goe1u/BgJ6xt8Wdw==
X-Google-Smtp-Source: ABdhPJwf4s99FYTmSwwJSuRK37S/NZeem4aSCPj4N0G7jv3SZ4shgR7TvHY4rbq79tz98RH03Zm3Ig==
X-Received: by 2002:a5d:528a:: with SMTP id c10mr4722075wrv.270.1606429394859;
        Thu, 26 Nov 2020 14:23:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] mktag tests: remove needless SHA-1 hardcoding
Date:   Thu, 26 Nov 2020 23:22:53 +0100
Message-Id: <20201126222257.5629-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests amended in acb49d1cc8b (t3800: make hash-size
independent, 2019-08-18) even more to make them independent of either
SHA-1 or SHA-256.

Some of these tests were failing for the wrong reasons. The first one
being modified here would fail because the line starts with "xxxxxx"
instead of "object", the rest of the line doesn't matter.

Let's just put a valid hash on the rest of the line anyway to narrow
the test down for just the s/object/xxxxxx/ case.

The second one being modified here would fail under
GIT_TEST_DEFAULT_HASH=sha256 because <some sha-1 length garbage> is an
invalid SHA-256, but we should really be testing <some sha-256 length
garbage> when under SHA-256.

This doesn't really matter since we should be able to trust other
parts of the code to validate things in the 0-9a-f range, but let's
keep it for good measure.

There's a later test which tests an invalid SHA which looks like a
valid one, to stress the "We refuse to tag something we can't
verify[...]" logic in mktag.c.

But here we're testing for a SHA-length string which contains
characters outside of the /[0-9a-f]/i set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0e411e3c45..e9d7799537 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -43,7 +43,7 @@ check_verify_failure 'Tag object length check' \
 #  2. object line label check
 
 cat >tag.sig <<EOF
-xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
+xxxxxx $head
 type tag
 tag mytag
 tagger . <> 0 +0000
@@ -53,10 +53,10 @@ EOF
 check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
 
 ############################################################
-#  3. object line SHA1 check
+#  3. object line SHA check
 
 cat >tag.sig <<EOF
-object zz9e9b33986b1c2670fff52c5067603117b3e895
+object $(echo $head | tr 0-9a-f z)
 type tag
 tag mytag
 tagger . <> 0 +0000
-- 
2.29.2.222.g5d2a92d10f8

