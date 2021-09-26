Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F8C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6796A60F44
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhIZTFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhIZTFN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363ECC061575
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x20so728375wrg.10
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvUvrKrIrhyz4NOhQc7W18mEfgd+XWyQ4/wuiJfhMU8=;
        b=Ket08UVYiLT97luMATVgTDbbKg3TkTxb6smugyFlqtDbnEf/8rZgXIYsBlbx937AHi
         pECK59X/HthnoBpM7uO83YnyDhAUeTiOQw8yZq8J3D/j+FCUlKeVP8KVi+Mv/AosYDAT
         3p/PvLDLHPBOidq36ASkfHwvgvRcrMXjfOkMGF80+LuhvNPhVUrygcIA1eoY0bdvzAcK
         Tk86YuKDtUNl2EwASPFC8xp8TU0oao3JiNhCvyI0uuKVlE7ddfZcsQ7h/2VhTRHH7ufh
         ymv6+d5EIG8Vk3uwzJasCRWDRQCcKxcpI6yuhwqrf0ny0ZK9nx/xMiIlDDGwPoB73nyt
         vSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvUvrKrIrhyz4NOhQc7W18mEfgd+XWyQ4/wuiJfhMU8=;
        b=BwrjouDtjrYFlIni5HUWo0q4BI4YYK+8Dof2PZKiTOHRjyquNDkHqyYU2xLk+J8HdO
         4Q0ifX2vYyy2HNs1Vnx7KaZrvyYTVjA38zAZzGDTrEYrq52BU1VenAJJx9phL/2HKjlm
         O9GjS/jfR6k7Frs3syT1copadNNT+iLJ2lZLHEJJz4m89yvafeWoObB9BvoE7mgutUL0
         3TnappjaGaIc9yAWcJN5EE7OyNVJ2t4Kwi/WOBOIPjvFGJfTsvv+UsSO7h3ry4Up0J0k
         ZYQbDepqmsNk9tpALZhaNBdwMps3rWXeUhV7qxrYkrakxIqkYnWJK8Vlxi1bysuOeZ09
         hCVg==
X-Gm-Message-State: AOAM5317+LvvcHXuNvHbh8HKN15s8vVuE3ucTzlqJB9bik15L9jtKeDt
        3gnOsB+RJTIHyCRFcq8C8WQW9Z3dFTuYQA==
X-Google-Smtp-Source: ABdhPJz90rSGmaBPqL48N8yV+RE8wjT0yHbLb/LiMcTLhJPCCugdqFs8TPHG+pcYKPsFXe1u0UZDXw==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr24477289wrr.354.1632683015521;
        Sun, 26 Sep 2021 12:03:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] Makefile: remove an out-of-date comment
Date:   Sun, 26 Sep 2021 21:03:25 +0200
Message-Id: <patch-v2-4.8-aea4868f988-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comment added in dfea575017 (Makefile: lazily compute header
dependencies, 2010-01-26) has been out of date since
92b88eba9f (Makefile: use `git ls-files` to list header files, if
possible, 2019-03-04), when we did exactly what it tells us not to do
and added $(GENERATED_H) to $(OBJECTS) dependencies.

The rest of it was also somewhere between inaccurate and outdated,
since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
it's not followed by a list of header files, that got moved earlier in
the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
into LIB_H, 2012-07-06).

Let's just remove it entirely, to the extent that we have anything
useful to say here the comment on the
"USE_COMPUTED_HEADER_DEPENDENCIES" variable a few lines above this
change does the job for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Makefile b/Makefile
index e6b8d00f221..b9bf13239d0 100644
--- a/Makefile
+++ b/Makefile
@@ -2501,13 +2501,6 @@ ifneq ($(dep_files_present),)
 include $(dep_files_present)
 endif
 else
-# Dependencies on header files, for platforms that do not support
-# the gcc -MMD option.
-#
-# Dependencies on automatically generated headers such as command-list.h
-# should _not_ be included here, since they are necessary even when
-# building an object for the first time.
-
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
-- 
2.33.0.1291.g8857a6a91ac

