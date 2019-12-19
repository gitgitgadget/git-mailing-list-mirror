Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBFBC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F640206EC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPz5XxSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLSPJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:33 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38940 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:33 -0500
Received: by mail-ed1-f54.google.com with SMTP id t17so5186637eds.6
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqWVIJiIk91twvPGuJ/UqHUfwBliGfkxJPeKiC8vQ/w=;
        b=bPz5XxSrj4o0h9ITZa34wWUf7Rtk2VjfiW6Izk/gIMes2Bbe1maHefp/CApKC3saSw
         r57pCP9RqvALvczoqfTlgTX3nEiI8tw33sDuqxC37QCPIJy3KnXyNBW1Cu4htKgahfj7
         PbPynH0Hu910aiHsnTzX23VdaL6DrjB7c4QZNcrQbCwTByzIsxypQESOPW+BVQSQwyE7
         vdH2VmQC/CKawtv2KbTMUfV7SdTO9NBpzepaCn/5xn/ZmFIbYhdMsY0704tG8lhHd7Dz
         qo2P05ZtnBLnYiYaV8QIS2gneLpLm7c84HGrLjmEx5cqcw4RG3lisTBEJParO/NHDyHv
         n70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqWVIJiIk91twvPGuJ/UqHUfwBliGfkxJPeKiC8vQ/w=;
        b=b6Fxh8p/DRKUn4JNA61JSz+hblRjCHXu/BbSbs244rpY+oVkBAVsQ8V4AApRKXrJLH
         QE+FncN8oFHTrXCkfY6j+SDAgZsFyKlV9xrewh7VSz8rBhrFaNSh47m8kzVyQfk6u2ta
         9QZ0OlJHC3KfwakcMURLEqODUU8SbZmKcoP/atHj8uBVumu0y8cVzJntKN8Nrrmblms3
         MMnY645xzWo0TkMPkjxI/ZFyBPMvQGzlxQTVfjs/F+AExBte1MLUTKLPtzB+lyAf4aWY
         j3NQ9xZjX95grL6VqAc4UwEzvurbkRowbTNqe5R7SpehuYkxcIkefFFrejCCKPCIGhHT
         oqPQ==
X-Gm-Message-State: APjAAAXUatnUa2L5lsO8fLBVXYBVGF6XP/LtV2dikQZo9YVtrOFt4zKN
        jVbPBo/lrL/pjsBL5cv6CU8=
X-Google-Smtp-Source: APXvYqxuQkhMFjis0t9N6C04RuFIyib3u6I9DrV3WbiFU3e0on3P1p+UJm46W2kmIEvZFcCw8Geyeg==
X-Received: by 2002:a05:6402:64a:: with SMTP id u10mr9926462edx.147.1576768170953;
        Thu, 19 Dec 2019 07:09:30 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/6] completion: improve completion for 'git worktree'
Date:   Thu, 19 Dec 2019 16:09:15 +0100
Message-Id: <20191219150921.5889-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.1.982.ga4d4aba446
In-Reply-To: <20191017173501.3198-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complete paths of working trees and refs for 'git worktree's various
subcommands.

The last two patches do the actual improvements, the first four are
preparatory steps.

Changes since v1:

  - Added an in-code comment and clarified the commit message of patch
    5/6.

v1: https://public-inbox.org/git/20191017173501.3198-1-szeder.dev@gmail.com/T/#u

SZEDER Gábor (6):
  t9902-completion: add tests for the __git_find_on_cmdline() helper
  completion: clean up the __git_find_on_cmdline() helper function
  completion: return the index of found word from
    __git_find_on_cmdline()
  completion: simplify completing 'git worktree' subcommands and options
  completion: list existing working trees for 'git worktree' subcommands
  completion: list paths and refs for 'git worktree add'

 contrib/completion/git-completion.bash | 119 +++++++++++++++++++------
 t/t9902-completion.sh                  |  57 ++++++++++++
 2 files changed, 150 insertions(+), 26 deletions(-)

Range-diff against v1:
1:  bd68b0b64b = 1:  b370a97edc t9902-completion: add tests for the __git_find_on_cmdline() helper
2:  b5c0312db6 = 2:  fb8f1e4840 completion: clean up the __git_find_on_cmdline() helper function
3:  6999b0b8e2 = 3:  47aecb9ac0 completion: return the index of found word from __git_find_on_cmdline()
4:  dd38374f2f = 4:  00c5a0f7df completion: simplify completing 'git worktree' subcommands and options
5:  619ff7021c ! 5:  2e4b1b3931 completion: list existing working trees for 'git worktree' subcommands
    @@ Commit message
         Never list the path of the main working tree, as it cannot be moved,
         removed, locked, or unlocked.
     
    -    Arguably 'git worktree unlock <TAB>' should only complete locked
    -    working trees, but 'git worktree list --porcelain' doesn't indicate
    -    which working trees are locked.  So for now it will complete the paths
    -    of all existing working trees, including non-locked ones as well.
    +    Ideally we would only list unlocked working trees for the 'move',
    +    'remove', and 'lock' subcommands, and only locked ones for 'unlock'.
    +    Alas, 'git worktree list --porcelain' doesn't indicate which working
    +    trees are locked, so for now we'll complete the paths of all existing
    +    working trees.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
    @@ contrib/completion/git-completion.bash: _git_whatchanged ()
     +{
     +	local IFS=$'\n'
     +	__gitcomp_nl "$(git worktree list --porcelain |
    ++		# Skip the first entry: it's the path of the main worktree,
    ++		# which can't be moved, removed, locked, etc.
     +		sed -n -e '2,$ s/^worktree //p')"
     +}
     +
6:  29a32e5d36 = 6:  16a9b5f4b2 completion: list paths and refs for 'git worktree add'
-- 
2.24.1.982.ga4d4aba446

