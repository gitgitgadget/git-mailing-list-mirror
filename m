Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5767C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 16:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBEQYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 11:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBEQYk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 11:24:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718543ABE
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 08:24:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r2so8410834wrv.7
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BdVwfnxUEyjJQufBikugTEj+TrkJr/36S3FzbDivdGs=;
        b=E1rufwSCWK5kbfHDm8FLrwAfFKAysIJCC/g4NSJRdKsAvm6uwW0b1gsK6G7ehik5Of
         S6iAtTz8iS2WzUH1ehZqujmgR+gxu+6nNQIQyyz8e0g2ylDL6YiptWkkSaZqMhpKDMfN
         8h8vIEFNQL1dIBchoS0IeZOn1XLD45sHnVAJfNYumDk8nMfQ+0vIjkfC3qcpja1fKRVm
         rDHTCpgw8jHkZaLkh/XKBLO9K059awGHGPX6HAiyh6isI7yyO8i5sypJoDuIDtkRaNEQ
         AqK0YhS4josRtqgTwPyq+uv1hdfNKoeJzeUBBw4YOhuTJqScJmatYe+wqn9ARpfCJnsz
         MlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdVwfnxUEyjJQufBikugTEj+TrkJr/36S3FzbDivdGs=;
        b=cvR0hHdW+ISEUihpRKCamFUFFdvAbm7QI4ES3Q7hft5iTe8Cyrea/ffzLKE+SmApJD
         UyXRT4LjVC/II1iB2iBZBeR5CVcjO3XDss0M3V3u1cSaBrOjC9vAfR35sP3KrMDDk633
         +CoJ1sSMBDw+Ltp2GPXA9Uh/qIjhAgQ0ZJ6cCI6Oje+PXPZlwLNGnLbqUg3FyG520W+W
         qQrQOCc1Ab+pSf3Y596p862/pItG8cvivJIHqIZYzQ1iIaUMjeYl1LAdoBszClwDH8O3
         OGnMCtpGCzNM1ogyANT9sr1jurA/CQPdku2R0OJ3TvB/N6VivqW2slaCBkjppOdsc9Eg
         vU4g==
X-Gm-Message-State: AO0yUKWAxYylA2nrU2TOraKeqnT0X0u+lubBMW7ROaUe0y6iAsHEVjgU
        LFafdJOCLmeTmeDPY3SmeM95SB/JFNc=
X-Google-Smtp-Source: AK7set8DfqWEY+oOOEOsfu8B+FF1utuDgrdM9NrRlL3UGmf+ZSzApbC3/7GlYHy5lMg1Bw17O9ezlA==
X-Received: by 2002:a5d:5c08:0:b0:2bf:c968:d181 with SMTP id cc8-20020a5d5c08000000b002bfc968d181mr17716838wrb.27.1675614277729;
        Sun, 05 Feb 2023 08:24:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d608a000000b002bfd8ad20a0sm6733942wrt.44.2023.02.05.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 08:24:37 -0800 (PST)
Message-Id: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Feb 2023 16:24:36 +0000
Subject: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

When "git pull" is called without a conflict-handling instruction or
configuration, it displays a hint proposing "pull.rebase" and "pull.ff"
config options for future handling.

The hint offers three permanent settings, "merge", rebase", and "ff". The
proposed command for "rebase" is "git config pull.rebase true".

Unfortunately, this rebase configuration can easily lead to non-expert users
accidentally rebasing not their own commits, instead others' commits, if the
new commits they have locally before the "pull" include a merge of another
branch, eg "main".

Since 2018 in git version "2.18", it has supported a new rebase flag
"--rebase-merges", with corresponding pull.rebase config option "merges".
This new option is ideal for rebasing local work on "pull", as it will
not "mangle"/flatten any local merge commits but rather recreate them.

Change the pull conflict hint text to propose "pull.rebase merges" instead
of "pull.rebase true", and "git pull --rebase=merges" instead of
"git pull --rebase".

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    pull: conflict hint pull.rebase suggestion should offer "merges" vs
    "true"
    
    Hint change as proposed in
    https://lore.kernel.org/git/xmqqa61uo3q0.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1474%2FTaoK%2Ftao-fetch-rebase-hint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1474/TaoK/tao-fetch-rebase-hint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1474

 builtin/pull.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005d..535364fbb07 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -967,13 +967,13 @@ static void show_advice_pull_non_ff(void)
 		 "your next pull:\n"
 		 "\n"
 		 "  git config pull.rebase false  # merge\n"
-		 "  git config pull.rebase true   # rebase\n"
+		 "  git config pull.rebase merges # rebase\n"
 		 "  git config pull.ff only       # fast-forward only\n"
 		 "\n"
 		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-		 "or --ff-only on the command line to override the configured default per\n"
-		 "invocation.\n"));
+		 "preference for all repositories. You can also pass --rebase=merges,\n"
+		 "--no-rebase, or --ff-only on the command line to override the configured\n"
+		 "default per invocation.\n"));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)

base-commit: a6a323b31e2bcbac2518bddec71ea7ad558870eb
-- 
gitgitgadget
