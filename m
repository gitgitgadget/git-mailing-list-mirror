Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0596C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 11:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiAKLpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiAKLpO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 06:45:14 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7762C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:45:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u21so43458008edd.5
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kFVHaOFKUnV+6/nW86Ue8Pcndsdk22qIGuY/G4JIb+g=;
        b=keYpyJNB/+NVUwFuP/dGjLJ8o50KP32FuqdGn+wBJOssyntaNzd4EULp+56Rw+Uegx
         aEvUZ0f5ROBJWNAF/75dpRtRrjPP5zmr74pKd0rRa9MOjaEfMgEkfgThwuxdMrOh8gy6
         ag5X0O6IY4BIbbI1wHgxy8kNtM/29IV7EkrV9yV6rocHPSG8fTM2wpqIQ/rSHv8Fu2eV
         CO4pjsZ0Wc2KyZ6uV6rfkbZEE2hzZiJ63hePs4E9E+BQKfbyLYV+WPxtMtbIoHRvglC+
         Cem5YHxyXZfe+AsbIUfKQrNKvnocIAYFENEnH3QtYf/lkL/RTbSQHWY/UVBF2Rrnpmbv
         6bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kFVHaOFKUnV+6/nW86Ue8Pcndsdk22qIGuY/G4JIb+g=;
        b=y43XJglpby3D8uOY28x0dHi1X8NBJ+xuTIQVXdDOLFjzr0LJQ/J3jhJWW0HITfXR6g
         7o5oNxoMJknZ01NksRcXSserAuQ7CVwrQ1IsA5+31ancNyp9mIRFGnbaWLGgNqkp3Nj7
         SQCrb62Ft6wF+sfdRe8dkAY6uPKqcFXFND6AW4wmHKBMUaSvdDvZfYGiRB5WuC/jknRS
         JtF41URonP9cIjxSTCVjFpFqcmiDAexlq4E0vVgzZkbQd6TyExlR56aIMBsgL3FNU1c5
         1ieQtMm/2+ca08XY/9lBHD1MobLVs0bFiXqaLsUQDRDQ/N23lnTut8OJs3kbRSQ9vSLL
         dCtA==
X-Gm-Message-State: AOAM531jWXemhDQb0NYGpG2PYVHZGmkpldAyzyjzXlgamCEDL7h1ihQB
        kGoSLixk/W6IU/DFubVZCHYMsf6un3Srdg==
X-Google-Smtp-Source: ABdhPJxnVShz4fGkv2DOx9OaafKtw9jUyi9qg4FY++WMPQcMLUl/7bN8pha1WENGFGodArcvIAqZyg==
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr3156066ejk.735.1641901512217;
        Tue, 11 Jan 2022 03:45:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ku15sm3064614ejc.49.2022.01.11.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:45:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7FaR-000aVm-8I;
        Tue, 11 Jan 2022 12:45:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] builtin add -p: fix hunk splitting
Date:   Tue, 11 Jan 2022 12:44:33 +0100
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <5d5639c2b0474680850b7adbb7c5ec81d124eb50.1640010777.git.gitgitgadget@gmail.com>
 <211220.86mtkvt7cy.gmgdl@evledraar.gmail.com>
 <23b6c237-5a95-7c3c-2bcd-567dbef5aafe@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <23b6c237-5a95-7c3c-2bcd-567dbef5aafe@gmail.com>
Message-ID: <220111.865yqqzebc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 11 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 20/12/2021 19:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Dec 20 2021, Phillip Wood via GitGitGadget wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> To determine whether a hunk can be split a counter is incremented each
>>> time a context line follows an insertion or deletion. If at the end of
>>> the hunk the value of this counter is greater than one then the hunk
>>> can be split into that number of smaller hunks. If the last hunk in a
>>> file ends with an insertion or deletion then there is no following
>>> context line and the counter will not be incremented. This case is
>>> already handled at the end of the loop where counter is incremented if
>>> the last hunk ended with an insertion or deletion. Unfortunately there
>>> is no similar check between files (likely because the perl version
>>> only ever parses one diff at a time). Fix this by checking if the last
>>> hunk ended with an insertion or deletion when we see the diff header
>>> of a new file and extend the existing regression test.
>>>
>>> Reproted-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>   add-patch.c                |  7 ++++++
>>>   t/t3701-add-interactive.sh | 46 ++++++++++++++++++++++++++++++++++----
>>>   2 files changed, 49 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/add-patch.c b/add-patch.c
>>> index 8c41cdfe39b..5cea70666e9 100644
>>> --- a/add-patch.c
>>> +++ b/add-patch.c
>>> @@ -472,6 +472,13 @@ static int parse_diff(struct add_p_state *s, const=
 struct pathspec *ps)
>>>   			eol =3D pend;
>>>     		if (starts_with(p, "diff ")) {
>>> +			if (marker =3D=3D '-' || marker =3D=3D '+')
>>> +				/*
>>> +				 * Last hunk ended in non-context line (i.e. it
>>> +				 * appended lines to the file, so there are no
>>> +				 * trailing context lines).
>>> +				 */
>>> +				hunk->splittable_into++;
>> I wondered if factoring out these several "marker =3D=3D '-' || marker
>> =3D=3D
>> '+'" cases in parse_diff() into a "is_plus_minus(marker)" was worth it,
>> but probably not.
>
> Yeah in the end I just factored out this hunk into a new function but
> I didn't add a function for "marker =3D=3D '-' || marker =3D=3D
>> '+'"
>
>>>   			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>>>   				   file_diff_alloc);
>>>   			file_diff =3D s->file_diff + s->file_diff_nr - 1;
>>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>>> index 77de0029ba5..94537a6b40a 100755
>>> --- a/t/t3701-add-interactive.sh
>>> +++ b/t/t3701-add-interactive.sh
>>> @@ -326,7 +326,9 @@ test_expect_success 'correct message when there is =
nothing to do' '
>>>   test_expect_success 'setup again' '
>>>   	git reset --hard &&
>>>   	test_chmod +x file &&
>>> -	echo content >>file
>>> +	echo content >>file &&
>>> +	test_write_lines A B C D>file2 &&
>> style nit: "cmd args >file2" not "cmd args>file2"
>>=20
>>> @@ -373,8 +411,8 @@ test_expect_success 'setup expected' '
>>>   test_expect_success 'add first line works' '
>>>   	git commit -am "clear local changes" &&
>>>   	git apply patch &&
>>> -	test_write_lines s y y | git add -p file 2>error >raw-output &&
>>> -	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>>> +	test_write_lines s y y s y n y | git add -p 2>error >raw-output &&
>>> +	sed -n -e "s/^([1-9]\/[1-9]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>>>   	       -e "/^[-+@ \\\\]"/p raw-output >output &&
>>>   	test_must_be_empty error &&
>>>   	git diff --cached >diff &&
>> style/diff nit: maybe worth it to in 1/2 do some version of:
>>      test_write_lines ... >lines &&
>>      git ... <lines .. &&
>>      ...
>>      sed -n \
>>      	-e ... \
>>          -e ... \
>>          >output
>> Just to make the diff smaller, i.e. just the "test_write_lines" line
>> would be modified here.
>
> In the end I decided to leave this as is, while refactoring slightly
> simplifies this patch it makes the previous one bigger and means that=20
> would need to be reviewed again.

All sounds good to me. Just stuff I thought I'd point out in case you
thought it made sense. Going with it as-is is fine too.

>> The changes themselves & this series LGTM.
>
> Thanks
>
> Best Wishes
>
> Phillip

