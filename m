Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3002BC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A55960EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbhHCTkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbhHCTj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD8C061367
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so78915wmb.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yem/csLCBuEtm+wciJ/HlPvXcvotFk/21uT1YnzVB1k=;
        b=rkw7awwH+JO9pn8umbLzMEV/CJAxWybtwvMuAzatqdLjxCuMlTtfEVZW1rbkPjFDLD
         lqYhH9wY9aHrmuK0nMUijOU2VNnzsMCpr8i8oGy5CE3VK/9SS0c0wMWKrJKdwemmcBZS
         bigGoar/P0K7xE+DFSo9FLi4bV7EVJgHKIhj31TDJjX51JUIGWiL3eRupOes2vtB9/oc
         8QJbN1UJMtwAISFiGG+j1K/2M3NO0xvd+jdB97dsWfd1x49WKk0sh8RmN4gFNtL61ryl
         R7ZTOqiOZYAZHyPl1DDNsqIhVUXGw/gDprnHT5i6SSx2dhWW06M+32oE98kmKRcehgjD
         Yxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yem/csLCBuEtm+wciJ/HlPvXcvotFk/21uT1YnzVB1k=;
        b=g53P/sSgSIAuxhKlZeDyMHOY8bCFHaGF9GCmyeLEVrwCpAA6HxiUak/7/HFR379L9Q
         INO7JAwP0GraXcthaFSujVE01pW+v4pAmZhRwBjMruXYhmaudyleXNmCtJp1ENmYqj8r
         f/VR1iD2bt1fBQ9ixMvHpcfxeWoEVFY4rAgF1F5Z8CehKLs8oGj/ZBgxnsTIpQPugvEj
         WDrKCm8Td0Y/cJDBQ5BWy85I2rvjONI2DpYQs0muR0XuKZXIZectgJYK8LvMefp8JL+V
         jXBhTEDmSPmXdkvj1oKci5O3WRGBsuCpcglDi5b3bZ0h57LZoI+k6xy17sF3boqk+Kq9
         Zp+A==
X-Gm-Message-State: AOAM533miGqrkkTLkOcLBCHtxJx+9tj3TfGpJN0roMtIokvaq8auMQTO
        XsUvpXHiscpT4u7eX0H0Zli/a5FOaF1efw==
X-Google-Smtp-Source: ABdhPJyXDoTL33ysvb0D3Tiurq4gcq86zDdwcw4r1E8f0cTdTFeT1cBlAK3F1e5sql3fyb/L5pIc/A==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr24102361wmj.100.1628019577415;
        Tue, 03 Aug 2021 12:39:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 28/36] hook tests: test for exact "pre-push" hook input
Date:   Tue,  3 Aug 2021 21:38:54 +0200
Message-Id: <patch-v4-28.36-ecf75f33233-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in ec55559f937 (push: Add support for pre-push
hooks, 2013-01-13) to exhaustively test for the exact input we're
expecting. This helps a parallel series that's refactoring how the
hook is called, to e.g. make sure that we don't miss a trailing
newline.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5571-pre-push-hook.sh | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ad8d5804f7b..d2857a6fbc0 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -11,7 +11,7 @@ HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/pre-push"
 mkdir -p "$HOOKDIR"
 write_script "$HOOK" <<EOF
-cat >/dev/null
+cat >actual
 exit 0
 EOF
 
@@ -20,10 +20,16 @@ test_expect_success 'setup' '
 	git init --bare repo1 &&
 	git remote add parent1 repo1 &&
 	test_commit one &&
-	git push parent1 HEAD:foreign
+	cat >expect <<-EOF &&
+	HEAD $(git rev-parse HEAD) refs/heads/foreign $(test_oid zero)
+	EOF
+
+	test_when_finished "rm actual" &&
+	git push parent1 HEAD:foreign &&
+	test_cmp expect actual
 '
 write_script "$HOOK" <<EOF
-cat >/dev/null
+cat >actual
 exit 1
 EOF
 
@@ -32,11 +38,18 @@ export COMMIT1
 
 test_expect_success 'push with failing hook' '
 	test_commit two &&
-	test_must_fail git push parent1 HEAD
+	cat >expect <<-EOF &&
+	HEAD $(git rev-parse HEAD) refs/heads/main $(test_oid zero)
+	EOF
+
+	test_when_finished "rm actual" &&
+	test_must_fail git push parent1 HEAD &&
+	test_cmp expect actual
 '
 
 test_expect_success '--no-verify bypasses hook' '
-	git push --no-verify parent1 HEAD
+	git push --no-verify parent1 HEAD &&
+	test_path_is_missing actual
 '
 
 COMMIT2="$(git rev-parse HEAD)"
-- 
2.33.0.rc0.595.ge31e012651d

