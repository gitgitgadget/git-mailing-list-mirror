Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84B2C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2DF22522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lpQtzYsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAUJY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:24:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41262 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgAUJY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 04:24:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so2287448wrw.8
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+TWlBulnogKNtX2lkPSjcEdxglR/EX7P1Vfzciuao4=;
        b=lpQtzYsUpJqvkwqYzemlbiNBn/s3TiGKRRCGO8xi7zJcrSecBnvohj7xrUAILuyhcK
         xf5YVxGJKitHOOvoB91MvFL6OUXA7uBjrtm1SaNTOpu8bwIGB0omnlqw0d/NUM7DVVOJ
         2ftfnEDZ6Hqw/esjSz6h+GFM8X2ZApXy5LJ33KEq14SJq8HRCBDCABQFskQf77Arwxme
         XOihtq915MgirHqb/WPRYHcKtu7KnHw2jxifU/UsvFrknLoE7xdxgdTy5gHVoa7c1Omj
         qp2/pTr6xOC+JNpzP6U2ZkLyfxc0f6Ywk6C3c4KG0m3Gr05Nn72XE1wY7zjecJxsheNM
         LAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+TWlBulnogKNtX2lkPSjcEdxglR/EX7P1Vfzciuao4=;
        b=f/nmmRUW4BQWh4/J//ZdZQ2LsC2ke5KnoZTmECajdFuQd14tW19WY/C3iIYYwxn6V5
         t1mGKFitdj97+DD8fNmIewT1CGWI8KLoZ93T+yHD9un6ltPGzn66ucSLHcvM4rPaRKbc
         wbMJLCnK5lZJwbk8hrrYwjqWCFOLhd/CD9l3XmF14HDHljNXPuuvlqr4xDBXUTOaipkm
         FqpUcVrWdTx1u8wQHNqbTusQI+AVJ5QF+ciDTRbyYEYN7z0dy8uzulfD0LbWlmrilGBw
         0RcSsCBI1VaqDMuIAqi/fdidMv8uA4yinck4N4A/C3w2n3dI6hwY5URSAkoaBHRCBToh
         lZxw==
X-Gm-Message-State: APjAAAXmvhPNMxsZtPKbtsRE4meMTrMehvGNxL9Ifw9C3Fc73LGs0YDt
        oRJsaCfzOzsiqp4whiI=
X-Google-Smtp-Source: APXvYqwfmsotpJoIvDzbWNNAIuePPPQGNQr+pLMPcegAJ0CRzcqBEK7VOv/4nhoy3cFyAZAQVrADKA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr3964728wrq.134.1579598696428;
        Tue, 21 Jan 2020 01:24:56 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id g18sm2903671wmh.48.2020.01.21.01.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 01:24:55 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] remote rename: improve handling of configuration values
Date:   Tue, 21 Jan 2020 10:24:48 +0100
Message-Id: <cover.1579598053.git.bert.wesarg@googlemail.com>
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

Bert Wesarg (7):
  pull --rebase/remote rename: document and honor single-letter
    abbreviations rebase types
  remote: clean-up by returning early to avoid one indentation
  remote: clean-up config callback
  remote rename: rename branch.<name>.pushRemote config values too
  [RFC] config: make `scope_name` global as `config_scope_name`
  config: provide access to the current line number
  remote rename: gently handle remote.pushDefault config

 Documentation/config/branch.txt |   7 +-
 Documentation/config/pull.txt   |   7 +-
 Makefile                        |   1 +
 builtin/pull.c                  |  29 +-----
 builtin/remote.c                | 168 +++++++++++++++++++++-----------
 config.c                        |  24 +++++
 config.h                        |   2 +
 rebase.c                        |  24 +++++
 rebase.h                        |  15 +++
 t/helper/test-config.c          |  18 +---
 t/t1308-config-set.sh           |  14 ++-
 t/t5505-remote.sh               |  52 +++++++++-
 12 files changed, 254 insertions(+), 107 deletions(-)
 create mode 100644 rebase.c
 create mode 100644 rebase.h

-- 
2.24.1.497.g9abd7b20b4.dirty

