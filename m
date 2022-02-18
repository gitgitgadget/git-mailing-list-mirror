Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92479C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 21:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiBRVCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:02:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiBRVCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 16:02:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D0028B610
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 13:01:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m27so4703473wrb.4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWog1JCjsJY/bHFJc53DmXqlBS0wk0Qtp3OPV2zH6iQ=;
        b=i1AuNzikfoPbBiuzLCSl75m+Gnx5VvdWQIkWQ3jrMvkwIRa0YSvW+vdufwHUA+zNeG
         zICLtW6/zKzu5oRX8OBMEVucvG7uaVZxBMYbBIBNM9BQC878w5VZtm4DchbXewauFn4J
         4GYRKflhd8tANQPDkMtlkFfVfPCuv+ILfuvSv/xCOXobF9I9phMroQJ0F1S1PQvz+M9/
         0+AugvHXThP7bzxEn597PVOvtP8axR444QI6DkSgVwxjsb1Z3UblZ8yoj7ZXWMeOYqi4
         K1WL8Na8NuPUNgOpEM+HL1OGGFjpGiZHigiHEKms5Xmhhdo10E9Njx33P0XUmVEX7Mx1
         ZowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWog1JCjsJY/bHFJc53DmXqlBS0wk0Qtp3OPV2zH6iQ=;
        b=zkWtWdNaVL9WfdQKD81G5uzsXIed94gn5GNCvQVWKnudr5hsrn7LhwNzF1g/UPffA4
         eEDL6xgKzt2427EQOV0YikqELlr/mFHoXvJOWPYxgjmqtgkmZob6LXJMSltmadtOu6WF
         H3yRLAwP7uyxTLz9LKOrTWXP7xYhbpoYZd12tsKE7reNNXubkwoCzLaRhVim8kOvD5yx
         mSdasbkiDg5mQVel7YKmTQbyZfaebJRdNyp6A91I+zwNc3DCCn3VNDmFn6jtdyhxh4D2
         Wkd21xg18G5zsvXXxnDMIlbTVaArHXLlC1ufB59tGcyZRvuvXmyOEH3asqwmP2E7AkOk
         Gurw==
X-Gm-Message-State: AOAM531O+c9k53ck436Lj3e4tnRQP+R03kM50+wmDeYUFXAv9Lq/O66o
        Qbaoisz1rswb3z5QJFLFy2S8FaByM7kp+A==
X-Google-Smtp-Source: ABdhPJz9svqW4klQ1i1zYyfSEttKoBTuWNzrndjgOHP/cX4XGrLF4t4rh4enrjzKupgfQTUa3vy7pQ==
X-Received: by 2002:a05:6000:3cd:b0:1e5:95c3:35b5 with SMTP id b13-20020a05600003cd00b001e595c335b5mr7433609wrg.14.1645218109799;
        Fri, 18 Feb 2022 13:01:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm14238018wri.33.2022.02.18.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:01:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] test-lib: improve LSAN + ASAN stack traces
Date:   Fri, 18 Feb 2022 22:01:41 +0100
Message-Id: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small series provides a much needed UX improvement for
SANITIZE=leak stack traces. As noted in 4/4 this makes LSAN around 10%
slower, but in some cases the stack traces we show now are useless, so
I think it's worth it.

This also changes the stack traces to strip the absolute path to the
build directory from them. See 3/4 for how much better that looks.

This series is a result of a suggestion by Jeff King in [1], when some
of these bad stack traces (which for anyone re-reading that, I had the
wrong idea about, we just needed fast_unwind_on_malloc=0) were
discussed.

1. https://lore.kernel.org/git/YXxh%2FGMuy+sBViVY@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (4):
  test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
  test-lib: make $GIT_BUILD_DIR an absolute path
  test-lib: add "strip_path_prefix" to XSAN_OPTIONS
  test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS

 t/test-lib.sh | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
2.35.1.1031.g277d4562d2e

