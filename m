Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E6C61DA3
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBTVdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 16:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBTVd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 16:33:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D257A1B8
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:33:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m23so1813302wms.5
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1FyHEU0tsDOODLeBa7+D7N0BY88/BUvx5d4foCSHXzg=;
        b=gsXDXsuVAOQcFHfeZDbUCJ4G+VrD9syQmU8nazhVokV5FLhKLGR+K6WS2e3TL9GaMb
         YcQ5jgl7P5+9fTa/epn+hhhEbSGNJPRV+khB12DjDDGxPbTgN6rDuCQHr6SCKgJ08nyE
         0xdCNnpxzhYg4O93ZK3YPNTi4eqjCH4SIRAO2RGG8GZC166icXk3lPRqdW72Dnxhb0pg
         gR9MU4HQZD9lpKM//85Uk2NsTFcF0jHL5BML59MGvFp3HDhQemINYElDXzYA8vsFkOU3
         /IovQr/nmJAwmFLROA91sTZKDXvXerX98lOoqGYrWqriQ9AFRdDN0Pkrs3P/5DlZwj0h
         ZQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FyHEU0tsDOODLeBa7+D7N0BY88/BUvx5d4foCSHXzg=;
        b=3rxCylYi3bp156ePEDCmQ53cf3OtRoNUCVtPSt4sZUqE4WXbMNwkJRWAmLHTv1c/f3
         NnJyHO1JMK5j6+6b/AI4MMO6isPWO0JapKKLwJx76j4Ap/N//jOE8wHmh67BwAtqJaGT
         NqbcMWPGHJEEmlHiO9hxcRp30jSO7HIIaUphIfXtu1N1GeFTDmS3AM6WdAC9VaiI/fi2
         LWHFhnhUDDurElf6CDqPWn/oYTi+jN5Kj3x6txILi5rzMu+kB9JaLt1bhVsRuSDW9cL2
         5+sqGO5ZF+JcCLOen8ncMBl3sm8uJYEb+uuFMD0P8nrJVXwn6ZY1G6zKBNpc1Vp0COWb
         xmSg==
X-Gm-Message-State: AO0yUKXH7OnV+Ppld/c4DoOzM8E0v+ItFpkonZqt3ZlvECasZ6Un346F
        I9enBA8w19dz9f1/c1Ossw7JTxyXjYs=
X-Google-Smtp-Source: AK7set8uDnG6d6qF5blTBgN3jWP7YjH/GsQGlxOuSGgtAF5L51emC7WBpr3z6kR28uf4qchyTK2yYw==
X-Received: by 2002:a05:600c:1688:b0:3e2:2304:c7b3 with SMTP id k8-20020a05600c168800b003e22304c7b3mr8754131wmn.34.1676928806970;
        Mon, 20 Feb 2023 13:33:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c500900b003daffc2ecdesm11456306wmr.13.2023.02.20.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:33:26 -0800 (PST)
Message-Id: <pull.1483.git.1676928805555.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 20 Feb 2023 21:33:25 +0000
Subject: [PATCH] fetch: choose a sensible default with --jobs=0 again
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Drew Noakes <drnoakes@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

prior to 51243f9 (run-command API: don't fall back on online_cpus(),
2022-10-12) `git fetch --multiple --jobs=0` would choose some default amount
of jobs, similar to `git -c fetch.parallel=0 fetch --multiple`. While our
documentation only ever promised that `fetch.parallel` would fall back to a
"sensible default", it makes sense to do the same for `--jobs`. So fall back
to online_cpus() and not BUG() out.

This fixes https://github.com/git-for-windows/git/issues/4302

Reported-by: Drew Noakes <drnoakes@microsoft.com>
Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
    fetch: choose a sensible default with --jobs=0 again
    
    Prior to 51243f9 (run-command API: don't fall back on online_cpus(),
    2022-10-12) git fetch --multiple --jobs=0 would choose some default
    amount of jobs, similar to git -c fetch.parallel=0 fetch --multiple.
    While our documentation only ever promised that fetch.parallel would
    fall back to a "sensible default", it makes sense to do the same for
    --jobs. So fall back to online_cpus() and not BUG() out.
    
    This was originally reported at
    https://lore.kernel.org/git/PSAP153MB03910458707331B64FA7460DCAA19@PSAP153MB0391.APCP153.PROD.OUTLOOK.COM/T/#u

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1483%2Frimrul%2Ffix-fetch-jobs-0-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1483/rimrul/fix-fetch-jobs-0-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1483

 builtin/fetch.c           | 3 +++
 t/t5514-fetch-multiple.sh | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a21ce89312d..a09606b4726 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2196,6 +2196,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		write_fetch_head = 0;
 
+	if (!max_jobs)
+		max_jobs = online_cpus();
+
 	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
 	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
 		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 511ba3bd454..54f422ced32 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -197,4 +197,9 @@ test_expect_success 'parallel' '
 	test_i18ngrep "could not fetch .two.*128" err
 '
 
+test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
+	(cd test &&
+	 git fetch --multiple --jobs=0)
+'
+
 test_done

base-commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
-- 
gitgitgadget
