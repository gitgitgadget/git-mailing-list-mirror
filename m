Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D7C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJDNZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJDNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A64558FD
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so21318804wrb.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnaPrUdd1ildrYIWHfqTEYwCw3r9Y2dvsWYBPFQQsbA=;
        b=XsFgvpQ5hD5Kok4zgkKh3rlNs3JaLzqrJpLmoYexwNRLkdD+0PnBlzp1NvQGPC2+FN
         gOr1lqIwmICQomTN1y9lt9g1vflVfCmTKNETo6lCMekRsQwcibWIdig1oLrFMfucdEp7
         BJn5b4+AdNBMlknFj/5Q20lMOsZ4kcrDsQUejO/T4mZ985J35CCNCQDR4yb2Q8byRpCy
         F45qkX14lf+f9S6Gw4iV+jzs8HU/MYWs1X7DvQzLznw9We7Tdi0ATP0YMTCHl5UuEJZj
         x3dioAZsEEnB2cN8+DK+cCBLnNlJUR4C1cW8wVeX9vfRdEbRbnsRFCRSwWkq0nwvNxcr
         qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnaPrUdd1ildrYIWHfqTEYwCw3r9Y2dvsWYBPFQQsbA=;
        b=K3TNNLBcAAsngBoPAUhIHt1/Fjj53vSuOg3dz6U96Qe643iEDMlHVY3gd0iNrXlu6j
         5rE6XL9qLIv0iwR+L60qtD1i5mvaoFQ+mVqZZGYfezaciMBIt5zQHJP+6OzulMspnZCU
         RVm8EbFFCcb2dJqerLQie62m72V9/YIloZu/NM7Pon7rxkvCSTqchOQvvifUBttioSKE
         1VF4Dfe4ql2zoK0xcKCZKoKL+018gruATdTA5IBhn1ZOojJfXu4RPwsXFD2xAjLehv1+
         xuP8hysj0+yVdACxObEu5tI1ZYQUhhgTDNc9ysTnjyoQNB8zfEpWs2QSkhLJMr7gvQ28
         WHZw==
X-Gm-Message-State: ACrzQf0j8sMOMXS/f9GpFBcUsEKwjiVnxRr6HJBT1k5D94NydugycqB6
        hjqigP5Pe30R/jDxBhyOG1AatGq8mZnjlA==
X-Google-Smtp-Source: AMsMyM5SbtgMGYWz1QNGp0HiG8bWQdHDEQTI53Pu5llkVWZNKRglrxnjw33Dqbhnmu9lZo21DF+sNQ==
X-Received: by 2002:adf:e381:0:b0:22e:335b:7c60 with SMTP id e1-20020adfe381000000b0022e335b7c60mr8890221wrm.332.1664889865562;
        Tue, 04 Oct 2022 06:24:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:24 -0700 (PDT)
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
Subject: [PATCH v4 27/34] doc txt & -h consistency: use "[<label>...]" for "zero or more"
Date:   Tue,  4 Oct 2022 15:23:41 +0200
Message-Id: <patch-v4-27.34-d991b9ef611-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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
index 61b6d8667a4..62b5715ba1f 100644
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

