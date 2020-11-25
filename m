Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FADC2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E822075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCfre5In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgKYD3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:41 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCDC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:41 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id a130so1251064oif.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOUH98nCGs9DMKDsvp7wJY3rFq1uOIP4owKbKVtccTY=;
        b=aCfre5InKx8xKc3zVqVBANpckQ2rm0G1i8Zm0oACb6jRsPcdi/Lw9izZMJd07tQZGK
         aDcRG9aDZbKcSjH8lU0ZrZM4NjO7sr/jb59wFHo/H+HRhdnSzky/WtDPrXVWGhBwsG7C
         Bboc10/bBatQLBl94obOi/l2vKP8Ft/yH8KU/HSppgD9+ansx2DlwR/0M9BQCfsfToZv
         GJXAqptm6xatdTcavm/kktXMseLPDOeHF+5fwdhWd6nlEfQucpTafd132xbxODcHpKCD
         33ORwErLnJncPnt2RmyqVQCI1N0wxNqern5AvJ5OPg3XvwDEQGMRrd1hm4K15cxjJDSX
         HScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOUH98nCGs9DMKDsvp7wJY3rFq1uOIP4owKbKVtccTY=;
        b=uO2IwqyyRMP7+HtIzbBHaZ3OFaGF/KhqU6HrbI27RXEUD4LvyiPCGCcq+t8zzC+8hP
         uJ7bbjz3+ipFkn04ru5fBE2e/ORktKoLSh/32BzSOXZYgufGyP1MBhrEbvvjJ9EEPXX4
         jJ4FyVwPNe4LZaEtEYoVUC4BN9e23D2zmhCjc243hKIeZxcp1oR39MdYF7AVrU7HDP2t
         HgKAsVrA9byZaaZtCkpoG44Dr8SR9kSoMjaBBl7reXwYmP9InCWsjRz0BBK40aaj30In
         c0QtmCr1m+y3SKYKtvj8gFjM8TxrzyvZS+48wEoSWIQZTJodny2Pkxkw6pHk5R/ekt9D
         efmA==
X-Gm-Message-State: AOAM530r7XoLZhSmiYFGcFkmRm5IqNOjQauM6u5gpGnaGT6G/qQIzoxy
        ZCxmIbfwxCmIPUa3uYzI7LjXcuUQDaxvdg==
X-Google-Smtp-Source: ABdhPJwX9eHngACUpHEsLeFSNBAi+3LY41ofjIBSipa6yt/zfOny1kDJYY0XVPWhy5gf8nYcGesoLg==
X-Received: by 2002:a05:6808:141:: with SMTP id h1mr937403oie.179.1606274980209;
        Tue, 24 Nov 2020 19:29:40 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e8sm568663oti.76.2020.11.24.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:39 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 00/10] Reject non-ff pulls by default
Date:   Tue, 24 Nov 2020 21:29:28 -0600
Message-Id: <20201125032938.786393-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to revive the old patch series [1].

Since v7 of the series the pull.mode configuration is added, and the warning has been updated to
make use of that.

What is missing from the old series is:
  * Add git pull --merge
  * Actually change the default to ff-only

Cheers.

[1] https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/


Felipe Contreras (10):
  pull: refactor fast-forward check
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: move default warning
  pull: display default warning only when non-ff
  test: pull-options: revert unnecessary changes
  rebase: add REBASE_DEFAULT
  pull: add pull.mode
  pull: add pull.mode=ff-only
  pull: improve default warning

 Documentation/config/branch.txt |   6 ++
 Documentation/config/pull.txt   |   6 ++
 Documentation/git-pull.txt      |  17 ++++
 builtin/pull.c                  | 146 ++++++++++++++++++++++----------
 builtin/remote.c                |  22 ++++-
 rebase.c                        |  12 +++
 rebase.h                        |  13 ++-
 t/t5520-pull.sh                 |  92 ++++++++++++++++++++
 t/t5521-pull-options.sh         |  22 ++---
 t/t7601-merge-pull-config.sh    |  49 ++++-------
 10 files changed, 297 insertions(+), 88 deletions(-)

-- 
2.29.2

