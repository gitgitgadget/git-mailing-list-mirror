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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0959C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4D64E90
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355355AbhCDAXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386149AbhCCRqs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 12:46:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE30C0613DC
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 09:44:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h98so24608303wrh.11
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BWBSb0XkLM6XpkSGke8UqlgXDxwiDlwI9nB53EU6ZEI=;
        b=UjqEzqq474edxnKVHfGEuaNQvBoB0NRlqJN9qJtgU5jPjpet1dbS+vp5JmRpNwIPKy
         ypyDQyyI+sVtiFZe4HUmSZ9RQpQAyS4zBU3W9ShL2b6WBf5ojH+tCcs8IYzMhH/iJwhB
         HQINTN5B/dTf7qG0dbLfMo0hykCzQXYYCM9cun1unetJe6oyraRe9kuTA/6xZzHWCN5i
         y/6r3VZvFHjYwmVkHMR3ZnfO/N1HhK5gEq8L4blizGvpzOohXocWYBXkdI+d+hU+9Rp3
         /5GYrVf2bT0XKeP02D7rWA13m4viJC1vhcMKHf8GurcbzCaK5DQgc2EdLBiuCVkZJ9zd
         j7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BWBSb0XkLM6XpkSGke8UqlgXDxwiDlwI9nB53EU6ZEI=;
        b=OZ9bYmwVZcQMMr1FuR35kTrsL01gNgYKLzsl3cdtPvfLvAn49JObS4SHpGwMVOyWSu
         Wivy0m7JNtCaq6v7xwFJtBouOSmfBIAMDf9uJGjmD/TnlkF7CpnRuK08CEmHfQKOzC1Z
         cWOdafGjp1Lk5m7K8KpwQGI8jp6rJnf4nJ4n28Q+8wA+Yfz7MOWgm2SuLcFUfoSn3XSE
         a8STWeySnhZDqXRyJJQS71APpU1a4GBxHF96k6XT+MxFoCQhTANcXQdKQjix4+J25eKQ
         M18gb6VapXtWoEkWbs4MlcoN0fW+Z0ChevuSsA4piyw3+brgdGtF6WrzZ2YQXkbMEPsR
         lBMA==
X-Gm-Message-State: AOAM532bjhUjUgJlZNvpB7omdtYcevl9XFWr1YNtY3bOQ9++kRWyp4Pq
        U/BjOn5wTnwooVz0n2HCC0LjowRnpUA=
X-Google-Smtp-Source: ABdhPJyMQ0aebiF0uKZ0X346OYXSeq+/AZ9hIgb7O1VdWEGbGCJ7FGQuA7O2rDS36D890dkpvJK2ug==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr27673142wrr.81.1614793492605;
        Wed, 03 Mar 2021 09:44:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y9sm30063812wrm.88.2021.03.03.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:44:52 -0800 (PST)
Message-Id: <pull.892.git.1614793491538.gitgitgadget@gmail.com>
From:   "Josh Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 17:44:51 +0000
Subject: [PATCH] branch: return error when --list finds no matches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Hunt <joshua.hunt@berkeley.edu>, Josh Hunt <johunt@akamai.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Hunt <johunt@akamai.com>

Currently git branch --list foo always returns an exit status of 0 even
when the branch being searched for does not exist. Now an error is printed
and returns a non-zero exit status.

Signed-off-by: Josh Hunt <johunt@akamai.com>
---
    branch: return error when --list finds no matches
    
    Currently git branch --list foo always returns an exit status of 0 even
    when the branch being searched for does not exist. Now an error is
    printed and returns a non-zero exit status.
    
    Signed-off-by: Josh Hunt johunt@akamai.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-892%2Fjoshuahunt%2Fjohunt%2Fgit-branch-list-return-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-892/joshuahunt/johunt/git-branch-list-return-error-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/892

 builtin/branch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index bcc00bcf182d..5573175734fe 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -426,6 +426,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	memset(&array, 0, sizeof(array));
 
 	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
+	if (!array.nr)
+		die(_("no branches found"));
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));

base-commit: ec125d1bc1053df7e4103f71ebd24fe48dd624a2
-- 
gitgitgadget
