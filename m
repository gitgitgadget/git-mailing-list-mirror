Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD3DC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343142070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpy8Qq4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK0SNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:13:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45873 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:13:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so11406982pfn.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4dPCuJuW+l5biFuykylkZA5uAHVBOBDlMzO4XnUQEdo=;
        b=cpy8Qq4mDo8EChTRAagTJWDyrGObSIjCH8oUrStmXFyE1YZGiutVpufORgun061s+Q
         4ctrnWQiezmnkeR7aaDI7k7jt4I2dU/8WO3RmLXuBMAHJT3Lvv7/C4JoQxTidaJr8Euj
         Ep23LEyo5d03IlvrXmprsKgGfMiIot7rYogXA/nQKsDkexCds31+UrkzkPAguq0BUSOS
         oLYM08ZDp4nweanAh0N9yYw8Mx213lBtWFRqudKuEWU0cJU1w53fLBWL7gYFwsapMOit
         uZtHBHHHg82LnCX+rkZhjcKe0WO4uh6MnQY/39Zyp/eyMDv/Zsug0+WWCigfCkONmTuj
         010g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4dPCuJuW+l5biFuykylkZA5uAHVBOBDlMzO4XnUQEdo=;
        b=EYRrsYQnBQJ9aOPAe4nrmRcW9nvAA+mlLkzpWskckyUbZRCaWisDENaVoFn7RYQEE2
         7cKjFWgMO2STqc//Wua92kw0WirOYjD19ZXrLUk64Y9bXEKJA5G5QZHM2QcXVK51LgoM
         6aGKfyF0womxDU2GDAs9pC9fPUWBrpSJeYjFHZXw/czPSga9QFxvsfMcxKM/YMFJb25h
         SHKRumneYzHzmn7lmDmLpIGN9056mPE/7R7ONITqQR9otpddrR4ECUfzjTlffd0ZZ0u6
         0/Jc3Txi/IgWWfa4x3smEDHnfO6Um4mDyEWPxx3ms6mh6BuaWm92ZYuEhwXXG8+BUC81
         wc5w==
X-Gm-Message-State: APjAAAVXocihbL3/MpaaW9d/5Uaf5lwxZta4QnfCMxD0JYa9Y4oulR55
        1GATP5OHUNEavDxVpy39vVwXud2S
X-Google-Smtp-Source: APXvYqyRXEKO5tcdC0mH5aGwMvofYqvaj2p6dMkUekLYdf/pqtweKX4PUpLhLJmTXBJ0M8USDOhXlg==
X-Received: by 2002:a63:ec09:: with SMTP id j9mr6483928pgh.367.1574878430973;
        Wed, 27 Nov 2019 10:13:50 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id i13sm2905911pgr.48.2019.11.27.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:13:50 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:13:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] rebase: fix format.useAutoBase breakage
Message-ID: <62c59c12e376dd73317a7e5d78275bca12875340.1574878089.git.liu.denton@gmail.com>
References: <cover.1574820308.git.liu.denton@gmail.com>
 <cover.1574878089.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574878089.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `format.useAutoBase = true`, running rebase resulted in an
error when an upstream wasn't set:

	fatal: failed to get upstream, if you want to record base commit automatically,
	please use git branch --set-upstream-to to track a remote branch.
	Or you could specify base commit by --base=<base-commit-id> manually
	error:
	git encountered an error while preparing the patches to replay
	these revisions:

	    ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12

	As a result, git cannot rebase them.

Fix this by always passing `--no-base` to format-patch from rebase so
that the effect of `format.useAutoBase` is negated.

Reported-by: Christian Biesinger <cbiesinger@google.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c  | 3 ++-
 t/t3400-rebase.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e755087b0f..51980ab63d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1012,7 +1012,8 @@ static int run_am(struct rebase_options *opts)
 	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 			 "--full-index", "--cherry-pick", "--right-only",
 			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
-			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order", NULL);
+			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
+			 "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
 		argv_array_split(&format_patch.args,
 				 opts->git_format_patch_opt.buf);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ca99e8c6c4..1323f30fee 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -159,7 +159,7 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
-test_expect_failure 'rebase works with format.useAutoBase' '
+test_expect_success 'rebase works with format.useAutoBase' '
 	test_config format.useAutoBase true &&
 	git checkout topic &&
 	git rebase master
-- 
2.24.0.504.g3cd56eb17d

