Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F1C74A4B
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCLVHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVHV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:07:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5C302B1
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:07:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i5so10885823pla.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLcjZ25juOAs612nNWxOEC+99TNrXZOUHLmuSEgQR54=;
        b=aV2LsJZggIIo7nS/tRUBTrl6oi2DHZNkMjmzdtzoOfn8HFQRCTbCFxZaJYkxrnccFX
         SdXhqjEGUq7Q37vlIhZUxeltHDXPSC9Hsghnfxde6piDNZ87VBMYXUA1CLDyi3XTpOB+
         8auBoMggGa3COfi7p5jbholjc/IqG0AAkmBt0vL38fjBlxz4gpqUVxWCX16+gnMBZqEu
         Yalb6blwZvvgpjYyqeQWOQHXC5SVos2N1aDeUIfEBhN30OHaGBYLtbIaqsTDFsEdkPuQ
         k1foJ45J+EuLHF630mtkVU5IxGO2PjIWdhoh3FGvzOk464YWRKY506eYcogO65Vfi/+k
         qzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLcjZ25juOAs612nNWxOEC+99TNrXZOUHLmuSEgQR54=;
        b=abKXGTDAZOxoDKCOfldbZWm4VvZ07FylKglvlRGaE1dvsmBiuw+mpmjzyGAqqT0rzH
         R8e1RH6czTpR45sFWmMg7cxUtRT2XonR9kMrkUpT0hLUjKNF4ZEosk7IiqZel4IiB/Z6
         GGJiSAHMZtOqguXuz4DdaUP7V8JcM6qYveZOfg05xm552tRgrIXpPTB0+Q3vMSd9it82
         u1oIW7sOUDGQNCAQw8vqkiq5ovybs5qpPp+XUho29TN8zbkZ+QLx8Z1zY3VLH+YTt2pt
         Iw3p6K3IvFGaialcs8bv6mOkIOAACaIKgRzThKytSSfdcgXpJQv154aSCI1PdOAEx5Ca
         v/NQ==
X-Gm-Message-State: AO0yUKUKAeEQp6XLThnaVtrWd2a3ENyJax/5ep6nEskAwRqYpI3rpTAD
        1SIuoejZ5OGOSf2CZBXPoRL5RLtWtJHEsQ==
X-Google-Smtp-Source: AK7set8mMJoAlcmXVI3mAV+iBGlEs8pL9QYAhwEGaZSh5OgH8m8r/nm1n91Avg7Yrgxehxl5TK011Q==
X-Received: by 2002:a17:90a:e7ca:b0:230:ac12:a5ca with SMTP id kb10-20020a17090ae7ca00b00230ac12a5camr8770933pjb.3.1678655239624;
        Sun, 12 Mar 2023 14:07:19 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b0019f2a7f4d16sm2653043plg.39.2023.03.12.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:07:19 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v7 2/3] rebase: deprecate --rebase-merges=""
Date:   Sun, 12 Mar 2023 15:04:55 -0600
Message-Id: <20230312210456.92364-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312210456.92364-1-alexhenrie24@gmail.com>
References: <20230305050709.68736-1-alexhenrie24@gmail.com>
 <20230312210456.92364-1-alexhenrie24@gmail.com>
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
index 6635f10d52..c36ddc0050 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1140,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1438,7 +1438,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
2.39.2

