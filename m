Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50213C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32657601FF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhIDU5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 16:57:07 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:45804 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234067AbhIDU5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 16:57:07 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:3dbf:67a8:d86:1503])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 93EE54F545F;
        Sat,  4 Sep 2021 22:55:28 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1630788928; bh=t5pihIMVEv6/PHVRUKGnNgZpKDYZZjtCdvEvW9PComM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=0kvTQDNX97LJnVNvd6LSDU+cN5pERdk6YASm+tfzDP//CB3ts36TnXm+p2sfwB/wP
         jEAmajpFnLz5IpgxuJaGRzFDNMFlpYuhPxEEAhkEMxXqoH3SQVTkfB5J/6J6dJXWWA
         O3qyAk73F6u9sjVV/Frj98nQTn6NVHVHoaveqfJE=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
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
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v10 0/3] maintenance: add support for systemd timers on Linux
Date:   Sat,  4 Sep 2021 22:54:57 +0200
Message-Id: <20210904205500.13074-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827210255.12565-1-lenaic@lhuard.fr>
References: <20210827210255.12565-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Please find hereafter my updated patchset to add support for systemd
timers on Linux for the `git maintenance start` command.

The only changes compared to the previous version are fixes for the
two typos in a comment that Ramsay Jones pointed out [1]

[1] https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@ramsayjones.plus.com/


The patches are:

* cache.h: Introduce a generic "xdg_config_home_for(…)" function

  This patch introduces a function to compute configuration files
  paths inside $XDG_CONFIG_HOME.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

  This patch adds a new parameter to the `git maintenance run` to let
  the user choose a scheduler.

* maintenance: add support for systemd timers on Linux

  This patch implements the support of systemd timers on top of
  crontab scheduler on Linux systems.

Best wishes,
Lénaïc.

Lénaïc Huard (3):
  cache.h: Introduce a generic "xdg_config_home_for(…)" function
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: add support for systemd timers on Linux

 Documentation/git-maintenance.txt |  57 +++
 builtin/gc.c                      | 581 ++++++++++++++++++++++++++----
 cache.h                           |   7 +
 path.c                            |  13 +-
 t/t7900-maintenance.sh            | 110 +++++-
 5 files changed, 690 insertions(+), 78 deletions(-)

Diff-intervalle contre v9 :
1:  1639bd151c = 1:  0c0362d4ec cache.h: Introduce a generic "xdg_config_home_for(…)" function
2:  ea5568269c ! 2:  5fb061ca9d maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
    @@ builtin/gc.c: static const char *get_frequency(enum schedule_priority schedule)
     + * list of colon-separated key/value pairs where each pair contains a scheduler
     + * and its corresponding mock.
     + *
    -+ * * If $GET_TEST_MAINT_SCHEDULER is not set, return false and leave the
    ++ * * If $GIT_TEST_MAINT_SCHEDULER is not set, return false and leave the
     + *   arguments unmodified.
     + *
    -+ * * If $GET_TEST_MAINT_SCHEDULER is set, return true.
    ++ * * If $GIT_TEST_MAINT_SCHEDULER is set, return true.
     + *   In this case, the *cmd value is read as input.
     + *
     + *   * if the input value *cmd is the key of one of the comma-separated list
3:  8c25ebd3be = 3:  b0f2f6df0e maintenance: add support for systemd timers on Linux
-- 
2.33.0

