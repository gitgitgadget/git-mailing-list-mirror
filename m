Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F7C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7E661976
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhC1PkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhC1Pjs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 11:39:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9FFC061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:39:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so15675471ejs.3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SFCrp+3D/jXWc4HLDWtYXd615u3WZtzJfN65mH16r1s=;
        b=Q+3NLwmAsSXAEbTuGhbw6F/Jn2CQoF1UFRcyGdQIaUJXiK3xQ9L+SDTu35VkZeTgGX
         RaDp1na1rApkzXTZpndciXIeQTdbIYSv1B2vLHjRTpNm3JDTEIQ7RqDlDrWEVloQppvx
         TzsayOQv9LwHL6tWn70rsifx6p86QcIGvgP3Eff6Z7F20/iOltuLR2RWX3ceNiQTbcO5
         cLJYqS/pW42lrvLnV2BBj6THwXRDGE0B0FYRFi6UrvwfhwT9mBeJmsHFi9tjmTWua9UD
         PwbRD/OCEtr6I4FoYHxI5BtKOjbrTvUCz/QxPRNI74cE6P25wmjv2aH2tJ2AZ63sGxTn
         LZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SFCrp+3D/jXWc4HLDWtYXd615u3WZtzJfN65mH16r1s=;
        b=SpdxbjQRCyL2wvkA78sPr1PMqqwcv9zT1V+25Y1cLJkpMc9ARG3KPNf8KO8VgXwiBj
         LgcgHO43kgCHDZ4IkyIYFhNAbEf2zEPKPNGnabRY1/oaZ4tzHFml13PxB5EGUetwGXCQ
         bEzZJDRmR3ua4JvkKk3DuvBO3JMEqkjvGxJ9X/BITX+VXT4c/Ixth1ZBkqDCBYSn/t7w
         4xbuZvs1BvE8VWWTNjPVkpS1OAq1hYbulg43HenXthP5Js1tAYh7I1Xm4QeX0MHe11LT
         udRmhrUfCxQpAgKX1+2lLdsFBJQbNK9tvY9Bnq1CX2o4x86VAE+W+J+yuETkG4e23qSZ
         ranA==
X-Gm-Message-State: AOAM531a5IHPtkaES4+bjR9MkbVE7cDov61uoU/ZKqfApIHfVDSwGEKb
        XQ0Idnhw7t1CivKepduSmyw=
X-Google-Smtp-Source: ABdhPJzEG3YLv2VqbdGDgARTrlRaPRgpv9wwjXLbgg9HTs9xq1cV8YbEDll4fC6RSryvZIYHqlCtjg==
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr24186642ejc.276.1616945986743;
        Sun, 28 Mar 2021 08:39:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k12sm7516288edr.60.2021.03.28.08.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:39:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] object tests: add test for unexpected objects in tags
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-7-avarab@gmail.com>
 <YEdRhulqevMjlrLc@coredump.intra.peff.net>
 <87h7kwnjpp.fsf@evledraar.gmail.com>
 <YGBHH7sAVsPpVKWd@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YGBHH7sAVsPpVKWd@coredump.intra.peff.net>
Date:   Sun, 28 Mar 2021 17:39:45 +0200
Message-ID: <8735wfnv7i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 28 2021, Jeff King wrote:

> On Sun, Mar 28, 2021 at 03:35:46AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> Fix a blind spot in the tests added in 0616617c7e1 (t: introduce tests
>> >> for unexpected object types, 2019-04-09), there were no meaningful
>> >> tests for checking how we reported on finding the incorrect object
>> >> type in a tag, i.e. one that broke the "type" promise in the tag
>> >> header.
>> >
>> > Isn't this covered by tests 16 and 17 ("traverse unexpected non-commit
>> > tag", both "lone" and "seen")? And likewise the matching "non-tree" and
>> > "non-blob" variants afterwards?
>>=20
>> Barely, those tests are mainly testing that rev-list doesn't die, and
>> only do a very fuzzy match on the output. E.g. checking `grep "not a
>> commit" err`, not a full test_cmp that'll check what OID is reported
>> etc.
>
> I thought the "blind spot" you meant was not testing these cases. But I
> guess you mean that we are not checking stderr.
>
> So OK, but...

Ah yes. I'll clarify that. I thought it was clear since the series is
about the output we emit on errors, not the rev-list traversal itself.

>> > The only thing we don't seem to cover is an unexpected non-tag. I don't
>> > mind adding that, but why wouldn't we just follow the template of the
>> > existing tests?
>>=20
>> I am following that template to some extent, e.g. using
>> ${commit,tree,blob}. It just didn't seem worth it to refactor an earlier
>> test in the file just to re-use a single hash-object invocation, those
>> tests e.g. clobber the $tag variable, so bending over backwards to
>> re-use anything set up in them would mean some refactoring.
>>=20
>> I think it's much clearer just do do all the different kinds of setup in
>> the new setup function.
>
> It does not seem to make the resulting test script more clear at all to
> create the same situation twice, but test stderr only in the second
> case. I.e., why is the change to the test script not just:
>
> diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-un=
expected-objects.sh
> index 52cde097dd..4cdc87c913 100755
> --- a/t/t6102-rev-list-unexpected-objects.sh
> +++ b/t/t6102-rev-list-unexpected-objects.sh
> @@ -82,12 +82,13 @@ test_expect_success 'setup unexpected non-commit tag'=
 '
>  '
>=20=20
>  test_expect_success 'traverse unexpected non-commit tag (lone)' '
> -	test_must_fail git rev-list --objects $tag
> +	test_must_fail git rev-list --objects $tag >output 2>&1 &&
> +	test_i18ngrep "is a blob, not a commit" output
>  '
>=20=20
>  test_expect_success 'traverse unexpected non-commit tag (seen)' '
>  	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
> -	test_i18ngrep "not a commit" output
> +	test_i18ngrep "is a blob, not a commit" output
>  '
>=20=20
>  test_expect_success 'setup unexpected non-tree tag' '
>
> and so forth (or you can replace it with a full test_cmp if you really
> prefer). That does not seem like bending over backwards to me, but
> rather keeping the test script tidy and readable.

Yeah, it needs to be a test_cmp (or equivalent) since the point of the
test is *which* thing we're reporting as the "is X not Y".

But yes, these can be combined. But I still think it's clearer to have
minimal tests for the traversal and then later (much more verbose) tests
for the output.

So if you the traversal fails you'd be looking at a fairly isolated test
with just two lines, v.s. 10-15 lines of later test_cmp etc.

> [...]

Will reply to the rest, but that discussion seems split, so reading the
thread to see what the best place to continue that chat is...
