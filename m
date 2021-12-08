Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 10:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhLHKcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 05:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhLHKbx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 05:31:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8164C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 02:28:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so6607596edd.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=09AtdlPZdmjIyqWETusDxhHEvHucf841Bm5BI88NJso=;
        b=pTq7iGYDVHkyZpy7x66DM0vmxw8A7jkd4s80fgOnZn/gXTI3LRD8/A4SXCb4Dy9574
         psKOb3XYL8xeA4taSLyAds7Ze8hDioG5skUjqJvhm3LTtMh/I657TSTjpOLe+s41iOdb
         FvtYYsnbLUEHuDJO92gNGbLpPZNDoVnZgtTihjlPYc9wpjDON5Kq5Qxxo4ETuKLsdah2
         x/WG4BRUjOpu3KLD7nDwIBmQEYQDUG02/igJV3Zugt+1Qcdan1FrZrzhnMOTcwa1gAUy
         bPJV3Z3ono+OhT+MJTuRt+fiTYjWUjnT9hW3SiIxudYRakkfPI+BnInPvwTnHbSRrQWt
         uqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=09AtdlPZdmjIyqWETusDxhHEvHucf841Bm5BI88NJso=;
        b=4TFW5AP1Jdx2b7v5Ej/eRPlT1T71GtEe2tvTTIWw3AwqztNyevcQpNjUG5X2emgYi4
         V1yo0ziSXwV0nDgS+hcDciXs38P/DowSeQZ3AEU86208vOLJLmidmovUeh4+e1Brkw7+
         cyAtX8gyCCXE1cwoS+RsqJCVTIeTgRFiDJvAJhtKMvT8LmT1n+l3JYFzSla1WKpqDzIU
         Cdv62yjdHC0SGNm1I96xHKmlLRBPsfHoVYEYzkWHy1ngcMh2B+u/a8+XE0r0Iu7lsK3H
         wuLwZEob8FnbjLlCOd7uHdkkC6ZEasNU2RV0nMZOy4K9IeSPRcBnl27dBufi4MOOOFkW
         K7KA==
X-Gm-Message-State: AOAM530iBHbaQ+mpI9VIGE1oD/E0Nb4kTjfmbUwT2ozcNZqwaxXUjyXV
        rX+br+7wm+uVnyqKqwLyEa2kqh38P7UZ3w==
X-Google-Smtp-Source: ABdhPJz0evvirk+D9SahhCyxFA4dxEZoJjpuGSj7M2Ihj9ogdISB7t9sxUPbJjfct/OuK3hRz0tDyQ==
X-Received: by 2002:a05:6402:34cf:: with SMTP id w15mr17391346edc.63.1638959299114;
        Wed, 08 Dec 2021 02:28:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w22sm1887093edd.49.2021.12.08.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 02:28:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muuBM-001Mzu-U7;
        Wed, 08 Dec 2021 11:28:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 00/11] Avoid removing the current working directory,
 even if it becomes empty
Date:   Wed, 08 Dec 2021 11:23:56 +0100
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
 <211207.86tufkmfc2.gmgdl@evledraar.gmail.com>
 <31bef4f9-2313-83a2-14e9-4ed1cc73a59c@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <31bef4f9-2313-83a2-14e9-4ed1cc73a59c@gmail.com>
Message-ID: <211208.86a6hbmlvj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Derrick Stolee wrote:

> On 12/7/2021 1:30 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Dec 07 2021, Derrick Stolee wrote:
>>> test_expect_success 'remove cwd' '
>>> 	init_repos &&
>>>
>>> 	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
>>> 	for repo in sparse-checkout sparse-index
>>> 	do
>>> 		(
>>> 			cd $repo/deep/deeper1 &&
>>> 			test-tool getcwd >"$TRASH_DIRECTORY/expect" &&
>>> 			git sparse-checkout set &&
>>>
>>> 			test-tool getcwd >"$TRASH_DIRECTORY/actual" &&
>>> 			test_sparse_match git status --porcelain &&
>>> 			cd "$TRASH_DIRECTORY" &&
>>> 			test_cmp expect actual
>>> 		)
>>> 	done
>>> '
>>>
>>> Please do not let this test delay the advancement of this series. As we
>>> find these kinds of issues, we can fix them one-by-one as needed.
>>=20
>> Not to pile on about "the core idea", just a question while this is
>> fresh in your mind:
>>=20
>> I think that those cases would per [1] be ones where a more isolated
>> change of reading the $PWD from the environment would make all those
>> commands work as expected. Or would the "$TRASH_DIRECTORY" also
>> otherwise go away in this examples?
>
> I have read this message and the one you are referring two twice and
> I cannot understand what you are trying to say here.

I'm asking whether the WIP patch I posted at
https://lore.kernel.org/git/211124.86sfvld4cl.gmgdl@evledraar.gmail.com/
would partially/entirely solve those issues you mentiened (but I see
Elijah has a side-reply saying it might not in either approach).

>> Anyway, just per [1] and the potential future follow-ups is this (I
>> don't think so, but maybe I'm wrong) or other examples you have things
>> that specifically need the "retain the getcwd()" part of this series?
>>=20
>> Or just (as I think would be the case with that "git status") to not
>> have setup.c die quite as eagerly as it does now when getcwd() fails,
>> but it can find its way back to the .git via the environment's $PWD?
>
> Are you implying that Git will be the only thing broken by a missing
> directory after we leave in this state? I doubt that is true, and we
> should be good citizens here by leaving the directory around.

No, I'm just trying to clarify which specific thing we'd need in
this/other cases to fix things *in git*. Because...

>> There *are* definitely cases where not-just-that-setup.c change but also
>> the "don't remove the CWD" is an inherently better & more complete
>> solution. But I think that's mainly to do with 3rd party shellscripts &
>> other programs outside of our control.
>
> Exactly. We should take this change because it is valuable to not cause
> a confusing error in other tools.

...maybe we should fix things for other tools too, but for any future
development it helps to know what was needed to fix what issues.

>> I'm assuming that you were working with this on Windows, where
>> presumably there's fewer/none such shellscripts you rely on, but that's
>> now two presumes in a row, so... :)
>
> I'm working on Ubuntu, where I do all of my Git development unless there
> is a platform specific reason to do so.

*nod*, badly assumed then :)
