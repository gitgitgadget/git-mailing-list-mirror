Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA1C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiCBNXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbiCBNXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7DB218A
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r10so2797681wrp.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFBqj4yqMLkzCfZqq3O6PsdGFjsb2eRhVwzE0/LsbN4=;
        b=lbIhD6oS/u0sML4reYxTozYbcY36MXWfQmU4uXMQPApla4FO1TInLWe5VEANmb9sIL
         siDv/XLtEwj6KrY8h+ULjhzC5PEn/mnkF808mYFAICwGkiSORsoOUAF8QDONztYY60ER
         G9JOuGubhKmrUa6QD7fDFPYvNRN10ebjL/WD1w3CrIsQjkCH/yYoW5maMOBXv8DlWXDV
         eUjpsW+RYJEqlNEANogqilh67ysvCdnUWvYGhZ6728wXq+s3QaDKUL8i+SwJNFC8r+Q+
         /BxMUwqYehWK6sOobi8o8JoHhNGePcZ5KQSX54PMVnbzGDsIrtwv386bPx+8uX8XeSpF
         aOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFBqj4yqMLkzCfZqq3O6PsdGFjsb2eRhVwzE0/LsbN4=;
        b=eFWtbpcrpntEqyfsWXJYnBw0hlN6yqxvlaGj0d8gn5zQHCHOGWdtcTeZ0GR4iYDhEv
         Orna6UnoVNXeJ/innYBFnMLCq9LeJ1GWbRuOWCcj1oHQ3I7JQ6ToaHmsmLKoCqwKSoBp
         +tPu00VtSIjbpy3haPCgB/xqSQToQWVBPvIiNTOu0we1J0zQllexesgCD6PrnXnG28dI
         Q7foTZNy8St0oWJ9o1m5GLEHNI+WOLOhWo3GT5SO4JT0dyGluRIXiJOO3sW/ObL2+d2Z
         RTdJoiWJiI8DuQp9S194LkM9tyKhW/uGcZgBlTpAX9OIyrAO5lNWrp2jtMQ+E/eRkT1c
         YgTg==
X-Gm-Message-State: AOAM530vR9+mzPAIPs2dXr7eR1WT/4c9H6qCUH+xjkxXeQ2UIQl10BRF
        j7AiF+buAgwd3JKdLXz94JG32+2/SEgGag==
X-Google-Smtp-Source: ABdhPJxC2UqBTVdW/kleI0wZLPdFyzKNErVvznUV2HxIRRhYfivRNQxCosTviI6xlSYaxNBUSaCqlw==
X-Received: by 2002:a5d:47c8:0:b0:1ef:8e97:2b8c with SMTP id o8-20020a5d47c8000000b001ef8e972b8cmr15172348wrc.545.1646227358045;
        Wed, 02 Mar 2022 05:22:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] bugreport tests: tighten up "git bugreport -s hooks" test
Date:   Wed,  2 Mar 2022 14:22:23 +0100
Message-Id: <patch-04.10-1da2efc9886-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 788a776069b (bugreport: collect list of
populated hooks, 2020-05-07) to make more sense. As noted in a
preceding commit our .git/hooks directory already contains *.sample
hooks, so we have no need to clobber the prepare-commit-msg.sample
hook in particular.

Instead we should assert that those *.sample hooks are not included in
the output, and for good measure let's add a new "unknown-hook", to
check that we only look through our own known hooks. See
cfe853e66be (hook-list.h: add a generated list of hooks, like
config-list.h, 2021-09-26) for how we generate that data.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0091-bugreport.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index eeedbfa9193..3025e685aaa 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -60,18 +60,18 @@ test_expect_success 'can create leading directories outside of a git dir' '
 
 test_expect_success 'indicates populated hooks' '
 	test_when_finished rm git-bugreport-hooks.txt &&
-	test_when_finished rm -fr .git/hooks &&
-	rm -fr .git/hooks &&
-	mkdir .git/hooks &&
-	for hook in applypatch-msg prepare-commit-msg.sample
-	do
-		write_script ".git/hooks/$hook" <<-EOF || return 1
-		echo "hook $hook exists"
-		EOF
-	done &&
+
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	true
+	EOF
+	write_script .git/hooks/unknown-hook <<-\EOF &&
+	true
+	EOF
 	git bugreport -s hooks &&
+
 	grep applypatch-msg git-bugreport-hooks.txt &&
-	! grep prepare-commit-msg git-bugreport-hooks.txt
+	! grep unknown-hook git-bugreport-hooks.txt &&
+	! grep -F .sample git-bugreport-hooks.txt
 '
 
 test_done
-- 
2.35.1.1228.g56895c6ee86

