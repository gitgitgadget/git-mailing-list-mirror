Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F66C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 13:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED20B61A56
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 13:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhJANZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhJANZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 09:25:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB612C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 06:23:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b8so271311edk.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VOwpLMYtBpnRpt80z2WFc5Ol20Bblh9iPXHybDNYV9o=;
        b=kJAqqkHBE5FXhXXMqGZM1RoOHPASYtqy/1Is3ZkoYubAWbG+Zo8QIxD1YXHtDng0Ye
         6/8FyTo6ycFnr96v7YNtCv+MvvXeFyS1lBWmzooXPkiFcBQ9cSRVSkwUUtFyoSztO66E
         PHVH3y2pOshoOfz2wU3NZqH3Kpn06bLLDx33NzfOGfplLuUpXS86pLsHaUi6KFMj2sPJ
         46Ghi2byJHfg63UtGHZKqYBlughvNe1I/eEgml3enz8xpKT/ne7Zo4FdY2PMFPG2+2ap
         5TwZuzaqFn0N41u78I18nnBRe1YJcQaxwOlLaJHL5rdYcDShR9hnxjeRbloRjJw3Wyb2
         CAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VOwpLMYtBpnRpt80z2WFc5Ol20Bblh9iPXHybDNYV9o=;
        b=2H9nNgEc1G9o5Hch2HXAc6TWcZVsM3W9u4U8fKl+dll/10aiw1RhvMa+dI4aGS32WE
         ahKxvN7/LphOfsanCPeMxvp+J5Rg0G9MihEzMUfrPEj3cTSfPRAarPeoKm2iEfRyl1z7
         3HgSdzRe+lGQWkbrHUqiRINwO1F8NRbFOv05TEcNabsJm68rjxMMmQUE5P6c1o/1ANNH
         CgU/8sOPrtp3bhnyGDxL7sZbJtbSlUKIChZI1fmStTEwuBGMPiZv1dcfCFpr6UWcXAav
         S+5DaACXslSHSXgkQHe0mgYBbjDdQFMZS0R7KXddylMFAw38agEvsaP+wOERaN14/RI1
         wUXw==
X-Gm-Message-State: AOAM530WgnigzVrUrdY2g0nfkJ7Cifwi2waX1m0r+eyOgfUy8CjlgFaF
        bZJrnDVYARP8gYcp1PYclPc=
X-Google-Smtp-Source: ABdhPJwxw4r3I3kcg7Ig1IT7JWAoMOYAijyQks3mj9BgoJyeoHtEARQHpsKtLZVh990QqFrfL1yC3Q==
X-Received: by 2002:a17:906:2295:: with SMTP id p21mr6292791eja.421.1633094637826;
        Fri, 01 Oct 2021 06:23:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n23sm3235266edw.75.2021.10.01.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:23:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 07/10] commit-graph: stop using optname()
Date:   Fri, 01 Oct 2021 15:16:38 +0200
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
 <patch-07.10-b0b313795c7-20210928T130905Z-avarab@gmail.com>
 <YVSiOMaKNoDZ3SlO@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVSiOMaKNoDZ3SlO@nand.local>
Message-ID: <87tui0ri8j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 29 2021, Taylor Blau wrote:

> On Tue, Sep 28, 2021 at 03:14:28PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Stop using optname() in builtin/commit-graph.c to emit an error with
>> the --max-new-filters option. This changes code added in 809e0327f57
>> (builtin/commit-graph.c: introduce '--max-new-filters=3D<n>',
>> 2020-09-18).
>>
>> See 9440b831ad5 (parse-options: replace opterror() with optname(),
>> 2018-11-10) for why using optname() like this is considered bad,
>> i.e. it's assembling human-readable output piecemeal, and the "option
>> `X'" at the start can't be translated.
>
> In fact, using optname there (which blames to me) was a mistake for an
> even simpler reason: there is no abbreviated form of
> `--max-new-filters`, and we know that by the time this error is emitted
> that we got the positive form instead of `--no-max-new-filters`.
>
> So we could have just written the option's name verbatim, and given
> translators something easier to work with.

As an aside: Did you intend for this to work:

    git commit-graph write --max-new-filters=3D123 --no-max-new-filters

It's in the docstring, but then you're using OPT_CALLBACK_F(), but just
to set a flag of "0", so a OPT_CALLBACK() would do, along with a
PARSE_OPT_NONEG.

I'm about to re-roll this, but won't change that, but I think it
probably makes sense as a follow-on cleanuup.

I think you'd probably want a BUG_ON_OPT_NEG() instead for the "unset"
handling here. This seems like another case of mixing the state of
parse_options() with that of flags for the underlying API that we
discussed elsewhere either for this command or multi-pack-index. But
more on that below...

Also the usage if --no-* is wanted should not be:

    [--no-max-new-filters] [--max-new-filters <n>]

But is currently:

    [--[no-]max-new-filters <n>]

Which says the --no-* will take the <n>, but it won't.

>> It didn't matter in this case, but this code was also buggy in its use
>> of "opt->flags" to optname(), that function expects flags, but not
>> *those* flags.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/commit-graph.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 0386f5c7755..36552db89fe 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -172,8 +172,7 @@ static int write_option_max_new_filters(const struct=
 option *opt,
>>  		const char *s;
>>  		*to =3D strtol(arg, (char **)&s, 10);
>>  		if (*s)
>> -			return error(_("%s expects a numerical value"),
>> -				     optname(opt, opt->flags));
>> +			return error(_("option `max-new-filters' expects a numerical value")=
);
>
> Makes sense. The `'-style quoting is still weird to me. It is consistent
> with some of the conversions in 9440b831ad5, but most importantly with
> how parse-options.c:get_value() behaves (because it calls optname
> underneath).

Yeah I just reproduced the existing output here.

> (This has nothing to do with your patch, but I thought the custom
> write_option_max_new_filters callback was weird when I wrote it. It's
> working around trying to make the negated form set a value to `-1`
> instead of `0`. But it's an annoying hack, because we have to call
> strtol() ourselves when we're not negated. *sigh*).

...on the "more on that below", looks like you intended that -1 handling
in some way, but I don't really see why yet, other than the "mixing the
state" I noted above.
