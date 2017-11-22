Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925E820954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbdKVWif (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:38:35 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43308 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdKVWib (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:38:31 -0500
Received: by mail-it0-f68.google.com with SMTP id m191so8043957itg.2
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N4UNvYgdjjLN+fVR19Le1UM2G5VeCGO0SV90Tlrs8E4=;
        b=ZWQ1QDA8bczbb7HRPy6ojCuzQ2eF2eeQMzM7mxJOWv6cWj9Wto9lmvCTcXz0pNPKhU
         Q0yxaCuYjHgXT2HulZ5Em0QC31nRnyyvpyMqYiHiwpiYpRDn0sUkAIbEBfJcYKUBFwzB
         TeY4ZqYtklGaNpdn7+tLXzYeoVNEVdwez5Z0v/1kiJ4V3wK7w36rEZjtrF4LLHZipVLm
         fN2oJD9UFV1LWqyCf3k2kgaXTKpZzoXCxVJVPFYr9DWi34eNUfKVo38/8PPZBBM1RIrm
         UMMYbaSUwn21bWh0VqjtlaEusQOiJAkCODW4x5P//cO7CNPEiH72MQGe4YTLhuQLLNe1
         NmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N4UNvYgdjjLN+fVR19Le1UM2G5VeCGO0SV90Tlrs8E4=;
        b=Tjy9edUYgfzgK81EwyzeXS9Bkf+Ir7OBCswuSLvrZivquLMDhjI1TBFXef3mlLpdbp
         3nHPMIHzh0TDOgEl3K/BoSAzHPhpCKT0R12izL/oZdV0TeBXKiF68iSmYiIqW0/1TIDY
         vp/GXqyQaLwZqs+eoYHWdoCF+F+C0Ke2OpeTBQ4vTERzhrH2ZIaaJewWqgwI0JYm6Y+b
         hXZC126kqgHkfkpjGm3X3918nE3pCU2XpkVsk3NiL9hVYu0lWO5mlA/QK3Q/Q94J3mLw
         jWtATZhNGzyrja1y1q3zCCIJU3AYA81iThWCiTPJ/g/6n+1HRqvUHlZwXxCaNYnywazF
         Xrkg==
X-Gm-Message-State: AJaThX5Ey1i0xMQVuXBgrrTWz9BTEZsjX1HfeeGa/STUTq3jca6+hYh+
        ERKMw0wKyTfZdD6Dusg0U/eygoCvULY=
X-Google-Smtp-Source: AGs4zMaCc33xI1Lh+pOOiqDtA4ySbRg8DV/TkyIp705ZNtGGxAGpaxwLOz+L5S8oUgMxxESxaZOfEA==
X-Received: by 10.36.85.139 with SMTP id e133mr8991242itb.147.1511390310011;
        Wed, 22 Nov 2017 14:38:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y73sm2486878itc.8.2017.11.22.14.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:38:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Date:   Wed, 22 Nov 2017 14:38:24 -0800
Message-Id: <20171122223827.26773-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On reviewing [1] I wondered why there are so many asserts and wondered
if these asserts could have been prevented by a better functionality around
bug reporting in our code.

Introduce a BUG_ON macro, which is superior to assert() by
 * being always there, even when compiled with NDEBUG and
 * providind an additional human readable error message, like BUG()
 
Opinions?

Thanks,
Stefan

[1] https://public-inbox.org/git/20171121205852.15731-5-git@jeffhostetler.com/

Stefan Beller (3):
  Documentation/CodingGuidelines: explain why assert is bad
  git-compat: introduce BUG_ON(condition, fmt, ...) macro
  contrib/coccinelle: convert all conditional bugs to bug_on

 Documentation/CodingGuidelines  |  3 +++
 builtin/merge.c                 |  3 +--
 contrib/coccinelle/bug_on.cocci |  8 ++++++++
 environment.c                   | 22 ++++++++++------------
 git-compat-util.h               |  4 ++++
 notes.c                         |  9 +++++----
 refs.c                          |  7 +++----
 refs/files-backend.c            | 14 ++++++--------
 refs/packed-backend.c           | 13 +++++--------
 sha1_file.c                     |  4 ++--
 tempfile.c                      | 34 ++++++++++++++++------------------
 usage.c                         | 12 +++++++++++-
 12 files changed, 74 insertions(+), 59 deletions(-)
 create mode 100644 contrib/coccinelle/bug_on.cocci

-- 
2.15.0.448.gf294e3d99a-goog

