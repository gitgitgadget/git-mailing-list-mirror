Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ADC4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKYJym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKYJyY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1DC47307
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x5so5957974wrt.7
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlJiJaAs3RkdyxZhSziXESzYVHe8PEZTDSvQzgV031k=;
        b=ax9d3d0UrGTH9i0vJ6X9/hoymi7QwsBf1LSMC2G9ApyeYci1fOROkBrHRssyFQYPYQ
         QtKDfvhSYtTV0Y79wvD96oZVQuRbjVZvZqzFGpy+09PCl6TD/jAW27a3FPFZcPsk7oQa
         zDnFFWWkpQPjI5xOsUWqMLtjocsh5tiFGleIzo4v8mZehNyrgkG1Gg665p+K4eBvLjak
         wF+4lCyib5+u0XLOuFi/VxPwei+JyPxgaLhT/OaiaiB24Yc6MFDzyPW7RSRmBqoXEVGU
         LHN09LyCn32A3IHfSZyBd30K45ci0yq+uaYUaPpbBc83SQlzP53fdLEx0Wr/hcCPunJ+
         NPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlJiJaAs3RkdyxZhSziXESzYVHe8PEZTDSvQzgV031k=;
        b=WF5yF//5G7hBCQQYBPHA1JPNSwekJsAJmtPef1idq9AOeDpeslC79Vu02nBpV3nNYg
         kKJ4UOj4utgYCUAzYOneku0QBDWkoUEOkLKq9ipbYwY8FajVpy7fBKQv6rtWuWuyISLz
         23FvV7SajCumjpPJD5knkjZGdkijBws5Kfag7V71S5gq+FMxSNkwwcl3CnxT9F6xyXPT
         U6mvHGxqWX9QukvoiGdxGN4TsIjoIip5AbqfkPt81Ss17FF7LoAd3Jbc29ynwEnlDsHI
         5snmg2OQMagYj+6nk0W9tsMoWb2CWQ1315jhtqfp4fV3wL1M87tlkhwHLYF4aNHzKVV1
         P5SQ==
X-Gm-Message-State: ANoB5pmwH24yC2c17ubJgw2LX4MUUknphVfZ7bx0BmkkMRA3YxKQiMV7
        Mb9ODj0zAi3dsp2NO9e46KEAapmLoRhVFvER
X-Google-Smtp-Source: AA0mqf5ZGEDAK//sflJ4w3VPpOv34oSwl+qwdrkKcui+9+/wkJQRZt5yjciW7BuKzslL1K1aCFUEKg==
X-Received: by 2002:a05:6000:683:b0:241:dac7:5282 with SMTP id bo3-20020a056000068300b00241dac75282mr13187823wrb.135.1669369881515;
        Fri, 25 Nov 2022 01:51:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] config API: make "multi" safe, fix numerous segfaults
