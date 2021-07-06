Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A95AC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197C861C94
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhGFVGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:06:19 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45827 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGFVGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:06:18 -0400
Received: by mail-ed1-f54.google.com with SMTP id t3so426749edt.12
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS1oUp/5bql5xb8DbeMJpa6rGHmRoMMCwKrNyWFU6ww=;
        b=eU79EGiYIz6nCobSwUz9uqPwAFz9oMP1a6dPckQAjbzcsgAKnIZX1mRxJwCjhyLoPi
         lREQnf2XU0IihJuwxT58RaOuTCuqgLWVbRUeJJ1hlMd88i4spWq4C1oTJxgxms4t19tB
         6hYMUGj12/t4Uj2iAeJvYUYb0oCke2NMkSwEOuj2seD79RsS2Ep6jr0YJhmjQGhe9TYU
         n508HFhkyyy89QvKsMJUDmIKzVwLwTqiZmwIBGTTr4imrxTVaGBPQQkmanzAhTE4NjxJ
         cdmbJ5Hnw1TuJKCwWPmEwork4ZydqH2hJLl74tiNJZQQHbfhikTv2GtiDJY0t2JkIKXD
         AFMA==
X-Gm-Message-State: AOAM532oWtbVFHbOvO/QJqsLgX4rP5XesVvJKPBKCoaPL6ztrPYO0t1q
        fJUqOhelGhZjhKYiDdc7PCiw6C9RQgUNfA==
X-Google-Smtp-Source: ABdhPJylnP8NmCQmEBUV9IE3a1aDKueEnr/HbqqTelPCzZD9NfCPEGzPa4KtiXKKHXVI0Znzoica6A==
X-Received: by 2002:a05:6402:216:: with SMTP id t22mr25230570edv.70.1625605418737;
        Tue, 06 Jul 2021 14:03:38 -0700 (PDT)
Received: from localhost.localdomain (IGLD-83-130-17-216.inter.net.il. [83.130.17.216])
        by smtp.gmail.com with ESMTPSA id t6sm7690284edd.3.2021.07.06.14.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:03:38 -0700 (PDT)
From:   Avishay Matayev <me@avishay.dev>
To:     git@vger.kernel.org
Cc:     code@tpope.net, Avishay Matayev <me@avishay.dev>
Subject: [PATCH 0/3] Override isatty with GIT_FORCE_TTY
Date:   Wed,  7 Jul 2021 00:03:15 +0300
Message-Id: <20210706210317.706313-1-me@avishay.dev>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the resulting patch series from the discussion in the mailing list[1]
and the Fugitive github issue[2].

The goal is to allow to override git decisiveness about not doing
something when some fd is not a pty, which can hinder Fugitive.

I didn't annotate the location of the commits as I wasn't sure what was
the correct one.. As it is not specific to a single mechanisms, but
rather it is something global, is it fine as it is or should I use
something as `global, `tree:` or `tree-wide:`?

I also didn't document this feature, or at least I wasn't sure where
to document it (other than on these commits), I would compare it to the
GIT_SMART_HTTP as it is something pretty niche and it isn't (and IMO
shouldn't be) documented to the regular user.

Thank you,
Avishay

1. https://lore.kernel.org/git/CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com/
2. https://github.com/tpope/vim-fugitive/issues/1772

Avishay Matayev (3):
  Change isatty's parameter to a *_FILENO define
  Allow isatty to be overriden with GIT_FORCE_TTY
  Add tests for GIT_FORCE_TTY

 builtin/am.c               |  2 +-
 builtin/bisect--helper.c   |  4 ++--
 builtin/blame.c            |  2 +-
 builtin/bundle.c           |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/commit-graph.c     |  4 ++--
 builtin/commit.c           |  2 +-
 builtin/fsck.c             |  2 +-
 builtin/gc.c               |  2 +-
 builtin/log.c              |  2 +-
 builtin/merge.c            |  4 ++--
 builtin/multi-pack-index.c |  2 +-
 builtin/pack-objects.c     |  2 +-
 builtin/pack-redundant.c   |  2 +-
 builtin/prune-packed.c     |  2 +-
 builtin/prune.c            |  2 +-
 builtin/rebase.c           |  2 +-
 builtin/repack.c           |  2 +-
 builtin/send-pack.c        |  2 +-
 builtin/shortlog.c         |  4 ++--
 builtin/sparse-checkout.c  |  2 +-
 builtin/unpack-objects.c   |  2 +-
 cache.h                    |  3 +++
 color.c                    |  2 +-
 column.c                   |  2 +-
 compat/mingw.c             |  6 +++---
 compat/mingw.h             |  2 +-
 compat/winansi.c           | 16 ++++++++--------
 config.c                   |  5 +++++
 date.c                     |  2 +-
 editor.c                   |  2 +-
 pager.c                    |  4 ++--
 preload-index.c            |  2 +-
 read-cache.c               |  2 +-
 remote-curl.c              |  2 +-
 sequencer.c                |  4 ++--
 sideband.c                 |  2 +-
 t/t9904-git-force-tty.sh   | 38 ++++++++++++++++++++++++++++++++++++++
 transport.c                |  6 +++---
 transport.h                |  2 +-
 wt-status.c                |  2 +-
 41 files changed, 101 insertions(+), 55 deletions(-)
 create mode 100755 t/t9904-git-force-tty.sh

-- 
2.25.1

