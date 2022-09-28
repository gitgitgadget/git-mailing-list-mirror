Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD54AC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiI1ImS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiI1IkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C361AA3D4A
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id cc5so18625282wrb.6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Sge/27OwZBw9C0ilMBK8tgtdQ8PvLpTIu2Etx2YDmUM=;
        b=la2r5/s+VkIejmUvAoBgvZDMO7NR0JDR/N7wRSZDbkPzaCFiyzgxpJ4ZIyPgAJyJXQ
         iUsyaznIrvxMTAgJQ3dH4VwZ4YgA2LS5l/T1HcyLwmTsHOYL06yLtqMsn41pxJiY0xZ9
         6OIuSumiQlG0idQ9ob2e6+PH37/t1ZNvby9NHrHqYKlShKQjb8kfj6joxuMbMCarod6A
         UePM+NXJezg662t1aQ1JxNQWlZzleQcIty966fAb7KUnzgLyhWwNENLPxgyXbv8fB028
         TeRarRkd4gVHhCtJ0HrqQtYhCHMjtWqJZ2jncrOR9xFqoZMsBfzEPn9L00MF13LAMfXD
         d3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sge/27OwZBw9C0ilMBK8tgtdQ8PvLpTIu2Etx2YDmUM=;
        b=aC64R0srrhVPqJ5D3A/bXnHbuJv33d6sXdOlVSMAh9SHrJpsiHNF3LyvXmMptRWuqg
         mSORJChU89IJlwiqz6CfKZF7OqAU45OxbTVpDTPw/Qb8TpeMqXhptA5FJ7S1yCbPLS0E
         WXHDP5xCpQJSbpwEn7v8SV4ZgoPZYBgVxagDWHtWREm9QK0shRyZlzv6INF1k4In9S0P
         9P2GQF15IBfrzc3qKD4Z2HakfsV14Y4s58xJkGPU16ahaIXMENtw+rvRd/GtPW00QUab
         Ni3oiPIsh8vOkmy/uH+WpEdLBXxmCZj3g3Bkk+mglReJ3ZU4GZcGqflF97Ez3AXxhIES
         dKTA==
X-Gm-Message-State: ACrzQf389+wcIIOIj6S4bYoScogtl25zVtdO/mzz/RX1eKs79iyEa1FT
        E94me1wrHTsizoibmS/yMMmJQepSOs8h9g==
X-Google-Smtp-Source: AMsMyM7+oEDCNv7aF+kM8LVVO6gQg1T7VeI17keKIV2+nL886Jkw1r6YSZNf0PepGu2ge0mB3hVI3g==
X-Received: by 2002:a05:6000:81e:b0:228:a17f:92f0 with SMTP id bt30-20020a056000081e00b00228a17f92f0mr20345563wrb.31.1664354405948;
        Wed, 28 Sep 2022 01:40:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:05 -0700 (PDT)
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
Subject: [PATCH v2 28/35] doc txt & -h consistency: use "[<label>...]" for "zero or more"
Date:   Wed, 28 Sep 2022 10:39:23 +0200
Message-Id: <patch-v2-28.35-42076626a08-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct uses of "<label>..." where we really meant to say
"[<label>...]", i.e. the command in question taken an optional set of
"<label>". As the CodingGuidelines notes "[o]ptional parts [should be]
enclosed in square brackets".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-clean.txt | 2 +-
 builtin/clean.c             | 2 +-
 builtin/commit.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 3f16f200d9a..db996a15e23 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/clean.c b/builtin/clean.c
index 6f039f555b2..40ff2c578de 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -26,7 +26,7 @@ static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] [<pathspec>...]"),
 	NULL
 };
 
diff --git a/builtin/commit.c b/builtin/commit.c
index fcf9c85947e..21ad4ccbf87 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -45,7 +45,7 @@ static const char * const builtin_commit_usage[] = {
 };
 
 static const char * const builtin_status_usage[] = {
-	N_("git status [<options>] [--] <pathspec>..."),
+	N_("git status [<options>] [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

