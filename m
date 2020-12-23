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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD0C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B062256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLWBib (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgLWBia (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD31C061285
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 91so16990301wrj.7
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEQWzeAkuyQQ9sFxG2xYC+ZXsn1ecfSSbM11lQUfzTE=;
        b=O2NVgCFyU2H6zudK+nqy/HLRXpQ3sqy9zCB9AyDf+dEQoNV5upSvOFNZvz97v0hK2S
         wVV2qnUySDD3Wcw1zomkHUPaFuVAC3ZBBMoaA9Wnf8kk0ck49GWftemJQSJiSgBsDcBY
         sWYid9M0A4kRCv5EEkytpXVuHX1HoYW92/wqU4MubLqm3f9pjBlzlQ3gCyVpEDklAFJJ
         rLv+pzVLoabGDTWNBdiu2xdrE3IPh9fmVkGKm7IyT12enFHErZjQSwSpr9Rfd86AGpNa
         dIeyqHCRYtIZXgGdO+m/4/dEHjluqY06MGSOooNLlJErwno4+4bBCJdWysDxVpLaxwdQ
         3UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEQWzeAkuyQQ9sFxG2xYC+ZXsn1ecfSSbM11lQUfzTE=;
        b=VyhON2QhHWrQSHC8tSF28i2lIfYIgb+PkTTFjyK5r0OSPYzY5k3tXPDNQmOQzS7t9P
         Tji6dZ/h0w5zQAvHGNioop2cLwRzIpgAOrTSzI/+/JKlymJKXA1GaWsrZ5XnefjOBL5G
         dk71js7QLFNWD7q+mQkQKWznbQI19aCgQN32LBl1XiUlws5Xq4M3FdQ9nyCJp8t8a/u2
         ji7Yu4+VeUIIvXkPvaxL/97Lo8PQOlR9RKj0YAyMdUZCI5GynkR08+BMDY8cs1heDW1q
         PLWW2h59xPTth0/k9ZNFNlnntQpsBfdmnYTVovERg23/GaKT5Oh+yahiv8DuEkKT12Ff
         8EEA==
X-Gm-Message-State: AOAM533T98JEE+L/MhEnnDTQtoV/79DwetWI/63J/9rN2Z2nAK45lZGo
        ukIM8tKAMU+ElHkKlh/buM6b0tptGdAoMQ==
X-Google-Smtp-Source: ABdhPJwoi6K2xHWovbdOB7vp1TWLoMp4LgWMvf8GTCZi96FgCUwHUZG2EI6gTCGJI+iwPWvxTOo6Ag==
X-Received: by 2002:adf:9d82:: with SMTP id p2mr14826242wre.330.1608687467413;
        Tue, 22 Dec 2020 17:37:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/20] mktag tests: remove needless SHA-1 hardcoding
Date:   Wed, 23 Dec 2020 02:35:50 +0100
Message-Id: <20201223013606.7972-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
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
index 0e411e3c45..a22a0954d5 100755
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
+#  3. object line hash check
 
 cat >tag.sig <<EOF
-object zz9e9b33986b1c2670fff52c5067603117b3e895
+object $(echo $head | tr 0-9a-f z)
 type tag
 tag mytag
 tagger . <> 0 +0000
-- 
2.29.2.222.g5d2a92d10f8

