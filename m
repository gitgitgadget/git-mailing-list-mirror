Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE414C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F3020760
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvFS4rQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIETsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIETsR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:48:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E47C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:48:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so9703682wmj.5
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=zSqBf5A/2B294p7x9YnQOHm6EoQWqx5242qfh8QaqLY=;
        b=lvFS4rQviPNjWEWpFrGu5Dok0RQkxcsmx9QHGdZkr37fWTz2Ee1VARYk/Sptqswsis
         rQVKprBLISXZrAbnFPa+DG7cFpiTKyKX1fRZ0wF5o7onZMh56r/H78/qweY0+q/qcFGB
         cdPLt3Igh796kJ07sr8EJlz0uQRkgxwup09adnPXD7UCbfpx4Jm+vOlgg4vYlj0FYuoJ
         +gWowJ+8Au213g3UVTQmzniHoY/zkOLRJ/S8CAQ3VpBkcMfOhqzP9c87sleEgu8UiR3J
         MayCRG6qU9hVyY/KQdhG7K1bfcbhGCFRAf08fKVWyRAjz9ddt7/gCIC2VlWZcsJrkuMO
         oBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zSqBf5A/2B294p7x9YnQOHm6EoQWqx5242qfh8QaqLY=;
        b=HqDRAByiG6j0FnSHHxPYr3/k9G98e27sBZvmGWY2+wjndhqilKxXCCY1Ah7wKf8sdr
         A80f2JOavuZEVTi0j4w88HysgsJAVV652K6cweqj17x8NTYcy5BkGtCVzIKZZ4Nf9dpc
         GMa8dEMVYgYMiQmhWlB++nfPXKv4RKI7EUorYKAzrzafUolZa8tnYWdRgUxvOeTzhkN4
         SLkRAG6tm0Yn4ypUMJxDGTRUD1om5e8t6ZUbrAF1xor9uZFWn9qEg3szAHZ16LM73UAH
         Er7mcIz5cX75RLb3NzJpL1EZsS4uat88IbK39VzWd6YuHPXMEmO8d8IdgggyFa1HT6g2
         11Dw==
X-Gm-Message-State: AOAM531JNuC/ZHtXurUk2G/waNVjf0veZuZKhHwstUEw6p0v6sc0/nbe
        nPoc47Jv6N7SmTdvt3cUTv27cxYPo5I=
X-Google-Smtp-Source: ABdhPJwPzq6wlpI5vi+Y4i5/Pv6Qj7zlueZ8UYcJowm9Uuz0/pzpaST6frPXpst3mr4lnrKEebeJTA==
X-Received: by 2002:a1c:302:: with SMTP id 2mr13008874wmd.134.1599335292903;
        Sat, 05 Sep 2020 12:48:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm20746930wrl.7.2020.09.05.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:48:12 -0700 (PDT)
Message-Id: <pull.726.git.1599335291.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Sep 2020 19:48:09 +0000
Subject: [PATCH 0/2] Unify trailers formatting logic for pretty.c and ref-filter.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a separate logic for %(trailers) in "pretty.{c,h}"
and "ref-filter.{c,h}". Both are actually doing the same thing, why not use
the same code for both of them?

This patch series is focused on unifying the "%(trailers)" logic for both
'pretty.{c,h}' and 'ref-filter.{c,h}'. So, we can have one logic for
trailers.

Note: We used pretty's logic in ref-filter because it supports more
%(trailers) options.

Hariom Verma (2):
  pretty.c: refactor trailer logic to `format_set_trailers_options()`
  ref-filter: using pretty.c logic for trailers

 Documentation/git-for-each-ref.txt |  36 +++++++--
 Hariom Verma via GitGitGadget      |   0
 pretty.c                           |  83 +++++++++++++--------
 pretty.h                           |  11 +++
 ref-filter.c                       |  35 ++++-----
 t/t6300-for-each-ref.sh            | 115 +++++++++++++++++++++++++----
 6 files changed, 215 insertions(+), 65 deletions(-)
 create mode 100644 Hariom Verma via GitGitGadget


base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-726%2Fharry-hov%2Funify-trailers-logic-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-726/harry-hov/unify-trailers-logic-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/726
-- 
gitgitgadget
