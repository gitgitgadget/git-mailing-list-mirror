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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A53C433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C013F6108B
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhIJLb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhIJLb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:31:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487CC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i3so972389wmq.3
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qjkeoBLWZp3W3G37t1lZY6yDIN2SCEN+Ps8suMIGCI=;
        b=pzCAYJwMexyuplwkoz3Ujc8gnOa001VSbZ2DA0jqLoiRqHoErAyAPa0ePDudnKsSQI
         eduEQUoM5xBhd4pcDps2z4JeAvn/O4pLjqrIX/EsvZ7DQHRDeLDH1NRRuDUVH5hL2c8f
         aN7EPqafdiUeBrCB+Auw1A9BEyUTX6TuF/cPAfjWimIzXVtvMC2w4Ce/uJTzRoN5tpfe
         PXnyok1UJgYkeIV3wKi03obRj8FD4fptQ39ZZE0iMjxrkjzQ2/ic42VJB4fGmvM1ELJH
         eNhVpQzTWyP2QG6oP/vqo19KzQpigbj8+67/aRFs5AykXTjEzvys1XyDgRcZE3Iy7QBM
         NGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qjkeoBLWZp3W3G37t1lZY6yDIN2SCEN+Ps8suMIGCI=;
        b=28IPBd+U9Psf+QVDmRCWOkZ2fGp8TmtwiBXBVBJnJWzczshazCTh0FMTqYzvYPSQEa
         P330SjhYmzNL7yHp8pDpdqX8aMu8SF2uNutbKvIUshXN+G/cLJox+Zro4VLuFNTz2Vdd
         HGXQDpSRfPsq4L1cHJLZRz6DqD6/AO6J1qYhInt8XChjViXaWAugzjkSylcH01+GrmbI
         EGyDN84BP5nWr998KKqtlQT4h0h+/oAJ+BOgewM1IYinHf4DDxhFfHZeTPBkpT32OcaE
         lDXKwrFUiIaDXy575529AdWtGttXZIJc0v2fOrTN9W4GRinLMVENn+v711GAviBrkWrl
         L4/g==
X-Gm-Message-State: AOAM532My/fwNQ3Te6HscfWtHDdHB+vYqHZ7dTG7JebmQltOHuUisl3b
        ksbYt7RrUd2GhNrjiwoaiX1I+zvsH63qDA==
X-Google-Smtp-Source: ABdhPJwoSVCgl66m9AdBVRYZpLoKB7SG2HK9Pk0NwaHN55iDg3aB+dT5TTSbDQMqtaeJnGo5RR6G8g==
X-Received: by 2002:a05:600c:3554:: with SMTP id i20mr7755070wmq.164.1631273415449;
        Fri, 10 Sep 2021 04:30:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4103278wmp.1.2021.09.10.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:30:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] help: correct the usage string in -h and documentation
Date:   Fri, 10 Sep 2021 13:28:42 +0200
Message-Id: <patch-v2-1.5-b10bfd21f14-20210910T112545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
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
2.33.0.873.g125ff7b9940

