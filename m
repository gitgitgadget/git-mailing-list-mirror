Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A492BC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJMPkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJMPjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2C9FD8
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so3414245wrj.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpndUFY+yhrSbBYcblLx3ZTaLD2aBOWsJ7Z6dlIN1nw=;
        b=LRZNkhD/MCOruQ4UwYhdLAvHIh0bt61pbg3QD6ZK9mCtrgEdYtYIHJiwS6USkp7y2n
         RmZStsqQSMEhlDtuLePR0uCfjBTKe4iCZBPLgtD5YsAxK3I/ODwkXmDnChi4sx5nU/Ig
         mIY/p3uBrUDkmilRLrs1bjgrDRwxnWNokcWjqXlsabe5M8AQVvSKHFcP8jbdnyxGv257
         28mli/Cdyk8+jE058v+T1FglXfsd3yPd89Umh3mgrk/p0tn7e567DEgJzemzm45Ru01f
         /o1WJoXpI+BEWiO5o1PougsriYnrD4hbUHEWuMpkzRFyGULgKd74O6r6r9gG0RBCiglD
         cfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpndUFY+yhrSbBYcblLx3ZTaLD2aBOWsJ7Z6dlIN1nw=;
        b=byCL4D+pswKNUOU7m6w3WBdPoYnJwwxU7uDfuFAMaAxZ6HBpSRN7vwzhxnq1GtfFst
         fT1ERSdWSpZBI2esoYGkikrZIkz3Moo8K1nVoLp1/faNkCJz8O343Of28e/8SEQCWTJA
         gAtSM+7j2imocLEO+mGhFwg/vGjLxw1WFSMWPch2pp/+N0iZQYiB5LiFveN0no9s1z78
         XelRZBsXMv48QfmHY1mnPz8tQsuragatjNW/kgG6dd3C8VL9TWazZMdTZoCETmsNvj+q
         XeAYQ/KWmm3l4fPflz07zFNDtdKhpvukskTXnuzgRwRZF+Bjg4b/b1rW5KmJxsjIcwTO
         fYAQ==
X-Gm-Message-State: ACrzQf2rvMNoTSdQfwUBGtUTHJf28ngR6SyexbZnXAzzP4uYDaj6weWK
        eKH9K8gMT4+osV87R5215c8K3PxkvolVSg==
X-Google-Smtp-Source: AMsMyM4KUKTlk7uRecJJTzlN6RpxI9TUqUrmmxRMieBPSIVeEJPpqNCJyAZ10nT7tttr6ishjx4HSg==
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id p16-20020a5d68d0000000b0022cdfba3bd6mr410207wrw.300.1665675580085;
        Thu, 13 Oct 2022 08:39:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/34] doc SYNOPSIS: consistently use ' for commands
Date:   Thu, 13 Oct 2022 17:39:00 +0200
Message-Id: <patch-v5-06.34-7a4e244b261-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our commands use ''-quotation only for the name of the command
itself, and not its (optional) arguments. Let's do the same for these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-export.txt     | 2 +-
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6ad..4643ddbe68f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -9,7 +9,7 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export [<options>]' | 'git fast-import'
+'git fast-export' [<options>] | 'git fast-import'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3776705bf53..872436d7426 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [<options>]'
+'git sparse-checkout' <subcommand> [<options>]
 
 
 DESCRIPTION
-- 
2.38.0.1085.gb7e61c3016c

