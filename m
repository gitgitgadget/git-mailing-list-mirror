Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9762C76196
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 03:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCZDJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 23:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZDJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 23:09:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDCA247
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 20:09:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso8316908pjc.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 20:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679800188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhnQ14SQZimBI9wylVjD/LnkoNj33iSDZSM/x/lAVjw=;
        b=Us7IWmnR6b8zJw8Q6LYBEBmlfqgmfPF4508uolU72rmJATCApLUzE1BTYabU9xbmpq
         xhAqn/YtJpPukNUAdwr+dYQf58VRvli3Ikkc5VhwOrXhhzTwBFSrtcLbcJEAriQnJi71
         sqBc2Pb4DihVmQtKsdgDXqaYCprbR8Nn4Zy5hB3NSHTnVZmEFZTm54acMpDZLo3SEApR
         TYK5Q61GgqysSjU3vQTGE7xEA6QMb0OutkcOLhXKK7ZOUiPxkzAhA9DDg7wScKSWxDPJ
         3hN8APiETp+fvoKRv2U0Mmy9fWAKD5aPTt21LXraP9AxGecN6fcqi4GujeK0o3LCGaGK
         n9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679800188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhnQ14SQZimBI9wylVjD/LnkoNj33iSDZSM/x/lAVjw=;
        b=ku23M1h9VBdpM/ItgnKQTEtwQDhGMta2ofy20SfzLCSZjSkohPZYrPpkmZ/OzwqiQw
         GSE0Z6jZuJAwEqK5J2CIUjdRwO0JiiHULM9NHVtEiqlvU2cxmDIIMs991bw35jZArOf6
         3rAW72iHVyXwR8FmhbQ6OZETgUzw1OFSoqofPS3berrc5ankCcflc9TnWqwLruQDNJHs
         UZdLMSRu45ULpnIVr7d6oLTaUj3RHra7XGmyFwU7oYXi0KuBedJsIUJQCGeTVXoOTAJ7
         W9uQny5ih58Gy90bQWVpuM4E/Dy/4733mI6teHxczc2ynhxpwLOKpoRTs/iWa/xckE6c
         FzCg==
X-Gm-Message-State: AAQBX9c2W4gSgjL+9GAF0UwRqQsX2Yaxm2l2tqKLYzIHmAk5wFOHLdam
        NYTmudW1zi7Cy3b7ZB81MujOCOEkZ1pHvw==
X-Google-Smtp-Source: AKy350adRd9arolejDlGQ1idV24hFF0cPP3CLzTkIEITPL5zl2AAGYxeY+WsYme1q4b7H9wSv2fCPg==
X-Received: by 2002:a17:902:e5c8:b0:19f:8bbf:9c56 with SMTP id u8-20020a170902e5c800b0019f8bbf9c56mr8946557plf.3.1679800187786;
        Sat, 25 Mar 2023 20:09:47 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:897e:74d0::de86])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b001a1c00317b0sm13587929plb.273.2023.03.25.20.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:09:47 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v9 2/3] rebase: deprecate --rebase-merges=""
Date:   Sat, 25 Mar 2023 21:06:35 -0600
Message-Id: <20230326030636.2635642-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326030636.2635642-1-alexhenrie24@gmail.com>
References: <20230320055955.461138-1-alexhenrie24@gmail.com>
 <20230326030636.2635642-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges without an argument. Deprecate that syntax to avoid
confusion when a rebase.rebaseMerges config option is introduced, where
rebase.rebaseMerges="" will be equivalent to --no-rebase-merges.

It is not likely that anyone is actually using this syntax, but just in
case, deprecate the empty string argument instead of dropping support
for it immediately.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b7b908b66..9448f7d87f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1141,7 +1141,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1439,7 +1439,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (rebase_merges) {
 		if (!*rebase_merges)
-			; /* default mode; do nothing */
+			warning(_("--rebase-merges with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--rebase-merges without an argument "
+				  "instead, which does the same thing."));
 		else if (!strcmp("rebase-cousins", rebase_merges))
 			options.rebase_cousins = 1;
 		else if (strcmp("no-rebase-cousins", rebase_merges))
-- 
2.40.0

