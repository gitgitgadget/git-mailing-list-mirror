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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B01C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319E7613BC
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFJInl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:43:41 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46762 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJInk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 04:43:40 -0400
Received: by mail-pg1-f172.google.com with SMTP id n12so21973992pgs.13
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJqOpOQdcrQGEGkWFrR9YTAdh47jQAN9AkUbt0XM0/s=;
        b=uxqKy46aCpcH9Y8eYKLmQHA48LRCUY+hVgcj6BOlSOgVK/9tciJMYTDXKDXGkyJN2c
         7dzjvqAoaTyYgrIfu5LLZ2jJAj3Dc/pZFd8fjEhkoBd+pGoUuaXB1PO4ySyN6iPebDwc
         sm2uTQ9K7qZn2GXjfzB07qHvhRoirgZupxQgks4DelXWCC44lyy1IAurH8l/SeWmNzr+
         PPzrNcLaqblVLUalS0g1ImhpX+vHZ32Eqhw0zfNJS4tMp8n6o9fntFrRdq4IFnXYSFtt
         1tYAjqUOVyVw15ZXotViR4yz8caJRPaU2HX/wPPoArNNNrnPrp73AVYMilKu6RYaSCh5
         FIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJqOpOQdcrQGEGkWFrR9YTAdh47jQAN9AkUbt0XM0/s=;
        b=kH9FIRsV5JkRyU3+F0myZ8YcNUlYcfO+2HF2PCXpk0snRd5qOuzZOqDfsb8XiQKw86
         V8y3Yq7D2sK5bA6psPx5GTq3HoWQxscX+9JfJ0DMM2jQ5ALs7mqEB5TgqnJb5cRkZFir
         LW71q/zcd+PNHASOZVGr3aWpz7UZJ1plTtLxjNpMOoZsAT4UjXNvt22Q6LHjPmh1/6qM
         bNRaU8PN8sKS6UQ1sCLfeLDUWPxIVhnN9SOtIBWAOOJ+LWAoHi7TKZs/tjq7wc0Dge2p
         sDdm8oiZEFIp3p0n1pO34oMF/Oi4wCu/X+LP9VRxzC9ki+uMsXkxFmxmwgm7FS2edkTc
         WlOA==
X-Gm-Message-State: AOAM533HTufU6yLwODx6dXTxeqILnG9Snytks2jNsXvcM5Xq+ztoqCxf
        TrQ3qsOQ9OX9zceekw+VVuRFXp2EKURSpwjBnGU=
X-Google-Smtp-Source: ABdhPJzNZI1uWdYddOwbrDJ8KIQAg2mmVFTLp9ZeNJneoasXLwZgAofz2f7rRtsSJpTkflEVnhGM7w==
X-Received: by 2002:a05:6a00:1c5d:b029:2e9:e126:64e0 with SMTP id s29-20020a056a001c5db02902e9e12664e0mr1981473pfw.61.1623314444807;
        Thu, 10 Jun 2021 01:40:44 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id u68sm1802423pfb.64.2021.06.10.01.40.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 01:40:44 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] [PATCH v3 0/2] submodule--helper: introduce subcommands for sh to C conversion
Date:   Thu, 10 Jun 2021 14:09:14 +0530
Message-Id: <20210610083916.96243-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608095655.47324-1-raykar.ath@gmail.com>
References: <20210608095655.47324-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Notable changes since v2:
 - In show_fetch_remotes(), remove the get_next_line() and parse_token()
   in favour of a simpler solution that uses strchr() and
   strip_suffix_mem()
 - Use OPT__FORCE() instead of OPT_BOOL for '--force' flags
 - Add checks for number of arguments in the helper subcommands
 - Simplify usage string for add-clone and make error messages start in
   lowercase.

Atharva Raykar (2):
  submodule--helper: introduce add-clone subcommand
  submodule--helper: introduce add-config subcommand

 builtin/submodule--helper.c | 299 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  66 +-------
 2 files changed, 301 insertions(+), 64 deletions(-)

-- 
2.31.1

