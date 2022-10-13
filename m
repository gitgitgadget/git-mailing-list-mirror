Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38313C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJMPli (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJMPkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CF65646
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1757197wmb.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIDViaxL2aKDgMO9d8WVEeXDq6VdPSFHykDbbtS6JZk=;
        b=okMNC2YRwmXVlhd2ptjoKM/ilRtEBWnUVzh8q05q0nd2U7oZxH8q21eDVk7UBD3Jcs
         GNexyapnOqsFvweV7+68qacnKjs9w4n+ZuPvX35D8+sGIzefuvwbWzUsFVWPmYAGjBDg
         UHhx+ggMTxtBqGfUsKGZGph4aNSK7xdLcAPRx1UhVig280kw82onX4zfkE8lkEmEC4MW
         Kh83JBH2VRXdxPT80rtYZPqj+FeVx5Ad80X73FAuvg3mWaG9j16bYdAhrQKa4TnvNGsn
         qLLlfvSp4Q5pyPireLy84YYbacUMbXqezPLZXdA9YytARqD6zue88tHvG/gaG6MOTXI3
         c53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIDViaxL2aKDgMO9d8WVEeXDq6VdPSFHykDbbtS6JZk=;
        b=fr86TErEbGS+yOOU8HkqdCZuWPk4ePdur2MChM/4tvbBLWGvRbXyvNMbq1slkrPknA
         L1ilBgt31RPBBJ4kHBDOU2cquck35ILJr3cPJ+D5H/KtSQFW+4DP234b95eOS6mQBj7I
         2Doy6MjxuPUgy6oDANYLbVRfUSs1NUPlXlqBMonSvqoMHoOuZHX2Jw/1I3kByMNJs+Cr
         fPspRnE5IfuANsqKNqiE4tYKp/BUooIxxERSkG0DdY4wc5wDIWwUXY1vhsebpQoqCbWA
         BC6FxMaykqOJeOpzII386LEydju70EnFtxzTYNgwgbDrVnikxPt7st+rQxjs8oyoU9W4
         YMKQ==
X-Gm-Message-State: ACrzQf0y5Y+kLNM36MhsH0fhVdhNt3LzGkpYMOgkVqSLHNqc7X6dKeH8
        ngIl0cvrw+52UENzy2Dydfswa6Sv954H/A==
X-Google-Smtp-Source: AMsMyM4vTX8lf87SDsB3RY5RqSjahsiZBATbmVKwGsimdfVeTE2maV/DJAMldrUvOkMHxVHYS+Wtrg==
X-Received: by 2002:a05:600c:4f89:b0:3b4:a6fc:89e5 with SMTP id n9-20020a05600c4f8900b003b4a6fc89e5mr6817905wmq.149.1665675603450;
        Thu, 13 Oct 2022 08:40:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:02 -0700 (PDT)
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
Subject: [PATCH v5 27/34] doc txt & -h consistency: use "[<label>...]" for "zero or more"
Date:   Thu, 13 Oct 2022 17:39:21 +0200
Message-Id: <patch-v5-27.34-6c68125f191-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
index 8347c6eed79..160d08b86bb 100644
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
2.38.0.1085.gb7e61c3016c

