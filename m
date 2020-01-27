Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F658C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EC620842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g0+KZhw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgA0HEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35766 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0HEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5804033wmb.0
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FVyZ8qUqcwQf94DUK96ABWLGe9e2dH8CilTkaCEH2zY=;
        b=g0+KZhw7++nHuw3Onk3SuhmpJkXkYWglyYzshsHtvij5iycSpNolTxV4/yieu5ZZMi
         mIAIlrQpzH2inKKU2bPpBJsVLszTQJq8lZN2LfakF2yoAvBH7R1WIr22f63SmaGL9/lW
         ZwPr/XvwVYSn8jAO1AqjP6zJM47k9JTc/krd3ViTvSPXwPzD58kUXESfRNA0pBbNCJ0m
         eozpP6G4nvM2K6re9vjvloWPPT+QdyWMtHOrYBpPre7QGsI0WGXvCABkLb7Ty808d880
         1vYLD6Lm8hZZAXabv49zi2cz68mdrnEPC4jGlA8a3ukbGTC/NRxwW/2k7VGNN7/04Kcg
         U7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FVyZ8qUqcwQf94DUK96ABWLGe9e2dH8CilTkaCEH2zY=;
        b=BvRn09nrrWunGHqCbw0Rpwuw4Br3vtaZIuP5sPAZwChuicdM1KOnBENzJ9gIZ3XHDX
         6ydVQsioYw5NOy+SuM9wsHmtY2SYNiC2maw0IcpiuJnD/iP6ji3FXTmTrepQHrr87zpX
         Fxz1v8O2noK1I4QR5YqXiBDanqB+LqZwlEmf5MyE3ppsesVEUxfz0Z2e/vprS2xnXNIc
         SDUrfSOS7YeK5On7biV23Rtnl1hoLah/xl24RKegEMSOZr3+plI9cgn4g7pbrR8ljZYk
         +nSx3ZpGUE6BJm1va0uWzwbFbAsKx6FbdcSpAeRmFwyREOv4Vevj7uvTx9pxxVjm71Wd
         FDeg==
X-Gm-Message-State: APjAAAWPdMVZ0yaF6aBdPJssH2bbNAQx9J4Mxl7IbbW3PpYwWi1us6ev
        RrgzGAB1pddIh7eWCFg=
X-Google-Smtp-Source: APXvYqznVy0SKxedYAfYzBMkVdD9dpeFFfGJUAtXG6HsenwxmLt4gKBqneyxNjk8CBioe1Mv3vHRBg==
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr12144338wmp.30.1580108673539;
        Sun, 26 Jan 2020 23:04:33 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id o7sm17273329wmh.11.2020.01.26.23.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:33 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v3 0/7] remote rename/remove: improve handling of configuration values
Date:   Mon, 27 Jan 2020 08:04:26 +0100
Message-Id: <cover.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While fixing that 'git remote rename X Y' does not rename the values for
'branch.*.pushRemote', it opened the possibility to more improvements in
this area:

 - 'remote rename' did not accept single-letter abbreviations for
   'branch.*.rebase' like 'pull --rebase' does

 - minor clean-ups the config callback

 - patch 5 will be replaced by/rebased on Matthew's work in 'config: allow user to
   know scope of config options', once 'config_scope_name' is available

 - gently handling the rename of 'remote.pushDefault'

Changes since v3:
 * rebasd onto mr/show-config-scope (feaf5eea41)

Changes since v1:
 * avoid mixed declarations and statements
 * 'git remote remove' learned similar treatment

Bert Wesarg (6):
  pull --rebase/remote rename: document and honor single-letter
    abbreviations rebase types
  remote: clean-up by returning early to avoid one indentation
  remote: clean-up config callback
  remote rename/remove: handle branch.<name>.pushRemote config values
  config: provide access to the current line number
  remote rename/remove: gently handle remote.pushDefault config

 Documentation/config/branch.txt |   7 +-
 Documentation/config/pull.txt   |   7 +-
 Makefile                        |   1 +
 builtin/pull.c                  |  29 +----
 builtin/remote.c                | 188 ++++++++++++++++++++++----------
 config.c                        |   8 ++
 config.h                        |   1 +
 rebase.c                        |  35 ++++++
 rebase.h                        |  15 +++
 t/helper/test-config.c          |   1 +
 t/t1308-config-set.sh           |  14 ++-
 t/t5505-remote.sh               |  88 ++++++++++++++-
 12 files changed, 304 insertions(+), 90 deletions(-)
 create mode 100644 rebase.c
 create mode 100644 rebase.h

-- 
2.24.1.497.g9abd7b20b4.dirty

