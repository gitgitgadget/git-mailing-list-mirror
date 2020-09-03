Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998AEC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676D020678
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTje014Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgICWEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICWEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:04:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02FC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:04:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w186so4643678qkd.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsUJGSKhqFRFbvY+ABSMxfejWHh/BCS8ZJKFsH8S8yY=;
        b=nTje014ZbRFDtt2jxEmh4K8CgmuXvF+NkQJcYO3Ss9v3s5IpR7cOV+5rDfS8xU/tyr
         X2F1EQzwGw6vFgzsS/USpR7KkJT2RcyIYlZhFmDY3bfrjPrH0OLwDLuHXbCxqk6gL//M
         LEPyOFdOmI2FpYFRD71c9NLB/4qllAD3m7H5KfNVMXnV+a1b7gPF9L1Ypq6JzsifeRvp
         0W+lmBAszhcD4mbwamONw3wAH22yISe1VLjXYfPBEIYcKNYqobVfMcJkFMWK6q5BWjB1
         KDGC4zJ8w8AmhwG0ijPmQwV1PuwiqwavDNqP5u2BGRXqFyGMFgwv1I7NMTrAJu7B0UM4
         T/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsUJGSKhqFRFbvY+ABSMxfejWHh/BCS8ZJKFsH8S8yY=;
        b=m7XJ1UYEegJyVZwKfXiXOhCFmFyaSU691b11wXpYrEjgfAa0qETngDOgOGvOOXGdic
         kJUK+Q5OfJTM3RY1B4CohzJQyH43Sr96NVK7gJ8zeybe4Zlx5HF5fSLgA/jRvsnMpCrn
         aBu66JW0ubSg3Xy/rCpfHwFuw6lLV34p3cgiSJWc4Xu69GxGV1QWtkZ94ephtTycaOch
         qkqK1mcsEy35d3ebE22kpS0PyaIkZUO7VGvsDmEMv/JT6WdUasvihI5P3dtS4LbrZPlB
         8lF38IS5Xwg5uJSxw3e/bZS3njoFvFt3Vki4vBppCcZc6nIbzu171SiULK107KCRPbAb
         HUTQ==
X-Gm-Message-State: AOAM530TpCE+yqvYqZD3VpPYeVIL55ejQHESOZrwLjhFUdsjoa7FjsjQ
        OLTWNnv7NHU6njaooaWY/80=
X-Google-Smtp-Source: ABdhPJwS5ew+KH7Yr9no2mRDFPodovg8FMFq+G4QP/QgIKCQROxQeFvWOFuOvaLSBkwGbm+hvATVLg==
X-Received: by 2002:a05:620a:1523:: with SMTP id n3mr5070236qkk.245.1599170648081;
        Thu, 03 Sep 2020 15:04:08 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x124sm3014836qkd.72.2020.09.03.15.04.06
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2020 15:04:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Makefile: add support for generating JSON compilation database
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqpn728s3f.fsf@gitster.c.googlers.com>
Date:   Thu, 3 Sep 2020 18:04:04 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98711D92-AE89-46B4-A749-89F85A9A87A7@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com> <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com> <xmqq1rjkccw8.fsf@gitster.c.googlers.com> <41D647C5-BC9E-431F-BEF9-C0040F4E0C94@gmail.com> <xmqqpn728s3f.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 3 sept. 2020 =C3=A0 17:31, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>=20
>> This addition to the .gitignore is for the individual JSON files (one =
per source file),=20
>> that are placed in the $(compdb_dir).=20
>> I think naming "rebase.o.json" the JSON file that describes how to =
compile "rebase.c"
>> into "rebase.o" makes sense. I don't know what is the convention for =
other projects.
>=20
> I agree rebase.o.$somesuffix does make sense, but I do not know
> 'json' is a great value for $somesuffix.  I wouldn't be surprised if
> 'cdb' or some other silly abbreviation for "compilation database" is
> how other people use this feature.
>=20
> Those watching from the sidelines.  Does anybody know if there is an
> established convention used by other projects?  If we hear nothing
> by early next week, let's declare 'json' is good enough and move on.
>=20
>> The name `compile_commands.json` for the database itself is standard.=20=

>> The name of the directory where the '*.o.json' files are placed is a =
name
>> I chose, and I don't feel strongly about it. I thought it made sense =
to name
>> it like that, then its purpose is clear.  We could make it a hidden =
directory=20
>> if we don't want to add a new folder to the root of the repo when =
using this feature.
>=20
> I think both of these are sensible.  Again if we hear nothing about
> common practice, let's move on with these constants as-is.

OK.=20

>=20
>>>> +ifdef GENERATE_COMPILATION_DATABASE
>>>> +compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
>>>> +	-c -MJ /dev/null \
>>>> +	-x c /dev/null -o /dev/null 2>&1; \
>>>> +	echo $$?)
>>>> +ifeq ($(compdb_check),0)
>>>> +override GENERATE_COMPILATION_DATABASE =3D yes
>>>=20
>>> This feels strange.  If the end user said to GENERATE and we find we
>>> are capable, we still override to 'yes'?  What if the end user set
>>> 'no' to the GENERATE_COMPILATION_DATABASE macro?  Shouldn't we be
>>> honoring that wish?
>>=20
>> We should. I'll tweak (and simplify) that for v3.
>=20
> I think
>=20
> - GENERATE_COMPILATION_DATABASE is set to 'no': don't even probe
>=20
> - GENERATE_COMPILATION_DATABASE is set to 'yes': probe and turn it
>   to 'no' if unavailable.
>=20
> - GENERATE_COMPILATION_DATABASE is set to anything else: either
>   error out, or turn it into 'no' (I have no preference between
>   them).
>=20
> would cover all the cases.

I agree. I'll do that.

>=20
>>>> +compdb_file =3D $(compdb_dir)$(subst .-,,$(subst /,-,$(dir =
$@)))$(notdir $@).json
>>>=20
>>> This detail does not matter as long as the end result ensures unique
>>> output for all source files, but I am having trouble guessing what
>>> the outermost subst, which removes ".-" sequence, is trying to make
>>> prettier.  Care to explain?
>>=20
>> Yes, it is because the `$(dir $@)` Makefile function will return `./` =
for source files=20
>> at the base of the repo, so the JSON files get named eg. =
`.-rebase.o.json` and then they are=20
>> hidden. So it's just to make them non-hidden, so as not to confuse =
someone that would
>> count the number of source files and compare with the number of =
(non-hidden)
>> '*.o.json' files in $(comdb_dir) and get a different number.
>=20
> Hmph.  Would $(subst /,-,$@) instead of "only substitute leading
> directory part, and concatenate the basename part unmolested" work
> better then?  After all, by definition the basename part would not
> have a slash in it, so substituting all '/' to '-' in the whole
> pathname should do the same thing and we won't have to worry about
> the spurious './', no?

This indeed works, and reads better. Thanks!

