Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34927C2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C198624671
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seCyCXfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgKRCQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKRCQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:16:09 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A3C061A48
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:16:09 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so148501plr.9
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TPoc1iKPaZs6VlWxPryLGf+HBhVA40uqjbPQLHX6UX0=;
        b=seCyCXfFfPWIS9fRfNvErcYKGyhhfIYymG+1MfBplwm8z9s3Tg/7Ji7cfMQb+q89ue
         LGZ7vxjup/rSl74qWnIFLOEKxKm3jHcPu9rkB4WGIK8+2f4LGELujNnJzrzpgDoKYcsC
         +9HxDkHLc+BVnWvzmGXnTRB7m2YlJ+bpoCgbcItttOZJwaH0rDo1PTm2QacIi1hJ4RLS
         6/A96zcj0BHN9djHdzxEoQ3Vh0zud1lGhEVQshpEfPSR3bo+mbQ3JVAa66NCaP3SCLQ3
         5k1/JxRjP2PLpmbym8YMhVjHRqcScwcEwmqek+pOXGu1YAhlyeZXbrer7rxdXkKM7ON0
         YAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TPoc1iKPaZs6VlWxPryLGf+HBhVA40uqjbPQLHX6UX0=;
        b=KmCY1DLiOvnj904dbftk5H973Lw5DfjpgS91afAldqeTZaKp7sl9n3xNCScZPTxPsG
         7HtEUm7QB7dabbNGCWV0mH8yGNRHu7JvTZXEul561TxAjuys3diOkBBwjdZ1NXbYrszT
         2jWVLLEdQHCgc1klhJaMOwssH/ejcnQug9w8I8JQ0tNwbZPMBDdCOAy41zIXkgHqhUqz
         kGHXn49+RCZ5oXcc0vIwoK4LUea7ev24DHq5n3tWpQHSd5Axty3S4eqmHo04Lj4mZbvu
         /cbZZl617WxUMmsTGdFXb+44ZYiLrvxHUIv9AprcrdDmRItpyeNR5xvKMp/ZvrUauELq
         rayQ==
X-Gm-Message-State: AOAM532Na7L7MjJ/idz14XqvYV9zO9Ujf7I3WShNx8lhEYEJ9QvdJLy1
        5qmq2TLaBRw9Gw+M/0zRM5o=
X-Google-Smtp-Source: ABdhPJyw+7DS2G0u4KMBnpifQMhOZn1WRBZW1F7kpOOKO5NC92jb3gNP7gKLmoubMA9NLdNDXDLnYw==
X-Received: by 2002:a17:90a:b904:: with SMTP id p4mr1786277pjr.81.1605665768405;
        Tue, 17 Nov 2020 18:16:08 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id o16sm20413286pgn.66.2020.11.17.18.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 18:16:07 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Message-ID: <20201118021605.GB360414@google.com>
References: <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
 <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
 <20181005194223.GA19428@sigill.intra.peff.net>
 <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
 <20181017083340.GB31932@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017083340.GB31932@sigill.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Sun, Oct 14, 2018 at 04:29:06PM +0200, René Scharfe wrote:

>> Anyway, drove the generative approach a bit further, and came up with
>> the new DEFINE_SORT below.  I'm unsure about the name; perhaps it should
>> be called DEFINE_SORT_BY_COMPARE_FUNCTION_BODY, but that's a bit long.
>> It handles casts and const attributes behind the scenes and avoids
>> repetition, but looks a bit weird, as it is placed where a function
>> signature would go.
>>
>> Apart from that the macro is simple and doesn't use any tricks or
>> added checks.  It just sets up boilerplate functions to offer type-safe
>> sorting.
>>
>> diffcore-rename.c and refs/packed-backend.c receive special treatment in
>> the patch because their compare functions are used outside of sorting as
>> well.  I made them take typed pointers nevertheless and used them from
>> DEFINE_SORT; the wrapper generated by that macro is supposed to be
>> private.  Given that such reuse is rare and I think we don't need a way
>> to make it public.
>>
>> What do y'all think about this direction?
>
> I think it's the best we're likely to do, and is an improvement on the
> status quo.
>
> The patch looks overall sane to me. I think DEFINE_SORT() is a fine
> name.

Since this came up in [1], I took a glance at this.

I also think it looks reasonable, though it's possible to do better if
we're willing to (1) cast between pointers to function with different
signatures, which is portable in practice but I don't believe the C
standard speaks to and (2) conditionally make use of gcc extensions,
for typechecking.

For example, CCAN's asort[2] does typechecking on the arrays passed in
and the callback cookie parameter to qsort_r, with no extra
boilerplate or run-time overhead involved[3].

(The core of that macro is ccan's typesafe_cb_cast[4]:

  /* CC0 (Public domain) - see LICENSE file for details */

  #if HAVE_TYPEOF && HAVE_BUILTIN_CHOOSE_EXPR && HAVE_BUILTIN_TYPES_COMPATIBLE_P
  /**
   * typesafe_cb_cast - only cast an expression if it matches a given type
   * @desttype: the type to cast to
   * @oktype: the type we allow
   * @expr: the expression to cast
   *
   * This macro is used to create functions which allow multiple types.
   * The result of this macro is used somewhere that a @desttype type is
   * expected: if @expr is exactly of type @oktype, then it will be
   * cast to @desttype type, otherwise left alone.
   *
   * This macro can be used in static initializers.
   *
   * This is merely useful for warnings: if the compiler does not
   * support the primitives required for typesafe_cb_cast(), it becomes an
   * unconditional cast, and the @oktype argument is not used.  In
   * particular, this means that @oktype can be a type which uses the
   * "typeof": it will not be evaluated if typeof is not supported.
   *
   * Example:
   *      // We can take either an unsigned long or a void *.
   *      void _set_some_value(void *val);
   *      #define set_some_value(e)                       \
   *              _set_some_value(typesafe_cb_cast(void *, unsigned long, (e)))
   */
  #define typesafe_cb_cast(desttype, oktype, expr)                        \
          __builtin_choose_expr(                                          \
                  __builtin_types_compatible_p(__typeof__(0?(expr):(expr)), \
                                               oktype),                   \
                  (desttype)(expr), (expr))
  #else
  #define typesafe_cb_cast(desttype, oktype, expr) ((desttype)(expr))
  #endif
)

Thanks,
Jonathan

[1] https://lore.kernel.org/git/20201117223011.GA642234@coredump.intra.peff.net/
[2] https://git.ozlabs.org/?p=ccan;a=blob;f=ccan/asort/asort.h;hb=HEAD
[3] https://ccodearchive.net/info/asort.html
[4] https://git.ozlabs.org/?p=ccan;a=blob;f=ccan/typesafe_cb/typesafe_cb.h;hb=HEAD
