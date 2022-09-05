Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B43ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiIEI1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiIEI07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:26:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7595DFF
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5226618wmb.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lc7y0cy7HqWcsl8iS6NQMkMnl7Oy6muCxdekmSW5n7s=;
        b=Rg3RRgXMBvoh/9Urjmdv3cIKMNhz2tyFJX0VxqR1O3rYUKbKJnaVOmRJY3lBJxouxt
         8oZ0Si4P/8xvVo7XH8dmVbR8shLA1PNwaEQdIbNY9j9XSkLd7a2r1dL1Diw4jaVA+cyR
         0gTV7j7dV9yCMSiebxM1ghMGygbM3zC0pW9Ld/JW2CRlZrPkf+LM4Jmf2RpMGLXCtwwx
         UkAK/6ylZ2igOSsmRNjX50CL6iAImQOFseRrhfaP2wCYAQGa0UlvJBHZWf4EWxCjjdcp
         foOxrCPp0vp57yZcoPIFMmedxyYOp5KbIx5bqToQle2LBXTqMA5uPVxDeuy/T8KyBgkI
         PLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lc7y0cy7HqWcsl8iS6NQMkMnl7Oy6muCxdekmSW5n7s=;
        b=BimJ5rvOYPKS1guDPn09qsoz5SRE8Bd9suXw75dVOO3gynxkhDC/iEsvU3BvpW3YIO
         Osv6SKtMPSJ8ohuqWP2LnVrByq81hGEoub6YPR3zCpQRf8FKheSje+W2/UTAsKcAFb/F
         hvkb4r9dhmows+hxjUiyHSWnTlmK5r2k+yLIw5pdfT6fNszNF430XfkByNoJzGrV1Ttz
         /CHA9dDgmsLF+a8qgg8lXVHCeZLEk60h7sFMdnxiL0I11HZ5OrBSqICpk9zDi6M+bkxH
         8CmpfjWpMpsbDczd5Y6VxgKVmMgptmDxI6+/jjjTYKKK6L/tGEPjItlspbXoixmwv/Fy
         aysg==
X-Gm-Message-State: ACgBeo0axn4DIyHCF9oEUbkgtuHiMKKgSZjU34z7xQ7QbMz2zO+r61vX
        0odYq0cDhVghxGL/FatMAOD8Pb8t//b80g==
X-Google-Smtp-Source: AA6agR5Yr7QIYDQARcpmq+dDvsEmQpJSogdGcDft29owbQHVHsf/u4xlTuktOEvUUes2qggSKnstLg==
X-Received: by 2002:a1c:6a0a:0:b0:3a5:bcad:f2cc with SMTP id f10-20020a1c6a0a000000b003a5bcadf2ccmr10086676wmc.74.1662366416183;
        Mon, 05 Sep 2022 01:26:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/34] doc SYNOPSIS: don't use ' for subcommands
Date:   Mon,  5 Sep 2022 10:26:16 +0200
Message-Id: <patch-05.34-dc66db38a62-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
2.37.3.1425.g73df845bcb2

