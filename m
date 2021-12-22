Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA5CC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 11:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbhLVL3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 06:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbhLVL3y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 06:29:54 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE3C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 03:29:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x21so4699063lfa.5
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/x+KLfNo0GM2Y2t2jDHp9P/Z5iJzoYC8F2Ib1NuJK0=;
        b=Xiyhk891nw+EUAZK3LjrLuhw35aACx8Yuu8RacE7tgmtFYC3g2/hnjT1vhnA7tTd+x
         H+4t18BX19ysWeyyPmfT2AQBGxJ88lGHWuKUHnzEMaEriIJJKl0TybzkdX2qDI5+r0Br
         VTPLpxa3vbUUZ6oeryQYxkT9NJyWvxNOGiMtRASVKpJFakE6ndy+Sc0oez0CkN/V0+Bu
         84qpyCQDM1ySzDjlSs6fCJPJvi6C+R+ocIGi+4z8YLtMQXMHV7vwuCxu22L8q6cjpJDH
         xnNqrlg97Jj2QjDmXGD1DjditpLmO6HOFBgljwsVa8RnfCJ9x2ZywgobjkfodhymbZ6L
         tEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/x+KLfNo0GM2Y2t2jDHp9P/Z5iJzoYC8F2Ib1NuJK0=;
        b=g9Ap046p2bIegCuevzsRiy1+IviTuZDDPeXUiUajaea46E+nO9WEylYK1ltAcD6xB5
         w4jPA2O2SY67uit1TYRbeLenGJHhZPg+IPEYnmxWhhDXktX+Xdfbdlz/Vo5U98StIxvU
         GOG+2v2JqjlQLQGftCB5MGfYYa5jCbLui9TecyqdH7R2rsgVkhAG5tqFV9aQDUQSwBxX
         N1vhKI/tF1u6xvjezRNlgwYGM+GEiR2xuGIWo8JvqEr1GudNoMj4hiWXhE6JYl707Afp
         jM/14y4Bc9gwSHlKlK1sZF6LTyBkY+ZzO0H/jeyXCaruK7pnc4RvIq5NMsPx7m4lV806
         uvKw==
X-Gm-Message-State: AOAM533s4UN1yOVje83zrcRlWmbyPvx1D9AUFVYCKOdYX5wp0N1n+SQf
        bZ6Eid6Jo0rG75JOzEOebUXmj/1kTpvrEM96X2g=
X-Google-Smtp-Source: ABdhPJyStoQxXDKir7HvDgGhF8LPUz5lvH7DOFeicCpkgQ11x+5FQGTMrgeb2GNwFncXgQn/LO+3w4oDIJbM2WOzZAw=
X-Received: by 2002:a19:a417:: with SMTP id q23mr2168650lfc.596.1640172592468;
 Wed, 22 Dec 2021 03:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20211221115201.12120-2-chiyutianyi@gmail.com>
 <211221.86bl1arqls.gmgdl@evledraar.gmail.com>
In-Reply-To: <211221.86bl1arqls.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 22 Dec 2021 19:29:40 +0800
Message-ID: <CANYiYbHdMTS9CqTqKfiKjBc=6uVsUSz91Qk+gEdghq_=JXbOHQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 8:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Dec 21 2021, Han Xin wrote:
>
> I commented on this "find" usage in an earlier round, I think there's a
> much easier way to do this. You're really just going back and forth
> between checking whether or not all the objects are loose.
>
> I think that the below fix-up on top of this series is a better way to
> do that, and more accurate. I.e. in your test here you check "!
> test_cmp", which means that we could have some packed and some loose,
> but really what you're meaning to check is a flip-flop between "all
> loose?" and "no loose?.
>
> In addition to that there was no reason to hardcode "main", we can just
> use HEAD. All in all I think the below fix-up makes sense:
>
> diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-del=
ta-objects.sh
> index 8436cbf8db6..d78bb89225d 100755
> --- a/t/t5590-unpack-non-delta-objects.sh
> +++ b/t/t5590-unpack-non-delta-objects.sh
> @@ -5,9 +5,6 @@
>
>  test_description=3D'Test unpack-objects with non-delta objects'
>
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> -export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> -
>  . ./test-lib.sh
>
>  prepare_dest () {
> @@ -20,16 +17,22 @@ prepare_dest () {
>         fi
>  }
>
> +assert_no_loose () {
> +       glob=3Ddest.git/objects/?? &&
> +       echo "$glob" >expect &&
> +       echo $glob >actual &&

Incompatible for zsh. This may work:

    eval "echo $glob" >actual &&

--
Jiang Xin
