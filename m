Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDEFC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347143AbiCKSqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 13:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCKSqE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 13:46:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1AF1D17AF
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 10:45:00 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h14so16525660lfk.11
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EmXbRCgO0c6VgjWXSoQpE3M07CVuCaxcuSkcuLD4E9w=;
        b=GE6kprWz71Ngqhv1H7YVwZkvM4VlCLlk/3ckXO3cNDaaUM6DWK1s8aB26WDdmGTYJa
         MAdzhTTFqV2djj/2sNj8gacyMXpy8NPzVnXKM2e4LPSt44q5RmIDHPPLQzjKsjEF/7bJ
         t91uKXsQDJHPMu/9aVNCQCwi28fkeSYdIjwt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EmXbRCgO0c6VgjWXSoQpE3M07CVuCaxcuSkcuLD4E9w=;
        b=XlrlBTNYWUuC9ynDaz0AhdXc4wr3V9EBmoeUFcAKIvNHzvkRjJcJHMjw8U8j+jVNVV
         K8AC4PaAy+zld26p0QPLuu5Ew+OmeUohs+jSbv03dFgCMBOhqW1V8t3e4T1hE/6g+6nb
         ijCXpqimpFAVXX7CbSZeH6nOCxCPBZQlVJ/8046CdAcTi0tFmsqfw+6DwEPIQ6WLB2cN
         K3Q+U5gQv3C4Kt/MzcThVi2tyqf/xIm/8NHZ+HhimM06OutzL5P6sh6VpEJpe39IT/fm
         ncq4xQUl1bBv4ZWPt1aS6GUKJ5K8XWBrcZ8iwKQvVb2HqMPggxphqjIKsX5WvhabEkLV
         7D/w==
X-Gm-Message-State: AOAM533oE1tojTGRlfeajmwaEVE2mVm+VbShY2wU25fmpY2rQG64boD1
        3HmZTQMmNVve82qkw6eeaNCdgUsRqtUo0SScjQo=
X-Google-Smtp-Source: ABdhPJxvkTWA0Olv7qsu06RUpACpcJG7kfQQL+c7eyLQ6MgAgJR71rVkadXiQo9r5c/DlWvcrfuRHQ==
X-Received: by 2002:a05:6512:3f99:b0:447:7fc0:8d3 with SMTP id x25-20020a0565123f9900b004477fc008d3mr6910925lfa.671.1647024298848;
        Fri, 11 Mar 2022 10:44:58 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id bu1-20020a056512168100b004437db5e773sm1739596lfb.94.2022.03.11.10.44.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 10:44:58 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v28so13196827ljv.9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 10:44:57 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr6665315lja.443.1647024297636; Fri, 11
 Mar 2022 10:44:57 -0800 (PST)
MIME-Version: 1.0
References: <220311.867d90j2vj.gmgdl@evledraar.gmail.com> <patch-1.1-d2ae423d1ad-20220311T094315Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-d2ae423d1ad-20220311T094315Z-avarab@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 10:44:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjB_MZqG6QN8gcmdQ2Me9GWmr5HJ8TX8cj9fHck8y75XA@mail.gmail.com>
Message-ID: <CAHk-=wjB_MZqG6QN8gcmdQ2Me9GWmr5HJ8TX8cj9fHck8y75XA@mail.gmail.com>
Subject: Re: [PATCH] parse-options: add per-option flag to stop abbreviation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 11, 2022 at 1:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> So let's tweak this rule to be more narrowly scoped, now we'll allow
> abbreviated options regardless of PARSE_OPT_KEEP_UNKNOWN being set for
> parse_options(), but we'll provide individual options an opt-out. By
> using that opt-out for "--output-directory" we can have that case work
> without overzealously disallowing others.

Thanks, this looks much more obvious to me than the odd
PARSE_OPT_KEEP_UNKNOWN logic was. And would seem to obviate the need
for my hacky short aliases.

                Linus
