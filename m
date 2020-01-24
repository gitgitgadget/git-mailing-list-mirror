Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02892C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4CE20838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LsL9gZLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgAXJZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32782 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAXJZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so1124312wrq.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFbSmyY4YsLGhOO/qPUYRogMqm2bV5onJotvdqSEYl4=;
        b=LsL9gZLD5Ny5i8rI51oiei+y2/wel3qH0wfFSUxITTzEkzXaW837aqDNS6NEvQjHZ7
         W80VNBQuF7dZjQMirfyyTOnhCVCPawMHiov9GntwxjBEc51rSW903XjkO+nEf24z+cAD
         l7IVwO26DVRilNiQVAv8M6UT971BMGeDvmtUW2SToFYC6iitVtnqatJH2UD/k8br2I7S
         oA660M1D4X+/LwC5UsfDSFjAv7NvuwulcXVWL17/PL2dM9vjxGrhJD3UyIAt7GNC8H6N
         02WTCNIHtG3rX7wNTxeUArpLVJKVsEfjBqWGtuPR6CrqpXP5uwJHWs+I5Ur7Hucd1lzl
         6N2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFbSmyY4YsLGhOO/qPUYRogMqm2bV5onJotvdqSEYl4=;
        b=OXjwbGVlA3qpV+hSnA0/PlU/gmUG5roz/zPMMFXWJg32hkM9yE+RnlRa0RzAJ4shzf
         BfCuVml+TFFFGloh3GGis82Sg5LDh1usAC5m6n+yExKda54y73sKqFVJAJtvfKhtGCon
         qKsKkDYjm3cR08gAKrhxoPK0ybCA/9M06DQllJJo9GRmtTT4/2R/0JhIpGCzG8XszVhM
         Q4FcTikqu5U0VmyVxUpdvC2vbdofk3pdxJAn8q7BnuEdCk8zNY4Uh4OB4fn29uJ/ZYFZ
         21SGGsU9WTZcl8287hO57ckY/L3xf4EF8InsitK/R8IXAnTM0K+CQqux6KkhYDVcpgTg
         xZig==
X-Gm-Message-State: APjAAAXpwADGK/Q/FRoQyMUczqPK0sw9GJoUh9/2inIrLDjHeI8Jm/z3
        7YmGsKk2aBYviNZdW4s=
X-Google-Smtp-Source: APXvYqzhvTmb7Mlu4njY0EKuVZ2Eg4kPgi28HKh5CZW9YIj4Ll61u7031aM5WQ+zQtGj/4CPEvzlNQ==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr2994604wrx.145.1579857929033;
        Fri, 24 Jan 2020 01:25:29 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id n8sm6645400wrx.42.2020.01.24.01.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:28 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2 0/7] remote rename/remove: improve handling of configuration values
Date:   Fri, 24 Jan 2020 10:25:20 +0100
Message-Id: <cover.1579857394.git.bert.wesarg@googlemail.com>
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

Changes since v1:
 * avoid mixed declarations and statements
 * 'git remote remove' learned similar treatment

Bert Wesarg (7):
  pull --rebase/remote rename: document and honor single-letter
    abbreviations rebase types
  remote: clean-up by returning early to avoid one indentation
  remote: clean-up config callback
  remote rename/remove: handle branch.<name>.pushRemote config values
  [RFC] config: make `scope_name` global as `config_scope_name`
  config: provide access to the current line number
  remote rename/remove: gently handle remote.pushDefault config

 Documentation/config/branch.txt |   7 +-
 Documentation/config/pull.txt   |   7 +-
 Makefile                        |   1 +
 builtin/pull.c                  |  29 +----
 builtin/remote.c                | 188 ++++++++++++++++++++++----------
 config.c                        |  24 ++++
 config.h                        |   2 +
 rebase.c                        |  35 ++++++
 rebase.h                        |  15 +++
 t/helper/test-config.c          |  18 +--
 t/t1308-config-set.sh           |  14 ++-
 t/t5505-remote.sh               |  88 ++++++++++++++-
 12 files changed, 322 insertions(+), 106 deletions(-)
 create mode 100644 rebase.c
 create mode 100644 rebase.h

-- 
2.24.1.497.g9abd7b20b4.dirty

