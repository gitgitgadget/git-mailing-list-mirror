Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C989C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A9561008
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhDHW7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhDHW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:59:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225BC061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:59:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o18so1933051pjs.4
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GdNT7KXR79cP8dLkoYHpyVWvNHrdLnZxougqpg+jmj8=;
        b=kkqMNfsdFS5loG41Ulb82gRys68CcAjKj8sejcrmgtL2O3rwpcPZxM0Z4VbWIKHXKe
         SwEzKiZf7hZb3G3NjH/I8HJQEW+9DfA6Iq3UZQZdGBn5HOxuKKn7rGxawX021Cc5azh7
         xNqy7orh+QczOalx+BmfoD2wL/6jAH3d0Bh22uMstQGt6tTEVgeAT1NBIsTCRylXbLCD
         MfklDBgCHe7GKgI04kVFQrp4jiw4uuIOXm7pvZfpEnzTt2TOuiP/dCYSQ2/gzAKZ+jNI
         TUnBd3CUY1vC07dCiPbFmHvvqjM+Wh+jdg/8YuD0NbLF8fNJILjCqMwCVlJ+tK0Goijc
         PzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GdNT7KXR79cP8dLkoYHpyVWvNHrdLnZxougqpg+jmj8=;
        b=Y3q2lOfugVlEEFlL7UAvA5C1r7z3PROQlvt/CaRFcbKKjDuzjmERJA1Id9Vag6wdw7
         yWfkioQLC7+9YY55ZYs6ZHxT3Mn5N5sNeb4gx89gkCpkatZrdc0w+mFcMnU4Av4iVuds
         wyry7GFyv0ny/3LsCS9mbcZvq69lLLCG0rn4gbYLpP29qI5BbFJCLPuJBapbEvkHwnvS
         VKS15jFbXV0FK057fol3uwX5/cNOy7386K2sk93hNruJWraDcg/EX36EZl9oX2w7IWih
         Oniqdm28J/xgdhwxBC60HT1af26teaWc2dH9XJr9j2xgorA2rqe94BZBvULW8udRiYbm
         lAfA==
X-Gm-Message-State: AOAM533Sb9KFSddVgvuUqKRN8o+uAhO7WuQEPsm9RYZCwUhuA/ejtOHR
        sjsNcuaJ+3sjlWnDoU9ayrs=
X-Google-Smtp-Source: ABdhPJySOfw/QA5PWUoFzS/biWtRVU2vtyKG2MojljiuX2PfiFhi9q8oVGsXpQOiBj6XYdhqM3UzjA==
X-Received: by 2002:a17:902:bb91:b029:e6:bc94:4899 with SMTP id m17-20020a170902bb91b02900e6bc944899mr9922993pls.25.1617922758179;
        Thu, 08 Apr 2021 15:59:18 -0700 (PDT)
Received: from localhost ([2402:800:63b8:e237:6144:daaa:2a78:8b4c])
        by smtp.gmail.com with ESMTPSA id j21sm415536pfc.114.2021.04.08.15.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:59:17 -0700 (PDT)
Date:   Fri, 9 Apr 2021 05:59:16 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v13 5/5] bugreport: add compiler info
Message-ID: <YG+KxG8Nahl2OtyL@danh.dev>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-6-emilyshaffer@google.com>
 <87k0pcifev.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0pcifev.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-09 00:23:52+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > +static inline void get_compiler_info(struct strbuf *info)
> > +{
> > +	int len = info->len;
> > +#ifdef __clang__
> > +	strbuf_addf(info, "clang: %s\n", __clang_version__);
> > +#elif defined(__GNUC__)
> > +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> > +#endif
> > +
> > +#ifdef _MSC_VER
> > +	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
> > +		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
> > +#endif
> 
> Why the ifdef/elif/ifdef instead of ifdef/elif/elif? Isn't _MSC_VER
> mutually exclusive with __clang__ and __GNUC__?

No, clang-cl is a MSVC emulation from clang, and clang-cl defines both
__clang__ and _MSC_VER. See: [mail].

AFAICT, clang-cl is production-usable, Google uses clang-cl to build
Google Chrome for Windows fro 2018 [blog]

mail: https://lists.llvm.org/pipermail/cfe-dev/2016-March/048147.html
blog: https://blog.llvm.org/2018/03/clang-is-now-used-to-build-chrome-for.html

-- 
Danh
