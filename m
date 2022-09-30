Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiI3SL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiI3SLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9221E26
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso2603021wmq.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=efyfiON6IPVAHzQ8vzuur0JNhJDfgT7aRAOPM/KszQ0=;
        b=ptz/8zjoUKqZvEkuYhe4+XAmk4jEyxHjBxJSPxSVNYTm5lwuzxe/H7xO8nCFjB61a1
         E8JqaSubX3ikI9ZuYsJChfMMo3VzWUjc7dvsuW91IKvl8Ux3jiQBv0v6k0k/mgLpZyGu
         lGmaB2zWCuf9oaQsr+yQLSV2plv31EM0TCrSiyA4XCcY4HmshxOfivkco6KkSCEfMAoO
         BhE6HeEQsRbeQNuMDKwfoL/Y2nPZQW72aUKkG5TKRAkdVaa3UJ0TAXthNUKo7rW+ynOi
         6NUgqH49+mxNSfV5laqKoeP1CSeJ9TUQWqIDOPUWlUYpCcZlcd7r05ArCIQUYGtpC8hV
         0Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=efyfiON6IPVAHzQ8vzuur0JNhJDfgT7aRAOPM/KszQ0=;
        b=l6WDn1W6padVK/SUBoUTIGnAjRc/+FZIwkYhRIZKl1hf78/Nn/AoVQBMlSQDYaLHp/
         atF7kVHM3gImGtmma51LCAaBiC0VrJSx4bxiDzIB4k43LFKdBV2TutQq9G4VVuwPc6VL
         DEPk/iE3BVWfEVe6ZiKTfUaOF7/zie9t1Ka0up6uUdvRha+IK/7FA4I71UvMMCCHuoij
         mdWul+RPWdh+Em1qk/1VCDmUqr8+lY+L2JDGiSKJr0mxpew7/Gg75ljgKA4Fqxe88R1Q
         cIb5rPnFNdKo8iQfxlZKFofMjt8546oxfUEhGCRdnSWIqnCrOTC3qXIloxBIw0xKwyUM
         HQcA==
X-Gm-Message-State: ACrzQf1Lqh9ZQsmeVeu4gYk58bg77bioHOtSbeiK5cSCfZYID9vmW1yz
        S+xU4n+QTgt86AXONMZyjgMVFMt2C+hGXA==
X-Google-Smtp-Source: AMsMyM6lsS+OHZHClHR2dj2zDJpHvpalNR0PQQoy65MgLM4m/opZ+7L7f0c0W6T7z/L1nlJ8s3a9pg==
X-Received: by 2002:a05:600c:4f0f:b0:3b4:c09b:37c5 with SMTP id l15-20020a05600c4f0f00b003b4c09b37c5mr6598823wmq.181.1664561384699;
        Fri, 30 Sep 2022 11:09:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:43 -0700 (PDT)
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
Subject: [PATCH v3 29/36] doc txt & -h consistency: use "[<label>...]" for "zero or more"
Date:   Fri, 30 Sep 2022 20:07:52 +0200
Message-Id: <patch-v3-29.36-c96c3fc6d8d-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

