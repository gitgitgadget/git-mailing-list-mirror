Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4FDC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD664F0C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhBYBWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 20:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhBYBWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 20:22:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49AC06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:21:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t11so6098640ejx.6
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mylyAWocbwS/aJv3PodldjsjuGjFXoFo+XTFbX6gIR4=;
        b=M+AfwgsO2GiGbpQXVHLwH+W1oT5Y0a4WxiXCQcYNSjIuCSWStjOFv6M8eP61xwIb1b
         taqoHRfhZiT9Ch2Z7DqHdwpynyVuF9eOcSzked9LgVSO7Te3LzuM2c4rLQxqLcupGdVV
         EHlLQ7hViYBKu0uRZFHTGbXNespJgQt+T5ENVnHJOrNkkOV+WTYhbkvm2swTOJPe4cU+
         qL14aQkf/vJuXaeB0peRLuMBzKSM4ewfXhjeW+wgQLu4NiI8lO53qDjmUp8GzqgZqwL5
         oEyPZX79rq5LUCrH8IfzXTMWowEdpYO2gEKQvtWnz+4KKj0GSJbHdBWuEpjfP4HIsQce
         /tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mylyAWocbwS/aJv3PodldjsjuGjFXoFo+XTFbX6gIR4=;
        b=ho0x/9sHqKYDKh28T0Xd5/raWlowrZe0wRuR3pBw0xB6ejpH1+uwEOi2oon6F2I4cd
         yYToi/SMJ/S4s0MkV0KI+mfs549uP6Q1dVVVOsFhPNNHCn9pAGIpMvp8jitlTI4KRvZp
         8Qz6+/Sl2g88ePtOnAjRppQusYtD8I7Q4hgdM3jag1+QGaqbPZaclt9u5LPUVr9xDhmq
         Tfuwso+2UEReTvV+NESYTSrSG33AnEBeeLr96Cpl5Z/D6qw9rf19c4PTWvNUReuC9tTM
         uVlIlwBM4L3pdjPw+oiS12zzoQBvp4gNiwySWlrNX6iQHR01beGNf+2aHiYvBxF1CBFY
         IumQ==
X-Gm-Message-State: AOAM531AdyglM2R0QSiJw5EEornT158hJWL67WRDVmwyE9I5py+bwhem
        gVgikwp8rnw7GAC0xjyrR3QmTOWelyZwrg==
X-Google-Smtp-Source: ABdhPJzEZ9hGOaGGfOBLD+Spm5p5FUsnODf4d5fMHzMCk0hhGfXizVmied2//7pqMHnXLrbbEAO9CQ==
X-Received: by 2002:a17:906:12d2:: with SMTP id l18mr379321ejb.308.1614216092902;
        Wed, 24 Feb 2021 17:21:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12sm2648216edb.52.2021.02.24.17.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 17:21:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] remote: write camel-cased *.pushRemote on rename
Date:   Thu, 25 Feb 2021 02:21:17 +0100
Message-Id: <20210225012117.17331-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210225012117.17331-1-avarab@gmail.com>
References: <20210225012117.17331-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote is renamed don't change the canonical "*.pushRemote"
form to "*.pushremote". Fixes and tests for a minor bug in
923d4a5ca4f (remote rename/remove: handle branch.<name>.pushRemote
config values, 2020-01-27). See the preceding commit for why this does
& doesn't matter.

While we're at it let's also test that we handle the "*.pushDefault"
key correctly. The code to handle that was added in
b3fd6cbf294 (remote rename/remove: gently handle remote.pushDefault
config, 2020-02-01) and does the right thing, but nothing tested that
we wrote out the canonical camel-cased form.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/remote.c  | 2 +-
 t/t5505-remote.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f286ae97538..717b662d455 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -746,7 +746,7 @@ static int mv(int argc, const char **argv)
 		}
 		if (info->push_remote_name && !strcmp(info->push_remote_name, rename.old_name)) {
 			strbuf_reset(&buf);
-			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
+			strbuf_addf(&buf, "branch.%s.pushRemote", item->string);
 			git_config_set(buf.buf, rename.new_name);
 		}
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2a7b5cd00a0..34fc3fa421f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -757,6 +757,7 @@ test_expect_success 'rename a remote' '
 		cd four &&
 		git config branch.main.pushRemote origin &&
 		git remote rename origin upstream &&
+		grep "pushRemote" .git/config &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
 		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
@@ -773,6 +774,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
 		cd four.1 &&
 		git config remote.pushDefault origin &&
 		git remote rename origin upstream &&
+		grep pushDefault .git/config &&
 		test "$(git config --local remote.pushDefault)" = "upstream"
 	)
 '
-- 
2.30.0.284.gd98b1dd5eaa7

