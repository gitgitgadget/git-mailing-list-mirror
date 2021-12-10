Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A87C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhLJPZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbhLJPZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:25:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D26C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:22:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l25so31381520eda.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dNl75iyUXIh/Frt2GoGTssaho8v1oFkzzD13WyzJKgk=;
        b=pfWqBJ56uBeZQwIL3iQHNDuS6pNyNMgAwmoTpeB6YnSv8SCwOvL/Fd2e+6Us5EE3t+
         UOYEdJkpF0ZnBB1YzS/GMAi7FPr7+egUO09gocU0SUu3zpeD4OqqGAfNHZTtlSmxw3Yo
         1AAMDxTRUQxom05sm3GqdDb49Chj7MqITaFVcUfB1DbR7JrI14NjCl/bqNwqsXJ0tpnw
         cEITTI52DF/+8/saXwwOwj+qBfxgLR3zrGEuphL5YvMQfzsiBUoa2ETSyTjXpPyzOKju
         gJqzD0yEJud4F2JLfrjMSVIk4nUm4m2zpw9gJRt6rwugff8Wz7dKL40YIfstjltRJmd4
         lotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dNl75iyUXIh/Frt2GoGTssaho8v1oFkzzD13WyzJKgk=;
        b=IvKeYtS9DaabReJ5wptwAUvbr1wGXCghrqTykWbbKf1KnOvgHyCSWTohx04p45Dli3
         eKMG1nXTfuXb9mS+Mo2gj3tmAeN2nvs88JupZgoSLBIn1mG1TlY8glCUWhNWuaA+tZ/0
         5+wguANFweKZUPDkrdUAYMbKlAzZeOjzPLcxhB8z31IXw8EYCvQW7IZR71wf0txKUWu5
         sJBX1ycZ/hZI39nmD5QJOHemENTU7034cJ7ivxp+jEiTf4Rvbg8AjebmwOTq5POb35Yf
         gdfSdglh5ALTTpry7hi6nIsdjjz2+zQKngxkU+x+avKaBOW4rDLThjD8Jj7GgZi+sno/
         Ejuw==
X-Gm-Message-State: AOAM531qpGpMQ+cxJxdQsvQ856yU/OL1HKBSSvuE4dyOu2peLOfyfhsh
        2R5DBTvJaUuzvPMcU0Wmi9U=
X-Google-Smtp-Source: ABdhPJyTiwr+KSDFrqFsaK+G3jrHKAF8OQe+2Esc0Qbnppl/0myKKfBfHxNt9wBArKs+dK8USocwHA==
X-Received: by 2002:a50:fb16:: with SMTP id d22mr39998931edq.367.1639149705159;
        Fri, 10 Dec 2021 07:21:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id aq6sm1643804ejc.41.2021.12.10.07.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:21:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvhiR-000Ml4-97;
        Fri, 10 Dec 2021 16:21:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Date:   Fri, 10 Dec 2021 16:13:36 +0100
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
 <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
 <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
 <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
 <211209.86v8zydjjl.gmgdl@evledraar.gmail.com>
 <745e79e3-521d-58bd-2ddf-1da4e0f6fe26@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <745e79e3-521d-58bd-2ddf-1da4e0f6fe26@gmail.com>
Message-ID: <211210.86zgp8bi48.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Derrick Stolee wrote:

> On 12/9/2021 7:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Dec 08 2021, Derrick Stolee wrote:
>>=20
>>> On 12/8/2021 1:36 PM, Elijah Newren wrote:
>>>> On Wed, Dec 8, 2021 at 10:23 AM Derrick Stolee <stolee@gmail.com> wrot=
e:
>>>>>
>>>>> On 12/8/2021 12:04 PM, Elijah Newren wrote:
>>>>>>
>>>>>> This actually looks quite nice, though the magic '16' is kind of
>>>>>> annoying.  Could we get rid of that -- perhaps using something to rip
>>>>>> out the diff header, or using comm instead?
>>>>>
>>>>> What I really want is "remove the first two lines of this file"
>>>>
>>>> Is `tail -n +3` portable?  Looks like we have five uses of tail -n +N
>>>> in the testsuite, so it should be okay to use.
>>>
>>> Ah, that's the magic incantation. Sounds good.
>>>
>>>>> but perhaps "tail -n $(wc -l expect)" would suffice to avoid a
>>>>> magic number?
>>>>
>>>> That works too.
>>>
>>> If the "-n +X" syntax works, then I'll opt for that.
>>=20
>> I think it should be per
>> https://pubs.opengroup.org/onlinepubs/009695299/utilities/tail.html
>>=20
>> But isn't that "diff -u" non-portable, per GIT_TEST_CMP. I.e. sometimes
>> we'll fall back on "cmp" etc.
>
> You're talking about this hunk, right?
>
> if test -z "$GIT_TEST_CMP"
> then
> 	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
> 	then
> 		GIT_TEST_CMP=3D"$DIFF -c"
> 	else
> 		GIT_TEST_CMP=3D"$DIFF -u"
> 	fi
> fi
>
> This only switches from "diff -u" to "diff -c" if the
> GIT_TEST_CMP_USE_COPIED_CONTEXT variable is set, but it is not set
> by default. Thus, we are using "diff -u" by default throughout.
>
> Please let me know if I'm misreading this.

Yes and no. Yes it's not on by default, but the reason (well, maybe not
*the* reason, but definitely one reason) we have GIT_TEST_CMP is because
-u isn't portable.

It's not in POSIX, and not just in the theoretical sense, e.g. when I
run tests on HP/UX it'll yell at me about not knowing about -u until I
adjust GIT_TEST_CMP.

Thus you can't use "diff -u" as you did upthread without breaking the
test on those platforms, and you can't execute "$GIT_TEST_CMP" either
because it might use -c, and then your "skip the first three lines"
might not hold.

So even if we avoid using "git" for the actual test helpers themselves
usually using it in this case is probably fine, and a neat way out of
this particular hassle without worrying about portability.

So I don't know if we want a diff here, but if so I think it would be
neat to wrap that in say a "test_cmp_diff" which we'd just use as:

	test_cmp_diff a b <<-\EOF
        <unified diff here>
	EOF

Where under the hood we'd just run:

	git diff --no-index a b >actual
	cat >expect &&
	[ munge diff header here? ] &&
	test_cmp expect actual
