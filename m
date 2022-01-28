Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6D4C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbiA1KPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiA1KPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 05:15:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01FEC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 02:15:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j2so8792266edj.8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=PgbZjWJViU94i+SolFI2zQ/Yw8hKG7F4xDbHle1+wdU=;
        b=La/Xatx6NJEDJOIY4EK1xf7qQY9sT+f1SwnovXMGBHcLwjPnvKGKB4SOChEurx7R8B
         rKCKh9CQcVzyCU7UeEqLLyr/bGlXnn4azBV1v33H6QWXjsNkOULCck3+rNX8/D7LKFfH
         KAuqGHMO3YVxKqc6x60EBl2q1SCZmb/n50gJtCprypONXuh++lzlIp7/GNL5W2zzKuRt
         dUmYWbwekgdI855+GEqW0Um+RuiXXngGpe8ApGwGBqSZucm3lTGdFiNnGW099j0wS5TR
         48hldnfbkYKg5Op0CnhkbodI7qOa7xRAtyhfDtji7hxhdK8ocpOH7FFDpqZEEkYhqvEw
         rT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=PgbZjWJViU94i+SolFI2zQ/Yw8hKG7F4xDbHle1+wdU=;
        b=L36mMHfXGaJmRBGo6u/6cG9MMMW7tOlzSMp2QIYgI0i9yTeSDVhJXJ2ptwIGplhzWJ
         d2pPmNi5bxGEILaFC7mNtBTa2LxUf3RnyFhgJ52Ugwkap6nZ2nWu/B/JFR3aq+0+GMmh
         hFnq36L5hOTFngA+c5zWob9BzgB8UDSHBf0ZfXtoOiCL7PXga8MlrwOsn7TZ+58Inmxn
         GaGWuXsYelchsVS5xkxeUNwAhQfcHuAYsatGIbjuntUtn5Bn0IXKgXqqIzEgVhdvIHkB
         lR6bDqghbYTsnlbGzybSx/JKg3zW7XKVPJ/18QlSJ4baQe8vYBftD/sjLZIZoqe+HhHu
         fJ6Q==
X-Gm-Message-State: AOAM530bWd6SyrWHXxmvI0CtGiw51H3Jb7n+shhgqWvOfUBu+6mxRzqm
        KIaXhf81NdhkJy3uN9bK6gRA9qphPIro4Q==
X-Google-Smtp-Source: ABdhPJzt/Zu43kY8nNLpm8VebD8eL8YLzbHhWz0WVrTTZbEqQDhf5r9jAdZ+ex4BXxoirNP+NKIGlA==
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr7686716edu.197.1643364948711;
        Fri, 28 Jan 2022 02:15:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h15sm9866539ejg.144.2022.01.28.02.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 02:15:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDOIF-003edM-NR;
        Fri, 28 Jan 2022 11:15:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Git ML" <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: BUG: Various "advice.*" config doesn't work
Date:   Fri, 28 Jan 2022 10:33:29 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
Message-ID: <220128.867dakcgj0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$subject, which I started looking at because in 4f3e57ef13d
(submodule--helper: advise on fatal alternate error, 2019-12-02) the
scaffolding was set up to read config, but nothing actually did so. So
"advice.submoduleAlternateErrorStrategyDie=false" has never worked. That
can be tested with:

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index a3892f494b6..8918be9ef5c 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -193,7 +193,7 @@ test_expect_success 'missing nested submodule alternate fails clone and submodul
 		cd supersuper-clone &&
 		check_that_two_of_three_alternates_are_used &&
 		# update of the submodule fails
-		test_must_fail git submodule update --init --recursive
+		git -c advice.submoduleAlternateErrorStrategyDie=false submodule update --init --recursive
 	)
 '
 
More generally, the advice API should be made to panic in
advice_if_enabled() if nothing has read the advice config, which would
turns up a lot of other such issues. I can't think of an easy way to
check for that. We could add a BUG() on:

    if (!the_repository->config && !the_repository->config->hash_initialized)

In advice_enabled(), but that wouldn't catch things that have read the
config, but which aren't actually using it to check the advice config.

Probably the inverse would be a good approach, adding a
advice.default=false to turn them all off by default, and then BUG() if
we ever end up emitting advice anywhere (except if other specific config
told us to enable it).
