Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76375C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbiCDSd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiCDSdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FF106B25
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso4400305wms.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NPleGx4VXJ0Pm0yvpN2F8JXlCjEy/TIbU+9tw4YclPg=;
        b=mk37lkdfmu5B31xtkLHOaQ6yAKMTE0tE1puyYoCNZsOaCSRwQ7KTZFkDrU8iXKPRMB
         kOv9/h/2irKP0nMKrQmSDGS9qWMJVjYGnSCkpTdrtwUpl2VK5FSyoiodRaTWIKDbS4u+
         PZM5qrHMQ0ncBd31WlmXMgQ3mOBFvzrRW8pbXwXwg8Bwx/ZFHSbM5LQOnZ45ZtUbV9xm
         7nyb/v//EMZ+juIwubcwDrT6jT8tAc5WdfYpx31EHCuzqZdAEYByGfGolOK2MBtqtVDo
         G6ysz/wnLeJdXLgexpNvtYIc9JbRVLQXp/EKo/xQXE+POPOXeaWUhywe4XZxkmjIgOk5
         GNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPleGx4VXJ0Pm0yvpN2F8JXlCjEy/TIbU+9tw4YclPg=;
        b=gZ2xeO/TPlXA3WqIuiz8LduomVZ1CzYM17mmd8G8XW8Y8rOY6WK7a62VxbaExsTF1B
         V0QZRWH0QtyHpHCRqEDQTQNUiqY8HXMoS6i4XOtvoQOWD5/wLtC5PuAzgXOVVfuVPMXH
         fQuDLXX5KoWewRWAcSMw4wEs1fGZyvp6x3sYvhV8DiM65PcYaRGHlTbpvVd89Z7qw/gl
         MtgQ5bgT06+MFiWwmYD1X5SfcwvtCsJsYJ7sUvMzFrkXazdn+ZwGyVf+pOSF/ptD3rXi
         Eq/O1q9ye5lvVUvvnw17WM0CHgf+JKHLM+Fufi46YYIp80ktZkDsiUN/GtMXMeE6LetQ
         9zXQ==
X-Gm-Message-State: AOAM531eeVGlmVK8NHNQIjjlnGTR0oeLCpcB01GMhVwGLTH/D0vJOsup
        UcD/XJAOMT5rw3i4XIc4eAEZRyKhsd7Zvw==
X-Google-Smtp-Source: ABdhPJxav38tC7SkADUn8c02bZEPvht+mAYrygP2st+z3JkPa4HEWZ3VxCuLbfBOQdKnEqLMe76VCA==
X-Received: by 2002:a1c:c911:0:b0:389:8f96:28f3 with SMTP id f17-20020a1cc911000000b003898f9628f3mr93540wmb.49.1646418746734;
        Fri, 04 Mar 2022 10:32:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/14] bundle: call strvec_clear() on allocated strvec
Date:   Fri,  4 Mar 2022 19:32:09 +0100
Message-Id: <patch-v2-06.14-c636770b5d6-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixing this small memory leak in cmd_bundle_create() gets
"t5607-clone-bundle.sh" closer to passing under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5a85d7cd0fe..2adad545a2e 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -93,6 +93,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
 	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+	strvec_clear(&pack_opts);
 	free(bundle_file);
 	return ret;
 }
-- 
2.35.1.1248.gb68c9165ad8

