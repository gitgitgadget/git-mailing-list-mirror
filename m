Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08AF60F48
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhIUP6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhIUP6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:58:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D7C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:56:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v24so76152794eda.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QTXS1XrB+jGXzC81oS8Tjyer40eeZG1HBLpur1cQBRI=;
        b=mQvIK1khoCYnW7eDpiBIcKgIvHZf0VSGTTWMx/P/c/QeeJnmfhjocoHJkcdDSH555G
         pRwEfrcX4/T8l/j2OwB/llhBcCVWz0R9GYvpBgtZuMaQRagWlybcWOcuvdMmIcCN+LBM
         zXuKQRDKmH/DsRgM3pka1+r+XL6evawnEHmn8tbL5jpzpWPcANNlbKirmkfwSkdca8AJ
         BFWXt2wxGnUJm/wDWRb51MMa8N9h7EjFqLqDjm0vcMueYPYcAPsiN3FFMjvaH4JSeTG3
         iU9oY7CDqrOJd7SDWQVkwyJULLk0TiN0HAF5iITI1mhL/E693OWUbklcOAVLY3vyQV1a
         u8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QTXS1XrB+jGXzC81oS8Tjyer40eeZG1HBLpur1cQBRI=;
        b=5dhFdKtcNCLHUJOjQhA8lfl7id6EtwBvEibCWnY2H7v7YLdSYQQ+rL1pYotTbUQ9ja
         NKoAxlPTCyPFMldE5AAapkDbeGXQp1dlRrHgaMh7p79aFKbm40Z+4s/KtTYo13mGs/HX
         dXfxYTP1yuMXga9vspzf3tZonDapRUSznbN1bgo0XQacP+Egya0FBUaH8ftmGg2n/W9e
         6CRo/B0ukIU6nBxrx1CwDKlOpkBOhaQGOUTJqaAZMZYnUmvvWnsb+TwnEDvk06jw/N5F
         PwaeAjdQ2xZ0G46lkAW9Ejm3nauQ8zsQR2A+VP4z/YYeg/IOhqvrRcFPPXQ38a8pstf1
         IDqA==
X-Gm-Message-State: AOAM533cmB/ddLLLy8znw/6VfLuxNHHdbAUEm/bWhb5e4rbh0h0c9AL9
        ZEnAqdumOrOOtzIueb3c7MwJ9ltkfp/QtA==
X-Google-Smtp-Source: ABdhPJzMSRFmCV7j1lfr9vhccSkmeUvRU5xqJpIQLO1BgnefgGFKnU5c4OUz6l922Vw20FcAyxkeNg==
X-Received: by 2002:a17:907:2cc6:: with SMTP id hg6mr35933439ejc.449.1632239687200;
        Tue, 21 Sep 2021 08:54:47 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l2sm74944edc.23.2021.09.21.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:54:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 6/5] grep.c: mark eol/bol and derived as "const char *
 const"
Date:   Tue, 21 Sep 2021 17:17:57 +0200
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <patch-1.1-c317e6e125e-20210921T124416Z-avarab@gmail.com>
 <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUnx7gt0KQNRlhuZ@coredump.intra.peff.net>
Message-ID: <874kadapq1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Jeff King wrote:

> On Tue, Sep 21, 2021 at 02:45:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I think that generally git's codebase could use going beyond just
>> "const char *" when a "const char * const" would suffice, for some
>> reason we seem to mostly use it for the static usage variables.
>
> I didn't dig up the references in the list archive, but I feel like
> we've had this discussion long ago. One of the reasons not to do so is
> that it pollutes the function's interface with internal details.[...]

Are there cases in my conversion where the caller has to do anything
special that they didn't before? These are also all static functions, so
it's all internal details exported to nobody.

> The caller does not care whether the function is going to modify the
> pointer itself, because it is passed by value.

Sure, it's for increased clarity of reading te function in question, not
its although in one case we pass a ** so you can see what exactly we
modify both from the callers and function perspective.

> You could apply the same logic that we should be passing "const int",
> and so on.

Sure, in general I think churn like that isn't worth it, and "const char
*" is usually good enough, even if it could be "const char * const" or
whatever.

I think it makes senes in this specific case where you need to read one
function after another with "bol" and "eol" variables, with some
treating their copy as immutable, others not etc. Particularly if we'd
convert it to some other style (e.g. str/len) we can see if an entire
chain of functions can all be safely changed over.

