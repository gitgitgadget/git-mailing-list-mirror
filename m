Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA00C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJMPkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJMPkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03789140B7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso3539208wma.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfcZs6OqcCYPidYbeWhaFGsB2TETC3otwI+SaIGgQmo=;
        b=COJEdfTwXwcB9QLbQiHVpG3LIzIeGnbYPtoBm+hX1JnEM3fJZM7g0H1nbJ5EWZxF7d
         TAqECGVTWDcaCv7RKGTmKiGZb+0Oe4A1iv1nyvYTeFKRURlaTRPoI9hppDtcgKn/R1SF
         isJyUprNpj9w03ydnPP5kUH/5GQLbhfDPFWlQPGBolwHx7KPRrIrWufBGUZT46N0Erz8
         bo+O6oHj1RZ6pvjx0P7hbhyzYnenW+KxI3VTjcpQvVjEON1WscZ7dT3ZmDLVXOEFiEDt
         69HFL4JXAlvTvUSPgQCvm6dcKj8CRpNZMZZuqj7ZAiKNyLoPIfBXNjrMGQsXhRm3ZZB/
         Qjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfcZs6OqcCYPidYbeWhaFGsB2TETC3otwI+SaIGgQmo=;
        b=XzZgfqQMkAeZXKCJjGIUx3av5mPMHB0h/CpfbjcfrkGzth7fCLtEFBrig0U6Q+3zDl
         cd2le+wgrSsBQHVEuSLE0AcRSs5G7wHsFKwNGIFGO0OBxVm1ffI43sfhJxJ0dpDgQLln
         xGUSRsxWftrtGbTvBF+qeUMoxqAuH+BzCoj9Mf8vbvNCc58IDk5MzR85SlkrOGUDmQMq
         Jss9+xM3Knihro182KunSbBp//9AYpiNzixdXJpKuddVjsKtsxfsMouy0ssR5sDAO3l0
         OlBJ/e7W+vawTANdaIANqvukCyQlZrd7KDls7uDQXtjN8kwQ+/dg2Pdr89PCTUc8qzi0
         RZsA==
X-Gm-Message-State: ACrzQf3+P58SU+Vu8qkJuLke3+7Y6BXz8w6dniD0AZgGNpM+VGxx8a1I
        aaTSU+dTHsTza28iYp85xvmFwrAnbPEWUA==
X-Google-Smtp-Source: AMsMyM6Id5Ttgct8oMne4TKe9uXUOpuAbPt/bZBwyZPUT093BHhEs7ZHWAMId4dc6PhtddPeGpCkJg==
X-Received: by 2002:a7b:c056:0:b0:3b4:e007:2050 with SMTP id u22-20020a7bc056000000b003b4e0072050mr7122213wmc.38.1665675585369;
        Thu, 13 Oct 2022 08:39:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:44 -0700 (PDT)
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
Subject: [PATCH v5 11/34] doc txt & -h consistency: balance unbalanced "[" and "]"
Date:   Thu, 13 Oct 2022 17:39:05 +0200
Message-Id: <patch-v5-11.34-84a81046a95-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a "-h" output syntax issue introduced when "--diagnose" was added
in aac0e8ffeee (builtin/bugreport.c: create '--diagnose' option,
2022-08-12): We need to close the "[" we opened. The
corresponding *.txt change did not have the same issue.

The "help -h" output then had one "]" too many, which is an issue
introduced in b40845293b5 (help: correct the usage string in -h and
documentation, 2021-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 builtin/help.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 23170113cc8..bb138161943 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -61,7 +61,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
-	   "              [--diagnose[=<mode>]"),
+	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
 
diff --git a/builtin/help.c b/builtin/help.c
index 6f2796f211e..53f2812dfb1 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -88,7 +88,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
+	"git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
-- 
2.38.0.1085.gb7e61c3016c

