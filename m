Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47897C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 20:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLFUAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 15:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLFUAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 15:00:06 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ECC391F8
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 12:00:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vp12so8989707ejc.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 12:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FP1jJLsRwD8AaFzOtMkj6SYbrCLhURpInRtbRHWioUw=;
        b=EEfhhmC6TZzGk87iWfTBNx5j0q+qlzOHgPB20ihtit7f2GVDGsaxnXlMGEy4MkVOcu
         uaOXzkt5bWj0kiFTi8vxm9X8luiLcd30YeB7X7HKamDuxdNuy4zrJDLUc7Rr408MVek1
         zwmq9jbNyB9Uxi4AaTNLEWx01gbPUE9qs8EF4IeG/m/Y+iExz8NA4N5A93hbGIlclxBF
         dRLx6NhXScoDk1Hs9zzAdsRzu2ujRkwLjYc0BGoewYtpxTgOJowHzR/mcnvWmsItsags
         kJTVxZkFCbjCCb0iZyPzDg2QAD9WAhj7HyBBrMcA+pPpQNrs4QUVIO3WL3WpTW9s3GnD
         +veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP1jJLsRwD8AaFzOtMkj6SYbrCLhURpInRtbRHWioUw=;
        b=u2qw7CN/Jil2NlH9ZzROvnk5XUwgkCG2zE6f1UE7NuxWen7RyJ662WGXyJm49yNIB6
         C5VA8/MeJJWkysKX1c1TG/fP9YmhP5urCKe9YLpPRebi5q+K6l2oZLMlz1JIHvC7qn0u
         gzyb8y79Grr2K8nXSyFQg2D4KWC3/acSBi/tWxGBPEY2XC2K+swE27ERV+BpSi+8F9gk
         qmqZ9erUIj6TS5SsKzWEsoafMQ/dTu/oZ2e4i7t7du8RiJtNHiYK/hWXmGq51BVw+qZd
         1ifr/P4EfLhSVgTfJEWYlBgBESW5naIJ0SdaozjUplaXdgiNgFGrgn9iMyS6FOarI0fz
         yZSw==
X-Gm-Message-State: ANoB5pnQQdSjg4kufVKXsFXNVzuG9ZWfj31Ze86wgOkhKk4KEjytWAyn
        BC5VGlgoQrMI/E1zMtYuIGjX7zfpQQiHAg==
X-Google-Smtp-Source: AA0mqf59xTtoZunfPSPscmu2H/Pk21QsstKA1k8iJl5lLYxK+EERK3jUs1AmbN61kD4qBUEAmjUEsQ==
X-Received: by 2002:a17:907:cf88:b0:7bd:4dce:248 with SMTP id ux8-20020a170907cf8800b007bd4dce0248mr42831849ejc.349.1670356803250;
        Tue, 06 Dec 2022 12:00:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906285a00b007af0f0d2249sm7760967ejc.52.2022.12.06.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:00:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CI: migrate away from deprecated "set-output" syntax
Date:   Tue,  6 Dec 2022 21:00:00 +0100
Message-Id: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1017.g5f0c708352f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in [1] and the warnings the CI itself is spewing echoing
outputs to stdout is deprecated, and they should be written to
"$GITHUB_OUTPUT" instead.

1. https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Along with my just-sent
https://lore.kernel.org/git/patch-1.1-4c1dcc89e7a-20221206T195552Z-avarab@gmail.com/
and Junio's https://lore.kernel.org/git/xmqq1qpd9bys.fsf@gitster.g/
this should make our CI warning free.

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9afacfa0b33..d1e16009b11 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -34,7 +34,7 @@ jobs:
           then
             enabled=no
           fi
-          echo "::set-output name=enabled::$enabled"
+          echo "enabled=$enabled" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
         uses: actions/github-script@v6
-- 
2.39.0.rc2.1017.g5f0c708352f

