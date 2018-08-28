Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFA21F428
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeH1QCY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51045 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1QCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1682941wmc.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbO+pQKjKikX7Wd6V0hlTW0KB/8BDc9wqcwJDu21jfE=;
        b=ZySOerWgiiE6PuWCN8yaIjNC/0k0vb5lEIeUd2uYuqmTdZh0AkkFR1VMqnYKhduIH+
         6clg+RnwwaZJxgGjFJOwjzPNn5WwzfMcG9MUlIfpXUnZsMGYeq4RzT4js2XQTpZ+d93w
         FOtaP1sSdtGmsmcve0AkNV0sLER0rRyc1ii6HSS99LWl02OdvDDnY2twh2/WikP1ZgDp
         79icrP+hZOok5Wh72QzNVZ8IRVVvo5v54BmgUBdC8HsfBITgRJXc56G3vRO0FmnxxGCq
         BtEX+Ec53f2VffajrsQE9mj3u3UK22u+CLFVL8KTMoQqc4/izbshin387Y8KLd+bBHfs
         5+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbO+pQKjKikX7Wd6V0hlTW0KB/8BDc9wqcwJDu21jfE=;
        b=olzhukL/iBLYmN0yatRHfr0h8bcYSnwt2uukXuGEzXm2CkTgJFRavCbE/ZTGN0TDX5
         ra/Nq6c2KpoaqelZrDWGxHICGL4Mf/wf615CMCV39LFsMPFYwa6mOf9h6AQEID8ALf2q
         QednWct70XxBXwzwJKGSL+tMLxnykU654bq5fr2RKEPzpR6I9RT69zojqGFsMumF0zBm
         F3jaFkBDsDjuFWHbFvZKbNAvudgudSyar4U/odtCloskwxsvoq86DuxueWMYT8Aa8hw0
         aQ/Shr0nPEZJujanRr4a65aUXZ4Cc508UNNwgCr1vUuMW7hSxYEvnNr7ZDKppfuI2N7f
         AWQQ==
X-Gm-Message-State: APzg51DZAV1MSwFYr5ZUof+gFuZk9WqwYXsSnazmkAcv2MMQlPpXKXIf
        /rZJAnqFWyVbyqOCikE1/ZYEzxqV
X-Google-Smtp-Source: ANB0VdafkOgxLqItecznTBFGZ9DsHm/VusCphYjZp8liB+fIxyJejcQg+qbT17aguL2/fCKC2UWjbQ==
X-Received: by 2002:a1c:9a43:: with SMTP id c64-v6mr1117554wme.1.1535458260520;
        Tue, 28 Aug 2018 05:11:00 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:10:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 00/20] rebase -i: rewrite in C
Date:   Tue, 28 Aug 2018 14:10:25 +0200
Message-Id: <20180828121045.14933-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrite the interactive rebase from shell to C.

It is based on ffc6fa0e39 ("Fourth batch for 2.19 cycle", 2018-07-24).
This conflicts a bit with b9dfa238d5 ("Getting ready for -rc1",
2017-08-27) because of the range-diff, but a 3-way merge can solve these
conflicts cleanly.

Changes since v6:

 - [11/20] Handle errors from checkout_onto().

 - [11/20] Remove useless calls to error_errno().

 - [17/20] Die with an help message if no parameters were given to
   rebase--interactive2.

 - [17/20 & 18/20] Die if no commit was provided with `--upstream` or
   `--onto` to rebase--interactive2.

 - [18/20] Replace "restrict_revisions" by "restrict_revision" in
   git-rebase.sh.

Alban Gruin (20):
  sequencer: make three functions and an enum from sequencer.c public
  rebase -i: rewrite append_todo_help() in C
  editor: add a function to launch the sequence editor
  rebase -i: rewrite the edit-todo functionality in C
  sequencer: add a new function to silence a command, except if it fails
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C
  sequencer: refactor append_todo_help() to write its message to a
    buffer
  sequencer: change the way skip_unnecessary_picks() returns its result
  t3404: todo list with commented-out commands only aborts
  rebase -i: rewrite complete_action() in C
  rebase -i: remove unused modes and functions
  rebase -i: implement the logic to initialize $revisions in C
  rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in
    C
  rebase -i: rewrite write_basic_state() in C
  rebase -i: rewrite init_basic_state() in C
  rebase -i: implement the main part of interactive rebase as a builtin
  rebase--interactive2: rewrite the submodes of interactive rebase in C
  rebase -i: remove git-rebase--interactive.sh
  rebase -i: move rebase--helper modes to rebase--interactive

 .gitignore                     |   1 -
 Makefile                       |   5 +-
 builtin.h                      |   2 +-
 builtin/rebase--helper.c       |  88 ---------
 builtin/rebase--interactive.c  | 270 ++++++++++++++++++++++++++++
 cache.h                        |   1 +
 editor.c                       |  27 ++-
 git-rebase--interactive.sh     | 283 -----------------------------
 git-rebase--preserve-merges.sh |  10 +-
 git-rebase.sh                  |  47 ++++-
 git.c                          |   2 +-
 rebase-interactive.c           |  90 ++++++++++
 rebase-interactive.h           |   8 +
 sequencer.c                    | 320 +++++++++++++++++++++++++++------
 sequencer.h                    |  22 ++-
 strbuf.h                       |   2 +
 t/t3404-rebase-interactive.sh  |  10 ++
 17 files changed, 739 insertions(+), 449 deletions(-)
 delete mode 100644 builtin/rebase--helper.c
 create mode 100644 builtin/rebase--interactive.c
 delete mode 100644 git-rebase--interactive.sh
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

