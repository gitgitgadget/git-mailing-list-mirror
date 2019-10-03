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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1360A1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfJCU1Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34652 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCU1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so2488663pfa.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7vin5W3vuLg2jQwJrPNkHwo3fQm5js9Af4xbGE5jUI=;
        b=s7XqUCnXyZBd7vmvA/FWsUYbklpnllPN05uWTkk1N/mah73cAg/FyGK8RsiH5MNCsW
         BUCheQOmGyzszLtskMbPojLfqgXiOG6HJHlYIV0F/BM97JPbkaG29CUDPYA5a5y35YEN
         pP3vWeyTIRh/wqaJUsMm3WxcJHN/t29XOuD+8Cba1tJRoIkDGvCoh1d3QMtAssPwKeL1
         TEG6pG0oEyFiNmYi9QovAM3nJKqwd/PrSzvhTPOT+ZxfpLzFRVGyBpVh58CclGSrS5pW
         227aRZqiNBfJCAVusgR5nRIgYGVlJpg/gKTfpx/jhPXm5OLBQngdXtpcB009OMYFUzCu
         Boyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7vin5W3vuLg2jQwJrPNkHwo3fQm5js9Af4xbGE5jUI=;
        b=jmlvjSItGwASKaUVaCTGUg3g84R+fF96CEwRFQpQIdASwh0fjcvatdabthxMooKhJI
         /TFE0HdbbZGmkjxwyZ/lhbg42N598d6aUoqG/jaEkK5TXVF4gu7DHzVtGjVdqmhhk1Sz
         t3WJMSLX6TCOCW6ORNCIKRBst2t+m/a7nCaLYtUeFE/L4QfxyTyiAi5QR3/O9VCg6TAh
         MMQyz557AlINj0QY4r38fs5wmjHGjGhJHCWV7hlRi8vONizp3yB44rK059UkyIQj7my+
         d4C+pNFpf/WX96f6S0m4De+xND3IK9JZdjLERkCPF1j+xDsWWXuSD1ki9t8+vodUs56R
         gKSQ==
X-Gm-Message-State: APjAAAUp0u62glyZj2k3N/VYp2Om5sx2fxKdbe4YcrZyGVPfdE16VT9V
        fZ4LB5/jhwY0U9c/MH3Nvuw=
X-Google-Smtp-Source: APXvYqwwT/C7iCLgWd5//9S7rW+KXgLl1CrWseVM0GyrbwJUYPtQrv0ofKfAlvfdrCvjRpP2La/eAw==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr5965626pgj.187.1570134435533;
        Thu, 03 Oct 2019 13:27:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 0/8] fast export/import: handle nested tags, improve incremental exports
Date:   Thu,  3 Oct 2019 13:27:01 -0700
Message-Id: <20191003202709.26279-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes since v2 (full range-diff below):
  - Code cleanup of patch 2 suggested by René

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
 fast-import.c                     | 92 +++++++++++++++++++++++++++----
 t/t9300-fast-import.sh            | 37 +++++++++++++
 t/t9350-fast-export.sh            | 68 +++++++++++++++++++++--
 6 files changed, 266 insertions(+), 38 deletions(-)

Range-diff:
1:  a30cfbbb50 = 1:  a30cfbbb50 fast-export: fix exporting a tag and nothing else
2:  1d19498bc6 ! 2:  36fbf15134 fast-import: fix handling of deleted tags
    @@ Commit message
         So, either way nested tags imply the need to delete temporary inner tag
         references.
     
    +    Helped-by: René Scharfe <l.s.r@web.de>
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
      ## fast-import.c ##
    +@@ fast-import.c: static void parse_new_tag(const char *arg)
    + static void parse_reset_branch(const char *arg)
    + {
    + 	struct branch *b;
    ++	const char *tag_name;
    + 
    + 	b = lookup_branch(arg);
    + 	if (b) {
     @@ fast-import.c: static void parse_reset_branch(const char *arg)
      		b = new_branch(arg);
      	read_next_command();
      	parse_from(b);
    -+	if (b->delete && !strncmp(b->name, "refs/tags/", 10)) {
    ++	if (b->delete && skip_prefix(b->name, "refs/tags/", &tag_name)) {
     +		/*
     +		 * Elsewhere, we call dump_branches() before dump_tags(),
     +		 * and dump_branches() will handle ref deletions first, so
    @@ fast-import.c: static void parse_reset_branch(const char *arg)
     +		 * NEEDSWORK: replace list of tags with hashmap for faster
     +		 * deletion?
     +		 */
    -+		struct strbuf tag_name = STRBUF_INIT;
     +		struct tag *t, *prev = NULL;
     +		for (t = first_tag; t; t = t->next_tag) {
    -+			strbuf_reset(&tag_name);
    -+			strbuf_addf(&tag_name, "refs/tags/%s", t->name);
    -+			if (!strcmp(b->name, tag_name.buf))
    ++			if (!strcmp(t->name, tag_name))
     +				break;
     +			prev = t;
     +		}
3:  e1fd888e4a = 3:  3b5f4270f8 fast-import: allow tags to be identified by mark labels
4:  93175f28d9 = 4:  489c7fd854 fast-import: add support for new 'alias' command
5:  8c8743395c = 5:  38fd19caee fast-export: add support for --import-marks-if-exists
6:  eebc40df33 = 6:  2017b8d9f9 fast-export: allow user to request tags be marked with --mark-tags
7:  de39f703c6 = 7:  0efdbb81b1 t9350: add tests for tags of things other than a commit
8:  ac739dbb79 = 8:  fe7c27d786 fast-export: handle nested tags
-- 
2.23.0.264.g3b9f7f2fc6

