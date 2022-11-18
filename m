Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FEC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiKRLTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbiKRLSm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D31403A
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f7so6690353edc.6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CPQq9eUBF8v9tQzO4la4Afhse7mPXnrmd/49dOdjjA=;
        b=m7f2LLRAKn3wooeQwDuW+PlGsWn1k3qAEIXxinBQCksVElWmxd+Of5vjg46ldSoJa0
         nSDXC8MTzCBje0f51ySNojNM5svl8swt63Fp76/m9IlBmKgVrX54UjT9V+YnFVdjNrUf
         ytK0fDG6qNTIMpjAhTce7RPnlAzawuxWUWKgUB254laEG5wKhqgGRBQwziuMY8n38Tpe
         AQg4Zu9KYcbKz1TPjSP/L9JkEkbiVmoPdMwvc4evVVvEudeRFxI4eEr/BNiTrrVaqLdJ
         cB3/uGdD/I8iteeWxpduxkGfrU0en0M6xMYLt/wTBCRODWaQSQS6h54NYzNH7vwjWkqR
         VNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CPQq9eUBF8v9tQzO4la4Afhse7mPXnrmd/49dOdjjA=;
        b=C9/Mxr3iThWmjqJBzG0FFpoTm34OFCu8PwnxR0hsfA6MmmCNdbNwa3hnR69v5suu76
         IBSzhDNATkS2fjHixrSJ1XQ8QyUkhbKKPtLzKt+hhU6+B/Zp42k9fLY9xAbV3cwEY/j2
         0+BK3pZCbGxT4tiO22M82+7cF28VaoAwJHRFrakkTFc2Ex50LvQM+hAI4UwMBw8n6s0U
         gw4gtIw4Fx1lF17CHnpQDHE6yoxCvBULzl+gZXa0Rq/BceSHgSz/PTt0ZLG4ih72gbRp
         WrykS7dquBHBv1xc8j4XeMPshmdBJ11aeiWRHX4ONu4IHHueeyDhmmAysAeSOd0IBMxp
         otSg==
X-Gm-Message-State: ANoB5pnRVJubP/FuJWuIk7o7uOnemrHjhQw1GuUrUwLa6QDRTQ+6vkwF
        P94l60qWiwwsNT9zk2CWS6T3EVl9skHhjQ==
X-Google-Smtp-Source: AA0mqf5vtiho18KBMtySmDY7Lk5HpHTBnuhLCWcPFMKXEr1/YaLhY2vN6lCpCZC0jNDVq3G3uZ+clw==
X-Received: by 2002:a50:ee03:0:b0:467:897d:eb09 with SMTP id g3-20020a50ee03000000b00467897deb09mr5828259eds.60.1668770318640;
        Fri, 18 Nov 2022 03:18:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 06/12] merge-index: improve die() error messages
Date:   Fri, 18 Nov 2022 12:18:23 +0100
Message-Id: <patch-v9-06.12-fc4e64f669e-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alban Gruin <alban.gruin@gmail.com>

Our usual convention is not to repeat the program name back at the
user, and to quote path arguments. Let's do that now to reduce the
size of the subsequent commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c  | 4 ++--
 t/t6060-merge-index.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 3bd0790465e..0b06c69354b 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -16,7 +16,7 @@ static int merge_entry(int pos, const char *path)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if (pos >= active_nr)
-		die("git merge-index: %s not in the cache", path);
+		die("'%s' is not in the cache", path);
 	found = 0;
 	do {
 		const struct cache_entry *ce = active_cache[pos];
@@ -31,7 +31,7 @@ static int merge_entry(int pos, const char *path)
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
 	if (!found)
-		die("git merge-index: %s not in the cache", path);
+		die("'%s' is not in the cache", path);
 
 	strvec_pushv(&cmd.args, arguments);
 	if (run_command(&cmd)) {
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 6c59e7bc4e5..bc201a69552 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -13,7 +13,7 @@ test_expect_success 'usage: 1 argument' '
 
 test_expect_success 'usage: 2 arguments' '
 	cat >expect <<-\EOF &&
-	fatal: git merge-index: b not in the cache
+	fatal: '\''b'\'' is not in the cache
 	EOF
 	test_expect_code 128 git merge-index a b >out 2>actual &&
 	test_must_be_empty out &&
-- 
2.38.0.1511.gcdcff1f1dc2

