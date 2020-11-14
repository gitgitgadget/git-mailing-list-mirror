Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC961C63777
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996712225E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLVyFZbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKNAeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNAet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:34:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24FC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so12120677wru.6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OgadTuTt8Iwy/EM3pubFHfGbMklVvW6qsRA9F6TQfnM=;
        b=bLVyFZbqNY49LYeWKgE+2yLXz7xBNKtdT1VP5w80qk4a2H03Mz2btrUuYBnR1fB05Z
         4/CyEI4EgPe+Q5p88HNrRAnVIaS7i1wPGzM2K8v3LkN2InwAIjbowOqN0L/7rgNpdLfL
         euG4p9TB7ZMHe6Xz0uYdy0TV6Wdwxc50WHDpTSTpdvv7SD1GVFdi4RrzrDQG4OzgZeru
         LG65LFAMcQeKs/Sc0yraWFylq6NtNuKCp0GMM3YAHroFRC7NYL+trIHwEpUo6uBw0EWy
         InNC/rgE5BYRkdTYhIYTVDTj0H0DJLc4e8MsCCaYW5WAaz997aASu+lfWQzbIXdfUbpg
         1TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OgadTuTt8Iwy/EM3pubFHfGbMklVvW6qsRA9F6TQfnM=;
        b=nikHq73VUxnU4ugQjcV8hI17gEKcGstQhslRT+B/cNfDR7t6yyw+gS8s3VtoTduSwX
         KyK6bH/Upr+tbj/ouQmlpfPG8brNp+odbQDOXvkoyGQFjRfpo7jqrNPDPgZVdcHiz6nM
         CR0fBZznwZpKmJE4kBDqrU58+Q5Vm79RZWXqUsmDR76AQDBzdcUlRw74PrbmWbgsFM5z
         1/Nj9mr5K3QbgMDZ7/zsWpPC4VcEZTdakOJ7w0tYstM8ovBZ++6lh3+cV3O6GkFdm907
         5PNYCOIOL049PzOXv/+WMT0KHWrHKjxAmbtcX7p1SUZ0eWpM7AnDILuVKKuN1OgDEZLU
         FDzQ==
X-Gm-Message-State: AOAM533TJChujmK0k3D3eQSLRC4NTYo7HDqIGUlE9KCg3xVuQ9y2Gihd
        jAA30R1gw5hIdxhoLleuSOoZl7xDsN8=
X-Google-Smtp-Source: ABdhPJwZ3SHKj4CODvQDrxX52u+gkBvEDceVASGzdoAKNuMFTdk6ACEg0fSSWgBizOo+XOb7NNV3TQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr6652538wrx.59.1605314086299;
        Fri, 13 Nov 2020 16:34:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18sm6118782wme.18.2020.11.13.16.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:34:45 -0800 (PST)
Message-Id: <pull.789.git.1605314085.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Nov 2020 00:34:41 +0000
Subject: [PATCH 0/4] Fix 'pull --rebase --recurse-submodules' when local and upstream branches
 have no fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brice Goglin <bgoglin@free.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a bug in 'git pull --rebase --recurse-submodules' when the
current branch and the remote-tracking branch we are pulling from have no
fork-point (git merge-base --fork-point refs/remotes/<remote>/<upstream>
<current-branch> returns empty), resulting in a misleading and fatal error
message:

fatal: cannot rebase with locally recorded submodule modifications

This is patch 4/4.

Patch 1/4 is a preparatory refactoring, and patches 2-3 add comments to
t5552-pull-submodules to describe 'pull --rebase --recurse-submodules' tests
a little better.

Philippe Blain (4):
  pull --rebase: compute rebase arguments in separate function
  t5572: add notes on a peculiar test
  t5572: describe '--rebase' tests a little more
  pull: check for local submodule modifications with the right range

 builtin/pull.c            | 48 ++++++++++++++++++++++++---------
 t/t5572-pull-submodule.sh | 56 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 14 deletions(-)


base-commit: e4d83eee9239207622e2b1cc43967da5051c189c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-789%2Fphil-blain%2Fpull-recurse-no-fork-point-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-789/phil-blain/pull-recurse-no-fork-point-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/789
-- 
gitgitgadget
