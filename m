Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06907C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 02:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378452AbiAUCRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 21:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiAUCRs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 21:17:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD2AC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 18:17:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m3so28904993lfu.0
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 18:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S47g1TmFTjWmH9QD9Ktcria6pQ0RmYYt9JUIBEU46Zs=;
        b=LsKg5AskFeGff0O2Erz2AvkftWfVHxZ+BS0T6QOZ8zkvHliRholieQvAgAyc/2flXE
         b2kz4hA5HIyNToOJFSvfFJqSRNBa9cU1LgXzPlk9NJBjilLMvhK+WMdC5mCuT6Dvs2Ty
         cgLJuEcK7gE9j00ABIigJexs4VXiXUv4TmPH0doYmKAvesw4Z/7a1Z8cGWW97SvMK5Yu
         Nvo8nBVwVLokSA2aYgBpZ7ceortv8RuXkyIU6jWxnySZNtGS9aTkcRlYKjl3SRlhSLux
         NH6baUvSp8+D1a0Djx3UYNOCweTeHCzwdNreKeiI9/uMS7RFPE1n439iFll6alyCSaBk
         GgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S47g1TmFTjWmH9QD9Ktcria6pQ0RmYYt9JUIBEU46Zs=;
        b=sVlL1q8p4aOFFH5zvhVSmyBtER1qByZ0spzs0kRq2UWJjtyJNe3+9PfufYW0LcBoQS
         /JVdZNFfAGMxZdYygudYEesIUqzBA6ovt2MTzolqFanyjYR1pXNUAm6xzAEu001Ffh/4
         a6XjJpsBDQJw5+3Yl2wOkR2pv9Q1TRj7dtmY9r8pO9NtmaMn2a/jWQorc0QpqyFV23/q
         gbZnIwyrRBixNuNkNXcTqLLOkd3fOJsejknetJPHy1DDQKPQJAGn2Cl8b/hSxjjnHzhR
         TkTyq5wE3wCEh94WpW4b2uN3Z3dBte1QAQFK+eicYY3QSKk+NbFB79njOia6k9nrfJyh
         Z7GQ==
X-Gm-Message-State: AOAM533M426Ps7eWhgNmfGeU6dFBPZfri6cntvCfreN7zvzizH7QbEmp
        gZq+x0ro6z2JRLCas9zgZFNv/tIOsGriR9tuf38=
X-Google-Smtp-Source: ABdhPJz+/MQnlEQ8mpqUVH5Gz3Q5YwfW45DC/W+VJOxJNg37OGQ9Buasc5jwpMzncBto1YS/5DiNd2GZrFJjaJiR4ic=
X-Received: by 2002:a2e:6a09:: with SMTP id f9mr1550055ljc.387.1642731465882;
 Thu, 20 Jan 2022 18:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20220119000056.58503-1-chooglen@google.com> <20220120174942.94231-1-chooglen@google.com>
 <xmqqk0eugjcc.fsf_-_@gitster.g>
In-Reply-To: <xmqqk0eugjcc.fsf_-_@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 21 Jan 2022 10:17:32 +0800
Message-ID: <CANYiYbGyJU-HQAgRPEB=Bdw8Oj+jvMnL3z=VguXh21OEQcfNgQ@mail.gmail.com>
Subject: Re: Re* [PATCH v7 0/3] fetch: skip unnecessary tasks when using --negotiate-only
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 5:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Glen Choo <chooglen@google.com> writes:
>
> > Changes since v6:
> > * use standard message format introduced in 246cac8505 (i18n: turn even
> >   more messages into "cannot be used together" ones, 2022-01-05) (thanks
> >   Jiang Xin!)
>
> As v6 is already in 'next' since yesterday, let's make it an
> incremental update.  It would give us a place to spell out why we
> consider this change is desirable.
>
> This is a tangent, but I recall there was a talk about "reviewer
> checklist".  Things like:
>
>  - check if we can reuse existing and identical message to reduce
>    load on translators

How to spot typos in l10n messages in time, instead of waiting until
the very end of the release cycle, has always puzzled me for a long
time. Until two months ago, by introducing a new GitHub Actions[1] in
the "git-l10n/git-po" repository[2], it was possible to generate
temporary "po/git.pot" file based on new changes in "git.git" in time,
and create incremental diffs of "po/git.pot" as separate files in the
"pot/master", "pot/next", and "pot/seen" branches in the "git-po"
repository. By checking the diffs daily, several i18n issues were
found in recent months.

We can make some improvements to the workflow:

1. Send each incremental diff of "po/git.pot" to active l10n team
leaders, and also to this mailing list. Git contributors can find
"side effects" introduced by their patches.

2. Just like using the "git-po-helper" program[3] to check "msgstr" in
l10n translations, develop a new helper to check "msgid". E.g.: check
if we can reuse existing and identical message to reduce load on
translators.

This workflow only works when patches go into the branch "seen" of
git.git repository. Lagging behind code reviews.

[1]: https://github.com/git-l10n/git-po/blob/pot/CI/.github/workflows/git-pot.yml
[2]: https://github.com/git-l10n/git-po
[3]: https://github.com/git-l10n/git-po-helper

>  - when we are creating a file in a subdirectory of $GIT_DIR, be
>    prepared to see any directories other than $GIT_DIR itself
>    missing and create them as necessary
>
>  - use safe_create_leading_directories() and adjust_shared_perm() on
>    things under $GIT_DIR but not in the working tree
>
>
> may belong there.
>
> I am not sure if it is feasible to create and maintain such a list,
> though.
>
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] fetch: help translators by reusing the same message template
>
> Follow the example set by 12909b6b (i18n: turn "options are
> incompatible" into "cannot be used together", 2022-01-05) and use
> the same message string to reduce the need for translation.
>
> Reported-by: Jiang Xin <worldhello.net@gmail.com>
> Helped-by: Glen Choo <chooglen@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/fetch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git c/builtin/fetch.c w/builtin/fetch.c
> index dc6e637428..5c329f9835 100644
> --- c/builtin/fetch.c
> +++ w/builtin/fetch.c
> @@ -2014,7 +2014,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>                         break;
>
>                 default:
> -                       die(_("--negotiate-only and --recurse-submodules cannot be used together"));
> +                       die(_("options '%s' and '%s' cannot be used together"),
> +                           "--negotiate-only", "--recurse-submodules");
>                 }
>         }
>
