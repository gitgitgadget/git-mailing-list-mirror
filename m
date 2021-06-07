Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F38C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CA2611AE
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFGUud (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:50:33 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44683 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhFGUuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 16:50:32 -0400
Received: by mail-wr1-f54.google.com with SMTP id f2so19052492wri.11
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sZGnugZODVcPa5JKgGacATJLljywV71FsRrq3hpMQ3w=;
        b=d55bApK+jdMcXWekhZO27cf8lCftxa5ADephDtq1HaluQ8oCJRTiMj1s50Khd+uSCF
         JBoUgelwhaip2433UzJC9EBhtwiYmPJXIKxX6cqVxob80ahDxJqTowtll81v3/wKlWgR
         Uk7nG3ivn7Vvuohgnx+v4AzaqEY/sPqzSow+rcVteA3I1S+PF3ZHBfMGk0q2MonFPY9W
         EN+I2usME89RLlA1O8TB+wGPuGdvExWuzLiqLclp7oorglmhGR1bLOeiRh6plGvWCe38
         KEUZl1mDCNUqZodvaaWnvb9KGL/JobYCFtsHKMXVTaWxJLcfukO+OvPEU3pw5AtxayXC
         arYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sZGnugZODVcPa5JKgGacATJLljywV71FsRrq3hpMQ3w=;
        b=k2/VDGXzeJEgM/8/iZ/qaCzt8UD/B6y1T/GsiQqgipwCN0JMDx8qKi1pzXkxu4xBDJ
         QizvAjHyo4v++UbnYulzVSD6Ehe0G5m6AveXD5fUP/Se6UEy/2C2znOtaicldZzBQxYK
         bfEN4JwjPbPb9uguW7vPSoo2JA4wpRveJVOQRkjoybwMVpTC8XCeoCBg6or8C8fCaPJ/
         gh6qUl08abBuQ/DSZZIbLr9afC/FYVLvqvfQo91InoAhmmnoXSkoqsN6vG2sAfkiNRtQ
         Xp3kJbLR/OnJ8cyp8LrcuYHR0/lJEAdjJLTJv5BzKNcfpy5FKzaruJtrOtJmxBnCQv1H
         ONPQ==
X-Gm-Message-State: AOAM531Ge4m81hTAchIm62a2K5i/rf+6B2wrdA9i9VgP61FYGHGrEZKH
        381sksIhd8O6EjuqYlMq14homXZZxHA=
X-Google-Smtp-Source: ABdhPJzXKHbQiLdh4rP3UIi29nx4H8wg9arG+96tXT7EiWheKz1OJAV4wn2A/nAyLkHd5NQclfwckg==
X-Received: by 2002:adf:ed03:: with SMTP id a3mr19107798wro.166.1623098846637;
        Mon, 07 Jun 2021 13:47:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm2870212wrr.27.2021.06.07.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:47:26 -0700 (PDT)
Message-Id: <pull.1032.git.git.1623098845733.gitgitgadget@gmail.com>
From:   "Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 20:47:25 +0000
Subject: [PATCH] use get_merge_tool_path() also in is_available() to honor
 settings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Schindler <michael@compressconsult.com>,
        Michael Schindler <michael@compressconsult.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Schindler <michael@compressconsult.com>

fix the is_available test used in git mergetool --tool-help or
git difftool --tool-help or to check the list of tools available when no
tool is configured/given with --tool

symtoms: the actual tool running run_merge_tool () considers the difftool.
"$merge_tool".path and mergetool."$merge_tool".path and if configured
honors these. See get_merge_tool_path () in git-mergetool--lib.sh
If not set use fallback: translate_merge_tool_path "$merge_tool".

The is_available () just uses translate_merge_tool_path "$merge_tool".

repo 1: Configure an invalid path in mergetool."$merge_tool".path for a
tool of your choice.
You will be informed that the tool is available, but when trying to use
it will not be found because the invalid configured path is used.

repo2: Install a tool of your choice on a nonstandard place (e.g. rename
the program) and configure mergetool."$merge_tool".path for this tool.
You will be informed that the tool is not available (because not found on
standard place), but when trying to run it will work.

This fix will make the information consistent by using get_merge_tool_path()
also in is_available()

Signed-off-by: Michael Schindler <michael@compressconsult.com>
---
    use get_merge_tool_path() also in is_available() to honor settings
    
    fix the is_available() used in git mergetool --tool-help or git difftool
    --tool-help or used to check the list of tools available when no tool is
    configured/given with --tool
    
    symtoms: the actual tool running run_merge_tool () considers the
    difftool."$merge_tool".path and mergetool."$merge_tool".path and if
    configured honors these. See get_merge_tool_path () in
    git-mergetool--lib.sh If not defined use fallback:
    translate_merge_tool_path "$merge_tool".
    
    The is_available () just uses translate_merge_tool_path "$merge_tool".
    
    repo 1: Configure an invalid path in mergetool."$merge_tool".path for a
    tool of your choice. You will be informed that the tool is available,
    but when trying to use it it will not be found because the invalid
    configured path is used.
    
    repo2: Install a tool of your choice on a nonstandard place (e.g. rename
    the program) and configure mergetool."$merge_tool".path for this tool.
    You will be informed that the tool is not available (because not found
    on standard place), but when trying to run it will work.
    
    This fix will make the information consistent by using
    get_merge_tool_path() also in is_available()
    
    Signed-off-by: Michael Schindler michael@compressconsult.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1032%2Fmichaelcompressconsult%2Fmergetoollib_is_available-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1032/michaelcompressconsult/mergetoollib_is_available-v1
Pull-Request: https://github.com/git/git/pull/1032

 git-mergetool--lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 542a6a75eb3c..8b946e585d7f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -18,7 +18,7 @@ mode_ok () {
 }
 
 is_available () {
-	merge_tool_path=$(translate_merge_tool_path "$1") &&
+	merge_tool_path=$(get_merge_tool_path "$1") &&
 	type "$merge_tool_path" >/dev/null 2>&1
 }
 

base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
-- 
gitgitgadget
