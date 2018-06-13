Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7606E1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 15:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935818AbeFMPXS (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 11:23:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43562 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935773AbeFMPXR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 11:23:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so3177871wrm.10
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T3Szh/cnzCebT2TIO3D/FD+Xr73+CVuMjP3vVkTPwZs=;
        b=udrehIS9FHDZJRHRHSmUdWfalZ6g/0+VaOPYnyMY6xftSmJQGxjEzqtVeMjNb4tdL3
         z/Z3BcWfg4d3tpU0LJJ6/d5IxkzDQ5ArlIT/f39FGIOEf1vpGp+pPMB0lqQD76T6Va/M
         m1iXhE4gYXEjt7BXzVUJJ8VOd+Gj+e9JI/LmDn3xfIg6y/KDYKAHrZbliLqkxjdLLcNj
         6tJtl2tahmDDlhvWtMr9t+ypvazjKzaJFpclWvIChuQ2iqgcOGh2p9wAJeCf0UFpHxlt
         dV0VWSD2cHgDMBklIUkj31dJYrDPcJvZMEbFtuUIaGMQbbyTbpUc4Lkw5LBzZ1EP02Rv
         ycbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3Szh/cnzCebT2TIO3D/FD+Xr73+CVuMjP3vVkTPwZs=;
        b=g8liXUx6B4TmvFpKqe4Fama9roiqCpXU8SU7g1ePl28MCIl74YuIFi5XoD3VNhgIql
         t7AOw11iPO24GL95xjynNVyE51/7czyltp/bLRVBP+6lGVxh4xkv+WatDsDrMMU+a0Oc
         QiYjcHMt6ey66P83A07PhIczbUOfTkuQUN1uB7d+HsisWVDaBga6JA1T5iswPlVbThTL
         rkbIHsc5SCR86rzPninNkW5ceTRD9upR0WCYlz7SATPb9//cWzO12ADFm/n2Av1ik7i7
         MJzfZK2nReh5I403Rp1F4ykNkgDYuv18YBrN3m7y++Q7K6oSmHRI9Sg6sXMvuqCCXHJ6
         MtKg==
X-Gm-Message-State: APt69E22HzMXaRc+GvcgokAGfNJnEWPxxPgraqvaidIi61LY9VHJFxqF
        b3iyUcGQf6Wovatra3/qWcjsmZUD
X-Google-Smtp-Source: ADUXVKKGJeVxQuwyMTesOdSfyWPIdZYK/n+CpoZmdlfqrTY0Ti7NwF/7WDMZUGPKTx+ON9VJhD8o6w==
X-Received: by 2002:adf:8361:: with SMTP id 88-v6mr4401098wrd.17.1528903396245;
        Wed, 13 Jun 2018 08:23:16 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm4526388wre.16.2018.06.13.08.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:23:14 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 0/2] rebase -i: rewrite the edit-todo functionality in C
Date:   Wed, 13 Jun 2018 17:22:09 +0200
Message-Id: <20180613152211.12580-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180611135714.29378-1-alban.gruin@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch rewrites the edit-todo functionality from shell to C. This is
part of the effort to rewrite interactive rebase in C.

Changes since v1:

 - Add a new function to launch the sequence editor, as advised by
   Phillip Wood[0]

[0] https://public-inbox.org/git/3bfd3470-4482-fe6a-2cd9-08311a0bbaac@talktalk.net/

Alban Gruin (2):
  editor: add a function to launch the sequence editor
  rebase--interactive: rewrite the edit-todo functionality in C

 builtin/rebase--helper.c   | 13 ++++++++-----
 cache.h                    |  1 +
 editor.c                   | 27 +++++++++++++++++++++++++--
 git-rebase--interactive.sh | 11 +----------
 sequencer.c                | 31 +++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 strbuf.h                   |  2 ++
 7 files changed, 69 insertions(+), 17 deletions(-)

-- 
2.16.4

