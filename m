Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14B420248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCKDmc (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36530 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so2964382pgr.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jHCQ7aVH63UE95dVevAtZMGXt7Mk9WTHWNv0bkBXOtY=;
        b=UwxnlDdwhqbqLwFgBlsc2UxPNVDN2QfPCPD8IxYWa5yTbSQGwLHuQohyNS+IxAJqS+
         ox/J/s5uT40X4sH+ReNvUvciQtkGcLPQEjTVIaAbhSwzrjNKnNXkBYNKI1+RRjsX0fai
         17TNsIrIzIA4Kv9necoCsgRErcqMo+ReyOa8S9w5O6iGuN1M4zRu52QgTMRydTV+rMt0
         23EJ0rxnc72qTarwGh95rWDmuLQvPQ3hOGTGtR0XHbAO6nHl7dIt5xx/wk+NjVHLmoKy
         QGqY23WMUunGAKFpfCOyRStrWYFhiZj+zVpz9eMWuGId/bG38KR/+WHWSsyWvCKFMTmq
         I12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHCQ7aVH63UE95dVevAtZMGXt7Mk9WTHWNv0bkBXOtY=;
        b=hiTG0i+Iw4nIIrDWw2ZyCjXvIzGZFUWtrBuMQShcz2UkHVv5gjNM2AdS0zgUfiuavF
         IhbioTj2maQ+vKRxw4qkIcxp4N+a3fPduHOmqfOht6gdP64R6FIZLeppyICPJjRZs1CC
         SUt1NGAhWzY5StLKlHAGTm/g/T1ZEJ0+Pu6wgCht6ne+yxqKzWM/FFEQUPi4QPSpWSQN
         R6Dj7Oac9+Wb2p+bngM2ocmEjdpAskxRFHKwlb25TcQNsbN0xKA1DvQCnWHHi0GQtwA7
         it6vgL/qbrNYaDEtQ3vsaMopYvfWxgGst9Olxjq0wi1nRVcAvb6Zm2LIHAbN5b1OqTHa
         KBhg==
X-Gm-Message-State: APjAAAUfCfUTACpWpkjPxFjol2txCIKkfNQtrGOI7171nolX2yllSj/c
        w0krBNCYKtMv8rLY36oNoNGH1tdt
X-Google-Smtp-Source: APXvYqxH2DEF4EtYgpodTzZrIqwoEOsGwZySFB5bK6xX5fXhtpm8a+2pQJqb4lE3f5Bcx7i/xRYGuQ==
X-Received: by 2002:a65:4384:: with SMTP id m4mr27941010pgp.375.1552275750817;
        Sun, 10 Mar 2019 20:42:30 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id n23sm5432311pgv.86.2019.03.10.20.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:29 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:27 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 0/8] Fix scissors bug during conflict
Message-ID: <cover.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548219737.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a complete replacement for dl/merge-cleanup-scissors-fix.

Previous discussion on the cherry-pick/revert changes can be found here[1].

Changes since revert/cherry-pick v3:

* Rebased on top of latest master
* Reordered and squashed patches
* Added populate_opts_cb and save_opts to save default_msg_cleanup at Phillip's suggestion

[1]: https://public-inbox.org/git/cover.1551867827.git.liu.denton@gmail.com/T/#u


Denton Liu (8):
  t7600: clean up 'merge --squash c3 with c7' test
  t3507: cleanup space after redirection operators
  commit: extract cleanup_mode functions to sequencer
  sequencer.c: remove duplicate code
  merge: cleanup messages like commit
  merge: add scissors line on merge conflict
  sequencer.c: define get_config_from_cleanup
  cherry-pick/revert: add scissors line on merge conflict

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 Documentation/merge-options.txt   |   7 ++
 builtin/commit.c                  |  45 +++++------
 builtin/merge.c                   |  40 ++++++++--
 builtin/pull.c                    |   6 ++
 builtin/rebase--interactive.c     |   2 +-
 builtin/revert.c                  |   5 ++
 sequencer.c                       | 102 ++++++++++++++++++++-----
 sequencer.h                       |  10 ++-
 t/t3507-cherry-pick-conflict.sh   | 120 +++++++++++++++++++++++++-----
 t/t7600-merge.sh                  |  53 ++++++++++++-
 t/t7604-merge-custom-message.sh   |  61 +++++++++++++++
 wt-status.c                       |  12 ++-
 wt-status.h                       |   1 +
 15 files changed, 398 insertions(+), 80 deletions(-)


base-commit: 6e0cc6776106079ed4efa0cc9abace4107657abf
-- 
2.21.0.370.g4fdb13b891

