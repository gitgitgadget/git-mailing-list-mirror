Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CCBC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 09:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjC2J6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjC2J6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 05:58:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A110CE
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 02:58:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so60772322edb.13
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680083885;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfeqI3byyDFjjuTgRj4Y3EmvXi1ouEatszy4y+C5mak=;
        b=O/L2pgJ9DyzuOSzXjpGahl1llwlRP/ctCERSv5tnKz3b538vjdzw1Q1wG1hDSqsuAy
         /blp9EmkGay5viQqlC9opwobRidUHoDUzTA/o0vHibkcRFoVQ9fmkZRUl4iBYNsqA2mi
         4X2gBfxA9PN7YHlvjrdczw3pj75iLE3MWPFKctbQ9SmG5uLBv1yXpN0bexq/cnQ4XlTe
         /PMRQx2F+3gzLbLQMNVn/aoSNT1I72+8DfA4QI978rmgM4h2VlpliBgRsE6zc/KhZV47
         uaLxP+hSeVPyWupzRAzwlMsfaOMf0TKRla3d8YlDHOdrjWoZk5M8qXwgdQ9gcllsujt4
         GWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083885;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfeqI3byyDFjjuTgRj4Y3EmvXi1ouEatszy4y+C5mak=;
        b=gMBvDvFxNOAvQLNo7+N1JSP46X5tntzMmsdq6jHDAOKh5mq+HmD3E6TjfciYNleSHJ
         ZTmG1E2Dh5Uh3PlpEGkhSZESPuwEq56qDtNDDk3NwiouRm3zGxQsYses8x+Wy0Bn0ovL
         TM8anjr33gS4omoOSrrbRxUtwEckTiT/77mwgnL/Oq3viNIUKmtIC4WBrwTZ7D8OEXB5
         28sKeIFSDADO7IL+QnSzny8JreEhQVe+ldn5jRHZl5CSF5Kmgctmi+0wISmCL/AWGXrr
         sCEZCz5ftfjcqaWx31YWy+BbwG1TcXWy1u5fZdnTLiPHfHRC2Sf7qZpOzgEeCVzbG+xq
         YAXQ==
X-Gm-Message-State: AAQBX9ef5GLKZvKohCuuEIl+8EO9JhVH8ufiUFB/0Eud50t5xp7MyhiS
        sQ/ErRfET7ObOTpCd9MwII+fC/C2cAcbtw==
X-Google-Smtp-Source: AKy350aul2vcv23YN/X1Csxo0MJ/IKuImtAoANAsJcNvBpgK79f7tDC5IXh9Y/0pfD63m43eBC9Afg==
X-Received: by 2002:aa7:c847:0:b0:501:bf46:a78d with SMTP id g7-20020aa7c847000000b00501bf46a78dmr16215257edt.36.1680083884843;
        Wed, 29 Mar 2023 02:58:04 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b004fe924d16cfsm16933115edj.31.2023.03.29.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:58:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1phSZ9-0056KI-1w;
        Wed, 29 Mar 2023 11:58:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
Date:   Wed, 29 Mar 2023 11:51:08 +0200
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
 <CAMP44s07W6SzJZnmpMMejM8cTNvwrKnNiD+1U=JWMBwUX8JbMA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAMP44s07W6SzJZnmpMMejM8cTNvwrKnNiD+1U=JWMBwUX8JbMA@mail.gmail.com>
Message-ID: <230329.861ql7x4k4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 28 2023, Felipe Contreras wrote:

> On Tue, Mar 28, 2023 at 6:57=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> On 2023-03-28 at 17:39:26, Felipe Contreras wrote:
>> > It's not difficult to make the testing library work for zsh, so I did =
that in
>> > the first patch.
>> >
>> > The rest of the patches are basically to deal with some variables that=
 are
>> > special in zsh, workaround a bug, and a minor discrepancy.
>>
>> There was a point at which the tests worked entirely in sh mode with
>> zsh.  I know because I fixed a handful of tests there, ending with
>> c64368e3a2a47, and I patched zsh to run all commands in a pipeline in a
>> subshell in sh mode to fix the remaining tests.
>>
>> If I symlink zsh (zsh 5.9 (x86_64-debian-linux-gnu)) to sh in a
>> temporary directory and use it in SHELL_PATH, I get only the following
>> failures:
>
> That would defeat my motivation behind the patches, which is to be
> able to run one test file in zsh.

"One" as in one specific file you have in mind, or a "one-off run"? The
1/6 here looks like it fixes most of the issues, but e.g. the
test-lib.sh fix in 2/6 would be needed by any test that reached that
code, wouldn't it?

If it's the latter, I don't really see the point of making just some of
it work with zsh's native mode (if I'm getting this correctly).

But for that case, wouldn't:

	zsh --some-options t0001-init.sh

Or whatever work, which just from skimming the help might be some of the
--posix options? But I can see that being more of a hassle, presumably
you want to use it as /bin/sh, and to have it pick up the script and
have it Just Work.

Some details on all of this in an updated commit message would be most
welcome...

> Only the first patch is needed for that, the rest were in case anyone
> cared to run all the tests.
>
>> I don't care a lot of other folks want to make zsh run the testsuite in
>> zsh mode, but I'd think that using sh mode would be simpler and less
>> likely to break in general, and would avoid us needing to carry a lot of
>> patches to work around various variables that are special in zsh mode.
>
> We don't need to carry the patches if the patches are applied.

But we do need to carry some hacks going forward, some of it seems
pretty isolated & easy to spot, but e.g. the 6/6 fix of:

-		if test "$c" =3D " "
+		if test "$c" =3D " " || test -z "$c"

Is quite subtle, you might look at that and be convinced that the RHS is
redundant, and be right, but only because you assume POSIX semantics.

If we are going to include this I think the relevant t/README and
Documentation/CodingGuidelines parts should be updated to note that
we're not targeting POSIX shellscripts anymore, but the subset of it
that zsh is happy with.

And, to avoid the inevitable re-breakage have this tested in CI,
usurping 1/2 OSX jobs for that might be a good target (or one of the
other linux jobs)...
