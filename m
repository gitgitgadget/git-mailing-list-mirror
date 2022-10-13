Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA59C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJMPkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJMPkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4623BEB
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i10-20020a1c3b0a000000b003c6c154d528so283977wma.4
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/MY2pSdUfkbAOfk2lL65YUEfzBE80iI9xAiaOlSbUU=;
        b=De2knmvxQlvfcjV+OAw6S1nKoHio9Nt+WsLaCsZKXG1ite/OELeGqGM+1Wwf7NTil9
         TLAxK7KP7WtEDQh9z9q3emqhLpQkvaas2KPzjp+FguIFfOO6pP2hQjbRWple1WlljHeX
         jo1eMpG6DyosRzTyGQBgMrHtI4duPTip3Av8nj21RpdDBfNrH0DKhxCkwI+DLIYs+xyx
         8bAPDBKSQCjS4NBkLAQi+0UzBjh2CkJ7O6cPQfLjPVtLy4IubR6nWPjS5JDbRFFErv01
         ElppIFx+TY51PlDWtKbGbiKyOdfhD00/SRx7QTXzKPqMKlvYPlP2agAwMBiCoyBHd2hS
         vISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/MY2pSdUfkbAOfk2lL65YUEfzBE80iI9xAiaOlSbUU=;
        b=gTLMOG5tx4a26DQ4y3SxqFdSb+9D2cTlMpdqylQea7WClQRXsqszJSkiH8N+5IuMrM
         +amMtoNLlgU3BpdVYtOOWQjYxT7u9IDi1YsqeyR+FWHykDas/nvVot2e1hdHmjvNFB2z
         EhJJLvj6kKW3yGY0S4hG6HWlN345K0SP8VI4ZCR5FaAInbnVaNSe/PvS1mECj3wWJhde
         32YA9ioTh6cYn6xaC/KLsqOK7XJ6Gno2l31Iad+6bMCGssFAykKqgAcEssO6HTCw5TyG
         pJrnWMABgXZHVDO1iXZSi0kkqXLN7qHh0G2WYj30BB3i75cPMGWbH3s09zfWfyKUldN/
         t8tg==
X-Gm-Message-State: ACrzQf0uZQ+vO6nM0vcOPkRTPAzUiGqI7PI4Y17L6yGjDxon1vTz+NYF
        aXAUhtrwJ91CHynG69YtnelSnvkcsr186Q==
X-Google-Smtp-Source: AMsMyM542qL3WjknGuAAij/VE8dkrBhOYZ4riasK9p4K6IuDf49WFaS7lbWB15qMjUrjQnrJD4j9zw==
X-Received: by 2002:a05:600c:4fce:b0:3b4:935f:b952 with SMTP id o14-20020a05600c4fce00b003b4935fb952mr7043495wmq.197.1665675588544;
        Thu, 13 Oct 2022 08:39:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:47 -0700 (PDT)
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
Subject: [PATCH v5 14/34] doc txt & -h consistency: use "<options>", not "<options>..."
Date:   Thu, 13 Oct 2022 17:39:08 +0200
Message-Id: <patch-v5-14.34-760bc0a6727-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's arguably more correct to say "[<option>...]" than either of these
forms, but the vast majority of our documentation uses the
"[<options>]" form to indicate an arbitrary number of options, let's
do the same in these cases, which were the odd ones out.

In the case of "mv" and "sparse-checkout" let's add the missing "[]"
to indicate that these are optional.

In the case of "t/helper/test-proc-receive.c" there is no *.txt
version, making it the only hunk in this commit that's not a "doc txt
& -h consistency" change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mv.txt     | 2 +-
 Documentation/git-status.txt | 2 +-
 builtin/pack-objects.c       | 4 ++--
 builtin/sparse-checkout.c    | 2 +-
 t/helper/test-proc-receive.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 79449bf98fe..972a055fbd8 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -9,7 +9,7 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' <options>... <args>...
+'git mv' [<options>] <args>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..5e438a7fdc1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -9,7 +9,7 @@ git-status - Show the working tree status
 SYNOPSIS
 --------
 [verse]
-'git status' [<options>...] [--] [<pathspec>...]
+'git status' [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..573d0b20b76 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -180,8 +180,8 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
 	NULL
 };
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index aac0f708e42..58a22503f04 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -20,7 +20,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
 	NULL
 };
 
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index cc08506cf0b..a4b305f4947 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -6,7 +6,7 @@
 #include "test-tool.h"
 
 static const char *proc_receive_usage[] = {
-	"test-tool proc-receive [<options>...]",
+	"test-tool proc-receive [<options>]",
 	NULL
 };
 
-- 
2.38.0.1085.gb7e61c3016c

