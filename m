Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B0FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiCUXLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiCUXJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F235F83A
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d7so22650430wrb.7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUhLyasL8NFSmwQ5DZZueKAovufe84tqBvXVpKEc9LM=;
        b=qvyfvE620JZ28UkKCNmPMmExWzmxp5r8H0hsGDD3QKeStEuYLr3eR+9lw1HFG7yrCy
         FHvqoMUx+ZjDbkZyR6k/Zy22ZSW2EW/qmek3VXDuklB/1yZ7pgsrI9ZkD9KuUXis+dgQ
         0Z1ukBOo2uTFZbNGg2DKP/6Q6RDWbvB9/Bqhlll6gR4WHIPQbam4Z2MvbTQBzb1m6aOz
         rqP9t7Y4xlIa9U1BltjCBNwFfs1fjIm9AD0fPOjrMyLltHQcSGm+Yq/jZFCrdkeWysod
         0d7d8oJVIOWPvrDuouA4bK/MB4iE/c14EYbcPjkGF8FWCzKisLhw1gvMlNWU5K/ksXgu
         wTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUhLyasL8NFSmwQ5DZZueKAovufe84tqBvXVpKEc9LM=;
        b=oyrwSGN37xrymCvDfMp1bt5T+D7affDMWlr4aJIZZQgUj3HOzQNm8qwUYpaXInxMZr
         3qIp2iRCwDIerwRgfW19ST6SQWCVjE2TVxO8NOnbb2iFQZeAK4lklsCXSRA+Jol+O3Lp
         Gvkq64pJBgG7shV0kVxys/o8Wg1WoT4FsBHLue2Jehr46zzFIaDcbZAIvtsZz2ZQ/PlQ
         AvjzqQIG74JVxLhEsVkoSY62e8EiXrCS45ucMBTUYoK7QliIvy7xv9KX2km4GPqBaBgo
         bMFtnIhPgLYlvJLA0UOzSDrckujrpgNOc/np2EX3NWbm6WuY9GhbcMMbg8vy3E9XJRJH
         0gzg==
X-Gm-Message-State: AOAM531xk/bY9FdYtfzkjlrVKWP7zVwVHV3YbBxHT2utFX5lf8aDWi9M
        dUyUUdbJs2+VZbhymOsE1TCo2RNgHz8=
X-Google-Smtp-Source: ABdhPJzDlebNBtn2Uh173HYzA5kFVq027GPf6GGFbEdRdtZOCuExT1vytTjIkUBAIMuc1ErPJpkK6g==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr19772789wrn.231.1647903341381;
        Mon, 21 Mar 2022 15:55:41 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:40 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:42 +0000
Message-Id: <20220321225523.724509-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

EXIT_SUCCESS or EXIT_FAILURE are already used in some functions in git but
not everywhere. Also in branch.c there is a returns exit(-1), ie 255, when
exit(1) might be more appropriate.

T$his patch series adds a coccinelle semantic patch exit.cocci in
contrib/coccinelle to rewrite:
- exit(0) in exit(EXIT_SUCCESS)
- exit(1) in exit(EXIT_FAILURE)
- exit(-1) in exit(EXIT_FAILURE)

The patch treats the status code in _exit equivalently.



Elia Pinto (41):
  archive.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  am.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  blame.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  commit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  credential-cache--daemon.c: use the stdlib EXIT_SUCCESS or
    EXIT_FAILURE exit status
  help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  init-db.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  mailsplit.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  merge-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  merge.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  pull.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  rebase.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  remote-ext.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  rev-parse.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  rm.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  shortlog.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  show-branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  stash.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  tag.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  unpack-objects.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
    status
  update-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
    status
  obstack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  git-credential-osxkeychain.c: use the stdlib EXIT_SUCCESS or
    EXIT_FAILURE exit status
  git-credential-wincred.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE
    exit status
  daemon.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  git.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  http-backend.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
    status
  parse-options.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
    status
  path.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  remote-curl.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  run-command.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  setup.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  shell.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  test-json-writer.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
    status
  test-reach.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  test-submodule-config.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE
    exit status
  test-submodule-nested-repo-config.c: use the stdlib EXIT_SUCCESS or
    EXIT_FAILURE exit status
  upload-pack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
  exit.cocci: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status

 archive.c                                     |  2 +-
 branch.c                                      |  4 ++--
 builtin/am.c                                  |  4 ++--
 builtin/blame.c                               |  2 +-
 builtin/commit.c                              | 10 ++++----
 builtin/credential-cache--daemon.c            |  2 +-
 builtin/help.c                                |  2 +-
 builtin/init-db.c                             |  2 +-
 builtin/mailsplit.c                           |  2 +-
 builtin/merge-index.c                         |  2 +-
 builtin/merge.c                               |  4 ++--
 builtin/pull.c                                |  2 +-
 builtin/rebase.c                              | 12 +++++-----
 builtin/remote-ext.c                          |  2 +-
 builtin/rev-parse.c                           |  2 +-
 builtin/rm.c                                  |  2 +-
 builtin/shortlog.c                            |  2 +-
 builtin/show-branch.c                         |  4 ++--
 builtin/stash.c                               |  2 +-
 builtin/tag.c                                 |  2 +-
 builtin/unpack-objects.c                      |  6 ++---
 builtin/update-index.c                        |  4 ++--
 compat/obstack.c                              |  2 +-
 contrib/coccinelle/exit.cocci                 | 24 +++++++++++++++++++
 .../osxkeychain/git-credential-osxkeychain.c  |  4 ++--
 .../wincred/git-credential-wincred.c          |  2 +-
 daemon.c                                      |  2 +-
 git.c                                         | 14 +++++------
 help.c                                        |  8 +++----
 http-backend.c                                | 12 +++++-----
 parse-options.c                               |  2 +-
 path.c                                        |  2 +-
 remote-curl.c                                 |  2 +-
 run-command.c                                 |  2 +-
 setup.c                                       |  2 +-
 shell.c                                       |  2 +-
 t/helper/test-json-writer.c                   |  2 +-
 t/helper/test-reach.c                         |  2 +-
 t/helper/test-submodule-config.c              |  2 +-
 t/helper/test-submodule-nested-repo-config.c  |  2 +-
 upload-pack.c                                 |  2 +-
 41 files changed, 95 insertions(+), 71 deletions(-)
 create mode 100644 contrib/coccinelle/exit.cocci

-- 
2.35.1

