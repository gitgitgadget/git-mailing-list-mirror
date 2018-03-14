Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8771F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCNT1z (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:27:55 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46023 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNT1x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:27:53 -0400
Received: by mail-qk0-f195.google.com with SMTP id s9so4726878qke.12
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0mo00xeMXd2w1uAuHwrl+W4xB8X8JJigT1yyH/+0eI=;
        b=aGVblHizBG8+z5S8QeOwoZrVoqPgvevkbu+gqr/S/30AeqPsUK+lnurrb0nSgJ9RWj
         PN4qUqh0hXCSBCHWb9lKkUwsEMQro19Q7GCFR9mM/kzPwzUOp4Qxm8KecRqyqk9Lojca
         B0rOP3JpXww0Eu2qKh3ZX06P6DFWOsgPP0+ngyF90zS72FpExtrIzhQg4OTxyw5408TE
         sT5A6+h2c5ABkv4VKFmzjS5uPoE33vEQ5GrnQjgVrioCxpjwhfwIE0ylUrP6PQR9DH6s
         1GTOh3X0asuuNJqo0Hmf2GweivowqlyQ4ExPLKphjJJ3Z9czUAZHh8kWRbDkDJCI1nnX
         HKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0mo00xeMXd2w1uAuHwrl+W4xB8X8JJigT1yyH/+0eI=;
        b=nmCl8bq1yGhPLmgqYFLNFoe9FpreJRQD1v7MwGcPzou4/KsJY0XZWMBXbGBDTxRjZZ
         Mbk3QUFRgKrIUOyL2wfXy7RiBCnJGz18odGwMR/8C6mAbfume42q3rj7+fgN9tujOGJU
         C15RqdqO91JdFqFDFSgCFn73lg0C9eKdQTjc63jWpCJmjYa0TLRcQKlWNqV2C5M+i7e7
         YeCGzFhfb/mZjnqeAkSwOLB3rKlfI/sv0DCVSlUfqRx1irs/cburhDMYXyNSN9Uujs7m
         O+wmSRMT0/U8YBso8CZlB/nNXnF04uv10VzlHSBZ49UK2NS7U2e88K63irhcWLsWtrD6
         7RMA==
X-Gm-Message-State: AElRT7GhjwlqVqWxq5t849/cFrVdblNazd5ynVtTIHROVs18fNehLlP1
        Bxwgd6zCpbA3xQnbXt3VA4yei5n75wU=
X-Google-Smtp-Source: AG47ELvPPU4n7QrTD9YMebrePlAfoGKNN7zYuqAYVQZSLLl9D7tS9QdyOkltKBu6fb7mOsuQ/1p8Og==
X-Received: by 10.55.171.6 with SMTP id u6mr7983868qke.331.1521055671757;
        Wed, 14 Mar 2018 12:27:51 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:27:50 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 00/14] Serialized Git Commit Graph
Date:   Wed, 14 Mar 2018 15:27:22 -0400
Message-Id: <20180314192736.70602-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v6 includes feedback around csum-file.c and the rename of hashclose()
to finalize_hashfile(). These are the first two commits of the series, so
they could be pulled out independently.

The only other change since v5 is that I re-ran the performance numbers
in "commit: integrate commit graph with commit parsing".

Hopefully this version is ready to merge. I have several follow-up topics
in mind to submit soon after, including:

* Auto-generate the commit graph as the repo changes:
   i. teach git-commit-graph an "fsck" subcommand and integrate with git-fsck
  ii. teach git-repack to call git-commit-graph
* Generation numbers:
   i. teach git-commit-graph to compute generation numbers
  ii. consume generation numbers in paint_down_to_common()
* Move globals from commit-graph.c to the_repository

The three bullets (*) are relatively independent but have sub-items that
appear in priority order.

Derrick Stolee (14):
  csum-file: rename hashclose() to finalize_hashfile()
  csum-file: refactor finalize_hashfile() method
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  commit-graph: implement write_commit_graph()
  commit-graph: implement 'git-commit-graph write'
  commit-graph: implement git commit-graph read
  commit-graph: add core.commitGraph setting
  commit-graph: close under reachability
  commit: integrate commit graph with commit parsing
  commit-graph: read only from specific pack-indexes
  commit-graph: build graph from starting commits
  commit-graph: implement "--additive" option

 .gitignore                                      |   1 +
 Documentation/config.txt                        |   3 +
 Documentation/git-commit-graph.txt              |  93 +++
 Documentation/technical/commit-graph-format.txt |  98 ++++
 Documentation/technical/commit-graph.txt        | 164 ++++++
 Makefile                                        |   2 +
 alloc.c                                         |   1 +
 builtin.h                                       |   1 +
 builtin/commit-graph.c                          | 172 ++++++
 builtin/index-pack.c                            |   2 +-
 builtin/pack-objects.c                          |   6 +-
 bulk-checkin.c                                  |   4 +-
 cache.h                                         |   1 +
 command-list.txt                                |   1 +
 commit-graph.c                                  | 719 ++++++++++++++++++++++++
 commit-graph.h                                  |  47 ++
 commit.c                                        |   3 +
 commit.h                                        |   3 +
 config.c                                        |   5 +
 contrib/completion/git-completion.bash          |   2 +
 csum-file.c                                     |  10 +-
 csum-file.h                                     |   9 +-
 environment.c                                   |   1 +
 fast-import.c                                   |   2 +-
 git.c                                           |   1 +
 pack-bitmap-write.c                             |   2 +-
 pack-write.c                                    |   5 +-
 packfile.c                                      |   4 +-
 packfile.h                                      |   2 +
 t/t5318-commit-graph.sh                         | 225 ++++++++
 30 files changed, 1568 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh


base-commit: d0db9edba0050ada6f6eac68061599690d2a4333
-- 
2.14.1

