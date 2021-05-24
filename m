Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AEDC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED5D610CE
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhEXHSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:18:12 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:42088 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232249AbhEXHSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:18:10 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:cea:a9d0:f3e1:f159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id D897F47424C;
        Mon, 24 May 2021 09:16:33 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621840594; bh=9o7kdmaur0YIOIV/T02ns5zkRRcQXCCsmp6PvTKMx4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xUwGIppyN21kZXU6KkdoziBJGvN3IfDrkDQ3C1Uk1xurrBQr6H4aaJMhAhjwjs9cW
         l9NQsPaCSeALG3enJCzjEzBD+7TIVItC1N659iDku+HlpyTxZHsHzu9XGXV6EtN3Ft
         muq+XPprMrDpDs163bEsgaLL4qPFQ3bP9R57JWVE=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v4 0/4] add support for systemd timers on Linux
Date:   Mon, 24 May 2021 09:15:34 +0200
Message-Id: <20210524071538.46862-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520221359.75615-1-lenaic@lhuard.fr>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The main difference between this v4 patchset and the previous v3
concerns the first patch, the one introducing a new function to use
$XDG_CONFIG_HOME.
Instead of re-purposing the existing `xdg_config_home(filename)`
function, I’ve created a new generic one named
`xdg_config_home_for(prog, filename)` to address the potential
conflict issue raised by Danh.

I’ve also reworded the commit message of the last patch to address the
review comments.
I replaced the “he” by a “they”.
To be honest, I’m not an English native speaker, so I don’t feel
comfortable debating which usage is common in informal speech or in
formal writtings.
So, I would be happy to change it to “he or she” if it is more
consensual and looks less “artificial” than “he/she”.

Lénaïc Huard (4):
  cache.h: Introduce a generic "xdg_config_home_for(…)" function
  maintenance: introduce ENABLE/DISABLE for code clarity
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: add support for systemd timers on Linux

 Documentation/git-maintenance.txt |  60 ++++
 builtin/gc.c                      | 548 ++++++++++++++++++++++++++----
 cache.h                           |   7 +
 path.c                            |  13 +-
 t/t7900-maintenance.sh            | 110 +++++-
 5 files changed, 657 insertions(+), 81 deletions(-)

-- 
2.31.1

