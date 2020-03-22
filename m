Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E35C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331DB20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 08:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTSBQP6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCVIOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:14:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39557 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVIOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 04:14:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so7844460wmj.4
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STv5DTLbZScQtsSI/RfRaY2aj0Y4wBk+0zGdcDK1h80=;
        b=XTSBQP6iR2y6DwWC0Z5fVsyRibyEyk16jVf25K0ZhMDueXFDwGe5T/NVSbDKJOLnYj
         PfpYBn6eI4XM4/CNNktUlxKud2TaADLytwy8B1y2fao7QiyVKKfYH/NCfn0G2lxBwKca
         ZzfDaY8DbEeXFOvxxbt8PPmHj8b0wH5uJwiBo/ORlLxJ0srHd0DqZjdvOOzf8DnY6Eth
         r/u2sbDLoDUnTZZpcRlllGKvRUNK/+Owbp2wcoSVa2Vg4rqmSEBTeyBL4BjY5bxxPebo
         Pjz1J/V48FHdJkwP6FlEuA4J6Ucq2lGIM4Gq+WCGNEEG+Q6i9Xcaim4YVbcFj1fhla8v
         yMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STv5DTLbZScQtsSI/RfRaY2aj0Y4wBk+0zGdcDK1h80=;
        b=rZteM7+8V0ova5qQTxbw9bagAa5sRIjk2MCLf/4U6v/wjoUmr+Qx4IK3H8uhExAnJk
         IIBjGKRMv8uNpKrfxDMOPezlNpaou05seCYHpOIxc2BM0DMoXyUYwGibycuMnU1f0nJM
         lJLvovBQQUTm3fAZHtpNvfYjl0nyYJUQOwKzLCAaOGfpQaSspwESVSPNTW8RZhOJ7pl8
         U4u7SFaQkHPA54E6XB74jM/vN5zmKscmLl2Bfe6QsOnm+E1kxtaEsr4wQrtgxlW+1242
         YEKxS3wAqiBBZ+LyzEq82I4uJuzmaTHZRwUM4kWsCZHPyCFvv9MssTGnyCMO1p+Hx2Pf
         bs6g==
X-Gm-Message-State: ANhLgQ0eJLuhmegQpPgsEfBzE0OSMYHfn/xTLxTE+wXLm8ZMB0j7umuC
        UJdLImUTvab2A646EhlZMNQ=
X-Google-Smtp-Source: ADFU+vsVwxCYFmkrk4Bc9qOH/x0mWWLXpabe/3/6uttOh6drM0SFRxEKik2oDIch1uM8VOy4jGZT5Q==
X-Received: by 2002:a1c:c257:: with SMTP id s84mr21153694wmf.9.1584864862970;
        Sun, 22 Mar 2020 01:14:22 -0700 (PDT)
Received: from szeder.dev (62-165-238-214.pool.digikabel.hu. [62.165.238.214])
        by smtp.gmail.com with ESMTPSA id f14sm15680995wmb.3.2020.03.22.01.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 01:14:22 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:14:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
Message-ID: <20200322081417.GA2224@szeder.dev>
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
 <20200321062611.GA1441446@coredump.intra.peff.net>
 <CAHd-oW4cGEwyge+BPRGiOsmMxr5ne9Ufk-BOM4EgG_i6qTxxMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW4cGEwyge+BPRGiOsmMxr5ne9Ufk-BOM4EgG_i6qTxxMg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 03:50:55PM -0300, Matheus Tavares Bernardino wrote:
> [1]: Someone that used '-rr 5 6' might have wanted the script to run
> *both* tests 5 and 6. But I don't think we need to support that now,
> since '-r 5 -r 6' doesn't do that as well (instead, the last value
> overrides all previous ones).

Well, that '-r 5 -r 6' should be written as '-r 5,6', but it shouldn't
be terribly difficult to concatenate the args of multiple '-r' options
with a comma, I suppose.

But '-rr 5 6' just looks wrong.

