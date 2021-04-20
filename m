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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B2FC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D53613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhDTMWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhDTMWm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3FC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w186so15512289wmg.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmt/OfrANsb1x/lcuP8wCH7s7LiSjmv6NxWhC90EpLs=;
        b=BH4Z99XzguYCBMs1dH+jMMLGbvqcPA+P4UlO5yhD0F/eokKhcz1qCW62N1GPADK6HP
         pBPV1YeFg6InBK65SYjx283cY9c3Epx13WLPBEUaRgFtaa0lsgnnEn45a+VT3CH2SjFA
         I3Qc46VAtscTCIbFsfcGM6QKkd/TY3RjW2kkajQIeGn+jalGVLChgAnXR7CZu7vg8gaq
         PxxwfUn2vUNDeBGuENc1D57hCMTeR7r91Qqsh2Q8qA70fYSEenSWM67vKm/RWdBRLyZ2
         CuEN5m9EtKJazrFO7OTgR/tbFpSfW4Ghi9jnBrJDTanuWIYJngpVR+wiDcyelX+6CDZY
         /SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmt/OfrANsb1x/lcuP8wCH7s7LiSjmv6NxWhC90EpLs=;
        b=uVigWOhTBapJYDEecjy0BdIyBbcuYCshuLa9+KkUXwtQWqB+NI2btTaKb0eubrCwXP
         vcW6XNuzyaj23mNblY5phOK/hdXJuC+F0Ud+7k5QG1IHxtFy5J4uu9pX+gBlBw9NzgZk
         IJc1JPFR/bcYzjX5ZT40Ja93EPQ7SVKV6Y+29lRPOxFHRqa+GRXeWGMiHG9Sx5MAizUT
         USIoNf39j3Jo9hzndRPbIQYyRsc0uQygEzzy+D8o8WJRk1YLjDGaLxtjb+ouTpMbA4jg
         8S1QmWuJ68mw52e94e6gd3nnuNJntm/OMJ4nusFx2axcNrK1I2/wTxaRQ4zikqU7cqqE
         04Eg==
X-Gm-Message-State: AOAM5319ik+11HgnCiPJE1tStUpUe70Uh7AYRQ9fumT07jhLAt3DRKIh
        E87sxLFdwSmzBrA+0kOZxX2/tnuClqm9fQ==
X-Google-Smtp-Source: ABdhPJxWxmIR0zfAZTgilL90z4Y6jyf2wTTFIKefIznGbpUIfvASlTjwZbxX2eeeW9XSDTgJT4AIAw==
X-Received: by 2002:a1c:1f52:: with SMTP id f79mr4277672wmf.171.1618921329821;
        Tue, 20 Apr 2021 05:22:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/12] test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
Date:   Tue, 20 Apr 2021 14:21:54 +0200
Message-Id: <patch-03.12-d669ce3196-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop setting the GIT_TEST_FRAMEWORK_SELFTEST variable. This was originally needed
back in 4231d1ba99 (t0000: do not get self-test disrupted by
environment warnings, 2018-09-20).

It hasn't been needed since I deleted the relevant code in test-lib.sh
in c0eedbc009 (test-lib: remove check_var_migration, 2021-02-09), I
just didn't notice that it was set here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27..2c6e34b947 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,10 +84,6 @@ _run_sub_test_lib_test_common () {
 		passing metrics
 		'
 
-		# Tell the framework that we are self-testing to make sure
-		# it yields a stable result.
-		GIT_TEST_FRAMEWORK_SELFTEST=t &&
-
 		# Point to the t/test-lib.sh, which isn't in ../ as usual
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
-- 
2.31.1.723.gf6bad1b9ba1

