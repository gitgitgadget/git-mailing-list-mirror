Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B2C74A5B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCRPrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCRPrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632901C7FD
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:47:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so31257809edb.10
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDaPxSGgIUOG1uM2q0vvMxPBkJdqqLH8giy72dWAzag=;
        b=KrQaeXhEEzPlzQjKHXJ2ys8Z8w/8JaJvr9rCZ8ZxAwS3EeWWFlokoWqvAGwZfftnm4
         ESDvJon3m5BZMYnXmBH/gc63SlRfspI5HU7fnPzMBlI2OeJAVPHQJvrUM3U5b+B0caW5
         ZZCJ7mhw+CzH18HqATAYdtpyzywBXkjSNGpALKz73V1GdzX6w7A38HW9BzT/cJttteDT
         MpJnVzdOQ7Q+pvfBXuvnSgBQajbTaP5XM7I9re580ajxqVSmrrLlJhmrZIobqc2mzg4N
         yjtZGK7Ps9gP14ocgR33r8eao1uOQ7xnP1lEYFF4Lx3+GiRRmOdZksuQABY97pWCCEc/
         2ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDaPxSGgIUOG1uM2q0vvMxPBkJdqqLH8giy72dWAzag=;
        b=E9LQtin08sRPOjJ7bcwE6hBy4ZibsvsU2PchZhJLU1atUBROaZF68K7hQ5xM0+WEe4
         DndMDmMx4eOHPeyKkZi14uF8C3TV0KKTamEyuoAwh0SGdCQpKlJrT26UFuxTfAwy15CL
         MnfS4TKVe04NmztvkCPJ1pj75spQGO9x6yWWONUR8hI+7e/Xd3GfgkmJB5r0gjio8xwK
         pjMYzpm/HxsON0SUyjUlemODPF6H0d7OKPKOhHmPxLiGTw+rrTX1iW3T87eWZzQRyzvJ
         CW2FtEDnMiOQV4WqR/7ND3hXcOyLNXr6YpKhiWDhlZ4qMuIdmbi75XVhMNRIN334a8JF
         UsSA==
X-Gm-Message-State: AO0yUKVYvUiruR0gXSkvFu1Z45AEWPa/dYKd6THbEOMs6LthyM4dfEfJ
        25bXg5eFEBhKJVNwkNVevSfb1Tf5VRORqDPrEv0=
X-Google-Smtp-Source: AK7set/wmzk+mFxw09otJvwZxN6hsVn6/caScuQdG7wFGBnbHjrGcBwkHb6gbw7d2uwtzqcj7f4wuQ==
X-Received: by 2002:a17:906:f217:b0:931:986:7531 with SMTP id gt23-20020a170906f21700b0093109867531mr3399519ejb.39.1679154418610;
        Sat, 18 Mar 2023 08:46:58 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:58 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/7] t1404: don't create unused file
Date:   Sat, 18 Mar 2023 16:46:45 +0100
Message-Id: <20230318154646.131344-7-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
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

