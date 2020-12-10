Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC35C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A4923C18
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393787AbgLJU3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 15:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393792AbgLJU3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 15:29:37 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D25C0613D6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:28:57 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id b9so9245524ejy.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RseEEt7yap+6uhBibYYZXUZWll7eL20eRX6kzd7t/BI=;
        b=qP0rX8BNhkO9uf+M0G6KnWblWtXkrXJBJ93N4K4LNfxKetDe7odCSzcNNyxiNP6eD8
         lsxz/GkWXTUCx8KoTudjz5TbwLF9ugcN8zGMHO4kq3XlH50BFQ5J8DjlrDmrbnxcjrWC
         1h+KSIGv5SXt13q6qMmtHIfOoBm4BnNyknbUMdJ1drsvaB29boiRqo486nn0TMFjQIpr
         X1SnMMDvaHq99ybukf6tzDI4kYgPHioBuBbM+AbkxR67/9MHC8CrqPuQfJE4yHqYce+m
         c8GgPPj5VOw4atPa1j80y/4DWCl+eMXZDsPWPNNpnZV9Rvq0KtjU0qkoOdsZpvlmHHYM
         hsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RseEEt7yap+6uhBibYYZXUZWll7eL20eRX6kzd7t/BI=;
        b=e1AdkwCi87VlZ3Vb17+yxnasBfiJB0qK2X5a4FxQ4/SCxCpETG5TZbNPMxvijKznk9
         28rBVj+YQaALWk0iLTwyi8p4+KemvlWvB/di4nKaEEV7AInUkGP77HTMhlDzWS0knbzi
         Bcq4A9by9I6QxMM0prDDYEYK42c9WxaKKla9PDee3CQsRQDhB39/mYv3mAnNR+BS40CP
         FAVKwy0JhPvClRgc9vzeHvJaHLCrWHIwXgcsWnGdhahxv5czI0vPYb8ckv2ImZGWdXxP
         BStGkhWpl7AQFraWdFfEz+BastZQ66R6WBwVE3D8zfexk85WCJR/x4anttGdcjWRE6Ln
         WaEQ==
X-Gm-Message-State: AOAM530igGZDSMNMZzE8A2uDw/nX2Exz+Q6G1kcySLpfE4fe3INz6skw
        nEroq2544TSPB3sWN9bnE3pFKX+Vu5VREg==
X-Google-Smtp-Source: ABdhPJy81iWgNtEzIsPoxr7aDTBHBmxB/zG8HirgzmxV9MDS6uOy2YJMjkjHJy0WHiq3/828F2lAug==
X-Received: by 2002:a17:906:a00a:: with SMTP id p10mr8104978ejy.312.1607632121042;
        Thu, 10 Dec 2020 12:28:41 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m2sm5801387edf.27.2020.12.10.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:28:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: warn on non-pseudoref looking .git/<file> refs
References: <20201210125321.19456-1-avarab@gmail.com>
 <20201210125321.19456-2-avarab@gmail.com>
 <CAPig+cQpB3B+Ywc1aFd7QMrqVKy29VmNKJfzcFeSCYz=mwO0Hw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAPig+cQpB3B+Ywc1aFd7QMrqVKy29VmNKJfzcFeSCYz=mwO0Hw@mail.gmail.com>
Date:   Thu, 10 Dec 2020 21:28:39 +0100
Message-ID: <87sg8dwglk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 10 2020, Eric Sunshine wrote:

> On Thu, Dec 10, 2020 at 7:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> [...]
>> Let's help the user in this case by doing a very loose check for
>> whether the ref name looks like a pseudoref such as "HEAD" (i.e. only
>> has upper case, dashes, underbars), and if not issue a warning:
>> [...]
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/Documentation/config/core.txt b/Documentation/config/core.t=
xt
>> @@ -355,6 +355,17 @@ core.warnAmbiguousRefs::
>> +core.warnNonPseudoRefs::
>> +       If true, Git will warn you if the `<ref>` you passed
>> +       unexpectedly resolves to a top-level ref stored in
>> +       `.git/<file>` but doesn't look like a pseudoref such as
>> +       `HEAD`, `MERGE_HEAD` etc. True by default.
>> ++
>> +These references are ignored by linkgit:for-each-ref[1], but resolved
>> +by linkgit:git-show[1], linkgit:git-rev-parse[1] etc. So it can be
>> +confusing to have e.g. an errant `.git/master` being confused with
>> +`.git/refs/heads/master`.
>
> Dscho has been submitting patches lately to eradicate the word
> "master" from the project source.

Muscle memory dies hard, will fix it in the reroll.

>> diff --git a/refs.c b/refs.c
>> @@ -669,6 +676,19 @@ int expand_ref(struct repository *repo, const char =
*str, int len,
>>                 if (r) {
>> +                       if (warn_non_pseudo_refs &&
>> +                           !starts_with(fullref.buf, "refs/") &&
>> +                           !starts_with(r, "refs/") &&
>> +                           !strchr(r, '/') &&
>> +                           !is_any_pseudoref_syntax(r) &&
>> +                           !warned_on_non_pseudo_ref++) {
>> +                               /*
>> +                                * TRANSLATORS: The 1st argument is
>> +                                * e.g. "master", and the 2nd can be
>> +                                * e.g. "master~10".
>> +                                */
>> +                               warning(_("matched ref name .git/%s does=
n't look like a pseudoref"), r);
>
> The TRANSLATORS comment talks about two arguments, but I see only one.
>
> Does the "matched ref name" part add any value? I would find the
> warning just as helpful without it:
>
>     .git/blork doesn't look like a pseudoref

Yeah that's much better, the TRANSLATORS comment is incorrect, rebased
out an earlier version where it took two, didn't notice...

>> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
>> @@ -374,4 +374,45 @@ test_expect_success 'branch -m can rename refs/head=
s/-dash' '
>> +test_expect_success 'warn on non-pseudoref syntax refs in .git/' '
>> +       test_when_finished "
>> +               rm -f .git/mybranch &&
>> +               rm -rf .git/a-dir &&
>> +               rm -rf .git/MY-BRANCH_NAME &&
>> +               rm -rf .git/MY-branch_NAME
>> +       " &&
>
> Nit: These could all be removed with a single `rm -rf`:
>
>     rm -rf .git/mybranch .git/a-dir ...

Will fix.

>> +       # We do not ignore lower-case
>> +       cp expect .git/mybranch &&
>> +       git rev-parse mybranch >hash 2>err &&
>> +       test_cmp expect hash &&
>> +       GIT_TEST_GETTEXT_POISON=3Dfalse grep "like a pseudoref" err &&
>
> What is the purpose of assigning GIT_TEST_GETTEXT_POISON here?

Since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
2018-11-08) we haven't needed to use the C_LOCALE_OUTPUT prerequisite
for any new code, since we can just turn the poisoning off.

I think we should just slowly refactor things away from that
prerequisite and test_i18ngrep, which were only needed because it used
to be a compile-time switch, but I haven't gotter around to that
refactoring.

In liue of that I think it makes more sense to always run the full test
if possible, no matter what the GIT_TEST_* mode is.

>> +       git -c core.warnNonPseudoRefs=3Dfalse rev-parse mybranch >hash 2=
>err &&
>> +       test_cmp expect hash &&
>> +       test_must_be_empty err &&
>> +       rm .git/mybranch
>> +'

