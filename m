Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE2C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 12:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiGMMS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 08:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 08:18:27 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576FA58D7
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 05:18:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so18876515ybu.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ScZRX8ZeZjKSDtbevMko2igoim9yoAcR1CBxoLoOoFw=;
        b=k3rpVfHe66+q3Z3VOHZiJNqUhb/NVofSlguqbznh26A8WgYFDsV+bJyN/NXS00dMr3
         50oJwM1M29/kuCh8uQohqXOI8DtDl/IdLEvAXXH9gGVj5ExRjzWqGbTFSfVjkv+MgEyr
         odP+oifcsWy5LB8EfiNWuk/Ifb6RLkqxmxmfXSFmZ+QG66GYXKRb6rFvuDp7APsajxEQ
         gltR/wnr9nzD71NDUZjVVl6hUO6coQ5r4HVP8548ZP+dfa5f1fV78fiatUyRw4AP6RZa
         9VvigzkDbZ+n5Uv5GPR1uH+9HL+EGY/z1END4jKRZmpwh1JLvV7Q/witfjz7cNdJazFS
         HjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ScZRX8ZeZjKSDtbevMko2igoim9yoAcR1CBxoLoOoFw=;
        b=iJTQ0ypFz1mfmPCPjorNFT8Z8B3oK7wIgFPqnsCc8r40iJrNc5Id5WdLHYRkb32wgD
         749uqeJZhLCEpfzOrHrG7+qFGlpMzSrxAb1jnm6JKZfw4jo8N519ctkBOKCNcyt1xzwo
         C7u1yRq2qwuqhPWS/23UZwAFEJoYawL1czjLGmgLTfLb07XfDjc0piDlCp+F0EvUeRyo
         PHfBWdsaDcNUEX9EYLkd7RoW+MjRQ6/ieTXDxyjAdF+OzdORe4hvHKvuCq5Grk1LQwsH
         dEuizlRFiAHj9TzJVc4z/LSMaT56hejx4CDrGizTWu4wsPk+h7tA7wQRXmOZoQtk8utu
         VVcQ==
X-Gm-Message-State: AJIora8nl1FTFfAuE+LaY/HESv/nZuU4zNcU5RVFKgHOUJ1hE+/hkTm/
        bNdTtsrlEXPBsUPwn0al7gE6n3Tixi3JZ9Lr5noGXPAbcCs=
X-Google-Smtp-Source: AGRyM1vm8fFE84SNQ6cBrDZJMi16pQ+GnFwUYB2icAnG3I94/Coir6V9dsLpElJ+bCJm+XxOxmczweICiPQz3Ob2A70=
X-Received: by 2002:a25:aaa9:0:b0:66e:c6ba:15dd with SMTP id
 t38-20020a25aaa9000000b0066ec6ba15ddmr3417699ybi.242.1657714705871; Wed, 13
 Jul 2022 05:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com> <20220712160634.213956-2-siddharthasthana31@gmail.com>
 <220713.86mtdd4xdd.gmgdl@evledraar.gmail.com>
In-Reply-To: <220713.86mtdd4xdd.gmgdl@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 13 Jul 2022 14:18:14 +0200
Message-ID: <CAP8UFD363FPO=eOnzb_8T54eVn2c8SGAvV+27rB=gwzs6o-cNA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] revision: improve commit_rewrite_person()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 3:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Jul 12 2022, Siddharth Asthana wrote:
>
> > -static int commit_rewrite_person(struct strbuf *buf, const char *what,=
 struct string_list *mailmap)
> > +/*
> > + * Returns the difference between the new and old length of the ident =
line.
> > + */
> > +static ssize_t rewrite_ident_line(const char* person, struct strbuf *b=
uf, struct string_list *mailmap)
>
> All tests pass with this as size_t, instead of size_t. Let's use that
> here instead?

Do you mean you would like to use size_t instead of ssize_t for the
type of the value returned by the function?

I think it can return a negative value if the new length of the ident
line is shorter than the old one though.
