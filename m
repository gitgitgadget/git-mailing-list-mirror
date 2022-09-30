Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB1C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiI3SMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiI3SLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432E5E54D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f11so5354810wrm.6
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=i210SOhaDvWGHMShiJSBmj6ZM/qSrNmLAX5e/fE427k=;
        b=MBfYFuqK2KgjciBqWwrx4i1y+4cTZnRzthx3B1QMOMmrZI8Gw0SYccjaIJHF1L/P6s
         M39w47oyEA93E4BAUgAJq3/aAqYcxyCijaukHHkcSfy3pzAWCmmpsC/pxG6LyziE3u6L
         gWEnP5lOY/AFN5ig2My/8fI1NkGgwPBQWpUCMowk2FmvmajfWP1X9tZi2b1RHay2f8Ox
         PRGmwgwaaydN9R4GRfmZ2r7sFe7qstR2XuLH/aEsKo8H74p3RpL2QGgchSKa87Lhy/V5
         tqtRkRkLhuNdzVWzQPTGPjH/lWbEG9FM268Es8tLFgqn7QGxhA8mZUCVaQQ3R6ZKuWm1
         RTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i210SOhaDvWGHMShiJSBmj6ZM/qSrNmLAX5e/fE427k=;
        b=vf/92xCykEp83PV52kALcABTRxLUvTQ4G6/PTgeiVskpEE3ScgyL5DoW8r5qCKK6ma
         +xSoepc9/mzjChBTaIpzlqG6nf+5HV436F74YCtZaBddUw2/D3fQZ0GGTLDbYYsoDj44
         AreAyH19ZaO1XTnug+4au1szlVaTp60q8e4fdxJYpkZ1nnbWe9dC46j3l9zqGTyPyGCO
         ZJwZZwTb1IionpdafSm9pUBnoIxED5lnXB4sVJWZljEVnAhOJY/JPtnhSi1HLIa9z8JD
         JFHbAGA2i62XSHCzEmd/i1olrxC///+8aN3Ij7AK+WYnwbvGcEtIsqnmp99WKPQgrghQ
         +p1Q==
X-Gm-Message-State: ACrzQf0I+GgZlcAlqTm1VBBSCKpFL1VFlz88JlsAAWtLl55Tso0FSkrJ
        li9Z+9OL13/heuCNFhxvcwQGG6iPyhN7Rg==
X-Google-Smtp-Source: AMsMyM7Zmiwx1CHezPOeJ5QZi3MMzf0uWBGj3lQs4BvaBB63rHcvbbrirMZHvCcYy9mo2ZNCbLFPOg==
X-Received: by 2002:a5d:5a9e:0:b0:22a:498d:d2fd with SMTP id bp30-20020a5d5a9e000000b0022a498dd2fdmr6666372wrb.390.1664561392371;
        Fri, 30 Sep 2022 11:09:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:51 -0700 (PDT)
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
Subject: [PATCH v3 31/36] doc txt & -h consistency: make "commit" consistent
Date:   Fri, 30 Sep 2022 20:07:54 +0200
Message-Id: <patch-v3-31.36-336fc749f1c-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "-h" output of "git commit" consistent with the *.txt version
by exhaustively listing the options that it takes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 21ad4ccbf87..64f420bcbf6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,14 @@
 #include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [<options>] [--] <pathspec>..."),
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
+	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
+	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
+	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
+	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
+	   "           [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

