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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDFEC433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA67E6199E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhC1C6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1C6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:58:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9595C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v4so9343134wrp.13
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yC6rxbQvKX6gOmaGASiNGQdlsBv8ZufEAsn4+Te7nM=;
        b=vT9feCwHCV306VqzU77xEUyZVEPSL35mvC5Z/gkKoz0/MbT91M6BsiBznUSkqT7EKw
         8XUTHU8aHvuPKNYpr1hc6GlojPjO6uYrijv1+7QpK8utMzHtfYjS7fJ4cGySv8qpWdS0
         Uxci9Tz+CQ1YZdoqWKblAgFqTVBrKBUOSsPg5piMg46D0tI6s4rH0OA/JrAr16APKTZB
         uFnKSsp12SSMDdoR3HjLeit98T8xUVdLybUVKnMfc+5PlGbALSa3cgf9k5seTszk+4bB
         1aiW9rtPV0luTOtLMlgYq4CTZ+3q6WMQ5fKK/LT8KsSZmGFCFE/ybYbwKqIeYCPoLrA3
         vkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yC6rxbQvKX6gOmaGASiNGQdlsBv8ZufEAsn4+Te7nM=;
        b=cgAHDnyaVey7u85ZeYh27rViRjxzRocrfp2AkDWXtoDpgpBJaJ7DVznN0pULFz87I7
         26/4wl92DjhVn9Iq3V91UtJpMYiriHKJ9yrzoVUPOyzeUS+b1YFznPGJQpBGodkWmuBh
         2cwc/y+mhcDUFqCW9qAAbfqiDg3QMgfzi8wY+QtVf4xO/cyJAPlou6STxjq1IPzqL18s
         SerMT+0ptq1lDiB9cOk8YRamITPAziHUbZUqXXTEFZtkiu7rYSZI+u1OAChs+PmYe2Vn
         aUnmuS7cXJ9ujsB6t0mVFAWVyVG71gJWnufi0eqTTd1xfgh6WNJNmg/1js3Nczf7l9dl
         Raog==
X-Gm-Message-State: AOAM530FyNii0Cmxn/9+JHuZrLe1ChW4p9/e2PxRjbs5pg2wnNZJv0Cx
        pXaF55eR8KwptQ+kCaVkEkwES9BGKcvuQA==
X-Google-Smtp-Source: ABdhPJyysJ+tfFkxJVGzd8PXMb8SdT6TEaB/k+0yzY1WO8h/pzdfcfl7vC2ZjN4yM0Dh4F1SQOeLaQ==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr17250260wry.192.1616900316330;
        Sat, 27 Mar 2021 19:58:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y1sm17629421wmq.29.2021.03.27.19.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:58:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] fsck: improve error reporting
Date:   Sun, 28 Mar 2021 04:58:28 +0200
Message-Id: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting in a rather obscure edge case, and
fixes up some object APIs along the way as needed.

This is based on my series to add a bug() function:
https://lore.kernel.org/git/cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com/

The use of the new bug() function is in 5/5.

Ævar Arnfjörð Bjarmason (5):
  cache.h: move object functions to object-store.h
  fsck tests: refactor one test to use a sub-repo
  fsck: don't hard die on invalid object types
  fsck: improve the error on invalid object types
  fsck: improve error on loose object hash mismatch

 builtin/cat-file.c    |  7 +++--
 builtin/fast-export.c |  2 +-
 builtin/fsck.c        | 28 ++++++++++++++---
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  3 +-
 cache.h               | 10 ------
 object-file.c         | 73 +++++++++++++++++++++++--------------------
 object-store.h        | 19 +++++++++--
 object.c              |  4 +--
 pack-check.c          |  3 +-
 streaming.c           |  5 ++-
 t/t1450-fsck.sh       | 64 +++++++++++++++++++++++++++----------
 12 files changed, 143 insertions(+), 77 deletions(-)

-- 
2.31.1.445.g91d8e479b0a

