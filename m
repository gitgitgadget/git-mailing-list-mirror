Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FEFC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31ADB61360
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhDVKBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhDVKBk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 06:01:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CFC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y1so7615683plg.11
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qYqemX9OsxEhV4longx0wfm1TJZ/R+5GGfP9mUhezw=;
        b=OLSoJY+gFAXcPBzOED+8xhu+q8eQuUJhxiVoa78QBbMbTUzRHgyQVLEam8bKmwIwDe
         tQrCv9HEh8WsE2qSUzJSMnw2ibr/LiGG23xvXYGL66KZa3kzEei/DztTVwabl2fHzTvT
         c2s8b5Zm1IZcLIaLHQk+tEuu6rZ3tEJgMZp4HXh8jB9WI6LfKH5KB3hL9hKdP8U7/QW4
         XZbWh7Btt++D+TTAyTdrFUj2xBlFqWv3c+r46nsVrLdayRzQ+JPJGJVCSXLkdRE1sbVx
         p9zD0IsuGv4/mEMrUOeahs5thQkTpNX2WG8Tcw37oIMKERGcLHaWgQYKv6X8xm2Slyep
         Hv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qYqemX9OsxEhV4longx0wfm1TJZ/R+5GGfP9mUhezw=;
        b=WgJ/nlV0FZH6G35kND/8o09vVQaHlNYgEUnHMhESPyCyCY/R8IMaxUS0tJDjAntFJT
         yoFMYvAZ3ojyFzQCcICTNWUeT5ZcSSld+v0cFeGcHAHBzO3M2ElC4GGCOjhODaspbjV1
         9ybLxJ7KyKSYmfIu8BF9aDwy9PaImlQzuoXLRMPjsaqvg+H7RKn69Nc1V88XANJF1VTf
         FbaMcVFSIw41w1wM9wsYim/iuAhyJFMnNQERSpsWAn4DgvMP2gXfH36CNu3xrHLNXKLq
         MYM2XpwDEfXdIjtta2YtbpGG2sdQ9nL7aGfZQ/iIKrIbnvX5iTcFBAvCthE1G/XbXxVf
         FpXA==
X-Gm-Message-State: AOAM532rpvotb0SgrsDtnI+vPNSJa7Mf17wZH4yttGE/Bl5QbtmneC+X
        sqhwKc5B76gvbyyKqhvLDJt+jgHDFQc=
X-Google-Smtp-Source: ABdhPJwxBiq/fKNCEqHI6EsQtgJDMyeAN/4jvaBg5yG5EzDRTK8R1eyyiFF7FZ0s5TEkKZRnAeB8zQ==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr3159199pjb.23.1619085663465;
        Thu, 22 Apr 2021 03:01:03 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id r3sm1741314pfl.159.2021.04.22.03.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:01:02 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] git-completion.bash: fixes on top of 'dl/complete-stash'
Date:   Thu, 22 Apr 2021 03:00:48 -0700
Message-Id: <cover.1619085387.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.499.g90b4fd31cd
In-Reply-To: <cover.1618910364.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gábor pointed out some potential fixes what's currently queued in
'dl/complete-stash'[0][1][2][3]. This series addresses those concerns.

Changes since v1:

* Make the commit message for "git-completion.bash: rename to
  $__git_cmd_idx" descriptive and accurate

* Drop "git-completion.bash: consolidate no-subcommand case for
  _git_stash()"

[0]: https://lore.kernel.org/git/20210327183554.GD2271@szeder.dev/
[1]: https://lore.kernel.org/git/20210328103134.GF2271@szeder.dev/
[2]: https://lore.kernel.org/git/20210328103057.GE2271@szeder.dev/
[3]: https://lore.kernel.org/git/20210328110427.GG2271@szeder.dev/

Denton Liu (4):
  git-completion.bash: separate some commands onto their own line
  git-completion.bash: rename to $__git_cmd_idx
  git-completion.bash: use $__git_cmd_idx in more places
  git-completion.bash: consolidate cases in _git_stash()

 contrib/completion/git-completion.bash | 98 ++++++++++++++------------
 t/t9902-completion.sh                  | 19 +++++
 2 files changed, 70 insertions(+), 47 deletions(-)

Range-diff against v1:
1:  65c485ea0c = 1:  65c485ea0c git-completion.bash: separate some commands onto their own line
2:  7c7d6de380 ! 2:  76328e3123 git-completion.bash: rename to $__git_cmd_idx
    @@ Commit message
     
         In e94fb44042 (git-completion.bash: pass $__git_subcommand_idx from
         __git_main(), 2021-03-24), the $__git_subcommand_idx variable was
    -    introduced. Naming it after the index of the subcommand is flat-out
    -    wrong as this variable really holds the index of the git comand (e.g.
    -    "stash").
    +    introduced. Naming it after the index of the subcommand is needlessly
    +    confusing as, when this variable is used, it is in the completion
    +    functions for commands (e.g. _git_remote()) where for `git remote add`,
    +    the `remote` is referred to as the command and `add` is referred to as
    +    the subcommand.
     
         Rename this variable so that it's obvious it's about git commands. While
         we're at it, shorten up its name so that it's still readable without
3:  63a6992585 = 3:  70fda62db1 git-completion.bash: use $__git_cmd_idx in more places
4:  4f8d015d54 = 4:  103d38e293 git-completion.bash: consolidate cases in _git_stash()
5:  b4a9b0afa7 < -:  ---------- git-completion.bash: consolidate no-subcommand case for _git_stash()
-- 
2.31.1.499.g90b4fd31cd

