Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB14AC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJMPjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJMPjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D162EF
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so3458775wrh.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdmCi6VJ3w705NHkccAJsw106Rz1xlhQ5ug/mlpgFpk=;
        b=CfCaqIIHKuJ6Wu1bH8vUYdhP6fOZMFvZGbft5Ows+lhAb/rRzKZLkWvsdEb/R84bbr
         Ar9w+8gmpvepXgkM/0CqwND2tsVj0Rn3MRzOyKC6bscdsa/DecFvSukDtD8cNxREoE06
         2rSeD8mYeO7aelrWdrUlraFNz6s9aDysKmJz0j3yOeLoNIJWGkhlt1I+V0P8zWEtsCT3
         InaX5+uFzm7YD5h8zeW62iUmPZzyUODaeC36e434/ZWWuzUrBnyrzfxduXJuh5tYMunC
         vzgexwYfkm1/cFLuKZdgqEtlTVm8Q1+nxhQk4CkglbPZF3RpSL42FxCwXW6Q0ndcn4Ka
         k6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdmCi6VJ3w705NHkccAJsw106Rz1xlhQ5ug/mlpgFpk=;
        b=qL2nOJ3kDgz+bTITxTS+j38yNSqLyKwJCStwjyRVZyPuQU5p+pIlihaSx7bqRJnL0N
         nE+uNlrSICaYSONe7rN9mppOpt6i9y8jOthXpM9VWMXn0geu+cHpxCHcLvCT8vsJYZGi
         K6f/V4xqw9EryGc27hCeB7ldZUhSTiX89WzgDluVSOdDzDrj63AqDRt2iqSIGQNf4N/u
         v7T4Ney9WXlk+uLXqZq1aqvArICT2DD0yxVooaAsHQ+NCHj2xkaOwwZ3q2BxEL5OkVAN
         WhbSuGuzYLtIfQ8RF/nHf2/ZeTmPByWZ3ZSINR9/H39b05OcLMRDpZsbGqTYC2NRw5h4
         LhUw==
X-Gm-Message-State: ACrzQf1owsb8WmkFIDyXMIArA0oHibFBjhfl1kMtvp2EKuBc8Xro3iC1
        Tkdez/fRnJVIwMy/fG/URKnSVFOrKgdATQ==
X-Google-Smtp-Source: AMsMyM7QfVUKsIN64N3ZXAI0Z6T4UpgvwqBojamRcZXgE/veqCIqeCH7X2c3tWXxy0PErs5FX2rYiQ==
X-Received: by 2002:a05:6000:2c9:b0:22f:e7b5:bc26 with SMTP id o9-20020a05600002c900b0022fe7b5bc26mr380397wry.149.1665675579011;
        Thu, 13 Oct 2022 08:39:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:38 -0700 (PDT)
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
Subject: [PATCH v5 05/34] doc SYNOPSIS: don't use ' for subcommands
Date:   Thu, 13 Oct 2022 17:38:59 +0200
Message-Id: <patch-v5-05.34-88fdaff4f28-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Almost all of our documentation doesn't use "'" syntax for
subcommands, but these did, let's make them consistent with the
rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt | 2 +-
 Documentation/git-rerere.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index db9d46edfa9..0537d4645be 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog' ['show'] [<log-options>] [<ref>]
+'git reflog' [show] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4cfc8833780..4b613d4140c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
+'git rerere' [clear|forget <pathspec>|diff|remaining|status|gc]
 
 DESCRIPTION
 -----------
-- 
2.38.0.1085.gb7e61c3016c

