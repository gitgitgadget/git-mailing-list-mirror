Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5DC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0892460FE3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhILWT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:19:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49529C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:18:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t6so9937563edi.9
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Asvr3QbgppqsWk0oq6iBEQOz9OZPjY1Tx3KLYNqjd14=;
        b=FzcrraJGnAvn7ZiwSDoZymA9C1FyZJYX2cIFACnbXHdno1sLSo7WPygktljexG3QlF
         V2b/8Oigwu6vJU0WY67ZrM05KZIdrsXKR4eS4S+iy9UmJOf5LzZPUveYBRA+59u6Obvq
         08r6g56911CCF2yhs94CGj9UxrAMhwCbuW+8VcCKTnr0KhE2S4TyLo3ZUHZNBFeEmjnr
         UupCdilp9WtxmNYYLxPIX1nyPrbN2DCdAzVbIs2Ow2QFprtp6ACp4RAqHhjROVPstnsu
         yzpu4HmTZLUmbrGby3oQLGuUIyWLMhapTgcjiRm8ehLMWTL4xglHqc+6dphFGpCn6O0m
         4EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Asvr3QbgppqsWk0oq6iBEQOz9OZPjY1Tx3KLYNqjd14=;
        b=fN6A9h9Ism8+sa4sv1SrERE/IccTZI0BHYDiXy7cKiMPYmp6/KwG6h1554GMPSifSy
         eDzK+7f6h+sX1vA7pQg463cjxi3NX2wMJFZvP9fOF9JpM8GA5yMrNHSN6XLzHGWk9gcw
         uN+fgeuRlGnYGez/LKZuQRR7VBt+s9yPJ/8G6aU+13F6mykWAYz71URhKA+eVzhQpHYO
         gJvsCqPNL0sB8H3X2Oy/G2l2UQbHL+yzAL2QWe7Bam+n3kkDVHeFVUxoJ8kRuHyf5LZU
         VVqROCNlSf0+Bp2V766Id0LccjaSBwxiMeidcBAnSbEjyXpkYw3v49mVo10xVQOuQZPh
         jQ2Q==
X-Gm-Message-State: AOAM533FEP9JuYi3lehFhbZIOno06otBPsBu2ddhXTfdcTiy/U5qSa/u
        s1hr+igPCaFp9cHDx6WSEQk1IvCKwjuOAg==
X-Google-Smtp-Source: ABdhPJyPpZxo5phF8dQJwmu6+7TgW0KifEX0jkhF8sygSXI/mnyk3bmydU1JPTQUxW+oYeoLModVOA==
X-Received: by 2002:aa7:c2cb:: with SMTP id m11mr7116742edp.150.1631485090599;
        Sun, 12 Sep 2021 15:18:10 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x13sm2520456ejv.64.2021.09.12.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 15:18:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 02/14] t1092: behavior for adding sparse files
Date:   Mon, 13 Sep 2021 00:17:12 +0200
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <61c23dc59a6e062e073ba3bea135c370a78415aa.1631453010.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <61c23dc59a6e062e073ba3bea135c370a78415aa.1631453010.git.gitgitgadget@gmail.com>
Message-ID: <87lf415tge.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Derrick Stolee via GitGitGadget wrote:

> +# NEEDSWORK: This documents current behavior, but is not a desirable
> +# behavior (untracked files are handled differently than tracked).

I wonder if a test_expect_failure test would be better for the thing
that is the desired behavior, but maybe we don't know what the CLI UI
for that would look like yet.


> +test_expect_success 'add outside sparse cone' '
> +	init_repos &&
> +
> +	run_on_sparse mkdir folder1 &&
> +	run_on_sparse ../edit-contents folder1/a &&
> +	run_on_sparse ../edit-contents folder1/newfile &&
> +	test_sparse_match test_must_fail git add folder1/a &&
> +	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&

Just "grep" is preferred over "test_i18ngrep" now, the GETTEXT_POISON
went away.
