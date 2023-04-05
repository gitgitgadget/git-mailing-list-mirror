Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782FC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDEVVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjDEVVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:21:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93761BF
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:21:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j24so37584057wrd.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680729663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCatREPKZ1k9qVjjaXtsQbJYEyUR5HAkP3fROIQp2zc=;
        b=Ta47UMFMnsY5uoJHl8ZWLWyVcShlCVEcV9LOHBtRHZVisgQyH4JJ4plkso7aUUrFoT
         O+uLv92ZbmL83qlXvwLWwOiZfATHV4qpsHbAR55Sk+kCyy6KFLOFTD4UFzMvQCZcHhA7
         2X1wKhD14DjgqFxevFM3H0Et5TOA9PtmTUvQrgdKbITJ9XiDVCv2Ik4HPutUtJrNjHRH
         7QIv181+HI0FBkOECWKiG7d3yWk8ATxn8RpSSHdtlq1Jg1SyPTiWrgEbG41a5fbchxHD
         zvmoMS8fqbroTCbJlcKk72xXIe4l7yrdvznPRsgiQPsHjPvZqRRN2IZHLNxf3b0CIIg4
         /NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680729663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCatREPKZ1k9qVjjaXtsQbJYEyUR5HAkP3fROIQp2zc=;
        b=Wp8OrwBxPXr+RuDJyglD+Ny2DFqO24vfly/bJQt+XEX8eEChAxIwIBhnTCACOXRXxs
         icIZ4C38T5kKN59sovx/4DphEW/5aVYVeAmtZDmt5mp6xKksR5uFPHDk0gGPXz6EPoLe
         VpMWBpRxlJnze/kUs1hZ7wDer/phED2o4IP8S0GsotPI+2fG9jqVxJv68XbzBNn/BIcf
         MLZSZiTMugup7Tnl8rxEUe7Lecf+9qO/ittuSBXxy0CPfwzy4TcywqxltMVoWzBH2ebu
         wdhf5lBCVwxDTI22jzyUlo6+w+Zb+hcAlsDgcWvfiULBWFgALP1azRHl4XifwjMyAlmh
         JGnQ==
X-Gm-Message-State: AAQBX9dOord8KTGh1gaN14ME90NpWp5RTw7zPW1Zps69RxFWLVVmhQLw
        0eigjBwuCySw3w0Vh1AbjTUcrF/jI2EVadpPqOU=
X-Google-Smtp-Source: AKy350Yug+z1y1f69227N9A9y1YgjMZIWHm96uHR51/doAU4PfBXpU9KcCLPwSBbscke8hJLLb7BFyul+DEL7tmhHjs=
X-Received: by 2002:adf:e30e:0:b0:2e4:cbfe:da50 with SMTP id
 b14-20020adfe30e000000b002e4cbfeda50mr1424397wrj.1.1680729663146; Wed, 05 Apr
 2023 14:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu> <xmqqttxvzbo8.fsf@gitster.g>
 <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu> <CA+8g5KHYqgAZPpTOXWekDpWv-mvj-rBkGu+4MXy4OB1VDeS4Lw@mail.gmail.com>
In-Reply-To: <CA+8g5KHYqgAZPpTOXWekDpWv-mvj-rBkGu+4MXy4OB1VDeS4Lw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 5 Apr 2023 14:20:51 -0700
Message-ID: <CAPUEspjM6PtsY9LiK9Lqb2+H2UrWEfPziWVrOPwZGVpVbx7aJQ@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Jim Meyering <jim@meyering.net>
Cc:     Paul Eggert <eggert@cs.ucla.edu>,
        Junio C Hamano <gitster@pobox.com>, demerphq@gmail.com,
        Philip.Hazel@gmail.com, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org, pcre2-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 12:40=E2=80=AFPM Jim Meyering <jim@meyering.net> wro=
te:
>
> Changing grep -P's \d to match multibyte digits by default would break
> an important contract.

While I tend to agree[1] (and indeed that is why PCRE2_EXTRA_ASCII_BSD
was invented), it would be also important to note that it goes against
the Unicode recommendation[2] and it is actually not true already[3]
for Python, .NET or Rust (which means ripgrep behaves like GNU grep -P
3.9).

FWIW I also agree that (at least `git grep -P`) should use
PCRE2_EXTRA_ASCII_BSD by default as that is what makes more sense in
the context of matching source code and using instead `\P{Nd}` if you
really want all Unicode digits is not much of a burden, but I am also
not sure if that makes sense in other contexts, specially considering
that I am obviously biased since the languages I mostly interact with
ONLY use arabic numerals and therefore `\d` meaning `[0-9]` seems
"normal".

Carlo

CC: changed to the real email address for PCRE2 development, for full
context on this thread use [4]

[1] https://github.com/PCRE2Project/pcre2/pull/186
[2] https://unicode.org/reports/tr18/
[3] https://regex101.com/r/S5RW4c/1
[4] https://lore.kernel.org/git/230109.86v8lf297g.gmgdl@evledraar.gmail.com=
/T/
