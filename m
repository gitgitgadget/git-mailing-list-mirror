Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66422C4727E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E3320B1F
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZqvE/ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgJGFJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 01:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGFJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 01:09:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D47C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 22:09:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so398596pls.8
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 22:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94F8+vysXCWiw4s+2PHlMdgj81z3ax+HxYeMp5Xkrks=;
        b=HZqvE/ju91d3gSVbnpxzOEIuAeKeXUmQq7PI8wyvR5ghcheeex5IzC+kL1pxX9HD41
         dQI0BCrFiSOjit7iSJw2/NQ1n3mmMeUA9BKGkxM7aGUgJbwUtsyRIN1sQGu6CLP9Ok+C
         y5MOcjiLGRk/aqHR56l6DFLBBEin/zI6AfjAw4LnPg/oj2lDGNumTSf84J2Hd339WrKO
         3aUh+Ii45YGgNjoJJdaqEKc617Eus3nyWiSBKlDapa5+nEPOfxfIqETxQf/s9P0Rpv/p
         32x4xf3YYBddodun+fR/gQrs1zCrM0RfgHDCx9+mnW/ccp77ACuu02GQHVbFgaZMpPuu
         y+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94F8+vysXCWiw4s+2PHlMdgj81z3ax+HxYeMp5Xkrks=;
        b=jeaBkpECndgr2RvOEe3rG2gCfasQ7uE2ozaV+dKazPqnfCXgDZdpP6HH6j3wm6eEYH
         i8C/aI9GReVs/xogWXVqrzTDFUJBnQn4GN8GoPurre2sgziX0Rbu1I3fZU4Awprn35XH
         sYYa+nRqt1bgi+GKehE/bo0Dt/pk4Fsz/zpmQMdV/CSjQ0Hudw0PuupgMm9HAbBVpTg7
         9/6oTW6rT6aBfHRMakJ73dwQC1LOT+4WYZ4zxg9Urp6A+bdRMENfY2+ysnHnT3C1yE2X
         fcwpuHYFO0KX56X4LiJABePWEmW0b1TzXw+TPZ4bNwxjkKqX/BmZwqWd0ZiWSddGUAKk
         Ly8Q==
X-Gm-Message-State: AOAM530lj6aSwUJUq/OHkidcFI8nz/IxXqXXJS1TQTOu7ovq7OPgy/OR
        UWDyMjbfbJqeJoejvlZ2i3sB7ofrVNU=
X-Google-Smtp-Source: ABdhPJweExP6qerPbhQKZDHgMGp59usDk0wtWQvZ9DypdzNSL65zFkJtGzoalRdz03bIXNBnRhGeOQ==
X-Received: by 2002:a17:90a:39c5:: with SMTP id k5mr1393354pjf.34.1602047364667;
        Tue, 06 Oct 2020 22:09:24 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id x23sm1053621pfc.47.2020.10.06.22.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 22:09:23 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] checkout: learn the checkout.guess config variable
Date:   Tue,  6 Oct 2020 22:09:07 -0700
Message-Id: <cover.1602047333.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1601810233.git.liu.denton@gmail.com>
References: <cover.1601810233.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user does not wish to use DWIM behaviour, they must manually
specify git checkout --no-guess each time. Teach checkout and switch to
honour the checkout.guess config variable instead.

Changes since v1:

* Replace enumerated priority list with bullet points

Denton Liu (2):
  Documentation/config/checkout: replace sq with backticks
  checkout: learn to respect checkout.guess

 Documentation/config/checkout.txt      | 21 +++++++----
 Documentation/git-checkout.txt         |  3 ++
 Documentation/git-switch.txt           |  3 ++
 builtin/checkout.c                     |  7 +++-
 contrib/completion/git-completion.bash | 25 ++++++++-----
 t/t2024-checkout-dwim.sh               | 11 ++++++
 t/t2060-switch.sh                      |  5 ++-
 t/t9902-completion.sh                  | 52 ++++++++++++++++++++++++++
 8 files changed, 108 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  f08d3f796a = 1:  f08d3f796a Documentation/config/checkout: replace sq with backticks
2:  8172602f6f ! 2:  2678680a08 checkout: learn to respect checkout.guess
    @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_bundle ()
    - # To decide between the following rules in priority order
    - # 1) the last provided of "--guess" or "--no-guess" explicitly enable or
    - #    disable completion of DWIM logic respectively.
    + # Helper function to decide whether or not we should enable DWIM logic for
    + # git-switch and git-checkout.
    + #
    +-# To decide between the following rules in priority order
    +-# 1) the last provided of "--guess" or "--no-guess" explicitly enable or
    +-#    disable completion of DWIM logic respectively.
     -# 2) If the --no-track option is provided, take this as a hint to disable the
    -+# 2) If checkout.guess is false, disable completion of DWIM logic.
    -+# 3) If the --no-track option is provided, take this as a hint to disable the
    - #    DWIM completion logic
    +-#    DWIM completion logic
     -# 3) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
    -+# 4) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
    - #    logic, as requested by the user.
    +-#    logic, as requested by the user.
     -# 4) Enable DWIM logic otherwise.
    -+# 5) Enable DWIM logic otherwise.
    ++# To decide between the following rules in decreasing priority order:
    ++# - the last provided of "--guess" or "--no-guess" explicitly enable or
    ++#   disable completion of DWIM logic respectively.
    ++# - If checkout.guess is false, disable completion of DWIM logic.
    ++# - If the --no-track option is provided, take this as a hint to disable the
    ++#   DWIM completion logic
    ++# - If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
    ++#   logic, as requested by the user.
    ++# - Enable DWIM logic otherwise.
      #
      __git_checkout_default_dwim_mode ()
      {
-- 
2.28.0.942.g77c4c6094c

