Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608DC4332F
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJDNYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJDNYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF58B52E7F
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p36-20020a05600c1da400b003bd24ccae2eso835493wms.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy7dR8/Abr3dhe7BRag2bClwykGSjjDANdsGXG+aadI=;
        b=TjjXmc+4yYtzJzTYrKVepCUJgxMkgRGdQ3wlyG/i8eSOZsTX/aeBVGk1ymsnlv0Gk6
         lsBcq1wxp+kiUhf58HCQRRW/n+CO7S/wfGrXjeVpo9wNMred8VKW1yYuvzYKWjuVEHJ4
         Yy8bHoac08cZKSxi8FPcXGC+p5dhXMtf45vRzZpZdP0nCtuzTK9E+TSKL0izteF+w8ez
         5oQ8IX3DlXJn+ZWaAFw7l/0vL/bCfnQDdDLuiej9cgUxB1TSGnCOTod/j+EaZsL5AfES
         JLTQzknsJbWLfNdAC3pb3F+starL4Noo9mget5fsPASlRDAofWPGb07W36azSA0Veh5m
         fQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy7dR8/Abr3dhe7BRag2bClwykGSjjDANdsGXG+aadI=;
        b=bJoQqWbJDqxqaT8wxpCWl1AzbEIV0PVhZVTxJZ2j5sbbme4lWf86slKproGF7qF3nD
         5Onxn+tRRi40/F5dIF1IqP0n+nijTumfjtzRfSUwggxK9RBSYFLHs5N3kh/gyJeLdQZ3
         8Y2dw5fjQzvSCH4cjur7NBety7HHQetZ9MVk8olD5DhuiUFWexrX3LNFeBUy3fJ1xb8w
         HNggLfrRqPcAvItmeXFEUFA5roxHPiV6FWxEBlT/B+z6ZE9Tbgma4f2G5U8lPsWSTW5x
         LS0BE/EDtmaNvpi7jtHuHUaV640c762N4reE76QPpKNQL3zXp1Pd6NJcXidQ+a9xfJdh
         TEOg==
X-Gm-Message-State: ACrzQf1VDoWMF3gSYErqAy93FTOzCFy7eqw5HZK5vUeAwunZ2qLOpqTu
        I8W8P4HPyXQAZw9NRPhzn0XhkWt43Mu42Q==
X-Google-Smtp-Source: AMsMyM4ng6+iEwj+c+OHSvxaS+DPZen0SAbyrBpaVRWs4PWzpQp/H93AeBTUNJs38iUfDH0tqbnfIA==
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id n13-20020a05600c4f8d00b003b49f2f4311mr9897464wmq.17.1664889838713;
        Tue, 04 Oct 2022 06:23:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:57 -0700 (PDT)
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
Subject: [PATCH v4 06/34] doc SYNOPSIS: consistently use ' for commands
Date:   Tue,  4 Oct 2022 15:23:20 +0200
Message-Id: <patch-v4-06.34-f20cbb661c6-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

