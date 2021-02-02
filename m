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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F903C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CAF64F09
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhBBJek (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBJeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:34:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC256C061786
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:33:37 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o7so14543460pgl.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwXwEUdJxceP+6zasfQ5XnkUYLRLETVwPVwBa4dlK9Y=;
        b=ssTymicY9jhWtK6t79mSaZyTtb4WHxn5TF97iMnOOcfqg9GPY4mJdk18wvV3xhK1Qt
         0sRAa3fhQTzWqQzZ52hfcxEgYcOXcot52j4FskbcfiVvefx1Rfu78sxP/z1yUKkf3Q4u
         UvzQUlk2VjHF68zQYEP/KAFWHQrudKCNvgjK2SC8GWSL7ZP93TXcIBNqixM1D5dsp2fp
         7KJLbHLjJfE1nHdo4sL3xL/n26WA2rf2HJDvziHRsoU+s8Z+/xWh/zb7gResmEqQg9wb
         WvgkR+hxtwEIIKDvOFhP22sI90vxvxQDJmDw9+a2YGiLlsKTlTprel5/k4JqCth6fLKb
         fCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwXwEUdJxceP+6zasfQ5XnkUYLRLETVwPVwBa4dlK9Y=;
        b=oVppg54Q+J48rUtn8tSJI98qa1qGQQvV5oBvFcGPwAVgTt2xwA8YlDe4YFOunQuTQ6
         fBI+38bBN9OgMXygvTs6kuBdE640drMVFR3GSCzBheSG5T5h27Ef3gdxSO3uzW/O7543
         TZTmVH3knGvORsUdCEwRaumdRLm5IVn0zzVUszugFhkopawFidF7ANBR6wjUzzEe5W0p
         IQw7kLtgRcBjGkXpCgFsRtmM9OdxUoBVrI4mw+oW9o7yZexQiMQ+w2WMYCsAhL7FDCKl
         QzWl0mwnDpaG3IqfegHcwnWQZOXKo1+WGLSYfOnqJHI6snk8/2en3aQqHkkS6qZ4jV5H
         XZbQ==
X-Gm-Message-State: AOAM532Jx23E4ADNFijNIpyzDb7vojiswJmYdiRgt3i4clyABKzIoZV+
        +srSlueQo5+GsViSbdoI9vZq2Gg8xDU=
X-Google-Smtp-Source: ABdhPJyW6vCLufO0H21YETB6iu0Y6J3/Kse5WVray+xKgYW1fgqv7rsBlpbsWB3/HbohY69iwyKbzw==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr21312784pgh.39.1612258417271;
        Tue, 02 Feb 2021 01:33:37 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.33.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:33:29 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/9] stash show: learn --include-untracked and --only-untracked
Date:   Tue,  2 Feb 2021 01:33:17 -0800
Message-ID: <cover.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20210202093317.0W6g5NglK25FreqJFti5y1KJB4ZJ0C95y0ajusvt37A@z>

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

