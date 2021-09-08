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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D3DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2A661178
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbhIHTl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhIHTl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:41:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB569C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:40:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dc3so4004804ejb.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iJQwAOgGdxICoT9Po7nzQHpx/4ntV433VT/qXbiqMz8=;
        b=R6rbqTb4sAuP2URY8AWEC2fYDq1g4deCIqQcAIyrAikdC11mnX9cKgNu6B0kunjqd7
         x7CcMguJeOl1GaMB/+BodPBD3Ib8gGHa2mzIG+u9mnrW+KFDyzxZVfKvVoxdwDZgtSS7
         TzkpWXCKBQhHsNCqMKXboMQ849V7uLqSXMcJP143d22d2uEMx1LWRtGo97gBFKvSQ8fh
         ahYmEcuEXSSg6nPDu0wjaJAISm+ofX2k1ZOmqbOwiUPqFZAMrAw+fR8IjTH09//BkcQ1
         iPBcL+BUePLIg/rp0YfJoVePdOdjQnB0sTtpdqNq/UuJLUpi0/9pNH5Hl7pODzYKeoys
         ogXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iJQwAOgGdxICoT9Po7nzQHpx/4ntV433VT/qXbiqMz8=;
        b=ZNancVp/IlK4aw48tOJOBQcT0MmG0Bd4BT4JghUttF0x2FP2FppMYBNomzlHSMYIj5
         fVfATC9Ns4lp0yRsAg0IBz4a8iUstr+AdOPAmr7g2IGcKzjHMkNDcS++Id3GqsT2jmUF
         /t1a+9cDluUxeYS804xH9R0djQbu3eve07RD9jK3o1NWCl8Smuj0OBipORy+MUL6Xpo3
         6Br290vtsqa1yjroUOzkU3ZbIDjJwrKmROBj3mTWadY6+ys7+1FiDgrlpgBm4sk4272D
         eOAiIoMmwuXmCfIkoLc4bLKb7aMdeubWPe2isD+DA2qEdq3hc1oWBtJPMrAqLPioWU1v
         hY5g==
X-Gm-Message-State: AOAM531lANDmumOKVnqyDxkBPIXIvzqu+RdPo9yblbEMyQbfpLDOCffF
        tLRbZteJhIIrD/MOOJQBVI8=
X-Google-Smtp-Source: ABdhPJy6bQcfPNsH8NEd+OVR5YTAUIGQL1QcpsYiLDNXaCXJs5hQmXetQL4ZJQx3aLHqF7uqro8Msw==
X-Received: by 2002:a17:906:3fd7:: with SMTP id k23mr1567423ejj.176.1631130048303;
        Wed, 08 Sep 2021 12:40:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fp13sm344631ejc.29.2021.09.08.12.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:40:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 5/6] help: correct logic error in combining --all and
 --config
Date:   Wed, 08 Sep 2021 21:37:01 +0200
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <patch-5.6-bcc640d32a1-20210908T151949Z-avarab@gmail.com>
 <CAPig+cSK+wLPUDuGf1d41J_F5jQS+J=a=7kHQLV07-ZKZW9GsA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPig+cSK+wLPUDuGf1d41J_F5jQS+J=a=7kHQLV07-ZKZW9GsA@mail.gmail.com>
Message-ID: <87bl52hn40.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Eric Sunshine wrote:

> On Wed, Sep 8, 2021 at 11:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Fix a bug in the --config option that's been there ever since its
>> introduction in 3ac68a93fd2 (help: add --config to list all available
>> config, 2018-05-26). Die when --all and --config are combined,
>> combining them doesn't make sense.
>>
>> The code for the --config option when combined with an earlier
>> refactoring done to support the --guide option in
>> 65f98358c0c (builtin/help.c: add --guide option, 2013-04-02) would
>> cause us to take the "--all" branch early and ignore the --config
>> option.
>>
>> Let's instead list these as incompatible, both in the synopsis and
>> help output, and enforce it in the code itself.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/builtin/help.c b/builtin/help.c
>> @@ -549,18 +550,26 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
>> +       /* Incompatible options */
>> +       if (show_all + !!show_config + show_guides > 1)
>> +               usage_with_options(builtin_help_usage, builtin_help_opti=
ons);
>
> I personally find it highly frustrating when a program merely dumps
> the usage statement without any explanation of what exactly it doesn't
> like about the command-line. Printing out a simple:
>
>     --all, --guides, --config are mutually exclusive
>
> message would go a long way toward reducing the frustration level.
>
> (Aside: I also find it more hostile than helpful when programs dump
> the usage statement for a command-line invocation error -- even if
> preceded by an explanation of the error -- since the explanation
> usually gets drowned-out by the often multi-page usage text, and the
> user has to go spelunking around the wall of output to try to figure
> out what actually went wrong. It's much more helpful and easy to
> figure out what went wrong with the invocation when only a simple
> error message is printed -- without usage statement. However, that's a
> separate battle, as Git already has plenty of places which dump the
> usage statement in response to an invocation error.)

I'll make it emit something more helpful.

More generally I've got quite a bit of parse_options() improvements
queued up locally that I've been trying to trickle in at the rate I can
get them through the list, review over at [1] would be much appreciated.

I wonder if we can do this automatically, we already have the
builtin_help_usage, we could parse that in the general case and find
that certain options are mutually exclusive per the examples there.

We'd then discover what option we parsed when usage_with_options() was
called, and automatically emit a useful message in these sorts of cases.

Of course the usage strings might be incomplete or wrong, but part of
the point would be to find those cases & a test mode to die() if a
command was called with some option combinations not suggested as
working according to its documented usage...

https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@g=
mail.com/
