Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB5F20248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCSTD6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:03:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51476 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCSTD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:03:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so18010672wmi.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=haLSd780giagGzsLG9bJ42YJvPBIrmfMkmNcQzcU0Jw=;
        b=tTzezcYsPa6f7X3UFfTtOe3GVKbhhINp34hiupA8JdvGj4FDhG9n3JqTBp5Atyw87d
         6Ld2JpEMJ/F8p2TDwgEkSlKzS6xGa0kTfV3RdJJngKIWr1piSWRUpRVy3O3r+XgLjfAD
         tp2niXq9f9c9o91UCEPbeQbESUt3K15LJWa2+JvC6aXSndyqNuWXsxvaOcCF2YzpVjyt
         jJ48jsZAGRTuEmYdGIQCrcKZFnl5MvIv2AQcvTfBbbX7RJBE7Rta71xyjG6fiC6iycDj
         WK7lJOlwz+oZ6Ne3ez7ffQy4Uiy+dlnzGc3Q9VrX5pW375GeI144dTjv/dQskRwBPOYR
         I5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=haLSd780giagGzsLG9bJ42YJvPBIrmfMkmNcQzcU0Jw=;
        b=KJN9tGTqY10wAgacMr82h1+HyaIigMqLnfsiz/JcdpHEUluPHwpMnM2gNEUStYCo/r
         IIjg/1+m2vJMDWJkAdsyJet3EDNc4FXGQcsiq6OVsHU3GoxoRi8dO+dGkMq58Zlbvxlk
         1t0n2zz923KaOs91CXrpNS+mP8VsMjGDi0zuW1BwrzfLYuj9N6VZfMOSi5jnmgz2yqo2
         6docoRMVar6FmUsC04yv+4iIKqFPN4b7G5c84gmH/UlF4qgzuH020+CrB0MNoQ9dOfVp
         eKxMPjZVeDP+uDG6/H2mrt7s2Wl/Iyg2b3gsFSIa6gB57E4c5/r+xNe0TIuo32GvUAun
         1QDg==
X-Gm-Message-State: APjAAAUJa+P+vbuy99lZfN7RoDmDn0UStgJRJ1RZqWwJTNX8JgFzztkB
        4SAf6yQWUsM2i39S+my9r/7umf+pskc=
X-Google-Smtp-Source: APXvYqxVEeYdEx2za6j+h5xcqnnTkx9EgPxjCcglexTHPf15Q7EtErjJTYecgvtSaH4YxnNMEyDX3g==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr4665061wmj.121.1553022235471;
        Tue, 19 Mar 2019 12:03:55 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:03:54 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 00/11] rebase -i run without forking rebase--interactive
Date:   Tue, 19 Mar 2019 19:03:06 +0000
Message-Id: <20190319190317.6632-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the builtin rebase starts an interactive rebase it parses the
options and then repackages them and forks `rebase--interactive`. This
series refactors rebase--interactive so that interactive rebases can
be started by the builtin rebase without forking. My motivation was to
make it easier to debug the sequencer but this should help future
maintainability.

This series involves some code movement so viewing the diffs with
--color-moved is recommended.

These patches are based on a merge of master [e902e9bcae ("The second
batch", 2019-03-11)] and ag/sequencer-reduce-rewriting-todo ed35d18841
("rebase--interactive: move transform_todo_file()", 2019-03-05). They
can be fetched from the tag rebase-i-no-fork/rfc at
https://github.com/phillipwood/git.git

Phillip Wood (11):
  sequencer: always discard index after checkout
  rebase: rename write_basic_state()
  rebase: use OPT_RERERE_AUTOUPDATE()
  rebase -i: combine rebase--interactive.c with rebase.c
  rebase -i: remove duplication
  rebase -i: use struct commit when parsing options
  rebase -i: use struct object_id for squash_onto
  rebase -i: use struct rebase_options to parse args
  rebase -i: use struct rebase_options in do_interactive_rebase()
  rebase: use a common action enum
  rebase -i: run without forking rebase--interactive

 Makefile                      |   1 -
 builtin/rebase--interactive.c | 377 --------------------
 builtin/rebase.c              | 625 ++++++++++++++++++++++++++--------
 parse-options-cb.c            |  34 ++
 parse-options.h               |   4 +
 sequencer.c                   |  42 ++-
 sequencer.h                   |   7 +-
 7 files changed, 556 insertions(+), 534 deletions(-)
 delete mode 100644 builtin/rebase--interactive.c

-- 
2.21.0

