Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF6C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A034651EA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhCPGPi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Mar 2021 02:15:38 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38558 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhCPGPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 02:15:17 -0400
Received: by mail-ed1-f52.google.com with SMTP id h13so20081330eds.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XIqMMAU4CIuuakhv3LMFjE3FBTOUp1I2fjciygg1OXk=;
        b=mrPHCmho6hgkubdgfSCpjPhAWtjEj7vm2JYXsINTDwMS79Efd1HHzEiSpOP2q53nf5
         esKpL3YayRZmSw8UOXnxfhmytbwzv+SN7FKIq53dSaPLX12vWT+eJ7SpQcKi4Emh9/Xx
         8MwZ02kr6XL+Ez8PEOrD+Ca79prtH7JN4GRj7aeSdUjP2xAgcSzzbkM4Bd0xnMGd8Mer
         xvn/4qDwSWroXbpFOHLibzuvlbarS6qFe7VEtqkji/KA4k6bvqmMe9kaFkDboBbwKFVK
         CTpjulGBeaih6zBBXqiT6aDf73sA+7beFkVnykP3v7aiS47qQNniJh8J/GL/wkl4EcC1
         I6RA==
X-Gm-Message-State: AOAM5326r37WSIDr5HLwRpNDwuE5wAC28jjsYy8OYafUEwFoHyd9hIx+
        u4JvgZrSJyxpxaRjolbgm4QE/+cB5XF4dJDPgOA=
X-Google-Smtp-Source: ABdhPJxl3BI94BdQFHCfts/MzPPYEYl4ceEdQsxXnTa1tOBA2HdHOkaV1BurEUbcBhXyBWxD6Qc1nQ2Di3LT2E9manQ=
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr33983093edo.163.1615875315852;
 Mon, 15 Mar 2021 23:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com>
 <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com> <CAPig+cSd-e76bOQY8yoZnRDbuQbZ_FNHJ5TV6BC+dAofPmk7DQ@mail.gmail.com>
 <CAOLTT8T14P1VfbbXnXpAV-6GfZ8jXUqqCVaY1Uxs3UtfnFvKvw@mail.gmail.com>
In-Reply-To: <CAOLTT8T14P1VfbbXnXpAV-6GfZ8jXUqqCVaY1Uxs3UtfnFvKvw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 16 Mar 2021 02:15:04 -0400
Message-ID: <CAPig+cRkGvKU8b2vauUZ4=EtTj4DU2e9k0HciTVEz-6-P6X5KQ@mail.gmail.com>
Subject: Re: [PATCH v4] format-patch: allow a non-integral version numbers
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 1:48 AM ZheNing Hu <adlternative@gmail.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> 于2021年3月16日周二 上午7:41写道：
> > > +               strtol_i(reroll_count_string, 10, &reroll_count);
> >
> > This code can be confusing to readers since it appears to ignore the
> > result of strtol_i() [...]
> > [...] I think it would be clearer if you move the strtol_i()
> > call into the diff_title() function since -- following your changes --
> > that function is the only code which cares whether `reroll_count` can
> > be parsed as a number (the rest of the code, after your change, just
> > uses it as a string).
>
> Well, The reason `strtol_i` does not check the return value is that
> `strtol_i` will
> only modify the value of `reroll_count` if the `reroll_count_string`
> we provide is
>  an integer string, so if `reroll_count_string` is not an integer string, then
> `reroll_count` will remain -1, and then `diff_title` will only execute
>
>         if (reroll_count <= 0)
>                 strbuf_addstr(sb, generic);
>
> So don't need check strtol_i return value.

Yes, I understand the reason, but it is not easy for someone new to
this code to figure it out without looking at diff_title() and its
callers. The place where the return value of strtol_i() is ignored is
very far removed from the place where the value of `reroll_count` is
consumed in diff_title(), so it's not obvious to the reader how this
is all supposed to work. If you move strtol_i() into diff_title(),
then the parsing and the consuming of that value happen in the same
place, making it easier to understand.

> But what you said to put
> `strtol_i` in
> `diff_title` is indeed a good idea. Of course, we need to modify the declaration
>  and parameters of `diff_title`.

Yes, it is a very minor modification to diff_title(), changing
`reroll_count` from int to string.

Moving the parsing into diff_title() also allows you to use the
simpler name `reroll_count` for the string variable in cmd_fmt_patch()
rather than the longer `reroll_count_string`; just change
`reroll_count` from int to string.
