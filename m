Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FDEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 20:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGLUry (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGLUrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 16:47:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D9A2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:47:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e43473ee0so7659763a12.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194870; x=1691786870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhqbRSxtN1EB9TYnCl0nWfvwGFrOqwiSv5uEX/f6jw8=;
        b=Bh4HgLWxT4BhASsF34hGbgEEWTcAa+DP94Z/anHK1kTem7yp37t0IT/u3NJOLu4cB6
         KqnpTNO+mKd0T8+eQJ186aHYx9INwGgHHm3//2in95Qxl0exHXs2UVKMtMI0/r/JT43k
         /tqWMXYkzH1C0b4q2of8ZP9Gx+vF2Hp1VGPJBFWkUBA0fERL/XZjAmsFl5YfT0HK91/d
         ECbKG4rAd4IXaLrifiZusXdx3NEbfaGttJVMgJw95TSgWNTFO0J3chC+CUxuP/PtZrBm
         5ltuw1hcxzVdPptkxb6ywKZno6VrhZmCwk8DrIELMyotL+9pWNg08shnSdtnpxzddKWX
         kHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194870; x=1691786870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhqbRSxtN1EB9TYnCl0nWfvwGFrOqwiSv5uEX/f6jw8=;
        b=S1eond0OtfB89Ci5M7bS+PRhw1+yfO4On+aD+G5QHJkF0u6yQQlc+4Wuo+yHuMY4Yq
         TtIWQDIPen7jS3AeoWl2hgoXshy0qRdOUDlxoYTrzsdvVG3EZmeLPqWe/cAuCw+6khw+
         ZWty544+8BaFzkwcrvMu+4V1mhxkBM+Nf0FCfjH5R4X2uSEJ95XdUvZn74jUEOVoZK5U
         aNUUBx5oCoRW7lddjQZD+1H0VYOra2as1WGsNKh5WelySSnVQ9f6R3UreWkbZ2QGyJ2b
         HViVafYHjfvdPy/a4g5aMkBELuHItGdkLcZTJIGN74r9RuodHOkfUjv3AkOu4YiVJjd2
         NNLg==
X-Gm-Message-State: ABy/qLaRZClsuC1vpbcsewRS+TUDbHQzH1H9ukgIIT10L/lgUBAr0U02
        BszqPDrAe989/7A08z0r9HaZI9j8+o3YQ91hqLDTmABMKas=
X-Google-Smtp-Source: APBJJlF01BVuDaFmFvMINGEXT+1kiwyANNEq2tXuKHu6AIzTrexXnlyT9M6k784KeZoqoUBaB9ZhOr5/HxKf8V1p4Kc=
X-Received: by 2002:aa7:d782:0:b0:51d:98d0:3049 with SMTP id
 s2-20020aa7d782000000b0051d98d03049mr18455138edq.21.1689194870132; Wed, 12
 Jul 2023 13:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230712110732.8274-1-andy.koppe@gmail.com> <CAPig+cT3tWnSfk+ZoRWU=JTGctMiE38fH5V1ebpP7L1bGsfU4Q@mail.gmail.com>
 <xmqqa5w1t2kp.fsf@gitster.g>
In-Reply-To: <xmqqa5w1t2kp.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
Date:   Wed, 12 Jul 2023 21:47:37 +0100
Message-ID: <CAHWeT-agn87wc82xdMzB07Y=xe6H-yR_oxS_CGf2tE-szQ=T-Q@mail.gmail.com>
Subject: Re: [PATCH] pretty: add %r format specifier for showing refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Not a proper review... just running my eye quickly over the patch...
>> ...
>> Missing sign-off.
>>
>> Indent with TAB, not spaces.

Thanks for the check, and apologies for those avoidable mistakes. Must
remember to run checkpatch =E2=80=A6

I'll send a corrected patch, if only for completeness.

>>> +enum decoration_format {
>> Is this enum name a bit too generic for a public header? A quick scan
>> of other enums in the project shows that they usually incorporate the
>> "subsystem" into their names somehow (often as a prefix); for
>> instance, "enum apply_ws_ignore", "enum bisect_error".

I took existing decoration-related types as precedent, in particular
enum decoration_type and structs decoration_entry and
decoration_filter, whereby the latter is in the same header.

Junio C Hamano <gitster@pobox.com> writes:
> But more importantly, I doubt the wisdom of adding any more %<single
> letter> placeholders to the vocabulary.  Even though I personally do
> not see any need for variants other than just the plain "%d" to show
> the "decorate" information (if you want anything else, just
> post-process the output)

The proposed %r placeholder basically is the minimised version of %d,
which could save space in one-line logs and generally reduce visual
noise in custom log formats. Post-processing is rather more difficult
and error-prone than a built-in feature.

> if we really want to, the way we should
> extend the format placeholders is to add %(decorate:<options>) that
> is extensible enough that it can produce the identical output as
> existing "%d" and "%D" placeholders do, and add new ones as a new
> option to %(decorate).

I'd be happy to look into that.

What have you got in mind for the <options>?

Something like:
  %(decorate) for %d
  %(decorate:unwrapped) for %D
  %(decorate:bare) instead of the proposed %r

Or something with separate options for each element, similar to the
separator option of %(trailers)?

%r might look as follows, with a space for the separator and empty
strings for the other elements:

  %(decorate:prefix=3D,separator=3D ,suffix=3D,tag=3D)

(Each option would default to its %d value if not specified.)

Thanks,
Andy
