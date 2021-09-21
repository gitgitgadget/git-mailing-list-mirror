Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F2C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0C861050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhIUWmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhIUWmO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t18so1335183wrb.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5itkFyjseLfwhHWSPaj/rosYqZZdyD5T0GbfAx+6vTI=;
        b=VM3FCiVTa8RZ00dhrSsAQ1NuRQ43T1qlGwKV6AGDcMAhkkpIQ/zKm2RSHozouG4Tkc
         eHjOAND9HGmGOIbUtvqwuGirGlvU2sHpCH1Agc6N66xWLuojI/i5twxknziQHmVwFYfV
         WSz2fDs+pfmIVUYEhc/NUZG2KwTDWFv6a4NNY3l7ZKrUvbclni+3xNlnyUjGyclU7NEj
         ZJ6Nw50YYTmzS55ECpYZf1t26TuLUWdmruPsCtUyfBkQGPFl0TL8UyZsvK4IKPuaOgNM
         80MWPPCqpe3OeCmcAsioQA33goDJ39/z5Vz9ndlkprinHD7biO/rKIVFwTKpimqplQ/W
         e2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5itkFyjseLfwhHWSPaj/rosYqZZdyD5T0GbfAx+6vTI=;
        b=3bI74g5ff3aI7r5Fp3yZuYcWeeyKj2v+uKT6ao9zw6S/pgF2JF5Q6JYCWylBZ2yidk
         wpNc48M4d+87lfGUKW8iIhGLWG+K+romGRo7ARfiZ8Hz6/HFHfwt606tf6TQTCPgm+qH
         iY08NjCmzlC/2zIcnc/74rXHPZrC0hdzQqPSCRSl02AocXowyvGke5b0cLEM+HqOB+bM
         NfZxvhtrwEUSz8mDzQ9VVeajtLn01sJG164pkfxldObT2K55IaC41WxCfwWnogmcSGKT
         D8R47sTqNjyVVoUQcuUlVVviOBluay7K1Una0WFxGZxInfPXKXJLzjed9GmhCY/zUEqF
         fSdQ==
X-Gm-Message-State: AOAM532qxZQ5RY506eBeZzr7FhqbYEy0l/5WKJEjvwf6pAjhvc9e/Xq9
        U+3CF8DqCYBzcQOmwsCdJYeDbpG3wnG3Gg==
X-Google-Smtp-Source: ABdhPJwr0uP5LdVSt0ldKAJPlk+dpzyBbqZJcg613kQBQzAVWf9P7tcfG8+dDe3z6VE1DSomgmYaCw==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr15419463wro.306.1632264043616;
        Tue, 21 Sep 2021 15:40:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] help: correct the usage string in -h and documentation
Date:   Wed, 22 Sep 2021 00:40:31 +0200
Message-Id: <patch-v3-1.9-5341ddbe23e-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the usage string in the documentation so we group e.g. -i and
--info, and add the missing short options to the "-h" output.

The alignment of the second line is off now, but will be fixed with
another series of mine[1]. In the meantime let's just assume that fix
will make it in eventually for the purposes of this patch, if it's
misaligned for a bit it doesn't matter much.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 2 +-
 builtin/help.c             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 44fe8860b3f..568a0b606f3 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
-	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
+	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
 
 DESCRIPTION
 -----------
diff --git a/builtin/help.c b/builtin/help.c
index b7eec06c3de..44ea2798cda 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -59,7 +59,8 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [--all] [--guides] [--man | --web | --info] [<command>]"),
+	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
+	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	NULL
 };
 
-- 
2.33.0.1098.gf02a64c1a2d

