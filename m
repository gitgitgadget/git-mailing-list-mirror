Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD10C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBFXIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBFXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:15 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C685FDE
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mf7so38747662ejc.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSeAb1C9v6snDrj1a0sBuunztE7Eb9a3UW1IGOMF3jY=;
        b=qgFbCH/GIYvkgluHdUr0A81OuPfZe/DI95EUEWgOTHkxnMSwgx+j1b9ZaV2H5UvQjI
         M3+DKylRIEs4lmHhbEAmNI6ST11O8aVHtR9Ye3cGVh6+kgtZ6c4F56unI+4RnAXTs8m8
         l8kJIsdFG59LzXFSJFqDOmzMMU0QU1WcioIrlwguNLlIzJWo/l/2kSUtHMAM7i7VZUuS
         lR2Bci7EKSfSitKqXrf1UgAU3wwUCIK8Ue8DL7h2OU9d4M+PGxcO3x9qu8W2ChUyiiUi
         WqvZWZrX4aBBCLhr3lO9abekjMT2pYrVcyjbPH8KjS/YpZEEMcNFrPVadZv6ulWIkkkk
         q9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSeAb1C9v6snDrj1a0sBuunztE7Eb9a3UW1IGOMF3jY=;
        b=gBAY8V/r2VQoMtOEsgaq6wV8TPLZr1dQxqne9iutvu+zpDqj764vWRNeDPiyE7UsuA
         MfT65UHaTowJ44LRxLlPf2+kckLtFMtQq8bvLRsTHIwexw2FrSh4kXhccDRTsT8Yr7Ih
         RWSIoopSWgw+KsTn30YrLF4ChQ1HsIpVl9umiYgFtm+bwU3pmgkDIVcM4dBp68+dkWVJ
         37zmyPH/p9RY7Rx+AC3HtSv+wmscF94CKR6nx5GS4IbfOXHxOHktWVmrE3HrssYw76ka
         oLPPeyF5kOvqmcjoRUGBava9lSMMM2bsqZ/WSCjw8EOrAHbqjESmlNLf2WZxaeEZChLc
         fPig==
X-Gm-Message-State: AO0yUKVomuSICUWx57b7GDR2Wy2ivSNeYeGgV/Z8wo4t1bVa6Ud1UxM+
        F7QJ3Z2K+9kJ8aG8KZqApRtuSDkrMoyEUzA0
X-Google-Smtp-Source: AK7set87w6tfeXgbfkovMKFkyFNcac8wSqj+TSeFAEzwM4tj28i9pVX3L17RvodmTf8XA21KllEvLQ==
X-Received: by 2002:a17:906:a102:b0:878:5e84:e1da with SMTP id t2-20020a170906a10200b008785e84e1damr1122047ejy.27.1675724888522;
        Mon, 06 Feb 2023 15:08:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 00/19] leak fixes: various simple leak fixes
Date:   Tue,  7 Feb 2023 00:07:35 +0100
Message-Id: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
https://lore.kernel.org/git/cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com/#t
for the v6. Changes since then:

* Corrected the 17/19 commit message to note that it free()'s an
  entire allocated struct, not just its "flex" member.

* Per my replies on 18/19 and 19/19 in v6 I think those commit
  messages are correct as-is, so sending this in in case Junio's OK
  with picking up this version.

