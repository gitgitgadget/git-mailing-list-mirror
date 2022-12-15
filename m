Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC6C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLOIwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLOIwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B592A41A
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i7so2286969wrv.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hvpBFodT/68WXPxrXfvR7JdsuqQLUhNsBL8k0RXue0=;
        b=bdRkK2tkfUnNr6oo5NGX/oIwG4zTD+9v4hkkB3wxAvkJRgVHg7+6DJPwvz1+fzDand
         EuvaO+r/3ebIfQbQpgzUtuMKABOLpCf1nRXG3QrN8IchnbF6NJb73N6GE/gVvL00J4sW
         mjARjccKLR0WCdArfphNUArol9eS7be8lCRO+j290L5Li3u/a3+vMwzFDmYILEfYPxnj
         +03SWVnL+Pqw+OMkdv79Z1rhWtr/0C5HcCRtmdSY4UkLymv8OkRO+1TplAKBboQOooQU
         k82r5QCJdqHsg3Z47FLmQ/J14iR6Xy0RZPsm63ToASDllTPBmFtUzoX3zpbl10h/MMrn
         Qp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hvpBFodT/68WXPxrXfvR7JdsuqQLUhNsBL8k0RXue0=;
        b=75tLebD7KqRDaNM2m92G9WJwanMl/4b9WKa//MxG2kuQjnSFTmfGDUcPto/Ug+Sbt+
         ERyQ9FKn/rY+MO/DB4MpuwQnI01eKtEvzUJkR+ZIZ7WS0gFa9KL/FCQq6Hrwsm7J+QLH
         TisuNeu2lG4oXtkbFdjqfGxJoTnbWRoxb9ZJsKOGXsR5QxcDUFUaVLvLx4ti+SMnolcj
         1AITUlLUk6XUyAqnJP9Q0mfqVgvS581Otf9Elj2aMII2ElV9f/I13wKbaw3so5AaW85+
         5x5D9x/8BPPyJpRtYnJY08OVBjYzQ7ayZP0vZcDfhsii5LQBz5Yt590M0f6g3YPmmDtD
         5YHQ==
X-Gm-Message-State: ANoB5pnMfRW8HD/caNh48Vlj+/ck478fUf0aBQVIAGYoB4SFhoQFyGbX
        LuHf+dAAyMAFm+8KyHUVjPGTfl1W8We7xg==
X-Google-Smtp-Source: AA0mqf5hsTB9lZHLmhUg1j7v42PNYfNVqEs64/+Jhk510zhRXXdr5i/ppZCHb1qckTtTw+TaARGkcQ==
X-Received: by 2002:adf:e98f:0:b0:242:7f7f:da09 with SMTP id h15-20020adfe98f000000b002427f7fda09mr17215219wrm.34.1671094350540;
        Thu, 15 Dec 2022 00:52:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:29 -0800 (PST)
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
Subject: [PATCH v10 06/12] merge-index: improve die() error messages
Date:   Thu, 15 Dec 2022 09:52:10 +0100
Message-Id: <patch-v10-06.12-324368401a2-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
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
index 3855531c579..2dc789fb787 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -16,7 +16,7 @@ static int merge_entry(int pos, const char *path)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if (pos >= the_index.cache_nr)
-		die("git merge-index: %s not in the cache", path);
+		die("'%s' is not in the cache", path);
 	found = 0;
 	do {
 		const struct cache_entry *ce = the_index.cache[pos];
@@ -31,7 +31,7 @@ static int merge_entry(int pos, const char *path)
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < the_index.cache_nr);
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
2.39.0.rc2.1048.g0e5493b8d5b

