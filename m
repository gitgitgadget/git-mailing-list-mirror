Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C728C61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 16:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBRQle (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRQlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 11:41:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5812F1B
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 08:41:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg7-20020a05600c3c8700b003dc57ea0dfeso784184wmb.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VBfg4n8SOC7bp+8SGmeykcAgJwAkFgCMlki4P7OXbxM=;
        b=pQUl3zwtP2DSWRD00TAzJNeN+SIIwv/9acy3DDTNinYquQ6kdoHXUSErZsPfLawKe5
         A2TRIp0XgJlyciU1CHWeUARWnXKYHE7HSANT8sozttaN3QwGn9Pk8IeF9mMkFXOXDg/i
         Jblt3/9bUU3X82t+C6NGQwtP9GL8CzBNj1IOz2kVUnevpvn6B5EUJKrIyqOtkAlGZZ9k
         98y/rpa1r2wYiC5saNMfIgVV2JIgY0jjALL+TJhxATqBlEd2KP4dd0EEmfv6UNNRZ92+
         cLQ9S5f4dAd+b6mEKwsLeYAjlPpc96jEUzaBaWUZ7IBVV+aOfdUuwaQRuRfsDAtasmr1
         DuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBfg4n8SOC7bp+8SGmeykcAgJwAkFgCMlki4P7OXbxM=;
        b=z+jlhBgOfRSR9DqhEedB5SU6k8UL9Qp4B6vIUGKYIMMGXOyTOOk4ygQj7WH8h1vj6T
         lI26YaJ7+wzBMHP6h35Dc2DNnj92DK/XtZI4LbX4wI0+oMl2F1krJmiS6JzRF6Pj3qFR
         glHv+F7f4A8yU+munva0pEl5NorudaEDpRSFj4SXWNfqB5q1YcnbosT3uAg5jzE7OaFU
         9J4S56qJpt3EobjFoxyQn+5J7QSLB2KAva8fQlH9lShcOZC+6lmJ2NYIR1CGjSsPD/Uf
         5whyNRRRQoeJxUk/nfYdl0NtYheQlA32+xsoaZuRU0Dy4G9G7ONLNiWPlC69dQC5Xbt4
         3xxg==
X-Gm-Message-State: AO0yUKUx/5YYcLkTGUXRkOSZ2/rgQeBSBFZsIB1/KWox8/Y3lRwEjkH4
        UQ4uXnljfFz0iUZvdA/mp0Dsi7MPeQE=
X-Google-Smtp-Source: AK7set+M3+fPX4r+ihy1BT76EjUtY0kbe0/Pht0ejCU7XkQU0GO2QHM+Y+aayo0mt9ETPwS99SPgQQ==
X-Received: by 2002:a05:600c:746:b0:3de:d52:2cd2 with SMTP id j6-20020a05600c074600b003de0d522cd2mr2768227wmn.4.1676738490063;
        Sat, 18 Feb 2023 08:41:30 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id k37-20020a05600c1ca500b003db06224953sm9490178wms.41.2023.02.18.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 08:41:29 -0800 (PST)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] restore: fault --staged --worktree with merge opts
Date:   Sat, 18 Feb 2023 16:39:36 +0000
Message-Id: <20230218163936.980-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'restore' command already rejects the --merge, --conflict, --ours
and --theirs options when combined with --staged, but accepts them when
--worktree is added as well.

Unfortunately that doesn't appear to do anything useful. The --ours and
--theirs options seem to be ignored when both --staged and --worktree
are given, whereas with --merge or --conflict, the command has the same
effect as if the --staged option wasn't present.

So reject those options with '--staged --worktree' as well, using
opts->accept_ref to distinguish restore from checkout.

Add tests for both --staged and '--staged --worktree'.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---

CI run: https://github.com/ak2/git/actions/runs/4210823089

Some more explanation: when finding that 'restore --staged --worktree'
with --ours or --theirs was accepted, I assumed that it would do the
equivalent of 'restore --ours/--theirs <paths> && add --update <paths>'.
As it doesn't do that, I think it's better to raise the same error as
without --worktree.

 builtin/checkout.c |  6 ++----
 t/t2070-restore.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5155cf55c..b09322f7c8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -489,13 +489,11 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("'%s' must be used when '%s' is not specified"),
 		    "--worktree", "--source");
 
-	if (opts->checkout_index && !opts->checkout_worktree &&
-	    opts->writeout_stage)
+	if (!opts->accept_ref && opts->checkout_index && opts->writeout_stage)
 		die(_("'%s' or '%s' cannot be used with %s"),
 		    "--ours", "--theirs", "--staged");
 
-	if (opts->checkout_index && !opts->checkout_worktree &&
-	    opts->merge)
+	if (!opts->accept_ref && opts->checkout_index && opts->merge)
 		die(_("'%s' or '%s' cannot be used with %s"),
 		    "--merge", "--conflict", "--staged");
 
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 7c43ddf1d9..373dc1657e 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,4 +137,26 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
 
+test_expect_success 'restore with merge options rejects --staged' '
+	test_must_fail git restore --staged --merge . -- 2>err1 &&
+	test_i18ngrep "cannot be used with" err1 &&
+	test_must_fail git restore --staged --conflict=diff3 . -- 2>err2 &&
+	test_i18ngrep "cannot be used with" err2 &&
+	test_must_fail git restore --staged --ours . -- 2>err3 &&
+	test_i18ngrep "cannot be used with" err3 &&
+	test_must_fail git restore --staged --theirs . -- 2>err4 &&
+	test_i18ngrep "cannot be used with" err4
+'
+
+test_expect_success 'restore with merge options rejects --staged --worktree' '
+	test_must_fail git restore --staged --worktree --merge . -- 2>err1 &&
+	test_i18ngrep "cannot be used with" err1 &&
+	test_must_fail git restore --staged --worktree --conflict=diff3 . -- 2>err2 &&
+	test_i18ngrep "cannot be used with" err2 &&
+	test_must_fail git restore --staged --worktree --ours . -- 2>err3 &&
+	test_i18ngrep "cannot be used with" err3 &&
+	test_must_fail git restore --staged --worktree --theirs . -- 2>err4 &&
+	test_i18ngrep "cannot be used with" err4
+'
+
 test_done
-- 
2.39.0

