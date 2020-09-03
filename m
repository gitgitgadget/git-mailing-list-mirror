Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F9AC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8AA206CA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfNBzSqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgICVRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICVRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:17:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04ACC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 14:17:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g72so4469593qke.8
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U2FkW2xHYdOM2hKt9OWlohN/WcZNYUQJyx0ZrW6Tl0U=;
        b=hfNBzSqu9Lf3lCYFosyuCjKxfF0tzfcdhYnoWqzPC+rpU/A8G6k0gOW7S2/OnqUR6t
         Y00Lk8cFwu2FeKqKiH7TgPAvFiZaEXyAum3mToqmk87hTdYly+gTTLOR+jSI6UiKmeav
         cTMDvW8UuPoL3+k/JezKo7AwYkvIFV5LP+crx68yPhFOtVnEGLx1aVFLbKFe3NcdxPXE
         xL0JUuGeUgXH8i+g+X2EZHFU0vY8D5AktG4SqXamZiIyAqC3fPH2spiGD5hgqR+iQpzf
         gJ6bSR4Yvqt+SseZvkV9aWJc7W2UuT363qbmYn5877h7Qwz6Tp79B9Hbr4MP6WvAYWRl
         acKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U2FkW2xHYdOM2hKt9OWlohN/WcZNYUQJyx0ZrW6Tl0U=;
        b=p1UgCaIeRvLpJN5e2f/uH14kkJljuXL2yigkzaUPnCurWhLeQTCJkiWr8C4Ej1lkji
         bM9O+jzqCXQXNHBlYajYM1L91XlU2dLxBZBlgX2GsjDV4yoK0qnHaLIk3gRVQZLf31rR
         UiyOe252eo+wMCk5oBncXbbVwbley3zTAlDIWYNupw6/1guiVA1bIuFrjDhwenAhNHJ/
         wTCT6hHhCt+Y0Xt5cXSRXJsmelVAyj5KcsNzDA1ZrMlCcb3rMYOw4am7N/BzWWMIDtsj
         hMyKi4knN5D9TzdfdJ52WSvttwPKf9hTchmQu0h65SDsntk7HrmkEZh9NVAFfDI+4I6z
         fXoQ==
X-Gm-Message-State: AOAM5330zy9BrdCMUkctWfjFgb8FBBfXsSP6UpFUEV9jCnidys7iwFiz
        PkG3BnxUrTOfKn7PfoML/eg=
X-Google-Smtp-Source: ABdhPJzWc1QzE6SD0qa1G69CmOOuZivsYEl+H7KgqdRsjlI34BXwT2K3abfZSP+mCidFXvo7YoUXtA==
X-Received: by 2002:a37:d53:: with SMTP id 80mr4973371qkn.136.1599167847354;
        Thu, 03 Sep 2020 14:17:27 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y1sm2872583qti.40.2020.09.03.14.17.26
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2020 14:17:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Makefile: add support for generating JSON compilation database
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq1rjkccw8.fsf@gitster.c.googlers.com>
Date:   Thu, 3 Sep 2020 17:17:23 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41D647C5-BC9E-431F-BEF9-C0040F4E0C94@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com> <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com> <xmqq1rjkccw8.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,=20

> Le 2 sept. 2020 =C3=A0 13:21, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> diff --git a/.gitignore b/.gitignore
>> index ee509a2ad2..f4c51300e0 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -197,6 +197,7 @@
>> /git.spec
>> *.exe
>> *.[aos]
>> +*.o.json
>=20
> Does this naming/suffix follow the common practice followed among
> those projects that use the -MJ option?  Even though I may have
> heard of it, I am not familiar with the use of the feature at all,
> and to such a person, naming a file after what format it is written
> in (i.e. 'json') feels a lot less useful than what it contains
> (i.e. compilation database entries). =20
>=20
> It's like naming our source files with .txt suffix ;-)

This addition to the .gitignore is for the individual JSON files (one =
per source file),=20
that are placed in the $(compdb_dir).=20
I think naming "rebase.o.json" the JSON file that describes how to =
compile "rebase.c"
into "rebase.o" makes sense. I don't know what is the convention for =
other projects.

>> +# Define GENERATE_COMPILATION_DATABASE to generate JSON compilation =
database
>> +# entries during compilation if your compiler supports it, using the =
`-MJ` flag.
>> +# The JSON entries will be placed in the `compile_commands/` =
directory,
>> +# and the JSON compilation database 'compile_commands.json' will be =
created=20
>> +# at the root of the repository.=20
>=20
> Likewise for the name of the directory and the resulting single
> database file.  I just want to make sure that we are following the
> common convention, so people familiar with the use of the feature
> would feel at home, so a simple answer "yes" would suffice.

The name `compile_commands.json` for the database itself is standard.=20
The name of the directory where the '*.o.json' files are placed is a =
name
I chose, and I don't feel strongly about it. I thought it made sense to =
name
it like that, then its purpose is clear.  We could make it a hidden =
directory=20
if we don't want to add a new folder to the root of the repo when using =
this feature.

>> +ifdef GENERATE_COMPILATION_DATABASE
>> +compdb_check =3D $(shell $(CC) $(ALL_CFLAGS) \
>> +	-c -MJ /dev/null \
>> +	-x c /dev/null -o /dev/null 2>&1; \
>> +	echo $$?)
>> +ifeq ($(compdb_check),0)
>> +override GENERATE_COMPILATION_DATABASE =3D yes
>=20
> This feels strange.  If the end user said to GENERATE and we find we
> are capable, we still override to 'yes'?  What if the end user set
> 'no' to the GENERATE_COMPILATION_DATABASE macro?  Shouldn't we be
> honoring that wish?

We should. I'll tweak (and simplify) that for v3.

>> @@ -2381,16 +2401,30 @@ missing_dep_dirs =3D
>> dep_args =3D
>> endif
>>=20
>> +compdb_dir =3D compile_commands/
>> +
>> +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>> +missing_compdb_dir =3D $(compdb_dir)
>> +$(missing_compdb_dir):
>> +	@mkdir -p $@
>> +
>> +compdb_file =3D $(compdb_dir)$(subst .-,,$(subst /,-,$(dir =
$@)))$(notdir $@).json
>=20
> This detail does not matter as long as the end result ensures unique
> output for all source files, but I am having trouble guessing what
> the outermost subst, which removes ".-" sequence, is trying to make
> prettier.  Care to explain?

Yes, it is because the `$(dir $@)` Makefile function will return `./` =
for source files=20
at the base of the repo, so the JSON files get named eg. =
`.-rebase.o.json` and then they are=20
hidden. So it's just to make them non-hidden, so as not to confuse =
someone that would
count the number of source files and compare with the number of =
(non-hidden)
 '*.o.json' files in $(comdb_dir) and get a different number.

>> @@ -2413,6 +2447,14 @@ else
>> $(OBJECTS): $(LIB_H) $(GENERATED_H)
>> endif
>>=20
>> +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>> +all:: compile_commands.json
>> +compile_commands.json:
>> +	@$(RM) $@
>> +	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' =
$(compdb_dir)*.o.json > $@+
>=20
> OK.  The entire thing is concatenated and enclosed by a single pair
> of '[' and ']'.

Yes, and the comma after the last entry removed for JSON compliance.

> If we are planning to allow developers customize compdb_dir,
> requiring trailing slash in the value of $(compdb_dir) is not very
> friendly.

OK I'll change that.

> Thanks.

Thank you for your comments!

Philippe.

