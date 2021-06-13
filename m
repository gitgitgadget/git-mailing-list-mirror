Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46BAC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A926120E
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 16:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhFMQjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhFMQjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 12:39:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7EC061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 09:37:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o9so6772539pgd.2
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2UU6AaCmwTwky380xBv6iY666LGzfCJxQUC1uUuHqAA=;
        b=Cqu5FlEGPf9v7a0LMS1mbKEwg4ZvSg6DQWO7ax9pAjqP53fWNgHyWCjWVdgrsautXb
         STQfQUG3FyurRVpk2LF/LQSfeylb+ZRx2eLFAEgcCX3gbUNkXbnCAsx9Wb0m4D25LQuc
         8jalFTIUfZ7BEA/5fl6gkZao+voTQS7RBHv7OSPgeAyvT/GddZGEtYuqRZkIfKXOUfQs
         oRkpKVLzjO7fY1DtU0vJOJREaakI1JneKhQEiCy0d3KZ4tcBZ1IvEkcA6XkxnvZhzrX+
         IN2Fb+6rDHbwoWguRX2iG0tUG84GIVCTPtkavx7y8doZ9V1b11+IQ1kGgzHo7eklCWun
         wc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2UU6AaCmwTwky380xBv6iY666LGzfCJxQUC1uUuHqAA=;
        b=RHBfRbz6Vhf39NhxLQHGNFB8+QCqpy2cooeGLrN5xrBey75P1UmXNUmawJ4IYHkDQ0
         2ypvuRX8Y+yXIVvQUjCivK3gmfcHYkbCGU+nyUcydjWVqphPZ2KRKbLVtMl8/2uKzEdU
         2JDXFJ2w5YJ5SdsGAie7Aors0NLp4mv1wP7lKv04kP7y1LoqDRSSZdbTgmTo1QuDzuzX
         C+JAvIpeMiMha8E4wvTh7zzDeVjH7b5hFCccEpIbys/eGeNLrBw6iAl/kAJR8dE+mY5Y
         iAB/Yqm8zPr9DTGIyzf/QxfNrRpt9Q0aDGE6yVjbOyfwYW70yISkxGJo92ddhLwZWIR/
         mVIA==
X-Gm-Message-State: AOAM530PDXiMOq5JHxO4/A8UMveoaELId4+3HtIe96M/P7Lrj/ze6YpD
        3eLpbneqsxzXC1qhuxF0PQI=
X-Google-Smtp-Source: ABdhPJzb0f6GbFtiNBftcoY8aMSg6m1/b0v1+ThH8+X/nSYBsfxvQnaY7pIzTh6a1rD1FWrD2Dk9jQ==
X-Received: by 2002:aa7:8507:0:b029:2ea:559:da5 with SMTP id v7-20020aa785070000b02902ea05590da5mr17594474pfn.45.1623602252954;
        Sun, 13 Jun 2021 09:37:32 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id c196sm4229642pga.13.2021.06.13.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 09:37:32 -0700 (PDT)
Date:   Sun, 13 Jun 2021 23:37:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Message-ID: <YMY0SlCNy8jr8T6c@danh.dev>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
 <87bl8928q9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl8928q9.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-13 15:28:58+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Sat, Jun 12 2021, Đoàn Trần Công Danh wrote:
> 
> > +	   { test "x$1" = "x!" && test $# = 1 ; }
> > [...]
> > +	if test "x$1" = "x!" 
> 
> We don't use this test idiom in other places, it's OK to just use "$1" =
> "!". I think we're past whatever portability concern made that popular
> in some older shell code in the wild.

We actually use this test idiom in test_i18ngrep and test_cmp_rev.

I don't know enough to see where should I cut the base line.

-- 
Danh
