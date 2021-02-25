Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC0C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD93964F17
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhBYTu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhBYTsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:48:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C61C06174A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 11:47:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c23so1943750edr.13
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 11:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qAU5u/NCcM/mkNlAH4CIqDALet2jeZZoaKkjb7O/JoU=;
        b=D/VyABQYPTbEyCSGRJrrbT/3B7ZkRyX89KiIP0jRP4/3Em2n7pBoTej8xWQrOHJag0
         NgMU/+hxrW8nv2GNdOfgyJ7FZAyDUcxOjY0eDES4hZ8EzEYdt768rHnjSvkc4sJXK2pk
         dCRzNRyDD0/DqXSs7DSJxgb11nZ9Ccg5zZO4zZnqtZ0uJvnV4eMAhWqTDvKUAWrxDXCv
         YDKwMa/1Alf1Z3a9e8Sjmzx4Ty+CrAtEMzPs3Wk0KckCO5a95ibit++xyAT3DDTRyOvZ
         e++JGqSsSpoSntCURWLCO8/H5RHDErrjG8DkAqF+LYc77PsDgWj1HjT418W3yqfqAYNf
         VYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qAU5u/NCcM/mkNlAH4CIqDALet2jeZZoaKkjb7O/JoU=;
        b=PZohEOAQ4aTdJKI5aYMWGsnNhSOu63GqGHulj2cAz+yYW/DoqQP16C2PM++g73vEnS
         tKS95Ll1kPovpyO4jTDPJ3l7x9AZmaSSu4466OQwP7xvSuH9aEnBIYk2SlQBynESWRVL
         maWinDzmWagwReegV4MOTkr0xzeFtWTjFzigqRrUWKfeCJBEOpYVdbfoeAtXVWlKWV98
         IcGlgvAxoc+Li70Gw1U9Xv4Zsfecucp9Irn4CcFscaDrRYHtTdmcwE3zfuCWBl1m4VJo
         b4IhR+cRYzY85qwyO2crKoM5kGTpFZ8CiKWQuFGOj4a28seUqW+7PWWsRRFtaCrkb99K
         1MAg==
X-Gm-Message-State: AOAM531qRA5dM4EF5Tqe+WICLmRjnXDdqfn6yPSozERM5hbvcAiqMmJw
        tCIXhwucFFgPxahLxtsudzA=
X-Google-Smtp-Source: ABdhPJxPttd+mALtJfWQeA0og7oEY4/+qXhGNpGK6BxgrEJW40nhQ/1MMeUQ2DzRT8HVe6XtOSzyHw==
X-Received: by 2002:a05:6402:1398:: with SMTP id b24mr4551118edv.108.1614282456834;
        Thu, 25 Feb 2021 11:47:36 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id kv20sm3413829ejc.26.2021.02.25.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:47:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/2] remote: add camel-cased *.tagOpt key, like clone
References: <20210225012117.17331-1-avarab@gmail.com>
 <xmqqwnuwx2ea.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqwnuwx2ea.fsf@gitster.g>
Date:   Thu, 25 Feb 2021 20:47:35 +0100
Message-ID: <87wnuw6iaw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 25 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> It's easy enough to add a test for this, so let's do that. We can't
>> use "git config -l" there, because it'll normalize the keys to their
>> lower-cased form.
>
> I wondered if we want "git config -l --preserve-case" or something
> like that, but an extra grep for "tagOpt" would be sufficient in a
> simple test like these that are unlikely to have unrelated tagOpt
> defined in the file.  More importantly, I am starting to doubt if
> this should even be tested.
>
> If there were existing "section.varname" variable definition and we
> ask
>
> 	git_config_set("section.varName", "newvalue");
>
> we may end up with "[section] varname =3D newvalue", and that is
> perfectly OK, I would think, because the first and the last
> component of the configuration variable names are defined to be case
> insensitive, and here may be "[Section] varname =3D oldvalue" in the
> configuration file before we try to set it, and the implementation
> is free to replace "oldvalue" with "newvalue", instead of first
> removing "[Section] varname =3D oldvalue" and then adding a new
> "[section] varName =3D newvalue" (after all, there may be variables
> other than "varname" in the section, and the existing "[Section]"
> header may need to be kept for the remaining variables while we futz
> with the varname or varName).
>
> Which means that while we do want to spell the names in our source
> code correctly (i.e. "tagOpt", not "tagopt") when we tell which
> variable we want to get modified to the git_config_set() function,
> we should not care how exactly git_config_set() chooses to spell the
> variable in the resulting configuration file, no?
>
> So, ...

Yes, in general, but...

>> diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
>> index 6a6af7449ca..3126cfd7e9d 100755
>> --- a/t/t5612-clone-refspec.sh
>> +++ b/t/t5612-clone-refspec.sh
>> @@ -97,6 +97,7 @@ test_expect_success 'by default no tags will be kept u=
pdated' '
>>  test_expect_success 'clone with --no-tags' '
>>  	(
>>  		cd dir_all_no_tags &&
>> +		grep tagOpt .git/config &&
>>  		git fetch &&
>>  		git for-each-ref refs/tags >../actual
>
> ...as long as "git config remote.origin.tagopt" yields what we
> expect, we should be OK, I would think.  Insisting that the variable
> name is kept by git_config_set() API may be expecting too much.
>
>>  	) &&

...the cases fixed in this series are not ones where we're possibly
changing an existing variable name, but where we're guaranteed to be
writing new values.

We are renaming a remote or otherwise moving variables around, if there
were existing values to contend with we'd have died earlier.

I'm not quite sure what to make of this feedback in general. That you'd
like the bugfix but we shouldn't bother with a regression test, or that
we shouldn't bother with the fix at all?

I admit this is getting to diminishing returns in testing, we're
unlikely to break this, and if we do it's not such a big deal.

But I don't agree that we should feel free to munge user config files
within the bound of valid config syntax when we edit these files for
users.

We already go out of our way to add values to existing sections, not add
new empty headings etc. (I believe the last major effort on that front
was from Johannes S. a while back).

likewise here, even though cmd.averylongvariablename is perfectly valid,
it's much more user friendly if we write/edit it as
cmd.AVeryLongVariableName.