CI & branch for this at:
https://lore.kernel.org/git/cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (19):
  tests: mark tests as passing with SANITIZE=leak
  bundle.c: don't leak the "args" in the "struct child_process"
  commit-graph: use free_commit_graph() instead of UNLEAK()
  clone: use free() instead of UNLEAK()
  various: add missing clear_pathspec(), fix leaks
  name-rev: don't xstrdup() an already dup'd string
  repack: fix leaks on error with "goto cleanup"
  worktree: fix a trivial leak in prune_worktrees()
  http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
  http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
  commit-graph: fix a parse_options_concat() leak
  show-branch: free() allocated "head" before return
  builtin/merge.c: use fixed strings, not "strbuf", fix leak
  builtin/merge.c: free "&buf" on "Your local changes..." error
  grep.c: refactor free_grep_patterns()
  grep API: plug memory leaks by freeing "header_list"
  receive-pack: release the linked "struct command *" list
  push: refactor refspec_append_mapped() for subsequent leak-fix
  push: free_refs() the "local_refs" in set_refspecs()

 archive.c                                  |  1 +
 builtin/clean.c                            |  1 +
 builtin/clone.c                            |  5 ++--
 builtin/commit-graph.c                     | 10 +++++---
 builtin/merge.c                            | 14 +++++-----
 builtin/name-rev.c                         | 23 ++++++++---------
 builtin/push.c                             | 30 +++++++++++++---------
 builtin/receive-pack.c                     | 11 ++++++++
 builtin/repack.c                           | 13 +++++-----
 builtin/reset.c                            | 11 +++++---
 builtin/show-branch.c                      |  1 +
 builtin/stash.c                            |  7 +++--
 builtin/worktree.c                         |  6 ++---
 bundle.c                                   |  6 +++--
 grep.c                                     | 15 +++++++----
 http-backend.c                             |  9 +++++--
 t/t0023-crlf-am.sh                         |  1 +
 t/t1301-shared-repo.sh                     |  1 +
 t/t1302-repo-version.sh                    |  1 +
 t/t1304-default-acl.sh                     |  1 +
 t/t1408-packed-refs.sh                     |  1 +
 t/t1410-reflog.sh                          |  1 +
 t/t1416-ref-transaction-hooks.sh           |  1 +
 t/t1451-fsck-buffer.sh                     |  2 ++
 t/t2401-worktree-prune.sh                  |  1 +
 t/t2402-worktree-list.sh                   |  1 +
 t/t2406-worktree-repair.sh                 |  1 +
 t/t3210-pack-refs.sh                       |  1 +
 t/t3800-mktag.sh                           |  1 +
 t/t4152-am-subjects.sh                     |  2 ++
 t/t4254-am-corrupt.sh                      |  2 ++
 t/t4256-am-format-flowed.sh                |  1 +
 t/t4257-am-interactive.sh                  |  2 ++
 t/t5001-archive-attr.sh                    |  1 +
 t/t5004-archive-corner-cases.sh            |  2 ++
 t/t5302-pack-index.sh                      |  2 ++
 t/t5306-pack-nobase.sh                     |  2 ++
 t/t5312-prune-corruption.sh                |  1 +
 t/t5317-pack-objects-filter-objects.sh     |  1 +
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  1 +
 t/t5403-post-checkout-hook.sh              |  1 +
 t/t5405-send-pack-rewind.sh                |  1 +
 t/t5406-remote-rejects.sh                  |  1 +
 t/t5502-quickfetch.sh                      |  1 +
 t/t5504-fetch-receive-strict.sh            |  1 +
 t/t5507-remote-environment.sh              |  2 ++
 t/t5522-pull-symlink.sh                    |  1 +
 t/t5523-push-upstream.sh                   |  1 +
 t/t5527-fetch-odd-refs.sh                  |  1 +
 t/t5529-push-errors.sh                     |  2 ++
 t/t5546-receive-limits.sh                  |  2 ++
 t/t5547-push-quarantine.sh                 |  2 ++
 t/t5560-http-backend-noserver.sh           |  1 +
 t/t5561-http-backend.sh                    |  1 +
 t/t5562-http-backend-content-length.sh     |  2 ++
 t/t5573-pull-verify-signatures.sh          |  2 ++
 t/t5604-clone-reference.sh                 |  1 +
 t/t5606-clone-options.sh                   |  1 +
 t/t5613-info-alternate.sh                  |  2 ++
 t/t5705-session-id-in-capabilities.sh      |  1 +
 t/t5810-proto-disable-local.sh             |  2 ++
 t/t5813-proto-disable-ssh.sh               |  2 ++
 t/t6011-rev-list-with-bad-commit.sh        |  1 +
 t/t6014-rev-list-all.sh                    |  1 +
 t/t6021-rev-list-exclude-hidden.sh         |  1 +
 t/t6439-merge-co-error-msgs.sh             |  1 +
 t/t6501-freshen-objects.sh                 |  1 +
 t/t7105-reset-patch.sh                     |  2 ++
 t/t7106-reset-unborn-branch.sh             |  2 ++
 t/t7107-reset-pathspec-file.sh             |  1 +
 t/t7301-clean-interactive.sh               |  1 +
 t/t7403-submodule-sync.sh                  |  1 +
 t/t7409-submodule-detached-work-tree.sh    |  1 +
 t/t7416-submodule-dash-url.sh              |  2 ++
 t/t7450-bad-git-dotfiles.sh                |  2 ++
 t/t7612-merge-verify-signatures.sh         |  1 +
 t/t7701-repack-unpack-unreachable.sh       |  1 +
 77 files changed, 182 insertions(+), 62 deletions(-)

