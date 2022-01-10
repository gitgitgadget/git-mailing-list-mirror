Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D3C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 14:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiAJOkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 09:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiAJOkx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 09:40:53 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97534C061748
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 06:40:52 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id d189so8267318vkg.3
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HG3k/49b80soTPEZzrpCk7/iZpwZ8GuBBiY6J/EjQWc=;
        b=FthwOzp3Qis9TkIJIqnyLIXLKKmB3VZu1xM5EF0JdDv3qmZN4nAgWjwkkCduZZe0oL
         o+iHBgEbShGrKT35IlGEVHAaeQTl/kXd7mm4wZFTAwULNXLoBPpsCXur5RidcVe+Cy+Z
         W/6BgBlwXYfYzCv1gsPRaFocrFQyHvWUNFptnzDLuZ3JIy7HsjkDNPN1XUIUQ+8JaDf3
         j7I77MMD7mvDCs0BaFk5gxuE/BiTNRZLqe9dc6fT8ozuSHXiHA2p4kbKEHjVFMruWHyx
         nfIrRhiFKlklMDDYao+erR1CNyAgLr0k9oMJnoN7k1f29tsZ9R+oxsq79qPS5losjd1Q
         Wnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HG3k/49b80soTPEZzrpCk7/iZpwZ8GuBBiY6J/EjQWc=;
        b=QwyV+vaklptYP3c2mlEKBlG+K9E2KR1wl3bqTN4CxHETW9/vZQ9g+jkeUl/itHgPFO
         jUpy7+jni156vcY6ZpDme7wTRuZpIEgi0zmGSjDa/rYZZ4aIpqhzvMHVpn8CYI6tX44P
         bG7PJi1XsYjOFawMH//qLIPyRkIqppCf/z4H2Cr67X7ZrtmLdnPRHLi5HG1vLpeDLlSa
         ZgG18lrG0ok4TKkRGF/4Kd0B/uPh37Cgj6sMTmV8wdKYckqxeZRFwiBnMlv/CMYN1c4p
         a37+oV7+uJpgsSnUbJcmAnQ93WCPf3NL6XdHZm+qkL/yV+d8RleZHZVBISFK21LTENsA
         aUrA==
X-Gm-Message-State: AOAM532myIhzwQ2pklkTQ8ty0cWlY1q+vB+TndRRi4L6co+pvHXpbEm7
        Mt9bNP1yA4+eQztwnfXaOmrDvRbMo2vJLeNDeY0=
X-Google-Smtp-Source: ABdhPJxQFzfbjrE+YJ1J/M+rLkE5hpQZ+KJlCcHapcoMa6eQOP0ry6UQ2/R/+dyyfblLzShMzlsNmjc04RHhLhkuFNs=
X-Received: by 2002:a1f:2cf:: with SMTP id 198mr2463961vkc.35.1641825651715;
 Mon, 10 Jan 2022 06:40:51 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
 <20220110082254.54400-1-dyroneteng@gmail.com> <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Mon, 10 Jan 2022 22:40:40 +0800
Message-ID: <CADMgQSQWZRG2tCQ6tfBXMdyaVEzmWi0-5qCM3N1+YeN5nVMoGw@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I strongly disagree. Using a format requires the reader to interpret a
> `printf()` format, to remember (if they ever knew) the rules about padding
> with `%<number>s` formats, and then to satisfy themselves that the result
> is correct.
>
> That's quite the cognitive load you put on the reader for something as
> trivial as "      -".

> Not a fan,
> Johannes

Ok. I will modify the next patch according to your opinion, I just
hope to understand the problems and make better contributions in the
future.

Thanks.

On Mon, Jan 10, 2022 at 8:49 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Teng,
>
> On Mon, 10 Jan 2022, Teng Long wrote:
>
> > [...] about the using "strbuf_addf(line, "%7s" , "-");" or
> > "strbuf_addstr(line, "      -");". [...]
> >
> > Why I prefer more of the former that is because, for the single line,
> > it's more readable I think.
>
> I strongly disagree. Using a format requires the reader to interpret a
> `printf()` format, to remember (if they ever knew) the rules about padding
> with `%<number>s` formats, and then to satisfy themselves that the result
> is correct.
>
> That's quite the cognitive load you put on the reader for something as
> trivial as "      -".
>
> Not a fan,
> Johannes
