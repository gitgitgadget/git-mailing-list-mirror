Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9153C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7ADD60EE4
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhH0VE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:04:29 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:49260 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhH0VE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:04:29 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:9445:15b5:7384:b79b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 99F024EB41B;
        Fri, 27 Aug 2021 23:03:34 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1630098214; bh=+ZFTemBOzM31xLZA0NBAEO+HieU8hfVBdoPw6Nlegb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aID0WNpPRLa7ixtnBl9Y7/RGTkrq0P00wGt20FnfBwMaEo/DykyXpOjm75zlgMZrX
         qhEEI9dV+6F0UwmTq6ZmU/+oVZBlPONvYRLDrVKBYCA6RyY5TjwpYLJUc6wzWqcOcT
         DZFqak6efsMUCQpgs4noVkorVf+4lvN9msXT/W4E=
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
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v9 0/3] maintenance: add support for systemd timers on Linux
Date:   Fri, 27 Aug 2021 23:02:52 +0200
Message-Id: <20210827210255.12565-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210823204011.87023-1-lenaic@lhuard.fr>
References: <20210823204011.87023-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Please find hereafter my updated patchset to add support for systemd
timers on Linux for the `git maintenance start` command.

The goal of this re-roll is to address Derrick’s remarks [1]
Namely:
* Get rid of the #ifdef around real_is_systemd_timer_available
* Fix the whitespace issue in systemd_timer_setup_units

[1] https://lore.kernel.org/git/44904983-a6a8-d72f-24db-50bf112c585b@gmail.com/

The patches are:

* cache.h: Introduce a generic "xdg_config_home_for(…)" function

  This patch introduces a function to compute configuration files
  paths inside $XDG_CONFIG_HOME.

  This patch is unchanged compared to its previous version.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

  This patch adds a new parameter to the `git maintenance run` to let
  the user choose a scheduler.

  This patch is unchanged compared to its previous version.

* maintenance: add support for systemd timers on Linux

  This patch implements the support of systemd timers on top of
  crontab scheduler on Linux systems.

  * The whitespace nit has been fixed with `git rebase
    --whitespace=fix`

  * The #ifdef around real_is_systemd_timer_available has been dropped
    so that its code is compiled on every platform.

    This means that:
    * The availability of `launchctl` and `schtasks` are completely
      determined at compilation time by the platform.
    * The availability of `cron` and `systemd timers` are fully
      determined at runtime even if today only Linux might have systemd.

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

Diff-intervalle contre v8 :
-:  ---------- > 1:  1639bd151c cache.h: Introduce a generic "xdg_config_home_for(…)" function
-:  ---------- > 2:  ea5568269c maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
1:  faf56c078f ! 3:  8c25ebd3be maintenance: add support for systemd timers on Linux
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd)
      	return result;
      }
      
    -+#ifdef __linux__
    -+
     +static int real_is_systemd_timer_available(void)
     +{
     +	struct child_process child = CHILD_PROCESS_INIT;
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd)
     +	return 1;
     +}
     +
    -+#else
    -+
    -+static int real_is_systemd_timer_available(void)
    -+{
    -+	return 0;
    -+}
    -+
    -+#endif
    -+
     +static int is_systemd_timer_available(void)
     +{
     +	const char *cmd = "systemctl";
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd)
     +	const char *exec_path = git_exec_path();
     +
     +	int ret = systemd_timer_write_unit_templates(exec_path) ||
    -+	          systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
    -+	          systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
    -+	          systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
    ++		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
    ++		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
    ++		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
     +	if (ret)
     +		systemd_timer_delete_units();
     +	return ret;
-- 
2.33.0

