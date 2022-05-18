Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A8C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbiERUFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242276AbiERUFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523682375DD
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j25so4136240wrc.9
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwXw+sCZFdt6p3ZdqeUNdkO/ZtGUIZ5Q446Ul4WIZ88=;
        b=h/9kwfeMm81MVki6ircq2R3S2ZidR/L6KYsdEosV4zWUyctscbu7PcNAfuphp25TYG
         xeO2ayeuuzElLuWLC2o9p19VDC1l3rg6ODclOo3cbgLi2TIYvLJpV0b70BcmpvuMna3S
         AtlVJQTRz+aOrCG5vOQXfmkxYuObxPl9hbRMNzIiqHMHHf4j+/udbdhCl+kSsaGSzbCJ
         Gt6UdUFBOsxUz/WfD4VqCtHKuElZLr7fwzfobR++THmTCRJ64OrgF4Q9VhXInlHRdXu7
         PMY/DE6M1fsbazlfuLnkYku+sALKYLdngKeov0Jae/xPT6baVbf8ip3GrxRO8fpmmtQ7
         Efug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwXw+sCZFdt6p3ZdqeUNdkO/ZtGUIZ5Q446Ul4WIZ88=;
        b=5WonD0wZ108CE5voUKuYRDET4C3BLnTkmLzSb9tD06LgzZ+kkw+oB6UfDio7kMrENu
         mmDeyICA+7lDPPptidqvKfwyWsUrqcVf3Na3g3huVdwh6fGpMYqFKD64IXEhzEQ0XrLV
         76u6pbt19A5hUocomt92sULE62lmUxJG8iG9VmqijU0Z0IVRzEfUYl68Z5NOQZzn/mHZ
         Uewq0ZO0PHFNxS2nxFo/VA5J1ujgNJ5IkNU8x0s43/8oHKB3g99neNGjsD1XIJsc4nR/
         +GHN4eMl3/QI4lg876k0nDZpwzqSOhqwVbOSD7gm7zwPK3xIN+zd02i2D/dq09JZ71Zv
         3uyw==
X-Gm-Message-State: AOAM531fV0oR1Fsc62AGLuQStcrFIBf27R5oSsEkOiml7VhAHQ2axSo2
        CCVWK0HytA5JnP9MjtGbIfYRXr5WkCxk1g==
X-Google-Smtp-Source: ABdhPJza45FbJsS+w3SamKhrQcB01urmT58GeOShjgGfmE98MeXLUZv/s3CvHvT+UjXCzS69sfuZwg==
X-Received: by 2002:a5d:4ed1:0:b0:20a:e375:35f0 with SMTP id s17-20020a5d4ed1000000b0020ae37535f0mr1092172wrv.94.1652904334551;
        Wed, 18 May 2022 13:05:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] hook tests: fix redirection logic error in 96e7225b310
Date:   Wed, 18 May 2022 22:05:22 +0200
Message-Id: <patch-v2-6.8-84e92c6f7c7-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) were redirecting to "actual" both in the body of the hook
itself and in the testing code below.

The net result was that the "2>>actual" redirection later in the test
wasn't doing anything. Let's have those redirection do what it looks
like they're doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 26ed5e11bc8..1e4adc3d53e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -94,7 +94,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1 >>actual
+	echo Hook ran $1
 	EOF
 
 	cat >expect <<-\EOF &&
-- 
2.36.1.952.g0ae626f6cd7

