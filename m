Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E200EC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiIZHQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiIZHQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 03:16:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCC2EF07
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 00:16:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso11997318pjq.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=g2skRT2AxEbiPmkhxiq2bP/il2RYO/K+5vgsCiU48Cg=;
        b=aLj8Iuude5ItHqeUMAhHRf5gcAEvlF8rjaT3EfRB1JJzVNtljpOyNixwjlbGAJlvVa
         QQUgN7x+oTSAp0/FGo5Z5xmpMiCJajmhpzen68eIgHWFWtZorl84WDMx0lVNE1Ivl6K7
         AQMahnEfudW2BttYodAyFELqJjWTlM5XpAaYZhW17zIKTDQKHC5paUqiymwG1PIASp9b
         f8IJjtZjSKS/9hg6VLKqiubuKU9ztDkwGtrf+WUIXO/82CL8csLgQ4L04CX/+RsN6LEa
         hWjsA3vNol/wZd65kSVcYIEsFcMp4ggC8/vFU2GotOYyZtHLrLrJsYWq3wc9LMwxtgpN
         uiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=g2skRT2AxEbiPmkhxiq2bP/il2RYO/K+5vgsCiU48Cg=;
        b=OfhV413rvgLDYyRNbTCd5mVtFm0NKnZ48FVoSrBW7DasY5r7Ruz+eN2P70u+BwFpZN
         y/rB+wLp4Ce82uGkbf3UmN6ERMCt8Kh6H7999se+DixPxOpbEXL5qwXxISCOijjM4GFg
         8i8Mh104vtjOgHJskxPVDoNQ1CEkWq9qrZOEzA4Lf8kNhqTgusoJAcPsPty4CEgxqkCW
         qIITZ2n6DV+hmulBjKdaejLTh6T3wt6KOMrfWuNmKWNeh42JNpcxli1DILtBRoj4FXD3
         R9asqDZ+pu4adA7/6WTzJQ0esXjwMBwnWmjJXNkyHRGNOTEBtoe9O5Md36iZSZNBwN/z
         5MbA==
X-Gm-Message-State: ACrzQf3XZIMxgZLs4YTu7YK9tBZcyE5MZJmrHAKZO1EEAXIi0+qmlKxF
        DR8M5jmG5dASIsNgr109PUaPA6Eod3xmRX9s14RlPyvEXOk=
X-Google-Smtp-Source: AMsMyM428rsF2XOYqVpYo/3wMO1vZN9qBgEQtULvgKRDAkvnPXAy3ti3Qj8CsXsfFDuE/frqI5ROrKBDC5MMtWii2CY=
X-Received: by 2002:a17:903:32cc:b0:178:3d35:dfc4 with SMTP id
 i12-20020a17090332cc00b001783d35dfc4mr21184968plr.116.1664176597567; Mon, 26
 Sep 2022 00:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220923070334.1970213-1-martin.agren@gmail.com> <Yy4uDW9YjpleFUHW@coredump.intra.peff.net>
In-Reply-To: <Yy4uDW9YjpleFUHW@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 26 Sep 2022 09:16:25 +0200
Message-ID: <CAN0heSpPGuSYb1nEyA3RuV+ACrXjHu+YqxAsfZN62EHVqcQ9Mg@mail.gmail.com>
Subject: Re: [PATCH] cmd-list.perl: fix identifying man sections
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 24 Sept 2022 at 00:07, Jeff King <peff@peff.net> wrote:
>
> I wondered if we might have caught this in a more automatic way. The
> output of:
>
>   cd Documentation
>   ./doc-diff cc75e556a9^ cc75e556a9
>
> makes the problem apparent, but I don't fault reviewers for not running
> it. I rarely remember to do so. And in general you need a human looking
> at doc-diff output to know if it was the intended change or not.
>
> I wondered if it might be worth running
>
>   ./doc-diff v2.37.0 v2.38.0-rc1
>
> near a release to scan over all of the changes. But the diff is over
> 8000 lines, and I admit my eyes glazed over before I got to the
> problematic hunks (even though I knew I was looking for them!).

I know how you felt when you looked at that doc-diff... I was lucky
enough to first look at

  ./doc-diff v2.37.0 v2.38.0-rc0

so that when I then looked at

  ./doc-diff v2.38.0-rc0 v2.38.0-rc1

this stood out quite well.

> So I dunno. I think doc-diff is a potentially useful tool, but I'm not
> sure how to point the human attention at the right spot to find a bug.

I try to do some such doc-diffing every now and then, and in particular
around rc time. It has caught a few buglets, usually nothing major.

I've also done

  ./doc-diff origin/next origin/seen

at times to catch such things a lot earlier, but it's not often that I
find the time to do so / think about doing it.

> Maybe "given enough eyeballs, all bugs are shallow" is our best bet
> here. After all, it did find this bug before the release. :)

Yeah, and luck never hurts -- I think it's fair to assume that I would
have missed this bug if it hadn't come in after rc0.

Martin
