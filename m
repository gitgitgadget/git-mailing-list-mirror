Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2140C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 04:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjDZEGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 00:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZEGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 00:06:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E7810FE
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 21:05:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b35789313so4800728b3a.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682481940; x=1685073940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLrmOt+QVDrmTlSNY6i26umff52HE0LeFNIGsieTXFA=;
        b=XnqhH+MOR3SZqxbuJuyXoHqcL5a83eZim7zQZ60p/hnfxVSEWNl/FL9wEP/N7lYhrc
         /dQZrkQIlN6buksek7G+saePdRpxDW/wTW0zszP4LrXTvis9aWjNBcEyLUZyBPrP2E0w
         LhWBoxZYDXrd2Qw+l8pbYjYWV+bCIWnTyRgcDF5rqPVvkQiQsjjHO1CLtHLqxuJr50Ft
         LEs8+OWYGn/X5vXSEAnuQq3YM6L6rHPf3qHxlIgCwz5+DZqmBsRXAVOu6BATY3EcSl29
         IzKfa5IMuG4s/Y4Kb+Sy6p8IiWvlHoNbiPo/dxLezbY2Np0vMzuYvcwOTFIS54rCM4Sp
         k6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682481940; x=1685073940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLrmOt+QVDrmTlSNY6i26umff52HE0LeFNIGsieTXFA=;
        b=G2jh067sRBm9ZX04dyYGhmXaIjm+sTFUIc0QrU7EgGGUkuMDWO9VkaddNL9wYN8T0V
         1zDl+ZrL1MkOIIJUQbr+uovfwiqDWpwaseO8/AtfovuW9ldRwfL1rdn8ri0oFYUvn28R
         Tfv43H79CfGEWFvvE2c6yNmDUzr8xhdwcj1j6FAUOq3xYKMMUyb3MA+CSE6nQ3aUUKnI
         YCwr3nNbAhkCM808LpCrpfKql6mVPx2vh6B7hZA/l5udGXX0zyCGFiaSJganFMiIpcYL
         F/RDGVU5M7Qur5a5iIsqQj+Pkx1v4TnQ28WCNUIiG7lypxKeysaBW57rkOux5E4xcB4h
         o9+g==
X-Gm-Message-State: AAQBX9cg04ZM2JD7a/uVFqeyNB7Q2uqWumWeB4qU6AS4sQ+Amj2LTsxv
        X3u7rgV/MHuGshzgtSfrLvjqPkrMaEefi71N/4k=
X-Google-Smtp-Source: AKy350aQy7nim97CtSsXGk7rNElwz4TuF69J2GcrQkZNoLiK0xvYjHUWI5hjYGDqvmNCaE7fLF2Fqg==
X-Received: by 2002:a05:6a00:b8b:b0:63f:1926:5bb8 with SMTP id g11-20020a056a000b8b00b0063f19265bb8mr19557137pfj.30.1682481940674;
        Tue, 25 Apr 2023 21:05:40 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id t1-20020a056a0021c100b005d72e54a7e1sm10038156pfj.215.2023.04.25.21.05.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 21:05:39 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] negotiator/default: avoid stack overflow
Date:   Wed, 26 Apr 2023 12:05:21 +0800
Message-Id: <cover.1682473718.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424022318.80469-1-hanxin.hx@bytedance.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series avoid stack overflow in negotiator/default.c and memory leak
in negotiator/skipping.c.

Changes since v1:
* Add duplicate protection in negotiator/default.c and
  negotiator/skipping.c.
* Split the memory leak cleanup in negotiator/skipping.c into its own
  change and fix some other problems sugguested by Derrick Stolee.
* Minor grammar/comment etc. fixes throughout.

Han Xin (2):
  negotiator/default: avoid stack overflow
  negotiator/skipping: fix some problems in mark_common()

 negotiator/default.c  | 39 +++++++++++++++++++++++++++++----------
 negotiator/skipping.c | 10 ++++++----
 2 files changed, 35 insertions(+), 14 deletions(-)

Range-diff against v1:
1:  a0a1473f5e < -:  ---------- negotiator/default.c: avoid stack overflow
-:  ---------- > 1:  935be72eb9 negotiator/default: avoid stack overflow
-:  ---------- > 2:  abbb1bc0b3 negotiator/skipping: fix some problems in mark_common()
-- 
2.40.0

