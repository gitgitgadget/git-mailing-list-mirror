Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9296DC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7563F6113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhGTLMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbhGTLLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 07:11:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D227C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:52:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w14so28052926edc.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lj/SMwogGefzwA1i8x5GF302kysw/nv0jAa7HTgC/TA=;
        b=Q43ikHgGaeZoCjKxhezm2FyHZxgdJH4z4Nr58AwoYQWfbMyW5lL02sNnq+iwMXUeFg
         AhvwM1WsgeS5QR7FWvAeldQe6kbbWuJVPyhKf2NVkkLL7WIqJD9upls4pM+KR81VBRgO
         mZGXOIVgpd7hs8cWYfoQXodHQ9x6Zsrzi933G92sz7BZSPGbCjFUroCEsMxBGtF3CkWQ
         Sna9ICf+/8ztHVI4tOwgpewnsJn3w6kc4zPRjnPQiTT2aWch4Rxet2zrGC/9MOaqKxfb
         OjHrLLbQ51scP9D4+Y3SsU3RcbANz34yLY0TO7eUtJOD97eEm9B1UDjtF1lyQmxwzj2n
         dCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lj/SMwogGefzwA1i8x5GF302kysw/nv0jAa7HTgC/TA=;
        b=lUSKNaxgzMfITbdsJ1jLS2NgPNz1lefGmlBRi80iyW3BrcCweoyJ/2oLTUdygZyWXg
         7EVLOlhUygkXHztbBBNnJmLzQsywXo6jw9+ACIGzvqShsQDvkFvHwmF+BiBjA/EZYZew
         aex8imLIMIlePITddFJTiS/DiX6oicgoy43O649xrtJVYEQjG6POokAftveOumSeyxeQ
         cP1Ct3oVwDddM7YkL+i3snPWYF4TifRqo9sTK5m52lcPt0kurfOBZ+m0sgi+7KQtfYj8
         F/+QfYHo6YpBa17dFCe2kTqTOuj+AK23ewc0KNQ7Z/wq4Jg3Qqmbk4m6hdZ7faX+uWuH
         K1zw==
X-Gm-Message-State: AOAM530Gl/5ySXCL5v+E8jwSrtMc9cUdT45AqCk8tg62raEK5nG8+FBy
        nAXFpUNO7qyZ6dz/yeuPbctmirzA4s5AuA==
X-Google-Smtp-Source: ABdhPJyj/RW6CZhCrmctd4U8uGlCMTPRxwAJMQrSmxEPp4hVPTSfPCnHtEfWbLBEolhdkH6z1GWSCQ==
X-Received: by 2002:a05:6402:35ca:: with SMTP id z10mr10547095edc.159.1626781932500;
        Tue, 20 Jul 2021 04:52:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm9100409edu.97.2021.07.20.04.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:52:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] bundle tests: modernize, fix missing coverage & test_cmp
Date:   Tue, 20 Jul 2021 13:52:07 +0200
Message-Id: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial series to improve the bundle tests a bit. This is split off
from some larger changes to "git bundle" I have cooking, where the
"test_cmp" in 2/2 helped assert & catch regressions.

Ævar Arnfjörð Bjarmason (2):
  bundle tests: use ">file" not ": >file"
  bundle tests: use test_cmp instead of grep

 t/t5607-clone-bundle.sh | 74 ++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 16 deletions(-)

-- 
2.32.0.874.ge7a9d58bfcf

