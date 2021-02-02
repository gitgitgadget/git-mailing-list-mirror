Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36633C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A0264F09
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhBBJed (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhBBJeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:34:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51644C0613ED
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:33:27 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e12so2938352pls.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwXwEUdJxceP+6zasfQ5XnkUYLRLETVwPVwBa4dlK9Y=;
        b=uG2/YArYcqW8ASjDuGGGtIjwoOrkiHcklJlxY2Iw8yHmbZ+u3i/ZXlKd9LqPjiNgXT
         pyouCerPZ5WEreguWGlX3Zi8H8waad0CajZVn4D+qiC3yGUzWBsXIpxBMBK3rfDXFzTS
         e3Hs+E+oM3MqCw6K5KClqeVqKNcjaon0ORPJYvjXMUdS5ksQRjLDRGo1OmDMC+MZDcu/
         4zxKUeShz9TnJypOYX/qGDBrZBlQIVVZrfJJDkEdjoaHB8JfATPxIeJvgm6AFYeyplFx
         tPbc7FTzpqzqYDmW7k4aU+D0o7aK2Ff1PiCasDrTttaARaQmgRGHSSq5NMXhQnfcRunz
         3zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwXwEUdJxceP+6zasfQ5XnkUYLRLETVwPVwBa4dlK9Y=;
        b=svNJzkeCbeVMrISGTW4YK3qIZL45+ZhqFL6tWAkf3CZ0YVtcBBbj7W/qujlrE5VFHr
         1RW4pD4rgxvu15Hzvc+hBSi6/M+t5VQAtFxsCYTQzAZyOZmoCOUXsxsjE91Dxa7MbCGh
         hhrrdn2Mch7ezbewd9lZdX1GecRkkFTYeL8zwOk8N+n2Nru+4ZkO74x1HfnkX6jsRWdJ
         tHz92J/gEXCK37YyOdVQevQeWSqlrXZgYWz9o3WpTGSAQ1BYxM7PIwfeuNyUIClEJc3J
         2MKCTcaS9/k4QL9YoqoV1w3kCmbAk66QyUcfuEvEckbY5qQ0GFOiUZv78H/0/5eIx3wm
         SQRQ==
X-Gm-Message-State: AOAM530CCOdDnlcpniYFzQZUjodf0OXYqZUcb2Pu6uF3Q36THXB/aGyY
        6aSGmrhZf8LJPIm5bjWaOEZH28HPV5Q=
X-Google-Smtp-Source: ABdhPJxx2usKjA2IW26yshGzyTP2Gd3+r6fVImU/7jZXgds740RlsGeRGXVlmup9DI5zipibDKPyMQ==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr3363305pjb.137.1612258406648;
        Tue, 02 Feb 2021 01:33:26 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id c17sm20653064pfi.88.2021.02.02.01.32.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:32:45 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/9] stash show: learn --include-untracked and --only-untracked
Date:   Tue,  2 Feb 2021 01:31:50 -0800
Message-Id: <cover.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A blindspot that I've noticed in git is that it's not possible to
properly view a stash entry that has untracked files via `git stash
show`. Teach `git stash show --include-untracked` which should do this.
In addition, this series also teaches `--only-untracked` and the
`stash.showIncludeUntracked` config option.

The first seven patches of this series are just some clean up that I've
done prior to working (because it bothers me). The remaining two patches
should be the meat of the change.

Denton Liu (9):
  git-stash.txt: be explicit about subcommand options
  t3905: remove spaces after redirect operators
  t3905: move all commands into test cases
  t3905: remove nested git in command substitution
  t3905: replace test -s with test_file_not_empty
  t3905: use test_cmp() to check file contents
  stash: declare ref_stash as an array
  stash show: teach --include-tracked and --only-untracked
  stash show: learn stash.showIncludeUntracked

 Documentation/config/stash.txt         |   5 +
 Documentation/git-stash.txt            |  22 +-
 builtin/stash.c                        |  30 ++-
 contrib/completion/git-completion.bash |   2 +-
 t/t3905-stash-include-untracked.sh     | 278 +++++++++++++++++--------
 5 files changed, 235 insertions(+), 102 deletions(-)

-- 
2.30.0.478.g8a0d178c01

