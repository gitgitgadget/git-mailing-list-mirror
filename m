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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77391C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4F860296
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhIPLli (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhIPLli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 07:41:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1586BC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:40:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q23so3533300pfs.9
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzD/o8EHXjHJHYsp98yV2D2GEfjz5Ljv41N4ym0tyzk=;
        b=SKV6wDHc+vJbDvH93qr66a2GC6bfzUY00f1tTRSKIHxSxGJsEFoMf0Ta7ip5cVcF1f
         Cyy434sSW4+vwAHgiUdyW0h3v5O9URpmHNRMo6DHM/zyANSqtVCZxDwrZ+EdeVd2tuxC
         Ne16jBPS6hg9Ke4qet4H9r5Re8JI6AYpfBhtOBh+uQVKBsfWRgLHqOO/28aNKOk56DrS
         AUsSgSZuiJMJmdyhfN76eyIh9wfmO8grbBV8l+0WXt27YJLUxvkk0wCI2O6PxmTF4jTw
         /RnfODsTjKX+3KEJeLnD69hOXz8nmlQmFjfpEXuFYtgqxnBKTlTXrSDUKv50uLFSw77G
         YlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzD/o8EHXjHJHYsp98yV2D2GEfjz5Ljv41N4ym0tyzk=;
        b=KjgEVcMfc+OCkcFFk4qAkyPHc/zLNqCNwLm3Chv5apLZBcLUcHunUAL6L3mv3xdagr
         nrsLLxdLBAI+tXnyPYof7TPEwSEvTBeIQXAVd3UdQkBDWF3wTSY5mkAzOlCJR6rrYdXP
         6MV4xCEL5ytiCAvmqaWOMD0olot0DjuzsVQYVl7RbbicxGMVww5gi64MPGOBiWlbOcTb
         D/Psk0ktNncqpLhaR+aVEctII+UJ19y4zR8OZ2MTzXhr3KNsHpdzsYoNy/pch7caszU9
         Ks5A4Xe80mk0VE/wok6zuI3p39Q+p8hE5IVF+fNd49Gk+eAgeUBpHqSd2QeGyJYZ1ctS
         DSUA==
X-Gm-Message-State: AOAM531jEup3y7gPnQ2zdoquVv2zjQ0TIgGm9/EbXjIpFMPkOZ8nvYOH
        P5ZjGyiBbrtC06uSnqzux7IGT23TyXZWHg==
X-Google-Smtp-Source: ABdhPJxK40ymw+L9+PAaH5my6xvtLAV9Gf8+D0CeAuF5w1+xM1Tbw59khTakrOac4LRxPjvlMad6ZQ==
X-Received: by 2002:a62:7e0c:0:b0:43d:fc6a:59d6 with SMTP id z12-20020a627e0c000000b0043dfc6a59d6mr4700821pfc.34.1631792417400;
        Thu, 16 Sep 2021 04:40:17 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id y8sm3086622pfe.162.2021.09.16.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 04:40:17 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] difftool: word spacing fix
Date:   Thu, 16 Sep 2021 18:39:35 +0700
Message-Id: <20210916113934.77097-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  - s/non - zero/non-zero/
  - add space between diff formats/mode and option parentheses

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/difftool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6a9242a803..ad9187761e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -410,9 +410,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		const char *src_path, *dst_path;
 
 		if (starts_with(info.buf, "::"))
-			die(N_("combined diff formats('-c' and '--cc') are "
+			die(N_("combined diff formats ('-c' and '--cc') are "
 			       "not supported in\n"
-			       "directory diff mode('-d' and '--dir-diff')."));
+			       "directory diff mode ('-d' and '--dir-diff')."));
 
 		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
 				     &status))
@@ -713,7 +713,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			    "`--tool`")),
 		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
-			    "tool returns a non - zero exit code")),
+			    "tool returns a non-zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),

base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
-- 
2.25.1

