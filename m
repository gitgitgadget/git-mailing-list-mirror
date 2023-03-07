Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F65C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjCGSPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjCGSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:14:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD8A337F
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:10:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a25so56176023edb.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDdnQ6yERIbX0aCwM5dihvL4YSD4XPKsQZRZTjX1yG4=;
        b=FUVJhl2j445ZEPsFsH8H+2Ex0wbxZsEi1QxEoisBwKy+SxVoYDWGj8SctdzM9ZXQe/
         6WoR9mU21HtG4ZBaKl3/ib4uXQKoSguG+RFFPmHTFf8sxSgAlRxPioTgmhj73mFgTAUZ
         KSrFxcQIMwIJW9IHH4wKIuho/A2hcKReI9ASiYjz7KhFkpscdAeMVNcB14qHCY46XC8J
         BVZyrGigUZNyb0cMpz/PIyZq1XZT3BC5EVZuGHLto4935dRM+uL8kwW59EdbZv/KtBXN
         jJVZkw2NUzd7uVWwiYs6hA43UsyNkLVgcAw7vYFSp30qHURGyMg2aEu6RIDqY/qRhRSo
         xuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDdnQ6yERIbX0aCwM5dihvL4YSD4XPKsQZRZTjX1yG4=;
        b=0b/QYD1fECKeK4bXRH23yCjjgJeMFRsGcODy3vYGLZIDbj4FwCp37TDbodSpoz/UNr
         jalmOQ6rKZb7iIbdQfEZS2b3K7aosfyscGrcQGIVBiJ0/NPn9AKbVJFsdS2rmLleBEPc
         FXXoAkGZERqQ1m7x+hHJbN8RC2JDXO0SyTaueCZNM36OWCsFG9MGYDEjabLTPrcNmyz4
         YygOh8ZoHLaohiwn1GbtVT3PnKog/jzIodOYqRpNv5rBtuD3zrx+zwKlE+r64V+PtF0G
         we6QvkZ/ibfXSUT9192okdTf6KSNz4bZAlVvPXSAKShIc1K6N+pKk3AYYTJveHqTED2y
         u3nA==
X-Gm-Message-State: AO0yUKWePEOjGwpaLpSAkG0ix5W7ginhTiOkOvUriINAlQIoCMO5/ube
        iQSUJnszmJD7bSc3ls0DRXBMdVXe6vPMXA==
X-Google-Smtp-Source: AK7set8WlqB/DME+ao01lrWYoDJuO5MZJsRmK08U64N+4YnGrDdEvnX+2TtReUSbS8tjFdZV3j51cQ==
X-Received: by 2002:a17:907:8a22:b0:88d:697d:a3d2 with SMTP id sc34-20020a1709078a2200b0088d697da3d2mr18514643ejc.54.1678212607813;
        Tue, 07 Mar 2023 10:10:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709063ec500b008b1797a53b4sm6401008ejj.215.2023.03.07.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:10:07 -0800 (PST)
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
Subject: [PATCH v6 6/9] for-each-repo: error on bad --config
Date:   Tue,  7 Mar 2023 19:09:37 +0100
Message-Id: <patch-v6-6.9-3a87b35e114-20230307T180516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
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
2.40.0.rc1.1034.g5867a1b10c5