Range-diff against v6:
 1:  36da48d4db9 =  1:  ab180d78c7b tests: mark tests as passing with SANITIZE=leak
 2:  f0f1a388350 =  2:  496bc2c46ce bundle.c: don't leak the "args" in the "struct child_process"
 3:  cf0dddf4e8c =  3:  ea9ee63b37a commit-graph: use free_commit_graph() instead of UNLEAK()
 4:  0430c1fec1b =  4:  56f9227c552 clone: use free() instead of UNLEAK()
 5:  fb2d9875c73 =  5:  2b5dc52039b various: add missing clear_pathspec(), fix leaks
 6:  bca659788de =  6:  67b8606c529 name-rev: don't xstrdup() an already dup'd string
 7:  09950d92940 =  7:  95db54d24b0 repack: fix leaks on error with "goto cleanup"
 8:  cd3eb9e68ff =  8:  81d97d03f42 worktree: fix a trivial leak in prune_worktrees()
 9:  e80a719913b =  9:  e657992ad14 http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
10:  9d9df0caf17 = 10:  1d8088dec84 http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
11:  65e25377791 = 11:  badf54d5240 commit-graph: fix a parse_options_concat() leak
12:  3b1d47b9d62 = 12:  b8536257029 show-branch: free() allocated "head" before return
13:  a85e5f3b14e = 13:  b33d61deaf9 builtin/merge.c: use fixed strings, not "strbuf", fix leak
14:  7dbc422d5b4 = 14:  c1223aad2ae builtin/merge.c: free "&buf" on "Your local changes..." error
15:  aa51668b70d = 15:  e2bf3245dd0 grep.c: refactor free_grep_patterns()
16:  0c51ea7fd2d = 16:  2aea4017491 grep API: plug memory leaks by freeing "header_list"
17:  4b2db91f5cb ! 17:  b02ece0d36b receive-pack: free() the "ref_name" in "struct command"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    receive-pack: free() the "ref_name" in "struct command"
    +    receive-pack: release the linked "struct command *" list
     
         Fix a memory leak that's been with us since this code was introduced
    -    in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29). See
    -    eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
    -    2005-06-29) for the later change that refactored the code to add the
    -    "ref_name" member.
    +    in [1]. Later in [2] we started using FLEX_ALLOC_MEM() to allocate the
    +    "struct command *".
    +
    +    1. 575f497456e (Add first cut at "git-receive-pack", 2005-06-29)
    +    2. eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
    +       2005-06-29)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/receive-pack.c: static struct command **queue_command(struct command **t
     +{
     +	while (commands) {
     +		struct command *next = commands->next;
    ++
     +		free(commands);
     +		commands = next;
     +	}
18:  aa33f7e05c8 = 18:  d28b710c0ba push: refactor refspec_append_mapped() for subsequent leak-fix
19:  67076dfba6d = 19:  ba8e5496d96 push: free_refs() the "local_refs" in set_refspecs()
-- 
2.39.1.1425.gac85d95d48c

