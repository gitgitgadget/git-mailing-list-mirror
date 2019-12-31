Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A73EC2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552D3206D9
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL3sv0p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfLaKPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:15:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36627 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLaKPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 05:15:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so34922658edp.3
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y/wgw+DTkiqmppFKqDe/UkZmRH6tgBPdMChQQoNp5YE=;
        b=kL3sv0p8IDLjFHOW4Q0FdsOahVlnSidqCVlYXQx2QkFvneCz7e1MfncSLbMcCHDOZ/
         JgdZxV8Ij6jycq+QG2yy1jX7ivN5r7sKAk8YFBw9r4eIZXJ3vPMJk96IOVd4IT/33fOb
         O3Uj7fkpAZWAqyECk3PB9WFkS2/B3bi52JCXyFQki5dTd5mHk5bFiUyQT6FF+ZOIpbwx
         WOXWOBh4yDlcUMXRfPP49Z0rS4VP4psKFkFfS7iQ7bx/CV+ofaQ7jKTGZfA7GsVzRtXV
         ghU9LjRFEUwsauzcUCz1bSZ42o92o5JteeHlTeLlczZtahgx158+5wij1siH8Zm97WN6
         MjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y/wgw+DTkiqmppFKqDe/UkZmRH6tgBPdMChQQoNp5YE=;
        b=TmEBGa+e8v9bYFX92Wqm5XF88WJKluf5q0TzK/0/VYtSTKrEYO9TRbPzr1fUUbq1Lc
         oJ0WrVDtcz+P6oFDBxzew6nLjnyocMl6VM1cTfthD23Hcv5LHfvHVYn4tfjllgxcn6sC
         HYCEwh3/UWi0f1bRR8cXyNJGBTmp1O31AMU4Dxr163AZGHuWZjFZyd+dV9QLhMdI5gsy
         /YzrXGgVZ5JLP3tyxMVjK5K6swseDV2+KDFKrzmPaRxEJwUto6UnydiAOQ5jtLU7nJw6
         T7c9fTkm7Ga0KfxcWrp+27q/OIeWOoOwTYzvt6JfqynYo8ODLLDAyBbb2VRKfY5r5BcV
         uvAw==
X-Gm-Message-State: APjAAAUoTDhDdUSt5m+A/u53pYorbS4omRHtoBf/8fioekQEQAA33bFg
        XCG+VWUrEc/9arEMuZIyAoaO0qI7
X-Google-Smtp-Source: APXvYqxxdAuiyDZFHYklEoYlAPOu2Ap1o/yQ9VQNIAUy0RqnCXZ5siqktWxcBH6QgbqIOlFrza1/8Q==
X-Received: by 2002:a17:906:e249:: with SMTP id gq9mr75280304ejb.219.1577787314409;
        Tue, 31 Dec 2019 02:15:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm6015440ejq.38.2019.12.31.02.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 02:15:13 -0800 (PST)
Message-Id: <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 10:15:10 +0000
Subject: [PATCH v4 0/3] t: rework tests for --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer to commit messages for rationale.

This branch is a follow-up for [1] where part of branch was merged into `master` via [2].

Previously in [3] there were some concerns on whether removing
copy&pasted tests is good. I still think that yes, it 's a good thing,
mostly because of high volume of potential 13*6=78 duplicate tests.

Still, I separated this change as last patch, so that the remaining
part of the branch can be taken without it.

[1] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/pull.445.v4.git.1575381738.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com/

Changes since V1
----------------
Small code formatting changes suggested in V1.

Changes since V2
----------------
Changed \\\\ escaping to use here-doc instead.

Changes since V3
----------------
Slightly improved commit message.

Alexandr Miloslavskiy (3):
  t: fix quotes tests for --pathspec-from-file
  t: directly test parse_pathspec_file()
  t: drop copy&pasted tests for --pathspec-from-file

 Makefile                            |   1 +
 t/helper/test-parse-pathspec-file.c |  33 +++++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      | 108 ++++++++++++++++++++++++++++
 t/t2026-checkout-pathspec-file.sh   |  70 +-----------------
 t/t2072-restore-pathspec-file.sh    |  70 +-----------------
 t/t3704-add-pathspec-file.sh        |  70 +-----------------
 t/t7107-reset-pathspec-file.sh      |  79 +++-----------------
 t/t7526-commit-pathspec-file.sh     |  70 +-----------------
 10 files changed, 160 insertions(+), 343 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-503%2FSyntevoAlex%2F%230207(git)_2b_test_parse_directly-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-503/SyntevoAlex/#0207(git)_2b_test_parse_directly-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/503

Range-diff vs v3:

 1:  88790669ce = 1:  ce0c592bb4 t: fix quotes tests for --pathspec-from-file
 2:  68925c2712 = 2:  8748f3baf1 t: directly test parse_pathspec_file()
 3:  f71021b0dd ! 3:  d02a1eac0b t: drop copy&pasted tests for --pathspec-from-file
     @@ -3,9 +3,9 @@
          t: drop copy&pasted tests for --pathspec-from-file
      
          With direct tests for `parse_pathspec_file()` already in place, it is
     -    not very reasonable to copy&paste 6 tests for `parse_pathspec_file()`
     -    for every git command that uses it (I counted 13 commands that could use
     -    it eventually).
     +    not very reasonable to copy&paste 6 similar indirect tests for every git
     +    command that uses `parse_pathspec_file()`. I counted 13 potential git
     +    commands, which could eventually lead to 6*13=78 duplicate tests.
      
          I believe that indirect tests are redundant because I don't expect
          direct tests to ever disagree with indirect tests.

-- 
gitgitgadget
