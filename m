Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6880C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49E020798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbhAANHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbhAANHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:07:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F454C061573
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n16so4772107wmc.0
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XQJGkDglyIDocI3qCkqMavMVocksB1OIOF46/ad401g=;
        b=kiZ5AEA8JmGuNqMEdy4aa1Bjc8aBkUwDtMhX9Q758ZCW6gnPNO/PinADaMvw5tHnYS
         3RzlVxy9enMUCKrEU95ii5S0vLZxRw1v1eVP1BJMqRyFkSAHfOzIAZVRDwCHG4vS/XnV
         SkektPkdNPQ2Zsm18M/g2FlXmvYGek8cvU9dyh/HY9C57c1ORV8YxNVL686beQDo5J+b
         9ArkmRaKAYnL80iPHwd2v3z8jOtUIcAUoClGaj64CVsP1izieHmZwkux1VA1V+vCGEIJ
         p1Gkoqdxu85MevbNVFcClAuBp6agQs8R+ssvkRtNq1qLkit3hHWs1OnyBLt0EKEA152Q
         +Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XQJGkDglyIDocI3qCkqMavMVocksB1OIOF46/ad401g=;
        b=Atek+4A9D6lAaOlCvq95cwxp5MbMG4IvkuSVCvO7nHnWP+c10/DN+fPPf4jJ6cr3qU
         Qynxf8+1wwDDFfxneQkCbmF4NRT9mA5G6I0ZA8qtwmNk9Xek3H4EcypSD6YcV8TLZ2yK
         Vt2wmMC1pIa1IrlPrq1STFVEsAyxbiYP3xVOauOBjZVi35ClaEepiai0zuAvS52B4y5M
         CKOU7zLd3wVDtqi16LiThGe1HfjrENAe9yljvx0cldEzM+X3twWMbXBQvVVZ9L/rO5zs
         aUFCQOV+zJr1varIYjqFb5nG4EUPT1Ux22wuwS9MWTo/JR0EO4vhHaMuZX1ka0fZuWro
         qM1g==
X-Gm-Message-State: AOAM530J2scmIW6gq3oqKJU2tBRq+GQsvpmrZUatvj7slcaxySo+lcME
        BgpclnLvzBrypLIERURjgFk7Zr/noqU=
X-Google-Smtp-Source: ABdhPJyOGDBnlHM7RJIUy+0a2WETiwZ/oopmYMZ0KIiZqo9k0Dz5tYiwY44lWqj6ofxEF1HVO4pRTg==
X-Received: by 2002:a1c:b742:: with SMTP id h63mr15484912wmf.122.1609506430135;
        Fri, 01 Jan 2021 05:07:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm81872376wrw.81.2021.01.01.05.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:09 -0800 (PST)
Message-Id: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:06:56 +0000
Subject: [PATCH 00/12] Remove more index compatibility macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that Duy's project around USE_THE_INDEX_COMPATIBILITY_MACROS has
been on pause for a while. Here is my attempt to continue that project a
little.

I started going through the builtins that still use cache_name_pos() and the
first few were easy: merge-inex, mv, rm.

Then I hit update-index and it was a bit bigger. It's included here as well.

My strategy for update-index was to create static globals "repo" and
"istate" that point to the_repository and the_index, respectively. Then, I
was able to remove macros one-by-one without changing method prototypes
within the file.

I had started trying to keep everything local to the method signatures, but
I hit a snag when reaching the command-line parsing callbacks, which I could
not modify their call signature. At that point, I had something that was
already much more complicated than what I present now. Outside of the first
update-index commit, everything was a mechanical find/replace.

In total, this allows us to remove four of the compatibility macros because
they are no longer used.

Thanks, -Stolee

Derrick Stolee (12):
  merge-index: drop index compatibility macros
  mv: remove index compatibility macros
  rm: remove compatilibity macros
  update-index: drop the_index, the_repository
  update-index: use istate->cache over active_cache
  update-index: use index->cache_nr over active_nr
  update-index: use istate->cache_changed
  update-index: use index_name_pos() over cache_name_pos()
  update-index: use remove_file_from_index()
  update-index: use add_index_entry()
  update-index: replace several compatibility macros
  update-index: remove ce_match_stat(), all macros

 Documentation/technical/racy-git.txt |   6 +-
 builtin/merge-index.c                |  33 +++---
 builtin/mv.c                         |  42 ++++----
 builtin/rm.c                         |  56 ++++++-----
 builtin/update-index.c               | 145 ++++++++++++++-------------
 cache.h                              |   4 -
 6 files changed, 149 insertions(+), 137 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-830%2Fderrickstolee%2Findex-compatibility-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-830/derrickstolee/index-compatibility-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/830
-- 
gitgitgadget
