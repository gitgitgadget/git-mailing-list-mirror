Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A476CC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbiCGMu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiCGMun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1B4F459
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 19so8847171wmy.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WA/Q4uxQK7vhci3tq2Quu+YNSXv2IUnAXsbdGaABki8=;
        b=g05Jaid/hWQRg5hExCw81rpDIOSWNujTTi216n8TjB2X8zyYKWhE+MPtJE7EeJiOcy
         g/vf1+W4jpJeJFgSSCSVqt/2OHcGV/bnUHX1fn/0WQHgoaMPGYuLdJ01XtxOQOQ12yE1
         J/yOC9GBknoxgddxD/puVK4SY6v4Jjv9Qav1cIxcTTQidc/zfU3w8O8N6BezKf3wdbOe
         zYrkOVG7W4TdZgGehclT3r6rrfdv9vtVCl6yBaOdgdLEwf18i/OQ3swhqyPv3jozwRHC
         moCFXrlc0psFPpcfH0Uso2moE2yHso2RsGU8x8Ng6WrWGICHGRUh9a61Ahg0vm9El2xr
         zgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WA/Q4uxQK7vhci3tq2Quu+YNSXv2IUnAXsbdGaABki8=;
        b=0XsMFFagiHQpSpP2ZrbCBreT0OeLRBkQz9O6iTmr8TRI+GZybbvrxsfyFAjpRGD1LY
         95PKM4w0Wz4/09GFE8zjjEeO5EIm+yqKGs5Y8fJRG8DCistlGcHvWZ/+WT83xwmTcQQz
         uTsV8SgKcLsR2UEvrB4m+zuPc3kJcg7wb5DFUdS9BA95svPJVjIEpVRg8dwJbSEYmYbD
         stVHGgobv/JERUp9hV45fUykw/HoxTW8u2boitnTqgBy/yhG0bGKsxp+0Hw39wRTC19e
         pFJNw8fbqq740GKh/P1Pthz/USErKb25tSAX3xZjM0mwhnyQG3uZL8+RZp9YpAV6MZ2E
         7DDQ==
X-Gm-Message-State: AOAM531Sv14WOg2laGd03A0iC1rc8+DfLvMBVTOauDe9SbAV9lPihXhS
        xYbJ0KnV7gcpiIupGcPrLAvP5ases6Bd3A==
X-Google-Smtp-Source: ABdhPJxk6wvG7pQGFq6E2d2hmNfT1U/15uCl4L5bMd/hsx6tb8GLqz3M4rfNr/RVDur8f8/tyWVNJg==
X-Received: by 2002:a05:600c:589:b0:389:a59e:a53d with SMTP id o9-20020a05600c058900b00389a59ea53dmr3099880wmd.28.1646657378234;
        Mon, 07 Mar 2022 04:49:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/15] apply tests: don't ignore "git ls-files" exit code, drop sub-shell
Date:   Mon,  7 Mar 2022 13:49:04 +0100
Message-Id: <patch-v2-13.15-dbe8d168401-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in 969c877506c (git apply --directory broken for new
files, 2008-10-12) so that it doesn't invoke "git ls-files" on the
left-hand-side of a pipe, instead let's use an intermediate file.

Since we're doing that we can also drop the sub-shell that was here to
group the two.

There are a lot of these sorts of patterns in the test suite, and
there's no particular reason to fix this one other than in a preceding
commit all similar patterns except this one were fixed in
"t/t4128-apply-root.sh", so let's fix this one straggler as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4128-apply-root.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index ba89a2f2d73..f6db5a79dd9 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -96,7 +96,8 @@ test_expect_success 'apply --directory (delete file)' '
 	echo content >some/sub/dir/delfile &&
 	git add some/sub/dir/delfile &&
 	git apply --directory=some/sub/dir/ --index patch &&
-	! (git ls-files | grep delfile)
+	git ls-files >out &&
+	! grep delfile out
 '
 
 cat > patch << 'EOF'
-- 
2.35.1.1242.gfeba0eae32b

