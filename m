Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478B320281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbdKEUZS (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:25:18 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:56443 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKEUZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:25:18 -0500
Received: by mail-wr0-f193.google.com with SMTP id q66so3176902wrb.13
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HOL7Fog8KYMOWjWqz/SlMK+J6f4xSG5X9dS8OpJ8pzo=;
        b=Vq+Yyqzfm/xFNffAj8UjIx8cdIVkxrhNZGopOfi0vchJjvzjIHUawwpd6Qu0wvxy9w
         DfJ3AYR68yoOYfAh+2LchUfhhrX7F6lXed1ElvuP7d7SBu6y1N/dpnGAJFt1+w0nuYT8
         /hQsK8qdnuU1/JZALzVKC0KqgMDePo9cCSJEPXpb5UxBdv+iO7XGaWOgaVu0Kfjmvitx
         Gw0hHw9y8p6wxzvUqAHQSO417ATbsmQ8gMTFGjY+c8b2Aa6PmRFfTJ/+mj2lpqskqoas
         DvJSlH5tNHQ3WzmntWHsJcxrgbQNVlhGS3T2WPZf8DtgigtLX36LO5YrLCI6bszyIeOS
         L7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOL7Fog8KYMOWjWqz/SlMK+J6f4xSG5X9dS8OpJ8pzo=;
        b=g3Og0HF+JlybZqWgbvTT9yqVDR5KXKBd8+f6lb7ntqjkICZB2jctUFac20lC598m8L
         xqWAUuUCVmjDANnuAyraHDg4oBlnxrdhLlK32nSnaMHGMjP1lr9miPQyUupq8Kmjv9Kq
         h+AudtB7D++QjLYgwlmmGIf8/lWo9IDPcrQPa49Gn/j1QHIcW7z0Zr/BzcHhNZb5S3Nr
         s/beh1Gglz74vXcUHcOSfItzDZOYr9tBNwvlIZDHpmk9VXlNQF5iQ6UCa53vm1o4NOmQ
         WaFFHdsGb7xgO31CYTNsOfnWdMyxS912ovGPAthuQ4ZmGabKWLl0cqwt0nm9jgYUZOgk
         11eA==
X-Gm-Message-State: AMCzsaVRK4IPpbCRbi1tFxaaDd9+g9uTZH4tv7PoU1t0O3QteafMVuAZ
        lt3whRX2nIdi1tCqdmEbeCoY8vJO
X-Google-Smtp-Source: ABhQp+S+PjPqTtCdX3Kklnb55oWzVoSxNA65zGIQmJ4xk1jmifXetzWNRbCLWswwmpJK4wqLCAzlSQ==
X-Received: by 10.223.142.180 with SMTP id q49mr11770989wrb.142.1509913516544;
        Sun, 05 Nov 2017 12:25:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 71sm12917543wmg.0.2017.11.05.12.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:25:15 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/4] bisect: assorted leak-fixes
Date:   Sun,  5 Nov 2017 21:24:27 +0100
Message-Id: <cover.1509906092.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <CAN0heSoBeG_8zLwS-71_ZVBF-HsVGKY1W1QiTSQ_ybwWCPauog@mail.gmail.com>
References: <CAN0heSoBeG_8zLwS-71_ZVBF-HsVGKY1W1QiTSQ_ybwWCPauog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a couple of leaks around `find_bisection(). The first patch
is new since v1 [1] to make the calling-convention of `find_bisection()`
less prone to misuse. Patch 2 is similar to v1, the only difference is
that the "while at it" has moved into patch 1. Patches 3 and 4 are
identical to v1.

Martin

[1] https://public-inbox.org/git/4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com/

Martin Ågren (4):
  bisect: change calling-convention of `find_bisection()`
  bisect: fix memory leak in `find_bisection()`
  bisect: fix off-by-one error in `best_bisection_sorted()`
  bisect: fix memory leak when returning best element

 bisect.h           | 12 +++++++++---
 bisect.c           | 33 +++++++++++++++++++--------------
 builtin/rev-list.c |  3 +--
 3 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.15.0.415.gac1375d7e

