Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D613C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673A723358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbhATPev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732346AbhATPdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 10:33:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843DC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:33:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bx12so12244632edb.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YIG+J7MiB5sS9rWPyNto+7moWAPbQjN1aO1bYsWW0jg=;
        b=I/vbHC8qXkW1bRpkPG/s8aaiStQZ3ZBpyXHbVnqgdcKsnsz21uPjMHSVkewktPS/U2
         zZDz1IZ8i2munIbdRepxRHmWlyE3sLEdokINcjzohGxEF0WokJy7t0T2DmK2Bo6BtTIl
         xEwhvjZ5N1NCvaxUiTTRYQG9gKQ/WapoixWWGmnCJWq5g+3zIMN1puNiGRIqXs1JKS4z
         EiBbB3lxAsjKwI9jBbNWzKgCIyMF6+/0Xb00yXxVWMhMVmUcqFxQ681xIs5lw718M+x8
         D74uLF7qdcNYaE0JdeVpghmxrasp6gPQ/l9rGJxBaa9FP1HplZ48lWogMoTiB9iwQ+A+
         R8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YIG+J7MiB5sS9rWPyNto+7moWAPbQjN1aO1bYsWW0jg=;
        b=sgkxgeuThFnimWNADWrrlaJrdW7JDlihKgackjhYD1Rn4+rIkaIRtqUzbnqA6tndtv
         hYS9X1Gykrmc5QNIitogijzbc6VpyDOI1GKED5BlFwavsnPsx5Q/L/OTPHm30lJs1eq5
         +M0ex8w/nnVjT5dpjldJ9vQdo9Lt/SmH3kcU35vHPqUmfuo49tkQ2bSgK5Sj5C5zmzcz
         iyLW5KV79ks8VXFZnM7Z7l+lttMwjAdPhq4xQm3JUejDKACo45aTYJmL+StYikSzVT92
         +k+Dfw5qswqUgIYW9VVJhplJI5XVTOd7IoSG+u3sTnZiSnJ8pPzF1+ikAlo455UYHErJ
         uufw==
X-Gm-Message-State: AOAM532rRI1HMqnBcuB8ABfFZ0mlxLSCR5gj/qnPoVXehOmfo85A/AUC
        gT9joTIsBDIF6Anu1KVHBp4=
X-Google-Smtp-Source: ABdhPJzC/ZXPBhnIE3Gdh0AeSggK3DjI/pkKk0MgisqVMO562mjm9foWC04idxRxAeb6kxQgBI875g==
X-Received: by 2002:a05:6402:34c5:: with SMTP id w5mr7857094edc.65.1611156789038;
        Wed, 20 Jan 2021 07:33:09 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id i4sm1042698eje.90.2021.01.20.07.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:33:08 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:33:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 0/6] Remove GIT_TEST_GETTEXT_POISON facility
Message-ID: <20210120153307.GD8396@szeder.dev>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111144740.6092-1-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 03:47:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> As argued upthread and in 2/6 this test setup has outrun its
> usefulness.
> 
> This series begins to remove it in a way that's very careful about not
> stepping on the toes of any other in-flight patches. In particular
> "master" isn't anywhere in the diff context here to avoid conflicts
> with the series to do that mass-replacement in t/. 
> 
> This series merges and tests cleanly in combination with the current
> "seen" branch.
> 
> At the end we're left with a bunch of tests still using
> test_i18n{cmp,grep}, but I think that's preferable to having in-flight
> conflicts. It'll be trivial to search-replace those at some point in
> the future where we don't have another search-replacement series
> amending t/ in-flight.
> 
> Ævar Arnfjörð Bjarmason (6):
>   ci: remove GETTEXT_POISON jobs
>   tests: remove support for GIT_TEST_GETTEXT_POISON
>   tests: remove misc use of test_i18n{cmp,grep}
>   tests: (almost) remove use of "test_i18ngrep !"
>   tests: (almost) remove C_LOCALE_OUTPUT prerequisites
>   tests: remove uses of GIT_TEST_GETTEXT_POISON=false

At the end of this patch series there are still a couple of remnants
left:

  - t3406: has a comment about gettext poisoning.

  - Makefile still has a warning about for the GETTEXT_POISON build
    knob referring to GIT_TEST_GETTEXT_POISON and t/README.

I think both can be simply removed.
