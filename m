Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13705C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFED222D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgLQBHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbgLQBHx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:07:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66611C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:13 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 91so24906512wrj.7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=aZ7xpW/zDSsBVZvz//x/VrjuyPN80Qj+P83DYfArw/A=;
        b=j/+cqZEBhZVJpP2C010R/qP+/dtUJODQi7nUl6eg1HqwnJROPpGilnPjuN0EJMcZaw
         2bXw2Xosm3FTQ5OJ+Gt+Lw4+nXnxkCMRjbZnfP02CoCJ546JdlRkmhg+J6IW5TmKGaOo
         Xzl5vufluM+6ZW98bg50sM3FROBns1nDM+YWw8aznINdium3dKRINtm+ioHIpPg1UogT
         oEXhzbB/Ti0piqaeOMtg148MMQAxsQkb7Wcs6mi+WbZri2ItxtrsTjj3NkpQtGktR3Zk
         yUnaGarMmeeMkgTwRgfmoVLlYWuRjF1Tm6TKVioL72MTCeJlxxMIgsSu6z08ZY3frFvM
         b7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aZ7xpW/zDSsBVZvz//x/VrjuyPN80Qj+P83DYfArw/A=;
        b=J5mi9L5ymw5hmCNHYMuqDVKMXPj0hkYZ0s6Fv9nOGf4veO9vYzN9gLOMx9tbmp8x/Y
         Sr+a8BrQz9qhx0x8zesat14UyQRhDewD2HDprVVBCOrmSjOFHo7+4joJhUf6ovkfWQYC
         1ODdT/TgRlZ8GwtOnjhLj0u2enNYMdCOn7iH9Sb6KQ0/0kpgfxdupXaHrTks0ARijVow
         h8QmUaeDfLlR/sgsGsuPBcbY4w28pO/q3MOPE3gAhW/yglDP0XzjxcDq2gUuYESlPp8K
         zNsBzXzuQzlWmuz2Dtgy1N77BiLKk0OD2LddwPhTiwqN4dZK0kOBkftZOWaCGwJapnZQ
         P/XQ==
X-Gm-Message-State: AOAM532ybb5DgmaKT6rbpR7tMEMmhcaK8cU+HKV2yLA0Bf/ipes/Zwpg
        Z5DO4NGlMMNc0x+Zs6PN33UUbWEiZVg=
X-Google-Smtp-Source: ABdhPJy5ac+u5d8ugRLHIi2iVABaEAJ7NHm93+rzDeQDcW3rO4wvy0oCdosW0DUX+PzLmQv4h3kTBA==
X-Received: by 2002:adf:bc92:: with SMTP id g18mr39950770wrh.160.1608167231933;
        Wed, 16 Dec 2020 17:07:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm5200612wrn.33.2020.12.16.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:11 -0800 (PST)
Message-Id: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:06:59 +0000
Subject: [PATCH 00/11] Drop the PREPARE_FOR_MAIN_BRANCH prereq
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I started contributing all those patch series to start preparing for
the default branch name main, I had the idea that we could change the
default branch name in time for v2.30.0, and therefore felt free to
introduce the PREPARE_FOR_MAIN_BRANCH prereq whose sole purpose was to
adjust a few tests preemptively that would then have to be skipped until the
test suite was converted to using main as default branch name.

However, this was too ambitious a plan.

The current state is therefore an undesirable one: we skip a few test cases,
in preparation for a time when git init will default to using a different
name than master for the initial branch name, and nobody realistically knows
when this will happen.

To address that, I spent some time to convert just the affected scripts to
using main, adjusting them in a way where they do not depend on the name git
init gave the initial branch at all, which allowed me to drop that prereq
altogether.

None of these changes should be controversial, intentionally so, to allow
this patch series to go in before v2.30.0 is tagged, so that we can enjoy
the full coverage of the test suite again.

Johannes Schindelin (11):
  t1400: use `main` as initial branch name
  t3200: finish transitioning to the initial branch name `main`
  t3201: finalize transitioning to using the branch name `main`
  t3203: complete the transition to using the branch name `main`
  t3205: finalize transitioning to using the branch name `main`
  t5505: finalize transitioning to using the branch name `main`
  t5510: use `main` as initial branch name
  t5703: use `main` as initial branch name
  t6302: use `main` as initial branch name
  t9902: use `main` as initial branch name
  tests: drop the `PREPARE_FOR_MAIN_BRANCH` prereq

 t/t1400-update-ref.sh              |  75 +++----
 t/t3200-branch.sh                  | 265 +++++++++++++------------
 t/t3201-branch-contains.sh         |  83 ++++----
 t/t3203-branch-output.sh           |  43 ++--
 t/t3205-branch-color.sh            |   9 +-
 t/t5505-remote.sh                  | 156 +++++++--------
 t/t5510-fetch.sh                   | 168 ++++++++--------
 t/t5703-upload-pack-ref-in-want.sh |  65 +++---
 t/t6302-for-each-ref-filter.sh     |  59 +++---
 t/t9902-completion.sh              | 309 +++++++++++++++--------------
 t/test-lib.sh                      |   8 -
 11 files changed, 621 insertions(+), 619 deletions(-)


base-commit: 1c52ecf4ba0f4f7af72775695fee653f50737c71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-816%2Fdscho%2Fdrop-prepare-for-main-branch-prereq-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-816/dscho/drop-prepare-for-main-branch-prereq-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/816
-- 
gitgitgadget
