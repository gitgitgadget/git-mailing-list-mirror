Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FBC6108D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351990AbhIHPZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhIHPZf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397EC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so3895050wrn.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuEeYg4x4mCSPQWwyP1PCOKXmE4Eza/m8hpIFQcj6vY=;
        b=S7kt79MpPdqC/RKjx7UbPNNvDEt9prT3l7f4qB1kzTV7Q0zik0QCwJEfceSEQvR/0r
         GTOMUngdGRINqdL6UW4dzBMtuZRVgjboZpLcZCESdm0Vn1sJBJ78i0RilFC1yrnkTHns
         j02ce4Q7zbl9Tzz+PO6yii3YsoCmatMlLgPXpOlD5DTKB7VSsGqBJr+QvV1WorbFs/21
         BKVNK+8ejUbvJNSiteln1hk39ccR+WjOlvxCiy8gZnENUmrPkRF7lDmNfpz6D/RkEBd0
         cYoTk/rQ+y/gySXdZ8nfQBDZ8zDknLf+eG6JgbD+jQ2HItjCHRPCNQLL2vbQyT+aWfji
         C6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OuEeYg4x4mCSPQWwyP1PCOKXmE4Eza/m8hpIFQcj6vY=;
        b=f+0qJUwdG3La6hhmOBrf9g2szXHsJBK6uYrj+FTA5Wb4UcmCNoEp8SlWQdPzr6Uo1N
         +DvAitPK2ns8YUN5xjP3hAdFhgc71QnKSq/syH0Iagv6bq2Sq4J/6PsOJGSpBYsaeuwJ
         Dl54Zhpp7HGRJ8fp3ZSjN/moqrN91GYtwlBMlqOatJCoVresm8SrebxBT/hvGgLqKGcn
         fmUiONwZCVRL0IxtaAdarI4PwEI0PynXGvg3k+cqaNfljb4EDvws7Qe+rCJUAMdRMZDi
         tig8yNnU0xUxGawTda5dPX57HBL+W6dX2r5Xh1wUPnkwaFvKuhZi2A7PdKLK0WL6ly+e
         3yTA==
X-Gm-Message-State: AOAM530Zs4zh2xnEpqhOqI3upTMonwmt/AeQtfFT7yfaI8sYPvGoOvMS
        mw15+PY+jhNOHR0dBqT6ju8Y/gE25jWDtw==
X-Google-Smtp-Source: ABdhPJycqLyuHKmf2Xb4bgeFLoztduSIlXtdvoAM/BhKFrj6X6qNJhR3RGrVsISmy9+/VxPPjUPXHw==
X-Received: by 2002:adf:e485:: with SMTP id i5mr4684952wrm.22.1631114665895;
        Wed, 08 Sep 2021 08:24:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] help: fix usage nits & bugs, completion shellscript->C
Date:   Wed,  8 Sep 2021 17:24:16 +0200
Message-Id: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes various bugs & edge cases in the "git help" command,
and improves and splits the internal-only "--completion-for-config"
option into two, and as a result can get rid of an awk/sort -u
pipeline in the bash completion.

This is all rather straightforward and boring, the first patch
mentions an interaction with my not-picked-up-by-Junio-yet series to
fix parse_options usage alignment at [1], but while the two strictly
speaking "semantically conflict" (in combination they'll produce
different results), the exact whitespace padding of "git help -h" is a
trivial enough issue that they can and should be considered
indepedently.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  help: correct the usage string in -h and documentation
  help: correct usage string for "git help --guides"
  help tests: add test for --config output
  help: refactor "for_human" control flow in cmd_help()
  help: correct logic error in combining --all and --config
  help / completion: make "git help" do the hard work

 Documentation/git-help.txt             |   9 ++-
 builtin/help.c                         | 102 +++++++++++++++++--------
 contrib/completion/git-completion.bash |  21 +++--
 t/t0012-help.sh                        |  45 +++++++++++
 4 files changed, 131 insertions(+), 46 deletions(-)

-- 
2.33.0.825.g2bf60429931

