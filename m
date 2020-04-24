Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99702C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CB520706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLaW12Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgDXPMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgDXPMk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:12:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4EC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so4736678pjo.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8v+dexoJDbkn5/CWE7fAsYprmFCZV4KOjwmgEP1iSs=;
        b=OLaW12Mf6VWWg93Tq+SZKkOOzLl+24BGY0Ci1TZ2iaU0uPpg9QvQKF5UROfluD1/Pc
         IeL1I72BaJjADs1cttYkJTz+zeN1MeQvAlPFny4S4GOwE+tWKY56U9VL7Emlj/+P8g9J
         c8ci6T4hk/AEXAoDsUKjWFEFKLnyvAtLQg3XzK11jZ9S1OcDoU0VshMSUgtwPvoSdJhD
         K8MZA0Z+rJRCEJ25o9AF8BYV+8YrkHzRaNPHz7nojLfA+FuYpD6Rf2+jMWuEpVo5FKok
         vo7GbyU+r76GfOy4oExUlhr54p2iGmn7evaveUueOB46EFGqUo6yD8JPYLhpSOzcLJlq
         QaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8v+dexoJDbkn5/CWE7fAsYprmFCZV4KOjwmgEP1iSs=;
        b=ayBCQcexCRieTbWimaoFHyg6KxUM/8xIeSOKBFG2OZLPPRGgpmUAQjwMpvHrbFGp2D
         Vb+sUHZmMZHX+HBz7kQMFOqtqVrUI9MdrsRkFyLuC8uggFkoUHFlrGI9FxHAcD+5oxgu
         DCqr+Z8qgmZOt/RIEMGD+TZ+5m4SzNYsotKSS0iot8anqNJj9K8uBqQ2vXczCfzwIlAU
         JXZGORSAJSq+vinLWsXgnKg3xPa7+V91YIgCaai6E3uFFFUDGi+EMXfU2ndC1/7aTb4a
         lqunDcy2WK3YjP9ffTlbmhDc8I2Yq+cLYiCwEbFK/V5LPSCq/RpVVNznWXlS9oRB9rdZ
         f62A==
X-Gm-Message-State: AGi0PuZglrm3rdr9g8cYk/sAd7zUagtYoRP76tREUnkHHsuis5+IczDx
        suELF7tbDggurN63vZcR/6oAh4X0
X-Google-Smtp-Source: APiQypKG1CgPsPTdjiV0HtkVsKU/UTEKsmytJghExCqvOJdasZU+sm+vu0TIzvRumxXr8OXNk1rgFg==
X-Received: by 2002:a17:90a:9318:: with SMTP id p24mr6561325pjo.163.1587741159869;
        Fri, 24 Apr 2020 08:12:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id f99sm5078429pjg.22.2020.04.24.08.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:12:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 0/4] Fix Sparse Warning
Date:   Fri, 24 Apr 2020 22:12:29 +0700
Message-Id: <cover.1587740959.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change in v2 from v1:
* = { 0 } is an idiom to zero the structure, it shouldn't be changed
* change in [4/4] for prototype
* ignore diffent function prototype

Đoàn Trần Công Danh (4):
  test-parse-pathspec-file.c: s/0/NULL/ for pointer type
  compat/regex: include alloca.h before undef it
  graph.c: limit linkage of internal variable
  progress.c: silence cgcc suggestion about internal linkage

 compat/regex/regex.c                | 1 +
 graph.c                             | 2 +-
 progress.c                          | 2 +-
 progress.h                          | 8 ++++++++
 t/helper/test-parse-pathspec-file.c | 6 +++---
 t/helper/test-progress.c            | 9 +--------
 6 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.26.2.384.g435bf60bd5

