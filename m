Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE62C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AB21741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPBosUKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGTJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:09:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42916 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTJa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 14:09:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so163289wrd.9
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AqzyPATwvU92FB5DtBHq+HYSz4iyw/6OurgejAn2PRE=;
        b=pPBosUKZ0INX2C+d0jUQ/Tu3/Wf1pWn79vXrY+ovMe0S70j4Bs3snO4MihgZUE+nXh
         9ylibFKr66jLHKWac4K92DiTvwwqF/g1js1WVWVUT7EXSBrXh14BJthaokWUOQitOZDt
         P1yRF62XPFUrXdWXZYG/f2YnUFEYWjP3lzLHxuwhDH5Y8hOaABaYETvu6cHCn5pnJmfX
         D/aJ58b/vKCehu7qmh7DGQXviRyU6DvCc9gvrA6GE9VpK9vasnJsSxoRzCefeit53oNO
         5CNyPrkHcPrkv+2zh2xffKUaJQqYvJUR9YmsyAMgiWCr2D5ZmC30R/y8BkfL3M5HNgWd
         UYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AqzyPATwvU92FB5DtBHq+HYSz4iyw/6OurgejAn2PRE=;
        b=oZ//PEjE0pFHnElnx4FnbBAvTrRWdHVLjp5eB9o8EQOyKZMi89qGKCnmYcz26MSLmI
         Gd+pRhQIRp0sKAUKmJDzba9r3qpOoxKojaNpBLWt8RNQEve2FIoQk5h0FVkbhUaJrImH
         pC4QYDj6YuYfOqXSrqmzZlaayBXz5Bzuy5Kc8Ynhdu4Nl4ZE43+YN6CuSvxbXIKCC10q
         3FS/jo/5FeAEAVO4Bg6mUiQZ7zNofX56yG6/u6y98GC9vi3MPwsMRbTzW8yQjjhvjq4I
         0GGCHW5WboEjonpVGF155iYwjJtFS0pr9KrrhZKAqBbyNvL79aWvwE0TT9hdWbcUFySr
         MHZw==
X-Gm-Message-State: APjAAAX2eDdZYFA9zKlvQsHE4pkph/p9I5dJgI1Jb7eHvGdMWGYSWliL
        YumgsRv5Q0ukGzz+ptKnwvYIxen+/tLMY8+tUkk4R1TvJww=
X-Google-Smtp-Source: APXvYqzZ76JGmaovOZZTpa114o/UEHSnmqZ/DTF2//zHmVcNEOrb/QmUcbb2naMKW18zuFzzp2BeFvPAcfsfadKC6wY=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr521454wrp.2.1581102568141;
 Fri, 07 Feb 2020 11:09:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev> <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev> <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev> <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
 <20200131161630.GG10482@szeder.dev> <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
 <20200207100247.GA1111@szeder.dev> <CAJ+F1CJc4kEvxLr-wLXpvXOC8YRVf5xP1HuJh9-cYa6mGmbyXg@mail.gmail.com>
 <xmqq1rr6444s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rr6444s.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Fri, 7 Feb 2020 20:09:16 +0100
Message-ID: <CAJ+F1C+qGo=6QrRw2299Apr2+-CHNWQyzWjvWbXJN5KC+T63AQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, Feb 7, 2020 at 7:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Also, when doing --edit-description there are comments like:
> >
> > # Please edit the description for the branch
> > #   unrelated-history
> >
> > What else do you suggest?
>
> How about teaching "git branch --edit-description [HEAD]" notice
> when/if HEAD is detached and always error out, no matter what
> operation is in progress?

Then --edit-description during won't default to the branch you started
from the bisect. So we are back to my original proposal only, having
branch default during rebase. Eric, do you mind?


--=20
Marc-Andr=C3=A9 Lureau
