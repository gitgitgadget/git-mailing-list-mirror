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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7DC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D1B64FD0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhCJToH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhCJTnn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:43:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B9C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:43:43 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o10so12085645pgg.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmLS39q+2JCJcOWs1rdaDIf8vZEou8KrGO5TsWEVm7w=;
        b=WvROorA6bGmQFKk4sCcY6TzauI0fmAh00mnAOY5D0RQyrzF2e8W3kBWEoLUo2gWWvk
         C6YHGdSdcUnWwukTzBNv1bmTaPxz2PlG2vPs9WbC+HVezq023Cu8Y+o07en5qNMzuAgJ
         pj12paFc3SuIUWKDNx5eIBuz+s6K8wbNLVOmsQ1SaIp/0+qpPT+weyRArk7C5dWE1I/b
         8/g9TETT0YDLKD0bIrg2Tid/OsQzw3AXyyWb51nX9+wsd91tSENL5J+s5WaS6ntOvZbT
         w8NbWmmmuP8mr2FZLnq5QYHAMY4IqbKgxI0VF1kvoI7oGWGuQD6Tyn7dimOZnvWhjami
         rNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmLS39q+2JCJcOWs1rdaDIf8vZEou8KrGO5TsWEVm7w=;
        b=q2xwY4l3pChl9ioQM5oe72W/YWzmJPcPKMGd0J79gfo2Aupv2AkyRqD48MTufOMzBy
         ZUyjkULC/uY2e5LLeqYjjV08N9yAVx3Afeqg+rDvKoguFW8b0YzRjBK3rck++hpAWTyV
         VXEcOidEgRJdxz57j3WVr4nhkzT1vwhmBo2W+XFnzYoAmw1gPzP5xs5lh/eEOCdIPEZP
         PT92K3WWRYFA1bVv/EcjoL/qUe31uK9Xh2qNtxhMEKmtsGNpqibyqeIJk28+jstiZ48V
         u/eBzYqsraPWU/nx3dBCtENMizlXRFLEuepV3b/lGBhWB10Wy8woPj3u74QvUSHHiZO/
         76Yw==
X-Gm-Message-State: AOAM532EugSSvwZN5/0VpnGFEIAmSWdBvDskZANlGvTRl8j0mcgRe3TT
        YA/8XnAbx2dqnd7oiW0o6QwUCb904m+uBA==
X-Google-Smtp-Source: ABdhPJwcdrew5Y9kmzeXdz1fCOwiZFHfHziZoQyGEvh4sqgcOn/JILPB7APt1+/bejuRwIZjcSFcpA==
X-Received: by 2002:a63:4a44:: with SMTP id j4mr4067703pgl.199.1615405423100;
        Wed, 10 Mar 2021 11:43:43 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:43:42 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 0/6][Outreachy] commit: Implementation of "amend!" commit
Date:   Thu, 11 Mar 2021 01:13:01 +0530
Message-Id: <20210310194306.32565-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches `git commit --fixup` to create "amend!" commit
as an alternative that works with `git rebase --autosquash`. It allows to
fixup both the content and the commit message of the specified commit.
Here we add two suboptions to the `--fixup`, first `amend` suboption that
creates an "amend!" commit. It takes the staged changes and also allows to
edit the commit message of the commit we are fixing.
Example usuage:
git commit --fixup=amend:<commit>

Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
ignores the staged changes and only allows to reword/edit the commit message
of the commit we are fixing. `--fixup=reword:<commit>` is a short-hand of
`--fixup=amend:<commit> --only`.
Example usuage:
git commit --fixup=reword:<commit>

** This work is rebased on the top of cm/rebase-i-updates.

Changes from v3 :
(Thanks to Junio C Hamano and Eric Sunshine for the reviews and suggesting the
improvements required in the previous patches )

* Now `--fixup=reword:` aliases `--fixup=amend: --only`. Added the respective
test and updated documentation.
* Modified prepared_amend_commit() in commit.c.
* Renamed the subject_length() to commit_subject_length() [v3 - 1/6]
* Modified the --fixup=[amend|reword] documentation
* Also, updated the commit messages and some other minor cleanup.

Charvi Mendiratta (6):
  sequencer: export and rename subject_length()
  commit: add amend suboption to --fixup to create amend! commit
  commit: add a reword suboption to --fixup
  t7500: add tests for --fixup=[amend|reword] options
  t3437: use --fixup with options to create amend! commit
  doc/git-commit: add documentation for fixup=[amend|reword] options

 Documentation/git-commit.txt              |  40 ++++++-
 Documentation/git-rebase.txt              |  21 ++--
 builtin/commit.c                          | 118 +++++++++++++++++--
 commit.c                                  |  14 +++
 commit.h                                  |   3 +
 sequencer.c                               |  16 +--
 t/t3437-rebase-fixup-options.sh           |  30 +----
 t/t7500-commit-template-squash-signoff.sh | 135 ++++++++++++++++++++++
 8 files changed, 309 insertions(+), 68 deletions(-)

--
2.29.0.rc1

