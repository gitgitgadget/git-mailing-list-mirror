Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F39BC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJMPk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJMPkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0399F140DB
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so3414542wrj.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fCXwnl2+bE+eJvHJ3jY59hqJeJHyZQw/4tjqn/1l5o=;
        b=jafw9PhANehimrsC5OiWBfZmDEnzvgSlCYNUlH/q74X7C4bYKxlpdsFg/o1IhL4GMQ
         vePmSCQPF2aYNUrhbZfJJaxGjY2dhjj02/rjiMelPidY45e+x5b4voyjFC7PKcas7Zap
         /38xxWQ1jbzsRPSz9VHfJGFSiDe/FS7dTpnTXcnq4L3uT4vT8nXUydU/ISR+qHaHdoJY
         2uqYqpV7QidggBPSxs8eVD3swUiACFtZ62CIZ+1XtR6CzEcVnZ3N24hAUEQXctrk6oA3
         R605rYy1PihSX3G7SpoGdC7diJWt2gxwM2gyiW5Qn9jR/LIWOOfyo+ugMyTb3mqgQI2L
         bAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fCXwnl2+bE+eJvHJ3jY59hqJeJHyZQw/4tjqn/1l5o=;
        b=IgvDnV4ykykUQRSvaoBBoLehQDGLLJ34f3lD7YO7T1CnIJOEiBmAtINFXrE09YQo1t
         ajbyOyzB5FdGt+1VJtzfoY/QMab0l+ueNy81s1iJzPsXh7UaaBz2RKIn1E6rJi6ryZB1
         2hZB2epbda0x56Ixo4xJhCYFRLymcgURUU525HO6mBvTT8bZx+Xqv46RgyvajdDJoeKz
         BcZa/m3hI3Wlw3hs8pGZwri+MSaT/ImQdoVkRTqCVXBhuec8TSfgKvpUIqmREbBU9EbT
         OpT3tBTWkr1SJBrz3XxHHiZNV7GM3VOblm1dURCOlYPpd4PZ/6WWuOEEZoAI4ywCc203
         4N9w==
X-Gm-Message-State: ACrzQf1pKxVciHJu/QYTuT8BC54f/1/wYSvW8PTa9yTNDnmEqFNCT4Tq
        RLmNV5HRoCE8x1MezWA1pH0oe0c0K3gJjg==
X-Google-Smtp-Source: AMsMyM4S+ES/SJEcLUcw4s8N6zipspHHt6Z84X+2Yeo8JL2UFHQGtBqg1QWZPUaF0BQ3VAsUjmKVhQ==
X-Received: by 2002:a5d:4cc2:0:b0:22e:372d:9c9 with SMTP id c2-20020a5d4cc2000000b0022e372d09c9mr407538wrt.576.1665675584299;
        Thu, 13 Oct 2022 08:39:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:43 -0700 (PDT)
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
Subject: [PATCH v5 10/34] doc txt & -h consistency: add "-z" to cat-file "-h"
Date:   Thu, 13 Oct 2022 17:39:04 +0200
Message-Id: <patch-v5-10.34-323afb78f75-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in db9d67f2e9c (builtin/cat-file.c: support NUL-delimited
input with `-z`, 2022-07-22), before that change the SYNOPSIS and "-h"
output were the same, but not afterwards.

That change followed a similar earlier divergence in
473fa2df08d (Documentation: add --batch-command to cat-file synopsis,
2022-04-07). Subsequent commits will fix this sort of thing more
systematically, but let's fix this one as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4c..fa7bd891692 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -893,7 +893,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters]"),
+		   "             [--textconv | --filters] [-z]"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
-- 
2.38.0.1085.gb7e61c3016c

