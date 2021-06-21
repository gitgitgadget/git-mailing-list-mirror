Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD4C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066366134F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFUTZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFUTZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:25:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF66C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:22:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id he7so30563616ejc.13
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FTvC0sBL5lBQpGFojKNdN/IOJCMSV5KurwMenvzS1AY=;
        b=MZwJNdNx+7hZEJVLqNRBTZZuPS2t8K4WVo5+H8ooYYKGjwAwdRXVLvbUleQsIXFU/x
         8s46zC49EiKlIYjRgbGq5772CDemgYDwxAFIxHT+gBxcaqdywRv3b4Vwzm0evABwX3lx
         aOIcpkQiy3Z4V8m0RTxUJxl+qbXOmGVCxZDCOCzOjWMt2W2QzZ81d1hz9AnCAHlFvJLg
         7dcazPYSbbapQSjty8EYnTf7m0/hf3tokL9aRIVTUEi3wUc6fw1YbljRLx4vCHHj7Wje
         461eM2knJzIjCaT4iXcLvEfUzvdLDPbDOaVPPRlL/d+TFXuH1w45k+rpaN3qhjm1nD+9
         qf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FTvC0sBL5lBQpGFojKNdN/IOJCMSV5KurwMenvzS1AY=;
        b=CGLXjBXPuW1j1z4O3blqZ6QrHHod5w2L2v42KulIGwvJ5eP80WR+M3jHSzvVH/Kha7
         M5KxVRAfzB8G99PGBH12UnV/q4AUvM2oQzYF3XTCIa6WFD7D4ZuI5WcNYtQZT4r6JcV4
         cvQrk2YSQWTZyRRkFuoEYD/oW2RVBc12zbsUC7YS6Kz//2Fa5HdJ2XpTYpDMCCjJSq8B
         VJ46+EDPQITyMblAFGX6XxqOdty3hSjcGRzuJKJif+HJ/4aE/y2+rjDoWuEJi6v8GzSJ
         0WcHvNt4d9wXgPtDh6Of3DUb/vhQR9eAvh9Oz08+NgXlASrizrWogOZulloXOn0L0zTY
         F7JA==
X-Gm-Message-State: AOAM530JQ4hyNpAuqwNuRlnZz1508aUIlo+nPJ64meTyutTpI3qroj4R
        hP/YMx+R4+mk9uWuuWiNhws=
X-Google-Smtp-Source: ABdhPJyZ03UMBuTSZFN98oaxVzp0EuR0opqVz+vA2PDlXhqF1xNnEDCSF3zhs3oqKzTD8L0Oepj34Q==
X-Received: by 2002:a17:907:2651:: with SMTP id ar17mr4022988ejc.135.1624303374360;
        Mon, 21 Jun 2021 12:22:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h26sm5145126ejx.25.2021.06.21.12.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:22:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Date:   Mon, 21 Jun 2021 21:08:20 +0200
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 <xmqqfsxbika3.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqfsxbika3.fsf@gitster.g>
Message-ID: <87mtrj2faq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> So, in order for this change to have any effect:
>>
>>  1. color.man=3Dtrue must be set in the config
>>  2. The user must use less
>>  3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with=
 overwrite=3D0)
>>  4. Have color.ui enabled
>>  5. Not have color.pager disabled
>>  6. Not have git with stdout directed to a file
>>
>> 1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
>> 2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>>
>> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> On Tue, Jun 08 2021, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> I've been running with this on my personal git build since May 26th. I
>>>> haven't had any issues with it, and I like the new coloring.
>>>> ...
>>>> I think this is a good example of a change that we're better off just
>>>> merging down and then reverting if the wider audience of git users hat=
es
>>>> it, rather than trying to come to some perfect consensus here
>>>> on-list.
>>>
>>> My impression was tht we already had a rough consensus here on-list
>>> that it may be good to educate users who like this "new coloring"
>>> like you do to configure their "less", so that they consistently get
>>> the "new coloring" they like whether they are doing "git help git",
>>> "man git", or even "man ls", and the approach the posted patch takes
>>> will not help (it only affects "git help git" among these).
>>>
>>> I'd rather not to take it.
>>
>> Fair enough, here's a version I think you and others will find
>> acceptable then. It allows users like me who like this to explicitly
>> opt-in via color.man=3Dtrue.
>
> Not really.
>
> [snip] I think it would be easier to understand to end-users
> if this were exposed as a new "mode", like "git help --web" and "git
> help --info" are different modes from the "git help --man",
> something like "git help --fancy-man" (or whatever is easy to type
> and explain, and also add it to the variants help.format knows about
> to make it easy to set the default).
>
> One advantage of doing so is that we do not have to worry about "ah,
> user has LESS_BLAH environment variable so we should disable this
> new mode here" etc.  As long as the new mode is requested either via
> the command line option or help.format configuration, it can
> completely take it over.  That simplifies the necessary explanation
> given to the users quite a lot, no?

The interaction between "git help" and "man"/"less" doesn't really have
an equivalent in the rest of git as far as color output goes. Usually we
emit colors via our own programs.

But no, I think it makes the most sense to consider this orthagonal to
help.format=3Dman or man.viewer=3D<cmd>.

We're not invoking a different man viewer or command, we're just
expecting that mode to invoke the pager, and if that pager is less to
have these variables tweak our color preferences.

> [unsnip] Since the implementation of the posted patch, as I understand it,
> does not aim to affect both "git help -m foo" and "man git-foo"
> identically,=20

Aside from this patch I don't think it makes sense to view git's UI and
interaction with the pager like that.

To probably >95% of our users the "we invoke the pager" is just a
technical implementation details they're not aware of. Git just has
pretty colors by default, so I don't think it's jarring that "git help
xyz" and "man git-xyz" look different.

We also don't try to maintain the UI that:

    git cmd >file &&
    pager file

Gives you the same UX as:

    # Invokes pager(1) for you
    git cmd

Since we set e.g. PAGER_ENV already, I believe this was brought up in
past discussions. So we're already past the point of git adding its own
magic custom options to feed to the pager.

So I don't see the problem with having "a bit more like PAGER_ENV"
hidden behind a color.man=3Dtrue config option in this case.

>> 	----
>> 	git-config - Get and set [...]
>>
>> 	SYNOPSIS
>> 	--------
>> 	[...]
>> 	'git config' [<file-option>] [...]
>> 	[...]
>> 	The `--type=3D<type>` option instructs 'git config' to ensure [...]
>>
>> Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
>> config" and other '-quoted parts in BLUE UNDERLINE instead of
>> UNDERLINE, and `--type=3D<type>` and other `-quoted parts in RED BOLD
>> instead of BOLD. The "Standout" setting is then used for the user's
>> own search bar (invoked with "/") and prompt. See [2] for more
>> examples
>
> There are BOLD RED and READ BOLD; are they differently rendered?

Yes, that's just an omission/mistake. It should be the "RED BOLD",
i.e. "<COLOR> <ATTR>".
