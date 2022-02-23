Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6198C4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbiBWWGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiBWWF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:05:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C822506C0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:05:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i11so261051eda.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YZji5v3+LcAEFcR0mPZlBzpTBil8KEplwXzdBe5ULpE=;
        b=dnBotJmWN4CawhHGuNOlemOpGGqPUYsp3aEgDlPcO8KrcyCr0l/DNtdtrMR6tA240q
         ebPVGnkNmN6v0FuoYZ+fDjhIPqMxIfVeoN1tkYQ1qErd4v18fsKGW5bIWRTkj2mDU9xt
         sMFLSza8ld6QjnUpOQ6ipt1z1YmMvdOtCAj0T0z8vLivtRtxV8K5HImedC8AAs5CvtHG
         +bsz5XzT6ti3Ixm3ktAxCBZLPAOY1PSQXkg8hl6ESYJWy2eB2VcCmfNPMpsKR3wQtbgb
         GJL6CQo7zFv5y4nGLqHvp7ssEprLDD6DJlsvK6fc/9TR58zzIw22Qr3fS0QWskQqa1nd
         ZEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YZji5v3+LcAEFcR0mPZlBzpTBil8KEplwXzdBe5ULpE=;
        b=u34D9PzRNPoMBty07E43hP9SGvYvFE3KT5wKGkET8q0XAbLKubvfVgGytsiqxUnzP2
         worGaBkV5DzoxIWJ92uTuE/FhHId2M8wmkLEXeq/6VBPOfyJOk7CdvDBmKRU65ouhY6J
         JSnxxTi2okUEpLsy/8CN0xZaHHhRgukQotZafDcbCY5myJao58bZmmaGr9bq62klPt+7
         ghIgw4p6EgHuM3LIWIQnGVFnlqx8rqkz948EcnFR1iLZvn2jFLhiwAjdsyKWccFMQ1yY
         g67FutzPNk8Nz4eGtCfpnLYYfuACpG7DUewfq2k2FOZspnaieaJxV1PHtVRB6w39sajM
         MkBQ==
X-Gm-Message-State: AOAM532g5fYJTGB3GOsxYLezMIHe6ROPwajqeL/uWI6MI8qYidunRu8U
        GmBvwyFxn30dozzoMogveVpbvD40QKU=
X-Google-Smtp-Source: ABdhPJx+HqETtf4erMugkg3a82zBJOnUR346fCBddS342raNlBmEuEqgxIJMLW6u4zuoA4f2R2MB2A==
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id ds1-20020a0564021cc100b004132cfbb6camr1382884edb.265.1645653927810;
        Wed, 23 Feb 2022 14:05:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nc33sm345546ejc.169.2022.02.23.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:05:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMzlG-0003Q4-7X;
        Wed, 23 Feb 2022 23:05:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/9] help.c: use puts() instead of printf{,_ln}() for
 consistency
Date:   Wed, 23 Feb 2022 22:57:06 +0100
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
 <patch-v2-2.9-124643c4b35-20220221T193708Z-avarab@gmail.com>
 <xmqqfso9s14j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqfso9s14j.fsf@gitster.g>
Message-ID: <220223.86h78pb5nd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -		printf("\n%s\n", _(desc));
>> +		putchar('\n');
>> +		puts(_(desc));
>
> This is sort of "Meh".  Even the justification that says "we'll do
> the same thing in future patches" is not really a justification, as
> it is entirely fine to add more of the "line-break plus %\n" printf()
> in the later steps in the same series.

Yes, I agree that justification wouldn't make sense, "let's change this
for consistency with code that doesn't exist yet and I'm about to
introduce" is a non-starter as an argument.

But that's not what I mentioned in the commit message or why I changed
this, as noted it's for doing the same "as other existing code in the
file does".

I.e. you'll see that adjacent and related code if you run this on
master:

    git grep -W '\\n' -- help.c

Now, I fully agree that's not a *strong* reason to change this, it could
just be left in place.

I just thought post-series that skimming through those related functions
made for marginally easier reading if they all used the same pattern to
accomplish the same thing.

In any case, I don't at all feel strongly about including this change,
so I can drop it if you'd like. I just wanted to clarify why I changed
it.

>>  		print_command_list(cmds, mask, longest);
>>  	}
>>  	free(cmds);
>> @@ -317,7 +318,7 @@ void list_commands(struct cmdnames *main_cmds, struc=
t cmdnames *other_cmds)
>>  	}
>>=20=20
>>  	if (other_cmds->cnt) {
>> -		printf_ln(_("git commands available from elsewhere on your $PATH"));
>> +		puts(_("git commands available from elsewhere on your $PATH"));
>
> This *IS* an improvement, as the first parameter to printf_ln() is
> supposed to be a format string, and should have been
>
> 	printf_ln("%s", _("git commands ..."));
>
>> -	printf_ln(_("See 'git help <command>' to read about a specific subcomm=
and"));
>> +	puts(_("See 'git help <command>' to read about a specific subcommand")=
);
>
> Ditto.

