Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F488C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358B661396
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbhDZUIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:08:38 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:39690 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbhDZUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:08:37 -0400
Received: by mail-ej1-f44.google.com with SMTP id zl7so6600412ejb.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiN+FbsrVQdH/cuOL4kJ3K6G6HCdBa6asMXnCzufWtQ=;
        b=fjRrGOBvDkeAovkslkQz+bJU/0/oUpH3JWk7ImY1Y3pnN8xSjnuk+tACFZwlt5aIVF
         UHCJLdckRW0DM3xuf6vRMDe/UAhO9OM7jvxaFKPG3N/QvPtWCouGKHPaDOMe0lnhYaO4
         eOjqq1l6WZsP8xL+/ugbgsy2HkhhqSttadkopBsycCQlYOe5aTL9AJvoxOsxCe24ON2D
         XhLnXjAKCAVUkFABYf7qHPLI+5rNiOXGerX7kWM71wyZ+KvokEaNRs19Lpj0/N/sqEE1
         CuBeRUBztHS8p0+0xm6EySVuKKlXMgn4N86nAiDgr1P0lCq/GYYaF9LO3UNBA4hcm31D
         +lXg==
X-Gm-Message-State: AOAM530qjp6B1JqeA4syHJtiipGK7JCKM16ux4LtLsyTFaF0GhraB5Qo
        RSMXynDbNHsbYZWevC+pP1YAeIz8WJICm5MOClfCLS8drvI=
X-Google-Smtp-Source: ABdhPJytAj4JAsDhDOPOCG1LHklciezDZY1FjhERtHVh73dMiMOtsGnNK9edq2lQu9oISVUYzmMLwdteBbr1NO+RaLk=
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr382142edu.221.1619467328306;
 Mon, 26 Apr 2021 13:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <304fe03034f8622aa8728d8872cc9bc539bab861.1617291666.git.gitgitgadget@gmail.com>
 <3f0c5c7d-8448-15ec-9e12-b2745d7bbf2b@gmail.com>
In-Reply-To: <3f0c5c7d-8448-15ec-9e12-b2745d7bbf2b@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Apr 2021 16:01:57 -0400
Message-ID: <CAPig+cSNJYh-cTxghPiaAxKhYENDKbYO8jrdvoBsB3Eq0GYWjA@mail.gmail.com>
Subject: Re: [PATCH 11/23] fsmonitor--daemon: define token-ids
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 3:49 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> > +     token = (struct fsmonitor_token_data *)xcalloc(1, sizeof(*token));
>
> I think the best practice here is "CALLOC_ARRAY(token, 1);"
>
> > +
> > +     strbuf_init(&token->token_id, 0);
>
> This is likely overkill since you used calloc() above.

Not quite. A strbuf must be initialized either with STRBUF_INIT or
strbuf_init() in order to make strbuf.buf point at strbuf_slopbuf.
