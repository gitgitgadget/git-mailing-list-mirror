Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A7C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E5460FE3
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhIKClX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbhIKClW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 22:41:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68250C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:40:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v5so5246704edc.2
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4INumET6Cuun8GVLmqJbNrN3OHxnaiZUNUqxaf6kOIc=;
        b=aAJLmQPKt75D2+LddKJfrraBj57NkDX/HmjER4E4mxKoGji6SlR1ggO2pRsMNHOOap
         2kIGpFsbMmuiiw5mI+mCjD7Ixa86hyPnv0+kdWcER9gzs3rZJXl6fuzl1x+yKPJa0tJR
         Okvp0x7c/Wu0aHFtw+js9+7i2WGP4fBwxCKb6IPoR0PIKUVBS4jYyHEmJ2YFMkXRvFv5
         Bvf6ZxGw9SUvm3STI9FYxIS45y048qBHPkFixfYdvs1vbom95L0tHrbMGlNkpRHrP+VE
         pjeE+cXbRy8WopssCwlM3BKxKlmUtko52WZ7DimJvwA1NZgzBM/Dl9NYVXbBFcv/+Hdl
         47qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4INumET6Cuun8GVLmqJbNrN3OHxnaiZUNUqxaf6kOIc=;
        b=nGEPZDSE2bXuIfLrcBksdLPapYPaFWWA9C/K6aEWBwMYWfachpUPLNfvocq1u4sipj
         l7aH0rTsfSTAm9S41zYhTdWsd+/snEXLOq4sJRgFo/CUkx4lm0GY/eRvVvZsfal1pAkL
         53boGrkoT1BDxkYWT0OM2nrjjo36dviRTXV+cCx5AYnlgjbEFnDRK59jNFIC0k9gYAAo
         XmCH1S6YhedNURgIhIR1QvyKNX42nXlQdPaVjPRPBHE1tYb9msoNHML6WhKMqHWJHt0+
         YHyaF/gtpiRCuFYt/n/yGTgr8q3HqWsmOJTjLsZ/lJOC8I1WEOuEXwslZw2wYPSZcgm3
         lEwA==
X-Gm-Message-State: AOAM531t9JSmvcRbXcsniI+PuwsWWfuvwJwZ+P28q/OYC9MnA2zajDHQ
        wN99G0Bs8w6f02S9AuVIShxjaO36Vnl9ig==
X-Google-Smtp-Source: ABdhPJzXFTeXG/J13Y/aI0NJGnK2J1E9Qb9aqFgjaACJyMu7D3PXFo2XV+Cb/NM3TfABzjwe5cZ9bA==
X-Received: by 2002:a50:cac7:: with SMTP id f7mr1043758edi.302.1631328008824;
        Fri, 10 Sep 2021 19:40:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t5sm180777edd.66.2021.09.10.19.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:40:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] help: correct the usage string in -h and
 documentation
Date:   Sat, 11 Sep 2021 04:34:45 +0200
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
 <patch-v2-1.5-b10bfd21f14-20210910T112545Z-avarab@gmail.com>
 <xmqqr1dvoqyo.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqr1dvoqyo.fsf@gitster.g>
Message-ID: <87zgsjal88.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>> index 44fe8860b3f..568a0b606f3 100644
>> --- a/Documentation/git-help.txt
>> +++ b/Documentation/git-help.txt
>> @@ -9,7 +9,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
>> -	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
>> +	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
>
> This one is good, but ...
>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index b7eec06c3de..44ea2798cda 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -59,7 +59,8 @@ static struct option builtin_help_options[] =3D {
>>  };
>>=20=20
>>  static const char * const builtin_help_usage[] =3D {
>> -	N_("git help [--all] [--guides] [--man | --web | --info] [<command>]"),
>> +	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
>> +	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
>
> Aside from the addition of so-far-missing "verbose", which is
> obviously a good change, I am not sure if the other change is a good
> idea.
>
> This is because *_usage[] is designed to be always shown together
> with the list of options built from the option table the
> parse_options() uses, and the readers will see the correspondence
> between long and short options even more clear there.
>
>     $ git help -h
>     usage: git help [--all] [--guides] [--man | --web | --info] [<command=
>]
>
>         -a, --all             print all available commands
>         -g, --guides          print list of useful guides
>         -c, --config          print all configuration variable names
>         -m, --man             show man page
>         -w, --web             show manual in web browser
>         -i, --info            show info page
>         -v, --verbose         print command description
>
> If you look at output from=20
>
>     $ git grep -A4 -e '_usage\[' builtin/\*.c
>
> you'll notice that many of them do not even spell out each option
> and instead have a single [<options>] placeholder unless the command
> has only very small number of options.  With the number of options
> that "git help" takes, it might even be warranted to switch to the
> more generic "git help [<option>...] [<command>]".
>
> Not a strict veto, but just making sure if the over-cluttering of
> the early lines in "help -h" output has been considered as a
> possible downside before suggesting this change.

That's a valid point, but if you look at:

    for cmd in $(git --list-cmds=3Dbuiltins); do echo git-$cmd: && git -P $=
cmd -h | sed 's/^/    /'; done 2>&1|less

I think it's fair to say it's a fairly mixed bag, some have the brevity
you describe, others are attempting to list every possible option combo
etc.

This is one of the commands that's more like than the likes of
git-branch, git-worktree, git-stash, git-index-pack etc. than git-add,
git-apply, git-mv in the sense that it's trying to exhaustively mirror
the options between the documentation and the usage string.

I do think we should pick one, but I think migrating from one style to
the other just for this one command would be an unnecessary distraction
from a change that's not about changing that style in general, let's
just stick with the pattern we find here.

I do want to make them pretty and consistent eventually, this series is
just one small step on the way there.
