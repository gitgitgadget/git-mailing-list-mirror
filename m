Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED03FC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D611061058
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhKBQjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbhKBQir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:38:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C7C079783
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 09:26:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so77648892edj.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c8fuq91fT7iViVhhQGgvDbewCEM/+2k8nQ+Emf/JDVY=;
        b=hiJIBETF94VHKyNO8pg+r+OQvFs2u6Le3FF6MSz8jEKCUb0MF+TAJMyItZPpIMo+Ui
         lFXC+9kS34Gm57XZ0D7FipV5fRTRS2BQ4f0yB9kdotueshxSkqjNsEuqE6Zc/l7Akvwu
         ffdwJ5/Ro/bO/NLwwpE7qPMoliT3DzbBIPzErwKdpiu2et6bcbf+WFk/ATIfYhM9pEAF
         wEfR6bXnL+3aZTb7T2cPP/4PO4v19FH93EtLcZTclv7d/x6sX65gKwY3kcGmAMx4wmE4
         b+K/mJVnEGPcdqpDzoNodIPsUEANzYPcAfuR6iWfTMKptkP7zQBFfvsJ9CdU+TGTBTz9
         1wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c8fuq91fT7iViVhhQGgvDbewCEM/+2k8nQ+Emf/JDVY=;
        b=t9YMYIt55snctqn4j2TqUspKKNQ08nWnX+UfSVLXPxIXZlgPZCgeOXHKT6Ac6mGsTN
         zg3HhMlAYsCwSkdjq86T3F7geTsZATZh+MevIoK5BmKDrsHAo2xHwK+0MvX+8WHJEk6d
         IaoX1AaBWf9PDBz28TN4pFPIgDF0kSJ2hNtIpgPbDcq6FVg1tkCcJxNp+RFoYr6S2pAe
         znPMOO5+dmciw4CN5oQnRWBDAC6knqUMUXNYTYiUgSG2YHJHt+EA6RVHgFc6w3twOUOP
         lnSAoFjqOaQkhkg5i2ZbMbAZvw2SDdNJNr2+LVibNIXz4JA1zDlK3kA2KYhvPrgJoCmv
         vRRA==
X-Gm-Message-State: AOAM532W0M054sZr+9rKzB8HakaVCtn1ovk1KIa/XI4MlzF+/8qMoFEE
        hw4azzAYobqMoA+JRCghjIY=
X-Google-Smtp-Source: ABdhPJzJ2ccUtmU+xFqcD5r9x1BNqOe9VTJWuIRRH3bvoeFFjbkO+tiwMRk7YscBRu0tHkn5/TJXHQ==
X-Received: by 2002:a17:907:3f92:: with SMTP id hr18mr34332618ejc.348.1635870411133;
        Tue, 02 Nov 2021 09:26:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b11sm864669ede.52.2021.11.02.09.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:26:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhwcb-002Ebq-Cc;
        Tue, 02 Nov 2021 17:26:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: disallow directional formatting
Date:   Tue, 02 Nov 2021 17:03:22 +0100
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
 <211102.86tugu1svc.gmgdl@evledraar.gmail.com>
 <YYFdu/+j8ba+hjCF@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYFdu/+j8ba+hjCF@nand.local>
Message-ID: <211102.86lf261q2e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 02 2021, Taylor Blau wrote:

> On Tue, Nov 02, 2021 at 04:01:57PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> There's a parallel discussion about doing something to detect this in
>> "git am", which for the git project seems like a better place to put
>> this.
>
> I don't think that one impacts the other necessarily. Having `git am`
> guard against this would probably be sufficient to protect Junio
> accidentally apply something containing directional formatting to his
> tree unknowingly.
>
> But the idea that we rely on the import mechanism to protect against
> this doesn't sit well with me. Ultimately, we should be relying on a
> static check like below to ensure that directional formatting hasn't
> entered the tree by any mechanism (not just 'git am').
>
>> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> > index 6ed6a9e8076..7b4b4df03c3 100644
>> > --- a/.github/workflows/main.yml
>> > +++ b/.github/workflows/main.yml
>> > @@ -289,6 +289,13 @@ jobs:
>> >      - uses: actions/checkout@v2
>> >      - run: ci/install-dependencies.sh
>> >      - run: ci/run-static-analysis.sh
>> > +    - name: disallow Unicode directional formatting
>> > +      run: |
>> > +        # Use UTF-8-aware `printf` to feed a byte pattern to non-UTF-=
8-aware `git grep`
>> > +        # (Ubuntu's `git grep` is compiled without support for libpcr=
e, otherwise we
>> > +        # could use `git grep -P` with the `\u` syntax).
>> > +        ! LANG=3DC git grep -Il "$(LANG=3DC.UTF-8 printf \
>> > +          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\|\=
u2067\\|\u2068\\|\u2069\\)')"
>> >    sparse:
>> >      needs: ci-config
>> >      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>> >
>> > base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
>>
>> It would be easier to maintain this if were added to
>> ci/run-static-analysis.sh instead, where we have some similar tests, and
>> if it lives there we could do away with the double-escaping, then it can
>> also be run manually.
>>
>> Also, can't we just pipe "git ls-files -z" into "perl -0ne" here and use
>> its unconditional support for e.g. unicode properties in regexes.
>
> I agree that the double-escaping is ugly. I think that this would be
> easier to maintain if it lived in ci/run-static-analysis.sh or its own
> script like ci/check-directional-formatting.sh.
>
> And yes, constructing a byte pattern is a little odd as well, but I
> think that it's the best you can do if you're limited to running 'git
> grep' without libpcre. I wondered if we could depend on perl being
> around during CI, but as far as I know we can since install Perl modules
> in ci/install-dependencies.sh and use Perl extensively through the test
> suite.

We can hard depend on anything listed in [1][2], in this case there's a
Perl 5.30 available.

We don't need any Perl modules, it's all Perl-native regex features and
a small for-loop.

On the topic at large I wonder how much we need to worry about this at
all, seems like somewher between case of "the anglosphere discovers
scary foreign characters in Unicode again" and "security researcher
creates scary landing page for well-known Unicode edge-case"[3] :)

In this particular case the test cases involved seem extremely contrived
and unlikely to be something we'd end up with in our code in any case,
even in a case where all the reviewers would be fooled by this method in
itself.

I.e. since you can't use these to "fold" lines in the eyes of a human
viewer it's all rather contrived cases where comments and valid C code
lives on the same line, e.g.:

    /*=E2=80=AE } =E2=81=A6if (isAdmin)=E2=81=A9 =E2=81=A6 begin admins onl=
y */
        printf("You are an admin.\n");
    /* end admins only =E2=80=AE { =E2=81=A6*/

Which at least in Emacs is highlighted the right way, which is the first
major clue, and having tested some of these just now on AIX I've got xlc
whining about some cases that gcc/clang will happily pass by, so our
tooling at large will probably catch these anyway...

1. https://github.com/actions/virtual-environments
2. https://github.com/actions/virtual-environments/blob/main/images/linux/U=
buntu2004-README.md
3. https://www.trojansource.codes/
