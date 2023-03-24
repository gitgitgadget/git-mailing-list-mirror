Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77225C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjCXUyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjCXUyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B565BA
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id er18so1445862edb.9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDaPxSGgIUOG1uM2q0vvMxPBkJdqqLH8giy72dWAzag=;
        b=VXELx8ZYWfP8khnKaQujAZng1N4EXN6ubOMmIqIU0CzqcLTG/hLLeBKMw03OrrCoXt
         vmQNDefez0KCBfIXmYN+vy1MSLsZ+G5FqdNGKoXV4kIGajbuIJFFCEerCG3EzS+ef44U
         qSvwyAgdtIlafYC2xoWY+w+3r1yUg9xMaQlFlXg25dyFjeRwwTMxFNLw842wx63rqAAM
         sfnEYV2HjwlbTCF3RCVGqeKAIUrGI1Xswr5tLFLdLBlCVgreeuyXsdrtpskldNVxYVNq
         1MqqvDB3j9ZkKOAx4eunzaQTC06wuXWAdKQlpdTcBCjlNfleG47k6nOHFYQbo7BF9+7s
         TZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDaPxSGgIUOG1uM2q0vvMxPBkJdqqLH8giy72dWAzag=;
        b=qwfCIIS5Exz+++Z0DASoYWD3sqeWDMcF4M7Ij+2SgUHqOwCzRGIb+hRAKClX8vu6Ak
         COuYdwDG0/zGaU4/lfiwza/ztQhqfTkuJL1pVfQUqVYyAZFPYV758rksNmg5cmIa+UTr
         qrO/HhrMLd2AwGWs9k/r2obdJy0BF1Igf5RkzXfsNBlbmC431rlyifxM8TYEhvDi7S2w
         SSas6LrvVsbJV/amwO0RdQTBk10S1SwRZ+NsFaQ5+w71BCi5nDlItdh/eauB2w2ti/U9
         pIMZcoWnbi4LOgSUWbL/rYPppQpZDCzwh3GLFDopKdEDLBN9jduKvtgLZ6TwHyIueJxM
         2pvw==
X-Gm-Message-State: AAQBX9cI+ABIGToVJiqv7j6UvQCRSpYSTt0cYMeQ+KytQYCpAHtKDfAn
        iRm3Oerd8NUTqnr/N0iDvnxt43ySDaYAyqBK
X-Google-Smtp-Source: AKy350bf/emhKpDr3VzbBAZyAr51liEC2qJFxMP/0DreiX6+ge698p/vKIt1VF0j3tkl50mVIjYM6w==
X-Received: by 2002:aa7:da56:0:b0:4fd:2363:16f2 with SMTP id w22-20020aa7da56000000b004fd236316f2mr4027915eds.37.1679691282640;
        Fri, 24 Mar 2023 13:54:42 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:41 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/7] t1404: don't create unused file
Date:   Fri, 24 Mar 2023 21:54:33 +0100
Message-Id: <20230324205434.93754-7-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in file t1404-update-ref-errors.sh create file "unchanged" as
the expected side for a test_cmp assertion at the end of the test for
output of "git for-each-ref".  Test 'no bogus intermediate values during
delete' also creates a file named "unchanged" using "git for-each-ref".
However, the file isn't used for any assertions in the test.  Instead,
"git rev-parse" is used to compare the reference with variable $D.

Don't create unused file "unchanged" in test 'no bogus intermediate
values during delete' of t1404-update-ref-errors.sh.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1404-update-ref-errors.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index b5606d93b5..937ae0d733 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -551,7 +551,6 @@ test_expect_success REFFILES 'no bogus intermediate values during delete' '
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
 	git update-ref $prefix/foo $D &&
-	git for-each-ref $prefix >unchanged &&
 	# Now try to update the reference, but hold the `packed-refs` lock
 	# for a while to see what happens while the process is blocked:
 	: >.git/packed-refs.lock &&
-- 
2.40.0

