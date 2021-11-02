Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB4C433FE
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3ED60EB4
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhKBQtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhKBQsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:48:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6EC06120E
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 09:45:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j21so55411930edt.11
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=72fCafFCrA5mHx368PCAQdV05cTvoHDIWLdzhfKLFMI=;
        b=YcPRYKLXNwAHgptryBDBgPUE/y/JQP6eJVoop8d01ujZ+dodYUEEbf+dIpB/c46Hqw
         UUGUfyNFsuEaFbcnA7/y9pLO4ldLWb9pds+jU8fSAiuunniOw5D9o898A0yVRhRMtF0G
         mOE1wAG0c+FcvD5bRUUfQKjaAw1o8PYSxNLKr8S+Hhk1e8zuAiKc3OohXUUGK7B0zAs1
         IyCBszXNrGpC0YAZkWAgm1wP9bkqXmomXrymZ/1hltmr9O4h84sCSmouyW/OeBr6IbGK
         DwHsoHVncncoMGZ244eOLYwnWJ+mjtd0FyAODFeVGsMpg699HNm8LsyNWfc29KPu9LVW
         yXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=72fCafFCrA5mHx368PCAQdV05cTvoHDIWLdzhfKLFMI=;
        b=nPeLwFy+WM/I1PDwlX3KcRHArOFvq7Z1agiDdMSwFK+ZHwCszr4V01FQUetM+2+TG9
         an6jcnHLyEb4QaaHkV6M43Yx+wLnYVEruHkxnreF/h4vhlltC6RXeyFIoEbqAFHglKO9
         vi462JTeNfabl4UbIgmH3z28w+UjuLZhNvAO71T/MWbVgeN70Lg2QWxiA4P7IIdlgpNz
         md5/Nn2kXFEgx+r2Tm02aU8GjDjncVmZ12EKlEFWuX2BYVrLM3FndFBHmTQ50pRpxSVO
         jteq1zfWU2iGfLYd95Vi6rki9OzSi1hhyy8MafShwWER8Ln5ncyJN14+pxl4M/LuIAVI
         hRFA==
X-Gm-Message-State: AOAM533EGDt1iFBactGKiuEPbQiVg0bzcXH/cmUjsswU69Rg6mfxHV6L
        8X30BexMt66Mscep6s4S20w=
X-Google-Smtp-Source: ABdhPJz0+0BJHgLftI88Xrzkd4vtocJyRp3z6jxHW+G5X6XNROaPzCgDAhM7hFC1hsCnwpBbN2RKyg==
X-Received: by 2002:a17:906:d552:: with SMTP id cr18mr47759230ejc.88.1635871529173;
        Tue, 02 Nov 2021 09:45:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u23sm10798868edr.97.2021.11.02.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:45:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhwue-002EgW-CZ;
        Tue, 02 Nov 2021 17:45:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: disallow directional formatting
Date:   Tue, 02 Nov 2021 17:38:07 +0100
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
 <211102.86tugu1svc.gmgdl@evledraar.gmail.com>
 <YYFdu/+j8ba+hjCF@nand.local>
 <nycvar.QRO.7.76.6.2111021706230.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2111021706230.56@tvgsbejvaqbjf.bet>
Message-ID: <211102.86h7cu1p7b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 02 2021, Johannes Schindelin wrote:

> Hi Taylor,
>
> On Tue, 2 Nov 2021, Taylor Blau wrote:
>
>> On Tue, Nov 02, 2021 at 04:01:57PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> > There's a parallel discussion about doing something to detect this in
>> > "git am", which for the git project seems like a better place to put
>> > this.
>>
>> I don't think that one impacts the other necessarily. Having `git am`
>> guard against this would probably be sufficient to protect Junio
>> accidentally apply something containing directional formatting to his
>> tree unknowingly.
>>
>> But the idea that we rely on the import mechanism to protect against
>> this doesn't sit well with me. Ultimately, we should be relying on a
>> static check like below to ensure that directional formatting hasn't
>> entered the tree by any mechanism (not just 'git am').
>
> Yep, the `git am` change and the CI change are addressing two very
> different concerns.
>
>> > > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> > > index 6ed6a9e8076..7b4b4df03c3 100644
>> > > --- a/.github/workflows/main.yml
>> > > +++ b/.github/workflows/main.yml
>> > > @@ -289,6 +289,13 @@ jobs:
>> > >      - uses: actions/checkout@v2
>> > >      - run: ci/install-dependencies.sh
>> > >      - run: ci/run-static-analysis.sh
>> > > +    - name: disallow Unicode directional formatting
>> > > +      run: |
>> > > +        # Use UTF-8-aware `printf` to feed a byte pattern to non-UT=
F-8-aware `git grep`
>> > > +        # (Ubuntu's `git grep` is compiled without support for libp=
cre, otherwise we
>> > > +        # could use `git grep -P` with the `\u` syntax).
>> > > +        ! LANG=3DC git grep -Il "$(LANG=3DC.UTF-8 printf \
>> > > +          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\=
|\u2067\\|\u2068\\|\u2069\\)')"
>> > >    sparse:
>> > >      needs: ci-config
>> > >      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>> > >
>> > > base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
>> >
>> > It would be easier to maintain this if were added to
>> > ci/run-static-analysis.sh instead, where we have some similar tests, a=
nd
>> > if it lives there we could do away with the double-escaping, then it c=
an
>> > also be run manually.
>> >
>> > Also, can't we just pipe "git ls-files -z" into "perl -0ne" here and u=
se
>> > its unconditional support for e.g. unicode properties in regexes.
>>
>> I agree that the double-escaping is ugly. I think that this would be
>> easier to maintain if it lived in ci/run-static-analysis.sh or its own
>> script like ci/check-directional-formatting.sh.
>
> That's a good idea, I will put it into its own script in ci/.
>
>> And yes, constructing a byte pattern is a little odd as well, but I
>> think that it's the best you can do if you're limited to running 'git
>> grep' without libpcre. I wondered if we could depend on perl being
>> around during CI, but as far as I know we can since install Perl modules
>> in ci/install-dependencies.sh and use Perl extensively through the test
>> suite.
>
> Perl alone won't fix anything. A crucial part of the `git grep` invocation
> is the `-I` option: ignore binary files.

As noted in [1] I'm rather skeptical of us needing this at all, but why
is "-I" needed over asking "git grep" or "git ls-files" to exclude
binary files?

    git ls-files ':!(attr:binary)'

I.e. why do ad-hoc binary detection on the fly in git.git when we should
already be marking what files are binary?

If this check shows a false positive due to a binary file isn't that a
good thing (sans LTR issues I mentioned upthread), i.e. we should be
adding that file to .gitattributes, no?

In any case, I meant that the match on the RHS might be easier with
Perl, in such a pipeline you could always farm out the binary detection
to GNU grep on the LHS or whatever. Maybe you don't want to do it with
Perl, but using the -I option seems like a bad idea in either case.

1. https://lore.kernel.org/git/211102.86lf261q2e.gmgdl@evledraar.gmail.com/
