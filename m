Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285BC2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C339620643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYGUjozc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfLXLFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39646 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfLXLFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so17872209qtm.6
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nCkUMNLnjfS+VlmlFYpk8n/qcodd6/sEYNYFOdn+ww=;
        b=EYGUjozcNQ9mnhzPDI1lQLrrMGjdJUA150r+VoB/3/f1+fngdc9Pp/7aXcXPTF6GNQ
         YqrUNbCbw8wNR3omV1vK/xWm4Mbtg4C7Y2K9jPDoHi9uMoiuj90IZ//ezncowmeYX8Xi
         RU40FVbhtYNEHriVKiPxacYl3VO09cM7bhsbS8Tn0TyEZSKHSt5ve6IeF/+yRp1hlXTO
         pKIMOpH9YnweJrbR65O2bljgSuyR8/JS7+Ka8ntVmrQf9lNGjPRn7l7W0I0z6P4Bmj7v
         P9PEa6cK3wC7LANUa0l8PQyh7Xzkcu04ItmZ9AEQQqCfWRH9QwLPixFJ0PQJqYXaY1ip
         6ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nCkUMNLnjfS+VlmlFYpk8n/qcodd6/sEYNYFOdn+ww=;
        b=fAanMmKK0EFi5x8G8LuZqSInE4W37DZHcNG4MJi9VFvXTPSJJ0mBdXkNG7L4ZGtzU/
         u3hRophmYkllNQ+lw9yJtDrZifm4tqTmUZGMXZOD0xPb9d+wfiNOLdHrl8cNaStK2grc
         atJqL7pjD0kZC+l6A8INGrAX5fg+hjV0tWJa4KTCHWfFq2JWnYWMfcL+ztbRE2ntkpcV
         Nhxci6YQdgtyCttvy7IoOrtSCUhrVUTKDQ2HRrzbpxVlYptpJyu9hSK1SJFnQfbVrekI
         hCkyvvdzu2gQ9PlciPVASSXiCxsUsPgqhe87AZKNSYJxvyVfijC9W8An8qY9wiYgjFUb
         h96A==
X-Gm-Message-State: APjAAAWtrGk3DKhHhexg4WrByLiHLnIzuPjJpnhUb4g86F8yw0/Rvesm
        DvbvzHKzigqh85DOQLsjtXQHbu7S
X-Google-Smtp-Source: APXvYqxTvGi/lR3AITlq3v5tot5Clwkyl3Buov7er4bKaVrcI7ElbzNoa/+LkjnaWCoZBucx448hnw==
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr26727243qtv.308.1577185546757;
        Tue, 24 Dec 2019 03:05:46 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:46 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 00/17] merge: learn --autostash
Date:   Tue, 24 Dec 2019 06:04:57 -0500
Message-Id: <cover.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban reported[1] that he expected merge to have an --autostash option,
just like rebase. Since there's not really any reason why merge can't
have it, let's implement it in this patchset.

The majority of this patchset is spent refactoring. This is so that the
actual implementation in merge is done as simply as possible.

Changes since v1:

* Completely changed how the refactoring was done

* More tests and documentation

[1]: https://github.com/gitgitgadget/git/issues/394

Denton Liu (17):
  Makefile: alphabetically sort += lists
  t7600: use test_write_lines()
  sequencer: use file strbuf for read_oneliner()
  sequencer: configurably warn on non-existent files
  sequencer: make read_oneliner() extern
  rebase: use read_oneliner()
  sequencer: make apply_rebase() accept a path
  rebase: use apply_autostash() from sequencer.c
  rebase: generify reset_head()
  reset: extract reset_head() from rebase
  rebase: extract create_autostash()
  rebase: generify create_autostash()
  sequencer: extract perform_autostash() from rebase
  sequencer: unlink autostash in apply_autostash()
  merge: teach --autostash option
  t5520: make test_pull_autostash() accept expect_parent_num
  pull: pass --autostash to merge

 Documentation/config/merge.txt  |  10 ++
 Documentation/git-pull.txt      |   9 -
 Documentation/merge-options.txt |   8 +
 Makefile                        |  76 ++++----
 branch.c                        |   1 +
 builtin/commit.c                |   2 +
 builtin/merge.c                 |  17 ++
 builtin/pull.c                  |   9 +-
 builtin/rebase.c                | 295 ++++----------------------------
 path.c                          |   1 +
 path.h                          |   4 +-
 reset.c                         | 140 +++++++++++++++
 reset.h                         |  20 +++
 sequencer.c                     | 128 +++++++++-----
 sequencer.h                     |  15 ++
 t/t3033-merge-toplevel.sh       |  22 +++
 t/t5520-pull.sh                 |  57 ++++--
 t/t7600-merge.sh                |  87 ++++++++--
 18 files changed, 522 insertions(+), 379 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

-- 
2.24.1.810.g65a2f617f4

