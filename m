Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7E71F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfI3VKY (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42506 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732486AbfI3VKX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so6286149pff.9
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLNgpM2Tyf9XkFJ4iXgXLl5f1hjiJoiUQtC08TzuYxw=;
        b=UgvbVepTXJwawBL0rVhSgAaHp0jq/cntMWLGucwlYLES9bHYnYc56UqSPzQztOpQ77
         7SAnL4uHz73w/b7njgTeyAvSvWkQasqzUG89s3uoun3y2LHHoHXQKWKKevp+coLk7rBx
         zQwqBd64vskAfaMAOA+qmaObz0LSFkLdZBnZF++vph5DJjV/M6QZDUyGxLhCLHt/RnKs
         dyaUd53s3YFdGJWIbxkR8beU9QRlngPtnrSDEVBB+Vy8+rCGMQh6wwenwupmkwCXACtS
         cYD6oodJM2kTGqS7U0IbcLWy+IH3engvT5RtkSzHduw6sCEVkX1QWZgCNKLXQYoDMGRy
         An9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLNgpM2Tyf9XkFJ4iXgXLl5f1hjiJoiUQtC08TzuYxw=;
        b=i7NDhmrfDjG/HpYh2sDgkozgSwD0Ccsgh+MmdXADZOwP5OFo8xrLoQHzZnryFX8L50
         g9ocFyzYxL4awogGSctKGbKK1/mE3bYiXRqzkoNY/fsQTLmB9eCTCToPldCO5VI/nOZq
         r0eWW+8oG+E65FKipX1C8QGVctX2mviybRTO6HPCHd+l4ZkKPTyfqaoHlvbYHElEt+hQ
         LlioNgfmqGTSdQjsrYJ3MYrjT0+7APtKJBJsoGg5M5siuDOlGCj7DDMyBoNDtSpZn8DZ
         gCpOl2dXNcUvd8l4j2IYbYQ6MgQyptdcRcBW4+YNJOtN8NZc0yPVLPPa26xC0kvIJCU7
         4Xtw==
X-Gm-Message-State: APjAAAUy7ikT7dTsgq0cou94wRp+cDrhxFp7T7PST7TDP67/fiPVRANf
        PHeZ0Pg/ROiCEhkV7qSjNqHigItBp/A=
X-Google-Smtp-Source: APXvYqwU8ILvm083rZqsF1+xaVUC3IPoY348F4V/7HQ3ZyzHX3a5fNhpyAS1AUueG51gIHVpmMLzSg==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr25671335pga.72.1569877822791;
        Mon, 30 Sep 2019 14:10:22 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/8] fast export/import: handle nested tags, improve incremental exports
Date:   Mon, 30 Sep 2019 14:10:10 -0700
Message-Id: <20190930211018.23633-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves the incremental export story for fast-export and
fast-import (--export-marks and --import-marks fell a bit short),
fixes a couple small export/import bugs, and enables handling nested
tags.  In particular, the nested tags handling makes it so that
fast-export and fast-import can finally handle the git.git repo.

Changes since v1 (full range-diff below):
  - Fixed an issue integrating with next/pu (in particular, with
    jk/fast-import-history-bugfix)

Elijah Newren (8):
  fast-export: fix exporting a tag and nothing else
  fast-import: fix handling of deleted tags
  fast-import: allow tags to be identified by mark labels
  fast-import: add support for new 'alias' command
  fast-export: add support for --import-marks-if-exists
  fast-export: allow user to request tags be marked with --mark-tags
  t9350: add tests for tags of things other than a commit
  fast-export: handle nested tags

 Documentation/git-fast-export.txt | 17 ++++--
 Documentation/git-fast-import.txt | 23 ++++++++
 builtin/fast-export.c             | 67 ++++++++++++++++------
 fast-import.c                     | 94 +++++++++++++++++++++++++++----
 t/t9300-fast-import.sh            | 37 ++++++++++++
 t/t9350-fast-export.sh            | 68 ++++++++++++++++++++--
 6 files changed, 268 insertions(+), 38 deletions(-)

Range-diff:
1:  b751d6c2d6 ! 1:  1d19498bc6 fast-import: fix handling of deleted tags
    @@ fast-import.c: static void parse_reset_branch(const char *arg)
      		b = new_branch(arg);
      	read_next_command();
      	parse_from(b);
    -+	if (b->delete && !strncmp(arg, "refs/tags/", 10)) {
    ++	if (b->delete && !strncmp(b->name, "refs/tags/", 10)) {
     +		/*
     +		 * Elsewhere, we call dump_branches() before dump_tags(),
     +		 * and dump_branches() will handle ref deletions first, so
    @@ fast-import.c: static void parse_reset_branch(const char *arg)
     +		for (t = first_tag; t; t = t->next_tag) {
     +			strbuf_reset(&tag_name);
     +			strbuf_addf(&tag_name, "refs/tags/%s", t->name);
    -+			if (!strcmp(arg, tag_name.buf))
    ++			if (!strcmp(b->name, tag_name.buf))
     +				break;
     +			prev = t;
     +		}
2:  26b77dde15 = 2:  e1fd888e4a fast-import: allow tags to be identified by mark labels
3:  e0d1a1d7aa = 3:  93175f28d9 fast-import: add support for new 'alias' command
4:  edea892661 = 4:  8c8743395c fast-export: add support for --import-marks-if-exists
5:  6af7e1fdd0 = 5:  eebc40df33 fast-export: allow user to request tags be marked with --mark-tags
6:  631ae9a63e = 6:  de39f703c6 t9350: add tests for tags of things other than a commit
7:  c0e932e4da = 7:  ac739dbb79 fast-export: handle nested tags
-- 
2.23.0.264.gac739dbb79

