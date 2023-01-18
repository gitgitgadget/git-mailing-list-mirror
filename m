Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390FC38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjARIDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 03:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjARIBF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 03:01:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C70577C7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:35:57 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso10152792oti.10
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUsVo9iGe5S+G0ZSEIwx5akarU05hAgKQd05mz2E1NA=;
        b=ciIYA49Pfhm+lKqmKlwyT70ksRkZyp1RsjSNEVYtyjM7KPJdXy3IephL4c6iB2y4Jv
         DdU8OjCpjei2SVjgFlSOlkvjdOvjPp8ROOIq9dvBSOrG6szuwa78gGSqEbF2XGms1q6V
         Gu4sudnrSr/TfPlCcdu9NOHlHl3oDEMjHUnl5vMV0tefAK2eU1EuLwsNvRcP59m92td1
         YisK4TZv/UCpDTQUTweu8dfVbu3gkteIx8uN28VonC25oeeqwbR2enY0YAmlZ+J052Br
         OkUTOFL3ZDWlttkKHdHcMBdWdDbAG0x2bwdJQuubk6MaBmgBtXJ2hL97dxgiFv5dqooH
         /ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUsVo9iGe5S+G0ZSEIwx5akarU05hAgKQd05mz2E1NA=;
        b=7Kqk/XQ28r5pPu88Dlw10QlzIUXPX+x0M4Xd5lajCny3AwnCssVprHeOFrCHs8q83e
         AUGYgsoQCGr+5hWG1Ofiw5P7OLqRKlYuitrV/KRvuL2PfJc+pC2BHZJGsLXU2WmY4+n9
         W+0hFE7YnT3iKc7yk38/hthrCBNi6i/D4pNb8W7ZwKpFJB98FlyiTUFc/GfVscE+8T7y
         JeEVJfBvdPBiAFltELkBZytUJxqARNhXnVFthhRYOc/2yk9zyDe3UO3AJg6vb2MLORdY
         Y9OivtuRHX2Qpi6mRZ4dzKxe/xZKTBOvZu+i0J0fUg32rjv7QU3DPZef9oZTvtpsDQDw
         S7Kw==
X-Gm-Message-State: AFqh2koC22I9OSwD7EIdSQoFRpxoXDYju5OjPpv7pmRHJjlp3Y0B+HkD
        3gjuhwktq9KAxF5I31I371HI9kW7ZTYgBM6a/asH+gsH
X-Google-Smtp-Source: AMrXdXuFOTWB+L2a+wkV3uc8NUA2QyWuysXYuEZEQegtYDvEvsIBOx+w7BbnGtmVmeJZpSKRgNTCAREE8XKTOtoDJtE=
X-Received: by 2002:a05:6830:111a:b0:684:eca2:a02 with SMTP id
 w26-20020a056830111a00b00684eca20a02mr337604otq.252.1674027356915; Tue, 17
 Jan 2023 23:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20230108155217.2817-1-carenas@gmail.com> <20230117105123.58328-1-carenas@gmail.com>
 <230117.865yd5z4ke.gmgdl@evledraar.gmail.com> <xmqqr0vt9oj9.fsf@gitster.g>
In-Reply-To: <xmqqr0vt9oj9.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 17 Jan 2023 23:35:45 -0800
Message-ID: <CAPUEspgzrW63GgbjXhKuvjpKXjEhiKaC7jtupiB-3AhcKTba8A@mail.gmail.com>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with \{b,w}
 in -P
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Diomidis Spinellis <dds@aueb.gr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2023 at 7:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > To argue with myself here, I'm not so sure that just making this the
> > default isn't the right move, especially as the GNU grep maintainer
> > seems to be convinced that that's the right thing for grep(1).
>
> OK.

I think that is definitely the right thing to do for grep, because the
current behaviour can only be described as a bug (and a bad one at
it), but after all the push back and performance testing, I am also
not convinced anymore it needs to be the default for git, because the
negatives outweigh the positives.

First there is the performance hit, which is inevitable because there
are just a lot more characters to match when UCP tables are being
used, and second there is the fact that PCRE2_UCP itself might not be
what you want when matching code, because for example numbers are
never going to be using digits outside what ASCII provides, and
identifiers have a narrow set of characters as valid than what you
would expect from all written human languages in history.

Lastly, even with PCRE2_UCP enabled, our current logic for word
matches is still broken, because the current code still uses a
definition of word that was done outside what the regex engines
provide and that roughly matches what you would expect of identifiers
from C in the ASCII times.

> > Of course all of this is predicated on us wanting to leave this as an
> > opt-in, which I'm not so sure about. If it's opt-out we'll avoid this
> > entire question,
>
> Making it opt-out would also require a similar knob to turn the
> "flag" off, be it a configuration variable or a command line option,
> wouldn't it?  I tend to agree with you that it makes sense to make
> it a goal to take us closer to "grep -P" from GNU---do they have
> such an opt-out knob?  If not, let's make it simple by turning it
> always on, which would be the simplest ;-)

GNU grep -P has no knob and would likely never have one.

So for now, I think we should acknowledge the bug, provide an option
for people that might need the fix, and fix all other problems we
have, which will include changes in PCRE2 as well to better fit our
use case.

Carlo
