Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DC5C41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 12:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A060206F8
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 12:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/LPHgFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgJCMKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJCMKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 08:10:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F929C0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 05:10:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so3365261pfk.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2020 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7fhkjtOr7Zdb2Ad4uivIgHW/DA3xj3fH/OGWlDaI6Q=;
        b=L/LPHgFztuh/AJbWptDlOsJKJ62A2gRL47yN707wo6xp+hqORIHK5kKjlYgajRYAhL
         1Z+6aLfsxLapRzsM9eqcYCWdMGrkCsUbNBel9rOcGvMjRNi8mQ3mFJmV2XWJEAMBNPeh
         cJEAMb6Rxtn9xfaDcglNBLDs0tQXz0PRCLyGAhHjlJ87wce6jYpU2E+s6ebNh0PJE8XB
         sPXnsy73PBKKkca3x41LcVlw0VnDcm87cxspxF3p6N+T9n908xxaLh9v7EI6ZlpSeibY
         ri660VGPgwwu/AmGkKohY/bJ9qKAzMWfuA4eAEoP8fPBCWsb7Z7745XVFV1xHlnU9BsD
         UdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7fhkjtOr7Zdb2Ad4uivIgHW/DA3xj3fH/OGWlDaI6Q=;
        b=NHL6i4W8qL6s/bFJtSNocaUj1LpfVxwv+rskbjWSVwC9WaXmXKkP1yOcnLwtqdXnvS
         w9f45uf5JdHZu7X2tyBL3VTV9k5u7kQCr0YhG+X4aejdJTt4mpcoz4uvAPJXS1Ll88NJ
         0C02Wp5QUyU+fxJ9RPNRs/Er9PlCGg/BcoXQ7AJnUPuhnXtU/9rHB+ZKwm/SZQKSbAf6
         CXeTzJhjkoRxtdDVp7eAuShJzh830Im86ONTRkQ8gdpV8wcnR7YfUucYnI4HiP4tbx3H
         Ndh2EFrYwgmK5g593D03YYqtGGd1gip6kFIaoehjLvN+6BaHcJGdAsqmEL92nNJsEuob
         fEOw==
X-Gm-Message-State: AOAM532IaMUhjN1rEmTJDfPt9gXBMjF6y8+Xq0vbq+6PqqLJJ5bN745F
        lwxHHM4pm6yBJekIi2JVq1VwXxDR9cSfIg==
X-Google-Smtp-Source: ABdhPJxjXGfZL1Wgg+FhO9qjAmBR9H4BIM7uSChtvYiSJrpJ6GSgdy1yk8OB0qZKubUjw/a2YxEfyw==
X-Received: by 2002:a65:60d0:: with SMTP id r16mr6513013pgv.348.1601727052757;
        Sat, 03 Oct 2020 05:10:52 -0700 (PDT)
Received: from localhost.localdomain ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id e21sm4821652pgi.91.2020.10.03.05.10.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2020 05:10:52 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v10 0/3] push: add "--[no-]force-if-includes"
Date:   Sat,  3 Oct 2020 17:40:43 +0530
Message-Id: <20201003121046.60604-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
References: <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to "git-push" where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can be used with "--force-with-lease" with setups where
the remote-tracking refs of the repository are implicitly updated in
the background to help prevent unintended remote overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with "--force-with-lease[=<refname>[:<expect>]]" without specifying
the "<expect>" value, can cause the update that happened in-between
the checkout and forced push to be lost.

Changes since v9:
  - Remove "toggle_commit_graph()" because "in_merge_bases_many()"
    has been fixed [1].

  - Rename "reflog_commit_list" to "reflog_commit_array", and related
    comments.

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |   9 +-
 Documentation/config/push.txt   |   6 ++
 Documentation/git-push.txt      |  26 ++++-
 advice.c                        |   3 +
 advice.h                        |   2 +
 builtin/push.c                  |  27 +++++
 builtin/send-pack.c             |  11 ++
 remote-curl.c                   |  14 ++-
 remote.c                        | 184 ++++++++++++++++++++++++++++++--
 remote.h                        |  12 ++-
 send-pack.c                     |   1 +
 t/t5533-push-cas.sh             | 137 ++++++++++++++++++++++++
 transport-helper.c              |  10 ++
 transport.c                     |   8 ++
 transport.h                     |  15 ++-
 15 files changed, 447 insertions(+), 18 deletions(-)

base-commit: aed0800ca6 (Merge branch 'ds/in-merge-bases-many-optim-bug'
			 into sk/force-if-includes, 2020-10-02)

[1] https://public-inbox.org/git/pull.739.git.1601650736489.gitgitgadget@gmail.com
--
2.28.0
