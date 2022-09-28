Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D72C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiI1IkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiI1Ijo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF320357E7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s14so18712539wro.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xLS7v7SXfPfuZUmYkrmwz1+ClqqC/KR2o5Ozz4zIDvU=;
        b=qM+5bHLb9qJENZmlGiSMOfS8wBDe/g99cKhlSEVm2HttJCIsLaI7Ko4tUemWyi3AkD
         v5y1/51YXnR3D8KCOWHFLqCMUflFehdc1CkdwYEtqBnHRevgR7hqYmjBBNV9fped/umS
         bSyS2vZtNp2RyXpZHLFOa8omE7GoWFAvez50CNvYDTHS/E71v6qX5I9Bxzoiy6SSJfBB
         /HpfH7uE8vUbibdNaYKvPJhzxlNYP6cmtmGTZjxkAOKkEN94pXehS9tvTrynD/3l5C0c
         0Nvn1zUl7WnDL2OBhpRSXdp0sAISAOMH76SbclNdHREwXy9SzVw1+Mgc8BM+DF0OM62w
         EP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xLS7v7SXfPfuZUmYkrmwz1+ClqqC/KR2o5Ozz4zIDvU=;
        b=jfHHg4/IZbBktdOCKqxWbs6BK3Adg6WNK/Faal5X4EmGisQdydHqs+qWmfW2R9bHiB
         uvLrf4WS0KbqBkftPmRgJ7Fbm73wTtfNY/f3cohgcAvrPSqOkS/7f9sx5JhDX+V0F8l3
         r4gJK7YBxMw14otM+XuPQOGdhHgwiu/PkN0pfrH9ASqC/o2FKipyAv/WirULLaup7I+U
         kzvEXEmV9VL2PM6x48YI5Gvb4Yzdq6bYAkdRrfzDzYkQY78WLpn+jTSHJio5MTzCIJWm
         ap2meuaZ3GNq73xW4bAlpFn16xe41Vf3YD0FHwn3Mj/QP79EooxU8/0h2kgNMaxUpAMW
         FqdA==
X-Gm-Message-State: ACrzQf2SdJ0FVv4H1V7ASwn4dLv/JknZmC/8Uoz9aN88dmFTURMzZU+y
        KpStyeQzHcyzvtmH3xbGmf00HAIhJn/lMg==
X-Google-Smtp-Source: AMsMyM44KaqeMiOa3E15Y1iEcN8kN/1RFFm2SxkCaGsnM5BdrVQDeRdotPK+8i/DCbiZR4DnNU4Q7A==
X-Received: by 2002:adf:f604:0:b0:228:6004:bb70 with SMTP id t4-20020adff604000000b002286004bb70mr19543452wrp.646.1664354381092;
        Wed, 28 Sep 2022 01:39:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:40 -0700 (PDT)
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
Subject: [PATCH v2 05/35] doc SYNOPSIS: don't use ' for subcommands
Date:   Wed, 28 Sep 2022 10:39:00 +0200
Message-Id: <patch-v2-05.35-ad0216f798e-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
2.38.0.rc1.925.gb61c5ccd7da

