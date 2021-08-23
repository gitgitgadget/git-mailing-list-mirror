Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830BDC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607CA60FE6
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhHWUmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:42:03 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:50700 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhHWUmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:42:02 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:16f:faad:bb0f:3a85:767c:1c2f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id B46074E6228;
        Mon, 23 Aug 2021 22:40:43 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1629751247; bh=38mFkpmD6D0Yudy1vvirjEBm3HrTZYyWSsTlYRNL/vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uA54kHsD0vgCGmVBIoqia7GCLAbPfu6ycjEdZMn50qyUS59XTNVgAKtCzpuD8pH7p
         P68d9NqvdRQKV57IQTOtc4z/nN7TFVljDcYXpyFOwWDbYOErhRxpnQ8KqGuv1p7Bw3
         vc4U/+LwEPe+noxIcMPMQJMFRvFB4Pdy9X3JGI5Q=
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
Subject: [PATCH v8 0/3] maintenance: add support for systemd timers on Linux
Date:   Mon, 23 Aug 2021 22:40:08 +0200
Message-Id: <20210823204011.87023-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210702142556.99864-1-lenaic@lhuard.fr>
References: <20210702142556.99864-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I’ve just resumed working on my patchset to add support for systemd
timers on Linux for the `git maintenance start` command.

The patches are:

* cache.h: Introduce a generic "xdg_config_home_for(…)" function

  This patch introduces a function to compute configuration files
  paths inside $XDG_CONFIG_HOME.
  It is used in the latest patch of this series to compute systemd
  unit files location.

  This patch is unchanged compared to its previous version.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

  This patch adds a new parameter to the `git maintenance run` to let
  the user choose a scheduler.

  This patch contains the following changes compared to its previous
  version:

  * Remove some UTF-8 characters in a code comment and replace them by
    ASCII ones.

  * Leverage `string_list_split` in `get_schedule_cmd` to parse the
    comma-separated list of colon-separated pairs in
    GIT_TEST_MAINT_SCHEDULER environment variable.

* maintenance: add support for systemd timers on Linux

  This patch implements the support of systemd timers on top of
  crontab scheduler on Linux systems.

  This patch is unchanged compared to its previous version.


According to [1], there were 3 changes awaited in this v8:
* The two already mentionned above (utf-8 characters and
  `string_list_split` thing)
* An improvement around the #ifdef.

I must admit I haven’t touched anything around the #ifdef in this v8
because I’m not sure what to do. I’ve just asked for some more details
in [2].

[1] https://lore.kernel.org/git/4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com/
[2] https://lore.kernel.org/git/3218082.ccbTtk1zYS@coruscant.lhuard.fr/


Best wishes,
Lénaïc.


Lénaïc Huard (3):
  cache.h: Introduce a generic "xdg_config_home_for(…)" function
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: add support for systemd timers on Linux

 Documentation/git-maintenance.txt |  57 +++
 builtin/gc.c                      | 592 ++++++++++++++++++++++++++----
 cache.h                           |   7 +
 path.c                            |  13 +-
 t/t7900-maintenance.sh            | 110 +++++-
 5 files changed, 701 insertions(+), 78 deletions(-)

Diff-intervalle contre v7 :
1:  899b11ed5b = 1:  1639bd151c cache.h: Introduce a generic "xdg_config_home_for(…)" function
2:  f3e2f0256b ! 2:  ea5568269c maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
    @@ builtin/gc.c: static const char *get_frequency(enum schedule_priority schedule)
     + *
     + * Ex.:
     + *   GIT_TEST_MAINT_SCHEDULER not set
    -+ *     ┏━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    -+ *     ┃ Input ┃                     Output                      ┃
    -+ *     ┃ *cmd  ┃ return code │       *cmd        │ *is_available ┃
    -+ *     ┣━━━━━━━╋━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━┫
    -+ *     ┃ "foo" ┃    false    │ "foo" (unchanged) │  (unchanged)  ┃
    -+ *     ┗━━━━━━━┻━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━┛
    ++ *     +-------+-------------------------------------------------+
    ++ *     | Input |                     Output                      |
    ++ *     | *cmd  | return code |       *cmd        | *is_available |
    ++ *     +-------+-------------+-------------------+---------------+
    ++ *     | "foo" |    false    | "foo" (unchanged) |  (unchanged)  |
    ++ *     +-------+-------------+-------------------+---------------+
     + *
     + *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
    -+ *     ┏━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    -+ *     ┃ Input ┃                     Output                      ┃
    -+ *     ┃ *cmd  ┃ return code │       *cmd        │ *is_available ┃
    -+ *     ┣━━━━━━━╋━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━┫
    -+ *     ┃ "foo" ┃    true     │  "./mock.foo.sh"  │     true      ┃
    -+ *     ┃ "qux" ┃    true     │ "qux" (unchanged) │     false     ┃
    -+ *     ┗━━━━━━━┻━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━┛
    ++ *     +-------+-------------------------------------------------+
    ++ *     | Input |                     Output                      |
    ++ *     | *cmd  | return code |       *cmd        | *is_available |
    ++ *     +-------+-------------+-------------------+---------------+
    ++ *     | "foo" |    true     |  "./mock.foo.sh"  |     true      |
    ++ *     | "qux" |    true     | "qux" (unchanged) |     false     |
    ++ *     +-------+-------------+-------------------+---------------+
     + */
     +static int get_schedule_cmd(const char **cmd, int *is_available)
     +{
    -+	char *item;
     +	char *testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
    ++	struct string_list_item *item;
    ++	struct string_list list = STRING_LIST_INIT_NODUP;
     +
     +	if (!testing)
     +		return 0;
    @@ builtin/gc.c: static const char *get_frequency(enum schedule_priority schedule)
     +	if (is_available)
     +		*is_available = 0;
     +
    -+	for (item = testing;;) {
    -+		char *sep;
    -+		char *end_item = strchr(item, ',');
    -+		if (end_item)
    -+			*end_item = '\0';
    ++	string_list_split_in_place(&list, testing, ',', -1);
    ++	for_each_string_list_item(item, &list) {
    ++		struct string_list pair = STRING_LIST_INIT_NODUP;
     +
    -+		sep = strchr(item, ':');
    -+		if (!sep)
    -+			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
    -+		*sep = '\0';
    ++		if (string_list_split_in_place(&pair, item->string, ':', 2) != 2)
    ++			continue;
     +
    -+		if (!strcmp(*cmd, item)) {
    -+			*cmd = sep + 1;
    ++		if (!strcmp(*cmd, pair.items[0].string)) {
    ++			*cmd = pair.items[1].string;
     +			if (is_available)
     +				*is_available = 1;
    ++			string_list_clear(&list, 0);
     +			UNLEAK(testing);
     +			return 1;
     +		}
    -+
    -+		if (!end_item)
    -+			break;
    -+		item = end_item + 1;
     +	}
     +
    ++	string_list_clear(&list, 0);
     +	free(testing);
     +	return 1;
     +}
3:  0ea5b2fc45 = 3:  faf56c078f maintenance: add support for systemd timers on Linux
-- 
2.33.0

