Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiF3S4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiF3S4T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:56:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF563524E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:56:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q6so40673843eji.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=K3JxjnYB8xUbnnD3hol/v+91hXywcq3ZBydeVNa1vV4=;
        b=I8le/x4Y+hii9oZ6J8vgdc6v/EBD5V2dbhvY+D2ATZ0GeIQcSDdi1jItrsUem72g5P
         Src9NXgxfQhVsVzbnXHJlmC6StfCgA0y0Sg7mxA2K3Ct6Z+zagbBhydEiTG/8hUrTZh3
         /rfd2wyAoW0ycGwJwPH6OXwMn4QutoPooELsGfbBsrV+iwdgyJQEDlrVK/OtxBkvU6pg
         mTkQdF/LwdLlsD294gJbP67LsTXpNeqoiZitMs0F2DbKSBJKToiR769eF0Hiz/1KtE7G
         LSBiwYRbZV7rKLHGvhS6UPECGSJQnZSRwHXz1Yw/udbCvrscU9WWZyhyhLYoXYuns5rP
         oFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=K3JxjnYB8xUbnnD3hol/v+91hXywcq3ZBydeVNa1vV4=;
        b=wNjAHptmLPME+a/Xba66xUd/4VLc9gmdcwvuzDISsbuz0xr8BWp/FRxW87RglZfMhe
         BryKLMvBnEk/FAvi7z4Sn3bu3vE8ph28SlGWzyUDwF3wOfvMntSk6rRbqw2D51Qde5Pr
         5sKOCGxu4CYlA3lb7xOakX29SiJqCcNbqtP/QkPgiwtRDO/tDlTmz5K1gsPCwpxOG8V/
         OTybhgsSSkJTE6PamfrMe/YnhkF3r1aZPeKTOe/jYw2olutn38CoIAyupajWwI/jNHPw
         j20xJkVoAfvxOXmsEIV3Zxi1DqR6eCSvpmOUXTbem89S58bu/UiPEPRsvcUtqoBIgGJb
         Bu/g==
X-Gm-Message-State: AJIora8PzfCGqeM8O24E/AvP8D06DdSyPxz0NqJzMj7q+NDpZmH745MT
        6xRNBdXn42lH5V3QIHZfa8A=
X-Google-Smtp-Source: AGRyM1uTfGwVMiRay8RXvR16G4T8L4ANi37Aodgx5e8tr9rldF2+w5ut7AXxLtW5uiu0/9tYH3PdjA==
X-Received: by 2002:a17:906:4e91:b0:722:f996:fa20 with SMTP id v17-20020a1709064e9100b00722f996fa20mr10534438eju.733.1656615376702;
        Thu, 30 Jun 2022 11:56:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b0072a3216c23asm2348249ejc.154.2022.06.30.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:56:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6zKp-002ScU-BI;
        Thu, 30 Jun 2022 20:56:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han Xin <hanxin.hx@bytedance.com>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Date:   Thu, 30 Jun 2022 20:47:30 +0200
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
 <cover.1656381667.git.hanxin.hx@bytedance.com>
 <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
 <220628.865yklgr6g.gmgdl@evledraar.gmail.com> <xmqq35folmgf.fsf@gitster.g>
 <5n35o008-pso2-6440-424p-q387q9n4so41@tzk.qr>
 <220630.86v8siclh5.gmgdl@evledraar.gmail.com> <xmqq5ykignwb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq5ykignwb.fsf@gitster.g>
Message-ID: <220630.86edz6c75c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jun 30 2022, Johannes Schindelin wrote:
>>
>>> Hi Junio,
>>>
>>> On Tue, 28 Jun 2022, Junio C Hamano wrote:
>>>
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>>
>>>> >> +test_expect_success 'setup: prepare a repository with commit-graph=
 contains the commit' '
>>>> >> +	git init with-commit-graph &&
>>>> >> +	echo "$(pwd)/with-commit/.git/objects" \
>>>> >> +		>with-commit-graph/.git/objects/info/alternates &&
>>>> >
>>>> > nit: you can use $PWD instead of $(pwd).
>>>>
>>>> We can, and it would not make any difference on non-Windows.
>>>>
>>>> But which one should we use to cater to Windows?  $(pwd) is a full
>>>> path in Windows notation "C:\Program Files\Git\..." while $PWD is
>>>> MSYS style "/C/Program Files/Git/..." or something like that, IIRC?
>>>
>>> Indeed, and since the `alternates` file is supposed to be read by
>>> `git.exe`, a non-MSYS program, the original was good, and the nit
>>> suggested the incorrect form.
>>
>> I looked at t5615-alternate-env.sh which does the equivalent of:
>>
>> 	GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"$PWD/one.git/objects:$PWD/two.git/o=
bjects" \
>>         	git cat-file [...]
>>
>> We run that test on all our platforms, does the $PWD form work in the
>> environment variable, but not when we write it to the "alternates" file?
>> Or is there some other subtlety there that I'm missing?
>
> I am also curious to see a clear and concise explanation so that we
> do not have to repeat this discussion later.  We have
>
>  - When a test checks for an absolute path that a git command generated,
>    construct the expected value using $(pwd) rather than $PWD,
>    $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
>    Windows, where the shell (MSYS bash) mangles absolute path names.
>    For details, see the commit message of 4114156ae9.
>
> in t/README, but even with the log mesasge of 4114156a (Tests on
> Windows: $(pwd) must return Windows-style paths, 2009-03-13) [*1*],
> I have no idea what makes the thing you found in t5615 work and your
> suggestion to use $PWD in the new one not work.
>
> GIT_ALTERNATE_OBJECT_DIRECTORIES is a PATH_SEP (not necessarily a
> colon) separated list, and I think the way t5615 uses it is broken
> on Windows where PATH_SEP is defined as semicolon without the $PWD
> vs $(pwd) issue.  Is the test checking the right thing?

Whatever th explanation is CI passed with a $(pwd) -> $PWD repacement in
the test being introduced here:
https://github.com/avar/git/runs/7136686130?check_suite_focus=3Dtrue

Diff here:
https://github.com/avar/git/commit/606d0060a57b7021396919044c7696489b7835cd

So either $PWD is fine there, or our Windows CI doesn't reflect this
particular caveat on some Windows systems, or the test is erroneously
passing with an invalid value. Knowing which of those it is would be
very useful...
