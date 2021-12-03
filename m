Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85CFC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 10:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379845AbhLCKXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379828AbhLCKXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 05:23:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6858C06174A
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 02:20:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so4446336wmj.5
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujcp/1F9NQG8PUokZE7cccnAWV+JRDYp45Xc/fN8iUU=;
        b=KVxVvYyvrJwYz+WslmGrBSfEsphXzip+/XAdnDayooylDBnkHbP9IM2KPBfNW3O66b
         /H4hZ35kPJ+SY3hlS1zb+Z9FA9ixxrzNYs1AgHIlOkYJiUkmgtGV20pCi5gRvifg1kDC
         vlWWbLZ7sMkkpb7tq4iHA8CVxShkNVDXjlvTdoi657+4gRHgs1CUTNUF4htbK/EfBU9V
         OeE+HFawQlS31iuyRAuyT23pko3WkU69p8+3f+JUjcFVrmgkjVILhI1gKF14R8lBn6Ko
         IXFAvvgAKDGhrGzFEwEC/VBmIowYFv0776PAWFsPIqE7ahVW3pLDG5aQFsXi4/rmNOSc
         1U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujcp/1F9NQG8PUokZE7cccnAWV+JRDYp45Xc/fN8iUU=;
        b=s5bRMLlNlUvf2fX911UbBXiVbet3K97iXulKT/voJQkqKMgrwZ2WQHvJiyQTmeisxS
         gZhZL8sFYIZ7MCIEl7ZPCXf8soaL4c1WnExXWZ4RpjbN7IMLG+xpofKbfzKUPktenff3
         9rhzdHZXeRqTavO63bMhF48nRHZtKh3nj87VUBspE7RIgeY6rvOXfyQDVGLOUD308REg
         T7Nfb3kOaYtnPtxdTC56/u/CndjjqHvLGN1fJBTjtdgM8bRlZtfIglAl1kcxNs3XdNgk
         D4qBSgYOPyopWjR6MGIoGPJpnGgVWCFeDR3eWlJuHkD5R2DgXCY59pOhQu9B5jbAUVrl
         FF6A==
X-Gm-Message-State: AOAM532PzQluOZRfkJ9jWmTtdNanvVWHQut2AH5wU+zRGgcVbskj6RiU
        j0XUMOC0v5I1h+iKhgpArVXyIrXshIBWuw==
X-Google-Smtp-Source: ABdhPJzUgGFWVpfEtne4A5+Lym9ir4a2noIWw1rJ6Elr0ULkveRY8cnUWiQQBO4mqsYznbitTxPLsQ==
X-Received: by 2002:a05:600c:6025:: with SMTP id az37mr13975569wmb.194.1638526809053;
        Fri, 03 Dec 2021 02:20:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r8sm2798448wrz.43.2021.12.03.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:20:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/7] grep tests: add missing "grep.patternType" config test
Date:   Fri,  3 Dec 2021 11:19:50 +0100
Message-Id: <patch-v4-3.7-a97b7de3a3c-20211203T101348Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.875.gb925cffed1e
In-Reply-To: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the grep tests to assert that setting
"grep.patternType=extended" followed by "grep.patternType=default"
will behave as if "--basic-regexp" was provided, and not as
"--extended-regexp". In a subsequent commit we'll need to treat
"grep.patternType=default" as a special-case, but let's make sure we
ignore it if it's being set to "default" following an earlier
non-"default" "grep.patternType" setting.

Let's also test what happens when we have a sequence of "extended"
followed by "default" and "fixed". In that case the "fixed" should
prevail.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..113902c3bda 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,25 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=[extended -> default -> fixed]" '
+		echo "${HC}ab:a+b*c" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			-c grep.patternType=fixed \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
 		echo "${HC}ab:abc" >expected &&
 		git \
-- 
2.34.1.875.gb925cffed1e

