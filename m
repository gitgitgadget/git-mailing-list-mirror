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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E998C4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746AB61601
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhFNKnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:43:05 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40681 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhFNKkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:40:52 -0400
Received: by mail-wm1-f43.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so12668168wmd.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnfl7CZXXowc+hCJIyBHjhPMqr0eLsGbK5piN3qykqQ=;
        b=fAQQfZt5ycJx63ROOn/MY7AoVaqvlE2kB2bG/GEY5JDRDUL9T6qs7WjHB/B0LV2Cfm
         Wl5q5Pt0hBpPSh1bGBer61JyiDxyvmBMRdaPvU2/XD1HKmKfoGr76B4q0lE0pUObFOZQ
         uldbE8a0ToeYV9yEDEjmpf827ySkLhpNakoBgxHWus+sNxrondmScHsvlCSrrf350k97
         480vgX+SVIwdlr9uwO0It5YKYH8FSd8HWjA9rpFniXDGm2V7/hl7YKIA47LqyPJOF90h
         /EN14IrxaHUwj72AMBvAj8gYMBvE200naTjnUR2+UMRgwAUI4lauBkHSjQ2DC8AJDV7o
         Wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnfl7CZXXowc+hCJIyBHjhPMqr0eLsGbK5piN3qykqQ=;
        b=lbJIyqn1OqjV1WPr7XgrEuUx3J3fwFIuOqwbUNWQSA5XoojpRCH1Y77Xr2SDOB1UX0
         LqGD++Az0ieS6wRpvsDalM42Mw6ppD5U1OZwjrSRfVJ9k53XojRj+CawcZJgAX9JKre6
         KsoaQKn9zV6Wli4exmx02m0LIS6MGj7cthZJA5KgrYfIuj4M785Q/0UdKlAKAybQoiKV
         sogKlfAK1F5t2Bdc//86UaOKz7N+B8KiZX77Vvv3J/jTRzlMGtaMdD/8xu56e09EYx6Y
         2yjEj2bppN2bBuCQKRzeQpzgW01EZco8dEATX4Sdz3f0UwZVFIIeOkCxPc98rB8ciR31
         GMaw==
X-Gm-Message-State: AOAM5320Aje/5OqHfJ9EaZVvUR/gNDn1jJ298d2ig/Gqn3EWCQQRAmGt
        f6DP9BazTlTDHFhQ1x4O7PF0waw45YXLeA==
X-Google-Smtp-Source: ABdhPJz1Vhfgwltr3tUd4T4zqyt8rNPFALO36GDSMocCziHgJ43uuMguc2WbYC5WQRKr/2ezHMSHFQ==
X-Received: by 2002:a05:600c:35cb:: with SMTP id r11mr15919207wmq.187.1623667058231;
        Mon, 14 Jun 2021 03:37:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m3sm16342585wrr.32.2021.06.14.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:37:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] pre-commit hook tests: don't leave "actual" nonexisting on failure
Date:   Mon, 14 Jun 2021 12:37:35 +0200
Message-Id: <patch-1.1-d08a435b8ef-20210614T103654Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start by creating an "actual" file in a core.hooksPath test that has
the hook echoing to the "actual" file.

We later test_cmp that file to see what hooks were run. If we fail to
run our hook(s) we'll have an empty list of hooks for the test_cmp
instead of a nonexisting file. For the logic of this test that makes more sense.

See 867ad08a261 (hooks: allow customizing where the hook directory is,
2016-05-04) for the commit that added these tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A trivial test improvement split off from v2 of
https://lore.kernel.org/git/cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com/

 t/t1350-config-hooks-path.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f1f9aee9f5d..fa9647a7c0b 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -5,6 +5,7 @@ test_description='Test the core.hooksPath configuration variable'
 . ./test-lib.sh
 
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
+	>actual &&
 	mkdir -p .git/custom-hooks .git/hooks &&
 	write_script .git/custom-hooks/pre-commit <<-\EOF &&
 	echo CUSTOM >>actual
-- 
2.32.0.rc3.434.gd8aed1f08a7

