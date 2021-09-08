Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97368C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7445261102
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348495AbhIHJue (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbhIHJud (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84397C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x6so2288726wrv.13
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=GYjPyFyW/fLuts8HcFBjXUUY5QgeoibwCtM3guZMyqE=;
        b=HAR5i/EVqVVswGUvH027c3lGNU/5Ver+w/yNVAxYbXkQKTLZYlf3aMTB8K0xkZAKcN
         bCDAQm32NrlE2hkt04278gd0NMa+jfAx6lYOLT0CbHThRBaTWVF5MLU5gQJqmBnaNkJj
         WvhhIvjfQd5RZzzp2kDJ/okNIY7f2zGxJMxOr/9w033xjC6at4vsAr3ix5AGtj//rYKQ
         vkmC1HNoyuaadsRq2QxBvXK5si+Att/qo7uz3CdpldCiSc/3ikE9Bh/miqj4p13mQRx6
         G4oK048ayjdgK4rZZQO9MozcdQrVWRyIWkZeJ/YGdTIzhanK/trIcR2e7jI7fna6KyAH
         E8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GYjPyFyW/fLuts8HcFBjXUUY5QgeoibwCtM3guZMyqE=;
        b=Wc3Cn+ZysRivguCTXkofBWSZXhTtE9A2U/DKwZn52V/nf4+k3UoAKXj64o0jJbAOdl
         r3wkZM8mBuYJpXxh9sNeTe9DnyY9/dAej1sJxCm0xdt8wMWBZf8sHU1pj5i69YbT7B54
         HgvriUfCNZx1m4ZP7O3AUNoCL80TJuxUZNpxxahGll6rTysu7SVwlQ+rq7Xzgi9Z/vmU
         Qm6wpwt/2ccTuZLw+YnWuSxy2jdHgYfr+pC63njoXdvqYJf82U34D3QeHJSYdmBq8bIF
         /kAo/iWPcdQAgsnb0Fe/a7BZkttkycdeJ8v7hvOSVVHS4EbUJuncM+CWgAPFhhpGDxJa
         OdWg==
X-Gm-Message-State: AOAM530/Q6aScARZbUGT3C6P/kulP89uJuYcCZ0g1QIRlnTd3/wvINCh
        OREQj6lbc9zL273QDpsOpuo7DoaUfvw=
X-Google-Smtp-Source: ABdhPJwl2JqkhS8zEagBhJ1PGJtN8TfcIUGhjsQXtSyrJYXHVKSSVC3KhhXtWzjmbeVdTn0ZFsz/XQ==
X-Received: by 2002:adf:b789:: with SMTP id s9mr2980987wre.315.1631094564104;
        Wed, 08 Sep 2021 02:49:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm1615898wrc.55.2021.09.08.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:23 -0700 (PDT)
Message-Id: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:11 +0000
Subject: [PATCH 00/11] rebase: dereference tags
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aborting a rebase stated with git rebase <upstream> <tag-object> should
checkout the commit pointed to by . Instead it gives

    error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'


The fix for that is in the last patch, the rest of the patches are cleanups
to t3407 and builtin/rebase.c

Phillip Wood (11):
  t3407: run tests in $TEST_DIRECTORY
  t3407: use test_commit
  t3407: use test_cmp_rev
  t3407: rename a variable
  t3407: use test_path_is_missing
  t3407: strengthen rebase --abort tests
  t3407: rework rebase --quit tests
  rebase: remove redundant strbuf
  rebase: use our standard error return value
  rebase: use lookup_commit_reference_by_name()
  rebase: dereference tags

 builtin/rebase.c        |  67 ++++++++++++-------------
 t/t3407-rebase-abort.sh | 105 ++++++++++++++++++----------------------
 2 files changed, 76 insertions(+), 96 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1033%2Fphillipwood%2Fwip%2Frebase-handle-tags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1033/phillipwood/wip/rebase-handle-tags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1033
-- 
gitgitgadget
