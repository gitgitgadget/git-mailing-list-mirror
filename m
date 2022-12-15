Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52EC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLOIwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOIw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6852613A
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f18so2302857wrj.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQpi3xrjH1eqxG8/vVQD3NOYgQMR8M+Fr0WoDY+57kg=;
        b=XoLqgsFROR+xvxRMs3AeCVL603So3hTvNgXDosAObvRULjx0jETPIsQYJC2KnlWWkD
         3CUHD6J4rbD30y6rRRrvphBsJ1jMJGLVASEF6jdrDP+m5sy2N3ODXkVJ9rwkZLj3Tfod
         SuTWZ+GRvgSYIcwbY/7rCFTVwgHapcwhpMHEIyCoHet2m6Q6QbsjEiP8lDnmLfdXE0Y/
         D8VxPIybp+RvxrV7pyFcKi92DXzlOqOv3r7kLLeo0ohk1cE4QTlQyDFcrhyyRbe4L7lB
         LRJJ+rIFxYp4QutHMvsfiNVZ9KAxW/JzvCsN7E90NPCxKA7lqC3/dsdFLhRYw9XaGR4/
         1iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQpi3xrjH1eqxG8/vVQD3NOYgQMR8M+Fr0WoDY+57kg=;
        b=bRze4HMFW076sYgFJB8ZKLU0uBMjoELN67G+mna0VY/bvIjgcX7tafbk+fQj3ihss+
         NrcFEM24E+vOC+usD/K7g09PNa1Z9tZeNf3ubtHZuuim5B1JnLGpFOpN09KJWAPib1wl
         H51THydvcfpegoNDzYlEb/38xPNB6mnxfe04zWIlBoG4w/JLv1zSLJ9F3e5k7JLx6DaB
         6abcaJDreVNmnJJ/JzcjMShKgBBYlikQ993qC8G+N/Zd1nyPxl4ZOHTy1nqJPbi9kr1r
         eqWKZ+QaBgDnCGPiAhbk9stODZJycHkrK+ssaT9efwM7DTUA2gu/acwApgoeYoe++69h
         K2Ag==
X-Gm-Message-State: ANoB5pmR9TgWy+jFF8n75P0QjZyJtDh4K0+otRMnHOHA3Sy4q9FtR4Kb
        V3FoBthBSlvG3vVMmCw4Sb3d2HVRTW+Y1w==
X-Google-Smtp-Source: AA0mqf7z2Kf64OZHe0KcKiUGN+I3g2tc0dITVtl3O0Ai7uVTP29G6/Q0yRUPCE4c5gmdriwxJosztQ==
X-Received: by 2002:adf:f802:0:b0:24b:b74d:8011 with SMTP id s2-20020adff802000000b0024bb74d8011mr17537905wrp.6.1671094344897;
        Thu, 15 Dec 2022 00:52:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 01/12] merge-index doc & -h: fix padding, labels and "()" use
Date:   Thu, 15 Dec 2022 09:52:05 +0100
Message-Id: <patch-v10-01.12-9240ab10649-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "merge-index" doc SYNOPSIS and "-h" output consistent with
one another, and small issues with it:

- Whitespace padding, per e2f4e7e8c0f (doc txt & -h consistency:
  correct padding around "[]()", 2022-10-13).

- Use "<file>" consistently, rather than using "<filename>" in the
  "-h" output, and "<file>" in the SYNOPSIS.

- The "-h" version incorrectly claimed that the filename was optional,
  but it's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-merge-index.txt | 2 +-
 builtin/merge-index.c             | 2 +-
 t/t0450/txt-help-mismatches       | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index eea56b3154e..a297105d6d8 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
+'git merge-index' [-o] [-q] <merge-program> (-a | ([--] <file>...))
 
 DESCRIPTION
 -----------
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 452f833ac46..69b18ed82ac 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -80,7 +80,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))");
 
 	repo_read_index(the_repository);
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index a0777acd667..9e73c1892ae 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -34,7 +34,6 @@ mailsplit
 maintenance
 merge
 merge-file
-merge-index
 merge-one-file
 multi-pack-index
 name-rev
-- 
2.39.0.rc2.1048.g0e5493b8d5b

