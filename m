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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57831C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B4E61074
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhIJPkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhIJPkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:40:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93CC061764
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so1777798wmq.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvOUNevOhcX3AhGpGhMtQtfRlz4ppjsS5O3y3/LTums=;
        b=MHJsrDCECvEbaKdzY9BHEQRRmr6nwQHF26ltr7wfuNuiVqmcHbK6aD+EWTUiCBxFWb
         7MdkBj0yVJ/1J6zK6eZqF1JqA95wl34ccRqqoN5NBLcneWygfDWFK5cwgrKnUijMd2F6
         msW/wjejZSGZvj9lFap9mwo8jGobMcZnjyLSOQTHDm3oPI+4R5MpkqbsgTUc1zXrDdp1
         ZhUqYnXkTkaSAVpysuO+7USVaMjRjxptIlhDlBSqyvoY8g2a+LAUB/CWALPVYvzFhuX7
         bPxTQN2gnzCsLGjy5oxtUKQDApwnzfNkFqljUEZi+xws2aIBBgMX/pfg6m9cxo2RD3V1
         FmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvOUNevOhcX3AhGpGhMtQtfRlz4ppjsS5O3y3/LTums=;
        b=pPyL50NIkkVJrwWDs8Citp4XpNNLcCYu5cUZlyKyGlFVV297mKxiXVTWnJUXYvnfWs
         3ay1NRXrQUfjs/qqDJAoQpUffv3xVBoA2R7aRfExODKQiM0gLAxa5Sebm+Dn23XjknNH
         HuyPz0K2A5qLk+1XJxh1MTZD4G7g9/iyZ4ucWrBmQaxjWRYW5Z8/ccH7xjUJKnOjwgCH
         vCXTKeVR62D9Upgf0+RrRtnBNaAqfTj1rp1tJDAeSxQKtr1BGORWb5IT0EDamRNgS7U1
         /HPNy29VUeSX6jP+3SDthtLblJn0wkt3/j4EOXT1zYt3nESgFXTce6o2i70y5/B7QUk1
         2jAg==
X-Gm-Message-State: AOAM530hKE3cpTaXxpSPVgL0z+J8mlDkXV1YYqE9a8GcynXoKXJ8i3vM
        xYz98escE4LuuuZowmzg+jOinPNcQzlIoA==
X-Google-Smtp-Source: ABdhPJyN0vDkvOUWTICIEJGvLjpuRQ20DwzXEWW7I+Z4pwZAd+EiIzxQL8v2Z0rzAgFX2DRKkCJtmg==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr8927192wmc.6.1631288329112;
        Fri, 10 Sep 2021 08:38:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm4181972wmq.17.2021.09.10.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:38:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] send-pack: properly use parse_options() API for usage string
Date:   Fri, 10 Sep 2021 17:38:35 +0200
Message-Id: <patch-v2-5.6-b884b361ace-20210910T153147Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.876.g423ac861752
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "send-pack" was changed to use the parse_options() API in
068c77a5189 (builtin/send-pack.c: use parse_options API, 2015-08-19)
it was made to use one very long line, instead it should split them up
with newlines.

Furthermore we were including an inline explanation that you couldn't
combine "--all" and "<ref>", but unlike in the "blame" case this was
not preceded by an empty string.

Let's instead show that --all and <ref> can't be combined in the the
usual language of the usage syntax instead. We can make it clear that
one of the two options "--foo" and "--bar" is mandatory, but that the
two are mutually exclusive by referring to them as "( --foo | --bar
)".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-send-pack.txt | 4 ++--
 builtin/send-pack.c             | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 44fd146b912..be41f119740 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,10 +9,10 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
+'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
 		[--[no-]signed|--signed=(true|false|if-asked)]
-		[<host>:]<directory> [<ref>...]
+		[<host>:]<directory> (--all | <ref>...)
 
 DESCRIPTION
 -----------
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 729dea1d255..89321423125 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -17,10 +17,10 @@
 #include "protocol.h"
 
 static const char * const send_pack_usage[] = {
-	N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
-	  "[--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] "
-	  "[<host>:]<directory> [<ref>...]\n"
-	  "  --all and explicit <ref> specification are mutually exclusive."),
+	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
+	   "              [--receive-pack=<git-receive-pack>]\n"
+	   "              [--verbose] [--thin] [--atomic]\n"
+	   "              [<host>:]<directory> (--all | <ref>...)"),
 	NULL,
 };
 
-- 
2.33.0.876.g423ac861752

