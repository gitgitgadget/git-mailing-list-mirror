Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67901C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4991A611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhJUT4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJUT4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA549C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o24so759943wms.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wCNLJR5YPpv8VdHbo3nD7ODXwfyYPFz7vUzAhpMqnI=;
        b=EcbhrrL736rT53XTAAMNaQVT3NEWppWbfAzlKoDzHtdv93+BanGNaHitvfZnNeO33C
         T/Y/NvY9Zdx0RCUsFTftCRY6S7CeLB0jdYtqgDS1/f7OxtXu+UR1L5308fG1QYIUzkaR
         TmdqlbHCxssBd711ggz+ZhEe8lLSa6ETCeO8T3TdFugL6BalXCmrdLq6L3Assr3MaBFU
         TnptZ5hECdCOkZicIxByJEb9/7gBCUYOp6Z1g6OzLSexUpgekxRBqW3hZclMWzVdgDm1
         SEvVHF9OixAhigGyhSjN8j1lKO14lbA6E21mg/DalRd6Hvc41M9w6JRJahQz1qdbocsR
         qNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wCNLJR5YPpv8VdHbo3nD7ODXwfyYPFz7vUzAhpMqnI=;
        b=hKbSSaFQ/4Fu+eigPnnZMZ9luZwJMqyTqVJzWM+W0/p4XWJb4CD8uTxj8CVnROOT/e
         EshPPX9dWoV7qMbfEDPWSqxe7TYbCqotEZ2BGXib4cH5Y63A3fdKfy8jfrtPOh2Fu7Vc
         vwOSOw2F4yoqByX9OO+jOIUwWH5yDxBzCkV0qLTCfkhwMwBfFsUDvu1dN42YgSGLwBqS
         hls6TGXu5eP8JKjWQc1xkSa0Y/qNbgdnbAOzB0XDKJk+jLuE7sRK0qHFyK33iY2cBesh
         SyaKDDOM3uvVeeDwrpv06wTbx6NAjU3NMZCjOQu1caRpR/Hl+P/P9YMDn6R/8CublaJy
         q/4A==
X-Gm-Message-State: AOAM533pTpnwnEJ7nv2+RRets1VIvAiqNBM2V3uczPZnR/AD0UZKM/Wc
        XTEpAmTl9sJFc+1lBjGBDnECpIS50NOF0Q==
X-Google-Smtp-Source: ABdhPJwzLz7MObS8Xoaz2UdKfnD1iD+LFBaP5BwvZGd30mbzHHbTFg7Bg2MMH1VABC5Ut1KDTKluqQ==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr24253703wmr.48.1634846061984;
        Thu, 21 Oct 2021 12:54:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7822492wmp.1.2021.10.21.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:54:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] config.c: free(expanded) before die(), work around GCC oddity
Date:   Thu, 21 Oct 2021 21:54:15 +0200
Message-Id: <patch-v2-3.3-d812358e331-20211021T195133Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my GCC version (10.2.1-6), but not the clang I have available t0017
will fail under SANITIZE=leak on optimization levels higher than -O0,
which is annoying when combined with the change in 956d2e4639b (tests:
add a test mode for SANITIZE=leak, run it in CI, 2021-09-23).

We really do have a memory leak here in either case, as e.g. running
the pre-image under valgrind(1) will reveal. It's documented
SANITIZE=leak (and "address", which exhibits the same behavior) might
interact with compiler optimization in this way in some cases, and
since this function is called recursively it's going to be especially
interesting as an optimization target.

Let's work around this issue by freeing the "expanded" memory before
we call die(), using the "goto cleanup" pattern introduced in the
preceding commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index c5873f3a706..ab40decaeba 100644
--- a/config.c
+++ b/config.c
@@ -132,6 +132,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
 	char *expanded;
+	int die_depth = 0;
 
 	if (!path)
 		return config_error_nonbool("include.path");
@@ -161,18 +162,20 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	}
 
 	if (!access_or_die(path, R_OK, 0)) {
-		if (++inc->depth > MAX_INCLUDE_DEPTH)
-			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cf ? "<unknown>" :
-			    cf->name ? cf->name :
-			    "the command line");
+		if (++inc->depth > MAX_INCLUDE_DEPTH) {
+			die_depth = 1;
+			goto cleanup;
+		}
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
 	}
 cleanup:
 	strbuf_release(&buf);
 	free(expanded);
-	return ret;
+	if (!die_depth)
+		return ret;
+	die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
+	    !cf ? "<unknown>" : cf->name ? cf->name : "the command line");
 }
 
 static void add_trailing_starstar_for_dir(struct strbuf *pat)
-- 
2.33.1.1494.g88b39a443e1

