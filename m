Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F65C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B853661178
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGUBCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhGUBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:01:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D99C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r11so376211wro.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FatQESMdxjTv017icNsVsMBtN1cbyEjxJj/PZ8GgCvM=;
        b=osavVzMXoNfw54vDyqUkuu3WNsgQXZ7Cz2UF34VpbC3m4y3EuhGGdIVwgF+1bwJK8u
         twsoZpFvPWq2T2H4mByzPntl1Lzl1mMoDFOUSEUvPjjmLulaCqIzxwOPXb1MenjFHfvW
         2tsovw0qEXf1yJcjo3DO0CEpax1nmqfHsCEOcL6gm9EFgSsAxUVDX0q1AbG86dc8p9yW
         3El4o+RLa6ivIAqgHu3GAlGQBzBp5wCByRyBPAqpiZZMzPRhjiPfn5Jz8h4zXf+aq6dv
         SM0qXnc7kY/5pygIKR+HCxKNteeE8L+cp0i8SpL6PleVjZniD9Cc9Sux8iyu40i2aJn4
         u2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FatQESMdxjTv017icNsVsMBtN1cbyEjxJj/PZ8GgCvM=;
        b=t2jKlx8YZ4GPjCIaYVthT7oTuGgwzW684bGXpN0+WzW/0VuSNgcMWlCneBicbNPVbP
         MC278b6TV7SHGrcbXPaZ/s9vCDCAvSHFOwQrXfHPEpNW1xVG6ks9EiB58k4RRU2I5qAv
         cUZSoEIhqP50gN+0TUTvHp5m7TRXb07CJZguFEovpNFmdBMwYwmX6NCbXO95fF3Ih0jV
         Ts0hNA7QtIHtZc3ZzV+Bu5klKcKTpF6F9fRHhTybM0FGzEFuaygH21awHXDyIpqZFc6w
         hpWGY+ZIEeiuHT1zUxjPVyljhBXcuN69hLvkx6KaRf4xslzcgryh8GQxHvYo/Fy0hd7H
         g7kA==
X-Gm-Message-State: AOAM530JxRvq+edobsMmA6775wsVIoY2vNY8/bw7U829Gprk7HJrM6me
        /NrwaoDQyLxuo/gXfWvFrJZr6OcMNcg=
X-Google-Smtp-Source: ABdhPJwNhYrnXH3aYaE+c1VeJclswxl0HQDNmGcvEhKg2RQ1Oy12DnMqpmnF4vxsAXh12m9UJIZaEg==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr40306905wrw.30.1626831747438;
        Tue, 20 Jul 2021 18:42:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm3245667wrs.44.2021.07.20.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:27 -0700 (PDT)
Message-Id: <66fe7f7f9341c11bc72eaf4cfa7b1d6c658e31a8.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:18 +0000
Subject: [PATCH v2 2/8] t7601: add tests of interactions with multiple merge
 heads and config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were already code checking that --rebase was incompatible with
a merge of multiple heads.  However, we were sometimes throwing warnings
about lack of specification of rebase vs. merge when given multiple
heads.  Since rebasing is disallowed with multiple merge heads, that
seems like a poor warning to print; we should instead just assume
merging is wanted.

Add a few tests checking multiple merge head behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index a44e6e69f2b..21db1e9e14b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -325,6 +325,28 @@ test_expect_success 'pull.rebase=false and --ff, ff not possible' '
 
 # End of groupings for conflicting merge vs. rebase flags/options
 
+test_expect_failure 'Multiple heads warns about inability to fast forward' '
+	git reset --hard c1 &&
+	test_must_fail git pull . c2 c3 2>err &&
+	test_i18ngrep "Pulling without specifying how to reconcile" err
+'
+
+test_expect_failure 'Multiple can never be fast forwarded' '
+	git reset --hard c0 &&
+	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	# In addition to calling out "cannot fast-forward", we very much
+	# want the "multiple branches" piece to be called out to users.
+	test_i18ngrep "Cannot fast-forward to multiple branches" err
+'
+
+test_expect_success 'Cannot rebase with multiple heads' '
+	git reset --hard c0 &&
+	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	test_i18ngrep "Cannot rebase onto multiple branches." err
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
gitgitgadget

