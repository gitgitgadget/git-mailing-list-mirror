Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2AAC4320E
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA8260E8B
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhGWLeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhGWLeC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 07:34:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C949C061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b7so2113980wri.8
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/R+kFhvXXcF2d2eDGqM1uycyvX7ErN+uwWtmnOkcRQE=;
        b=Yn6NHlGIgezlPw66vTojudmUF66avSEL06NejVZBcH2heRMlcVISIv/oyLMCeZtMAO
         wSTz0d0x2Gb5XMFHib5r2AVGFtaqogJ7lm4BEdfrxo88E1VI+GwcQcNRG63/g73/r/CD
         NlSB0LObgg/eAhqBtchj+pR6NVmAFpI01wRSd3qcJggOjncxXgNGBfKExcPjXypmkqxk
         sfG5YmG+Bv8N527TccpZd5DQUWk07DXWYsCUzOSiL8AxObt6GvNWUlfTjY3zahvjkdRB
         aTowWiTVcPqFGg5RAyJV1puMyK+DB/pQabRsgnBn9IBc+rz86ojEUH9ADd5EF8rAuUku
         5O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/R+kFhvXXcF2d2eDGqM1uycyvX7ErN+uwWtmnOkcRQE=;
        b=GF/mmgKC9RSovR+GEIaDEtTxgzyXmnLOwgNPHiIutOt8/mK+mwgsaBfMkUtqM2Kwfu
         EAAIqZRB5E/T/TtGmrLaqrPux7fgwHakduIzeCYl0hjaIQx4JCx4YdHZ2rKJ85zjTyDH
         4bKmNujDXREsjYP0VgL3fdaRWuudnvBODz13EGBbzolRet09olG0ITTWmc1mBRn8/wXP
         JzhIdF6YkoyoPGk+H3zmNhCBplDjFNQBoDWG7BCFOgObdV8tEsY8ms6oIgVgVC0aUwtA
         Ec8dVOemrP++ouROKcVFPL+Qu1BaEDke56yO+tj/XneG98kOXJi7hbNXfVp+wHDm99ul
         KfjQ==
X-Gm-Message-State: AOAM531eBwClo7QI6Q2bONBkulKAsX83LMivbOCBrfPcHiQ2EEJyPRRJ
        i+jbh1Zm4azmNDr6gfIS2GHNJYMyz+M=
X-Google-Smtp-Source: ABdhPJw3jqlP14KijSFtXNr5MHfzlYCtCBq90HKvoLcCxpp6+iscAULysfbANRZLHXn6nqxNVP5fsA==
X-Received: by 2002:a5d:6b8e:: with SMTP id n14mr4950058wrx.96.1627042474197;
        Fri, 23 Jul 2021 05:14:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22sm3728165wmq.44.2021.07.23.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
Message-Id: <e02b945ce8595a8d7b1b4ad9c382a1beeb040ed4.1627042470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:14:30 +0000
Subject: [PATCH 4/4] merge: apply autostash if merge strategy fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 'git merge' learned '--autostash' in a03b55530a (merge: teach
--autostash option, 2020-04-07), 'cmd_merge', once it is determined that
we have to create a merge commit, calls 'create_autostash' if
'--autostash' is given.

As explained in a03b55530a, and made more abvious by the tests added in
that commit, the autostash is then applied if the merge succeeds, either
directly or by committing (after conflict resolution or if '--no-commit'
was given), or if the merge is aborted with 'git merge --abort'. In some
other cases, like the user calling 'git reset --merge' or 'git merge
--quit', the autostash is not applied, but saved in the stash list.

However, there exists a scenario that creates an autostash but does not
apply nor save it to the stash list: if the chosen merge strategy
completely fails to handle the merge, i.e. 'try_merge_strategy' returns
2.

Apply the autostash in that case also. An easy way to test that is to
try to merge more than two commits but explicitely ask for the 'recursive'
merge strategy.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/merge.c  | 1 +
 t/t7600-merge.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 788a6b0cd55..d44c14a21a3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1709,6 +1709,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
+		apply_autostash(git_path_merge_autostash(the_repository));
 		ret = 2;
 		goto done;
 	} else if (best_strategy == wt_strategy)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 216113d3537..2ef39d3088e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -732,6 +732,14 @@ test_expect_success 'octopus merge with --autostash' '
 	test_cmp result.1-3-5-9 file
 '
 
+test_expect_success 'failed merge (exit 2) with --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.5 &&
+	test_must_fail git merge -s recursive --autostash c2 c3 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	test_cmp result.1-5 file
+'
+
 test_expect_success 'conflicted merge with --autostash, --abort restores stash' '
 	git reset --hard c3 &&
 	cp file.1 file &&
-- 
gitgitgadget
