Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480FAC4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiK0Jhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiK0Jhd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:37:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2B1136
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id be13so13156698lfb.4
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcwMuXEXI+PAlk4K83PiNU2wgNYQEU6zviZEnm6cSVA=;
        b=lUqNW017oKJWyygopUvWe+6uvCcoTwIXFaMKQ3DyYJZZMD4k5m9eNR9t6nn+hH/S1m
         27do6S7NmIpE72ZhkBMuFHyFa5Y64G180sVI5G9BHai+X6CJjEF9udKKDU6+Jo4bn+4x
         EoCzjiD4mBHRiQRMncadwkv5PZYDcfs65rexoYqfGis3+wtgzPtQfXhcEOHJshOAumht
         BYN3sDUgSGQCxnZleik7dbS1ro/8Mkd71G/eeRGvtgMX25N7d47Tj4G8iioKXB+GlVRS
         tGqL/r1JYyAHHXFYjqcrQF+wsi/hzkFLZz3902k5aOuzK24/LXNTaYvHiS2jEIoRCQ2F
         IX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcwMuXEXI+PAlk4K83PiNU2wgNYQEU6zviZEnm6cSVA=;
        b=JAdA7rPzXSjB6K1QfveauaE+z5L7XZFbK9d3BrHMkBOZ8vtBmTjayn2zX6NfGenmg6
         kU263wUdBOm/xRLrbH9A8MOVGPZ4gfDFIuKTQJA85mvWNl+AhQwjrv44BeU0zfU1qcMc
         RvQBMmQ1/tUWOTKyeHk6YnNPXlVezuzViL00P9tp8SE9Rt4IW80kH+TuDxMEZW1nxuzZ
         8VaG5HMsqLII9uKVmPgWVQngTLZMhpC/PQJPWWA0T451nA8r0tKDQJPIOgw016V1FTK8
         nabTSm5fDDkj0hyOqkbrXYJ/qWzUuvkRw95Xun92QDIEzEtVSEN6juOSBK3/Wb6qGYTZ
         Lmaw==
X-Gm-Message-State: ANoB5pn4aybmB0buyKMqu9CAJ3Oz15osJgCmTsBqVEwbhkh7n8PbipSA
        M//auCDuu9LM5CHNUBUh+o5hjYhjvRM=
X-Google-Smtp-Source: AA0mqf4jNiBl5i/wzAteBdG9r6UDOJKP7G7fS8w1iG34YxZLSJuh4kjO3Y7lU+S6cBTjx0LyBk2gGQ==
X-Received: by 2002:a05:6512:308f:b0:4b4:b8a8:69fe with SMTP id z15-20020a056512308f00b004b4b8a869femr14631684lfd.333.1669541850151;
        Sun, 27 Nov 2022 01:37:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05651c168300b002770a48fd12sm835615ljb.102.2022.11.27.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 01:37:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/5] diff-merges: more features
Date:   Sun, 27 Nov 2022 12:37:16 +0300
Message-Id: <20221127093721.31012-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. --diff-merges=[no]-hide

The set of diff-merges options happened to be incomplete, and failed
to implement exact semantics of -m option that hides output of diffs
for merge commits unless -p option is active as well.

The new "hide" option fixes this issue, so that now

  --diff-merges=on --diff-merges=hide

combo is the exact synonym for -m.

The log.diffMerges configuration also accepts "hide" and "no-hide"
values, and governs the default value for the hide bit. The
configuration behaves as if "--diff-merges=[no-]hide" is inserted
first in the command-line.

2. log.diffMerges-m-imply-p

Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
options do. Simply fixing this inconsistency by unconditional
modification of '-m' semantics appeared to be a bad idea, as it broke
some legacy scripts/aliases. This patch rather provides configuration
variable to tweak '-m' behavior accordingly.

3. log.diffMergesForce

Force specific log format for -c, --cc, and --remerge-diff options
instead of their respective formats. The override is useful when some
external tool hard-codes diff for merges format option.

4. Support list of values for --diff-merges

This allows for shorter --diff-merges=on,hide forms.

5. Issue warning for lone '-m'.

Lone '-m' is in use by scripts/aliases that aim at enabling diff
output for merge commits, but only if '-p' is then specified as well.

As '-m' may now be configured to imply '-p' (using
'log.diffMerges-m-imply-p'), issue warning if lone '-m' is specified,
and suggest to instead use '--diff-merges=on,hide' that does not
depend on user configuration.

This is expected to give a provision for enabling
log.diffMerges-m-imply-p by default in the future.

Sergey Organov (5):
  diff-merges: implement [no-]hide option and log.diffMergesHide config
  diff-merges: implement log.diffMerges-m-imply-p config
  diff-merges: implement log.diffMergesForce config
  diff-merges: support list of values for --diff-merges
  diff-merges: issue warning on lone '-m' option

 Documentation/config/log.txt                  |  20 ++++
 Documentation/diff-options.txt                |  20 +++-
 builtin/log.c                                 |   6 +
 diff-merges.c                                 | 108 +++++++++++++++---
 diff-merges.h                                 |   6 +
 t/t4013-diff-various.sh                       |  89 ++++++++++++++-
 ...ges=first-parent_--diff-merges=hide_master |  34 ++++++
 t/t9902-completion.sh                         |   9 ++
 8 files changed, 272 insertions(+), 20 deletions(-)
 create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master

-- 
2.37.3.526.g5f84746cb16b

