Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15685C636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjBBN2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjBBN15 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:27:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86FA8F25B
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1378852wmq.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDAYK4tECdpIzaXqNz7L+KnOqVVqDSzJi2q18roMSnE=;
        b=eEUi/AOZm2A5iOWJSsU34pxC+M3obxuv9FJaAvoyPpks/4gVHd4Q9lwjGz3WRlDNTb
         8RgjmVa6PtkXeA/7ZzSK44gDLZbRQWAYtEjyEQUmbeAJ6tbZ23T8b5kJYhSC5F1p926J
         w/2GOnWHjvs4KHB6MhAMStho8FbNHcDUF6Mhtls2UFUp83/SRXDHdZUvVWgziRsW/QtZ
         JerIxQTM7dpjBdp+SaFIHX5PBisfGhmkUi2LfzIXaXcZLL5SXwc5ennCbUKIKPMIoKHg
         24g/jmKQwBGxsB/3pWTshnyACEJRyCGa1ljMiGewqcBMZwl6cmZJtLtiB4pCpeyk03mO
         F34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDAYK4tECdpIzaXqNz7L+KnOqVVqDSzJi2q18roMSnE=;
        b=Kpki2O0lxnRaOZ+o4Qqb91mCPisGlaNl3W5DpTeMDhB240ERnmgFrXTTSwlRshOs72
         hQtvmE4XMj2L6QK7RSI9ibIleXpXg1Fx4yu7PiP60oj1r6Hn23PgD0oOvNfoLJaqhKFP
         atvXCXj9zwi/b3F8nqtCPDxGjBwEIdpCjuSMEpc0tf8tCJmXdvAQkW9iynS2y/yO2dz5
         2dxd30A0xoRFKWT87ezbjwdJGMHXyxYJVlh1oN79oLz7IvifYxU5MYyRuiW0LDhZ+r8Q
         UhrbPGKn+wlM3cyQ3xzBSqFbTxE6ycgWZohranMRWm0ADh6D0oLjwaFojMpw2SIByZMW
         J5TA==
X-Gm-Message-State: AO0yUKXQTbwp3/sSgLzOjLx0/MvFKVsJPyhflLCELyw8+ygyLzgSQMif
        YtMD0j6QMWcP1wZxztUadtDQ7bM7exfMBKTf
X-Google-Smtp-Source: AK7set9QeE7TwuIpSyYx3F2sVi+5J2s/ikBcI4AkdSELFeTKEO1jsliPcdPspJ3y+uoALEHveByNrA==
X-Received: by 2002:a05:600c:cca:b0:3db:1919:41b5 with SMTP id fk10-20020a05600c0cca00b003db191941b5mr6041114wmb.21.1675344455764;
        Thu, 02 Feb 2023 05:27:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/9] for-each-repo: error on bad --config
Date:   Thu,  2 Feb 2023 14:27:18 +0100
Message-Id: <patch-v4-6.9-17c1218e74c-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 6c62f015520 (for-each-repo: do nothing on empty config,
2021-01-08) this command wants to ignore a non-existing config key,
but let's not conflate that with bad config.

Before this, all these added tests would pass with an exit code of 0.

We could preserve the comment added in 6c62f015520, but now that we're
directly using the documented repo_config_get_value_multi() value it's
just narrating something that should be obvious from the API use, so
let's drop it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c  | 11 ++++++-----
 t/t0068-for-each-repo.sh |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index fd0e7739e6a..224164addb3 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -32,6 +32,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	static const char *config_key = NULL;
 	int i, result = 0;
 	const struct string_list *values;
+	int err;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
@@ -45,11 +46,11 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	/*
-	 * Do nothing on an empty list, which is equivalent to the case
-	 * where the config variable does not exist at all.
-	 */
-	if (repo_config_get_value_multi(the_repository, config_key, &values))
+	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	if (err < 0)
+		usage_msg_optf(_("got bad config --config=%s"),
+			       for_each_repo_usage, options, config_key);
+	else if (err)
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 3648d439a87..6b51e00da0e 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -40,4 +40,10 @@ test_expect_success 'do nothing on empty config' '
 	git for-each-repo --config=bogus.config -- help --no-such-option
 '
 
+test_expect_success 'error on bad config keys' '
+	test_expect_code 129 git for-each-repo --config=a &&
+	test_expect_code 129 git for-each-repo --config=a.b. &&
+	test_expect_code 129 git for-each-repo --config="'\''.b"
+'
+
 test_done
-- 
2.39.1.1397.g8c8c074958d

