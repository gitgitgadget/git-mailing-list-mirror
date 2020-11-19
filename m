Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C18C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9660D24698
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 10:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvzSjFg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgKSKWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgKSKWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 05:22:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A592C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 02:22:32 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so5777698wrf.12
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 02:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=OVWQ7KzSYsP0WJa8UWu8negEmoBfzPyr1wlsczGepp0=;
        b=qvzSjFg20BFHbCeWwPmzprSnq6uwGC7DAnwkK/eLNvhSIF8vNhRnD076OjDm7om4bt
         Yr9h+Eti6K3VA84gvGyeKV9q1vaQw9tDnBWAR6O9N+RZkF3KQKl+SSStzKfwktbBwTRt
         03mFLkcEc3GP3KEb90ohwGURBPKyvpxfcpLKCVvg5HUqRyVpdLXT3plAuboBHDVER314
         F0PHSU+jgtNVFkPFUy8Pi8bbVH1DHZTaVcmQ0cFBbswvIXTfGA8xxivntx+h0YyZLMkx
         nfN8j+ItwSGGh6XGBwV88oSu9LG4sSeXDDvq2i6wHB2iWzrR+Uw56mKTQLr7AwgoFovP
         aMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=OVWQ7KzSYsP0WJa8UWu8negEmoBfzPyr1wlsczGepp0=;
        b=Fpt0aXqHzyC5EpuAXpAwbxBtSG8TRc1QtQLvL3uZe+RrL3aWQgCoU0MFazPWeJjw4a
         QxQy28Ti0sRtBYfhunxU2/5qwwvwTuMtl7sM7VPLu83/UI7DIYTF57yESBBxRTvUUbkU
         VWQKkykarUmmmSSlw6jDP6T35ecAdZqzqMYdSGwRyJwTuMyNiT1VB7eZ0GQO7mE9Zhxp
         xPK08rFenYqNYmU3eSHQMuS+JEKDixeBtV3qyvAsff0G+tnpM/jmECoQTwfZ69unebjp
         F9rtMQ20DAtkQikc/1odiglCwU4+cZMr8diAikncz6s/GxpT3qhAwRqxE36uPkx9XzvS
         YdDA==
X-Gm-Message-State: AOAM533smz1q31Y4poSqLwFtrnUctdWdzpm73HqIVM+v1hy48Z+F+hoP
        daIRtSuaFd1Q5BUXCNFySwJOBqVFJ50=
X-Google-Smtp-Source: ABdhPJx0TAA52wjYXxwQIrYaDj3hFGiCFQBYWYB8WrOzzSulsKjIIuG14YHXFWht5fZcEsZY2uC3Kw==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr9920944wrk.71.1605781350909;
        Thu, 19 Nov 2020 02:22:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g186sm25023270wma.1.2020.11.19.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 02:22:30 -0800 (PST)
Message-Id: <pull.795.git.1605781349528.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 10:22:29 +0000
Subject: [PATCH] pull: colorize the hint about setting `pull.rebase`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d18c950a69f (pull: warn if the user didn't say whether to rebase or
to merge, 2020-03-09), a new hint was introduced to encourage users to
make a conscious decision about whether they want their pull to merge or
to rebase by configuring the `pull.rebase` setting.

This warning was clearly intended to advise users, but as pointed out in
https://lore.kernel.org/git/87ima2rdsm.fsf%40evledraar.gmail.com, it
uses `warning()` instead of `advise()`.

One consequence is that the advice is not colorized in the same manner
as other, similar messages. So let's use `advise()` instead.

Pointed-out-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    pull: colorize the hint about setting pull.rebase
    
    I see that Junio briefly wondered
    [https://lore.kernel.org/git/xmqqeeuecngu.fsf@gitster-ct.c.googlers.com/] 
    about using an advice here, and concluded that it was not needed because
    the warning is self-squelching (i.e. there is already a config setting
    that will silence this warning). But that missed the fact that warnings
    are not colorized, whereas advice is.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-795%2Fdscho%2Fcolorize-pull.rebase-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-795/dscho/colorize-pull.rebase-advice-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/795

 builtin/pull.c               | 24 ++++++++++++------------
 t/t7601-merge-pull-config.sh |  7 +++++--
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 17aa63cd35..1034372f8b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -345,18 +345,18 @@ static enum rebase_type config_get_rebase(void)
 		return parse_config_rebase("pull.rebase", value, 1);
 
 	if (opt_verbosity >= 0 && !opt_ff) {
-		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
-			"discouraged. You can squelch this message by running one of the following\n"
-			"commands sometime before your next pull:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-			"or --ff-only on the command line to override the configured default per\n"
-			"invocation.\n"));
+		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
+			 "discouraged. You can squelch this message by running one of the following\n"
+			 "commands sometime before your next pull:\n"
+			 "\n"
+			 "  git config pull.rebase false  # merge (the default strategy)\n"
+			 "  git config pull.rebase true   # rebase\n"
+			 "  git config pull.ff only       # fast-forward only\n"
+			 "\n"
+			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
+			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+			 "or --ff-only on the command line to override the configured default per\n"
+			 "invocation.\n"));
 	}
 
 	return REBASE_FALSE;
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c5c4ea5fc0..6774e9d86f 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -29,8 +29,11 @@ test_expect_success 'setup' '
 
 test_expect_success 'pull.rebase not set' '
 	git reset --hard c0 &&
-	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	git -c color.advice=always pull . c1 2>err &&
+	test_decode_color <err >decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded &&
+	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '

base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
-- 
gitgitgadget
