Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B61C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3346461355
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKHBFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 20:05:25 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44907 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhKHBFY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 20:05:24 -0500
Received: by mail-ed1-f47.google.com with SMTP id j21so55718882edt.11
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 17:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wp43LjKfpaBshTNpgihB479eVIjgYpS+C7DNN+AthbA=;
        b=urBlESYYD/aPSboY+rJ923gPq9d1KO1PoAAcqxHcIi8D8s2JFiIZMlolBTheBpEXTU
         rTSGbeSVkAMN4Gjci1kgAhGqPenQ2dp6QXVv3evnezuDTjEt7gWuAxDN20G2MB2L6/9P
         hVQAkf8KEAiU/5lygSX3TXwdH04CyuQF/FwrggLUZvgguEqkJvBbKRIVgEIoDisafTbQ
         bOyHnP8GjLus3O4sy1MKidbmnWMgOB4tR6YVtezpVEJtFAr0g/1efEeAv7sp5V2qeHm9
         AiC1S6sCFUld7Lse5bzOYG6uzxojhejL5lZs47iqIo2Y3kF7eCT8rxF6oB00SLH3k/Zi
         0x4Q==
X-Gm-Message-State: AOAM533qZCTJi9XU4AZ3IoVqFIQwVsNbHU/3jKYv4W6KicQ/xpPLvJuZ
        gaJGlQ3XXMEM87U70P79kvg+HEJ8gXrYAKPJ0xk=
X-Google-Smtp-Source: ABdhPJzygMlC/B7WzzOPF0MX53OzZ7x5XPOPlk8Iz9dohKcgCkpIRALMKNC5Pybh7K2yir1shT1Jqicu5VqpTqvmJiE=
X-Received: by 2002:a50:8e19:: with SMTP id 25mr81317062edw.47.1636333352916;
 Sun, 07 Nov 2021 17:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20211104160959.183402-1-greenfoo@u92.eu> <20211104160959.183402-3-greenfoo@u92.eu>
 <CAJDDKr4icrigRO-2S_HVdY7+W0EGJ8XBn5dD=O-qy1tXym4u8w@mail.gmail.com>
In-Reply-To: <CAJDDKr4icrigRO-2S_HVdY7+W0EGJ8XBn5dD=O-qy1tXym4u8w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Nov 2021 20:02:22 -0500
Message-ID: <CAPig+cSi9S+EdqKLNWDGA76B3kUbvxQHEh2csyZYqX2sf0gztQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vimdiff: add tool documentation
To:     David Aguilar <davvid@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 7, 2021 at 4:25 PM David Aguilar <davvid@gmail.com> wrote:
> On Thu, Nov 4, 2021 at 9:10 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> > +                               while IFS= read -r line
> > +                               do
> > +                                       printf "%s\t%s\n" "$per_line_prefix" "$line"
> > +                                done < <(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")
>
> If we wanted to shorten this line a bit, would it work to run the pipeline
> first and pipe the result?
>
>     (diff_mode && ... || merge_cmd_help ...) |
>     while IFS= read -r line
>     do
>        ...
>     done

The additional benefit is that this avoids the `<(...)` Bashism (which
you mentioned in your other review).

> > +               cat <<-ENDOFMESSAGE
> > +                       Opens vim with two vertical windows: LOCAL changes will be placed in the left
> > +                       window and REMOTE changes in the right one.
> > +               ENDOFMESSAGE
>
> Tiny nit: we call this EOF in the other places
> (git-mergetool--helper.sh) where we do the same.
>
> ENDOFMESSAGE is a bit verbose so it might be worth sticking to the
> conventional EOF marker.

A couple additional really micro nits (take them or leave them)...

We normally don't add extra indentation to the here-doc body, and we
use `<<-\EOF` to reduce cognitive load if there's nothing in the body
which requires interpolation or expansion. Thus:

    cat <<-\EOF
    Opens vim with two...
    EOF