Date:   Fri, 25 Nov 2022 10:50:01 +0100
Message-Id: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes numerous segfaults in config API users, because they
didn't expect *_get_multi() to hand them a string_list with a NULL in
it given config like "[a] key" (note, no "="'s).

A larger general overview at v1[1], but note the API changes in
v2[2]. Changes since v2:

* Rebased on the now-landed "rp/maintenance-qol", which had conflicts
  in builtin/gc.c.
* Re-wrap some of the code properly at 79 characters.
* Drop the stray submodule--helper from "for-each-repo", it was from a
  mistaken earlier rebase in v2.
* Avoid minor whitespace changes in a test.
* Don't change the BUG() message in config.c later in the series
  (another earlier rebase change when slimming down the v2).

Junio: I'm sending this re-roll because I see
"ab/config-multi-and-nonbool" got ejected (presumably due to the
conflicts). Per [3] I think the "mixed bag" note in "What's Cooking"
refers to the state of v1, which I tried to address in v2.

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/221107.86leomx2dg.gmgdl@evledraar.gmail.com/

CI & branch at:
https://github.com/avar/git/tree/avar/have-git_configset_get_value-use-dest-and-int-pattern-3

Ævar Arnfjörð Bjarmason (9):
  for-each-repo tests: test bad --config keys
  config tests: cover blind spots in git_die_config() tests
  config tests: add "NULL" tests for *_get_value_multi()
  versioncmp.c: refactor config reading next commit
  config API: have *_multi() return an "int" and take a "dest"
  for-each-repo: error on bad --config
  config API users: test for *_get_value_multi() segfaults
  config API: add "string" version of *_value_multi(), fix segfaults
  for-each-repo: with bad config, don't conflate <path> and <cmd>

 builtin/for-each-repo.c              | 14 ++---
 builtin/gc.c                         | 10 ++--
 builtin/log.c                        |  6 +-
 builtin/submodule--helper.c          |  7 ++-
 config.c                             | 87 +++++++++++++++++++++++-----
 config.h                             | 50 +++++++++++++---
 pack-bitmap.c                        |  6 +-
 submodule.c                          |  3 +-
 t/helper/test-config.c               |  6 +-
 t/t0068-for-each-repo.sh             | 19 ++++++
 t/t1308-config-set.sh                | 30 ++++++++++
 t/t3309-notes-merge-auto-resolve.sh  |  7 ++-
 t/t4202-log.sh                       | 15 +++++
 t/t5304-prune.sh                     | 12 +++-
 t/t5310-pack-bitmaps.sh              | 20 +++++++
 t/t5552-skipping-fetch-negotiator.sh | 16 +++++
 t/t7004-tag.sh                       | 17 ++++++
 t/t7413-submodule-is-active.sh       | 16 +++++
 t/t7900-maintenance.sh               | 38 ++++++++++++
 versioncmp.c                         | 22 ++++---
 20 files changed, 339 insertions(+), 62 deletions(-)

Range-diff against v2:
 1:  b8fd3bea4d1 =  1:  5c8819ff388 for-each-repo tests: test bad --config keys
 2:  6cd0d6faf3c =  2:  3eb8da6086d config tests: cover blind spots in git_die_config() tests
 3:  f2a8766a802 =  3:  14b08dfc162 config tests: add "NULL" tests for *_get_value_multi()
 4:  42cfc61202d =  4:  cb802b30cd8 versioncmp.c: refactor config reading next commit
 5:  48fb7cbf585 !  5:  e0e6ade3f38 config API: have *_multi() return an "int" and take a "dest"
    @@ builtin/gc.c: static int maintenance_register(int argc, const char **argv, const
      			if (!strcmp(maintpath, item->string)) {
      				found = 1;
     @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, const char *prefi
    - 		usage_with_options(builtin_maintenance_unregister_usage,
    - 				   options);
    - 
    --	list = git_config_get_value_multi(key);
    + 	if (config_file) {
    + 		git_configset_init(&cs);
    + 		git_configset_add_file(&cs, config_file);
    +-		list = git_configset_get_value_multi(&cs, key);
    +-	} else {
    +-		list = git_config_get_value_multi(key);
    + 	}
     -	if (list) {
    -+	if (!git_config_get_value_multi(key, &list)) {
    ++	if (!(config_file
    ++	      ? git_configset_get_value_multi(&cs, key, &list)
    ++	      : git_config_get_value_multi(key, &list))) {
      		for_each_string_list_item(item, list) {
      			if (!strcmp(maintpath, item->string)) {
      				found = 1;
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      		 * by default, only initialize 'active' modules.
      		 */
     -		if (!argc && git_config_get_value_multi("submodule.active"))
    -+		if (!argc && !git_config_get_value_multi("submodule.active", &values))
    ++		if (!argc && !git_config_get_value_multi("submodule.active",
    ++							 &values))
      			module_list_active(&list);
      
      		info.prefix = opt.prefix;
 6:  a0c29d46556 !  6:  06d502bc577 for-each-repo: error on bad --config
    @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
      		return 0;
      
     
    - ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv, const char *prefix)
    - 		NULL
    - 	};
    - 	int ret = 1;
    --	const struct string_list *values;
    -+	const struct string_list *unused;
    - 
    - 	argc = parse_options(argc, argv, prefix, module_init_options,
    - 			     git_submodule_helper_usage, 0);
    -@@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv, const char *prefix)
    - 	 * If there are no path args and submodule.active is set then,
    - 	 * by default, only initialize 'active' modules.
    - 	 */
    --	if (!argc && !git_config_get_value_multi("submodule.active", &values))
    -+	if (!argc && !git_config_get_value_multi("submodule.active", &unused))
    - 		module_list_active(&list);
    - 
    - 	info.prefix = prefix;
    -@@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
    - 	if (opt.init) {
    - 		struct module_list list = MODULE_LIST_INIT;
    - 		struct init_cb info = INIT_CB_INIT;
    --		const struct string_list *values;
    -+		const struct string_list *unused;
    - 
    - 		if (module_list_compute(argv, opt.prefix,
    - 					&pathspec2, &list) < 0) {
    -@@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
    - 		 * If there are no path args and submodule.active is set then,
    - 		 * by default, only initialize 'active' modules.
    - 		 */
    --		if (!argc && !git_config_get_value_multi("submodule.active", &values))
    -+		if (!argc && !git_config_get_value_multi("submodule.active", &unused))
    - 			module_list_active(&list);
    - 
    - 		info.prefix = opt.prefix;
    -
      ## t/t0068-for-each-repo.sh ##
     @@ t/t0068-for-each-repo.sh: test_expect_success 'do nothing on empty config' '
      	git for-each-repo --config=bogus.config -- help --no-such-option
 7:  c12805f3d55 !  7:  f35aacef4ca config API users: test for *_get_value_multi() segfaults
    @@ t/t7413-submodule-is-active.sh: test_expect_success 'is-active works with submod
     
      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
    - 	git maintenance unregister --force
    + 	git maintenance unregister --config-file ./other --force
      '
      
     +test_expect_failure 'register with no value for maintenance.repo' '
 8:  6b76f9eac90 !  8:  b45189b4624 config API: add "string" version of *_value_multi(), fix segfaults
    @@ builtin/gc.c: static int maintenance_register(int argc, const char **argv, const
      			if (!strcmp(maintpath, item->string)) {
      				found = 1;
     @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, const char *prefi
    - 		usage_with_options(builtin_maintenance_unregister_usage,
    - 				   options);
    - 
    --	if (!git_config_get_value_multi(key, &list)) {
    -+	if (!git_config_get_string_multi(key, &list)) {
    + 		git_configset_add_file(&cs, config_file);
    + 	}
    + 	if (!(config_file
    +-	      ? git_configset_get_value_multi(&cs, key, &list)
    +-	      : git_config_get_value_multi(key, &list))) {
    ++	      ? git_configset_get_string_multi(&cs, key, &list)
    ++	      : git_config_get_string_multi(key, &list))) {
      		for_each_string_list_item(item, list) {
      			if (!strcmp(maintpath, item->string)) {
      				found = 1;
    @@ builtin/log.c: static void set_default_decoration_filter(struct decoration_filte
      
     -	if (!git_config_get_value_multi("log.excludeDecoration",
     -					&config_exclude)) {
    -+	if (!git_config_get_string_multi("log.excludeDecoration", &config_exclude)) {
    ++	if (!git_config_get_string_multi("log.excludeDecoration",
    ++					 &config_exclude)) {
      		struct string_list_item *item;
      		for_each_string_list_item(item, config_exclude)
      			string_list_append(decoration_filter->exclude_ref_config_pattern,
    @@ config.c: int git_config_get_value_multi(const char *key, const struct string_li
      int git_config_get_string(const char *key, char **dest)
      {
      	return repo_config_get_string(the_repository, key, dest);
    -@@ config.c: void git_die_config(const char *key, const char *err, ...)
    - 		va_end(params);
    - 	}
    - 	if (git_config_get_value_multi(key, &values))
    --		BUG("for key '%s' we must have a value to report on", key);
    -+		BUG("key '%s' does not exist, should not be given to git_die_config()",
    -+		    key);
    - 	kv_info = values->items[values->nr - 1].util;
    - 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
    - }
     
      ## config.h ##
     @@ config.h: RESULT_MUST_BE_USED
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      				preferBitmapTips
      			EOF
     -			git repack -adb
    -+
     +			cat >expect <<-\EOF &&
     +			error: missing value for '\''pack.preferbitmaptips'\''
     +			EOF
    @@ t/t7413-submodule-is-active.sh: test_expect_failure 'is-active handles submodule
     
      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
    - 	git maintenance unregister --force
    + 	git maintenance unregister --config-file ./other --force
      '
      
     -test_expect_failure 'register with no value for maintenance.repo' '
 9:  e2f8f7c52e3 =  9:  58ead3ca555 for-each-repo: with bad config, don't conflate <path> and <cmd>
-- 
2.39.0.rc0.955.ge9b241be664

