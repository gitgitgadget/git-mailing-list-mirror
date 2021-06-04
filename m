Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5744C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC3A613E3
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 12:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFDME3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 08:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhFDME2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 08:04:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C1C061761
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 05:02:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 29so7674312pgu.11
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v9VjugMdA7Mvn/f1cR33Ct5n5cXXHa6C17QKQTp06s0=;
        b=RyDwrePIqhquYBWuHCZTRj13NTiOfHVjP3DeLuUecPoefPHmAo4D0Uisy0FDjeHdU0
         5oVcwX0UH0h9ODHipZKnRpakjkwCRkGgPOwsoFiSkTVV7Gk0tZ1IoUDfzQhjxNDBZRYL
         OmKAZ9RLjOHXAyHwxLNdI22GtXhR1GKeGN6rq8ErjX17/aXQpsbwLu4Nn4c3XEfrFYcV
         ywzLX789PfLqCx6ITZSgvRuB4jxoZPBIAeqxgMRlCQ9wcyFELQMxSYklxe/HyM4v1CRa
         54bGImUTP+HL3NGfLjU13Wf2sqJQ7T3zj5Ed5CCtbFTd6EDwzl21W9r9SS8HUZTHiI3B
         ex3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v9VjugMdA7Mvn/f1cR33Ct5n5cXXHa6C17QKQTp06s0=;
        b=BblflIV6vtvYVgHA2ypAivEI0bpRq+K6ject6q/YdXaptHBFZ4p5mPyvyz3uZEy4q9
         OzWV3/1guqHvADk7ElydvAHS9+fc157gl9bLft7n8s06R85MehflvEvHJdtR0mXEenJI
         +y9EBrutVfSbg/udIXzc46vay96ZikrYae4JVjiEfjZ7BL7L+3/8b9LKWYbl5IvVWZ6B
         YwO6TeyCxMD+YXzfR92eeUJldCy4cO4NMUrMjNZqAOhrnvsOkEm4gDODrbfVhvIilY6e
         xxXncgJJ/JE3pQ7Um6YpnvTZL1Q0fk7ceq8zlLbBcUYeqNKHVlFjIAkoa1ym8lEfWHh3
         gvhQ==
X-Gm-Message-State: AOAM533Tma+zlZA7Jdr4b5hzZDf+anQn8UePlRtpSxHsLDV9L5l8g9wi
        7EAasmcMDTemk0j52OauCNM=
X-Google-Smtp-Source: ABdhPJzAGppccdFChxIHvqWiOuU0aSi4f9IkRfbA0m/Ajfx5rL8L1/wMdgE2ybwYH+ttQ3HTZTuWCw==
X-Received: by 2002:a62:1942:0:b029:2e9:debd:d8b1 with SMTP id 63-20020a6219420000b02902e9debdd8b1mr4426267pfz.9.1622808148878;
        Fri, 04 Jun 2021 05:02:28 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id 130sm2024769pgc.19.2021.06.04.05.02.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 05:02:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] [GSoC] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP6+3T1hN5mvWBe9-hziw=XGOugJ3ah=LVEDwOM5XY2uiZPkOQ@mail.gmail.com>
Date:   Fri, 4 Jun 2021 17:32:25 +0530
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F10D45CC-033E-45F5-B1A6-CA757D3EB6F2@gmail.com>
References: <20210528081224.69163-1-raykar.ath@gmail.com>
 <20210602131259.50350-1-raykar.ath@gmail.com>
 <CAP6+3T1hN5mvWBe9-hziw=XGOugJ3ah=LVEDwOM5XY2uiZPkOQ@mail.gmail.com>
To:     Shourya Shukla <periperidip@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-Jun-2021, at 17:07, Shourya Shukla <shouryashukla.oo@gmail.com> =
wrote:
>=20
> Hi Atharva!
>=20
> On Wed, Jun 2, 2021 at 6:43 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Let's add a new "add-clone" subcommand to `git submodule--helper` =
with
>> the goal of converting part of the shell code in git-submodule.sh
>> related to `git submodule add` into C code. This new subcommand =
clones
>> the repository that is to be added, and checks out to the appropriate
>> branch.
>>=20
>> This is meant to be a faithful conversion that leaves the behaviour =
of
>> 'submodule add' unchanged. The only minor change is that if a =
submodule name has
>> been supplied with a name that clashes with a local submodule, the =
message shown
>> to the user ("A git directory for 'foo' is found locally...") is =
prepended with
>> "error" for clarity.
>=20
> It would be better if commit messages are limited to 72 columns
> (characters) per line.
> Though you can obviously write longer lines on the list no problem.

Good catch. My auto-fill settings had got switched to length 80.
I'll be careful next time.

>> This is part of a series of changes that will result in all of =
'submodule add'
>> being converted to C.
>>=20
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
>=20
>=20
> I and others before me used to sign off the previous authors using
> 'Signed-off-by:'. This trailer
> has not been used yet so I am not sure if it should be used though I
> prefer this over the former.
> Maybe Christian could comment here?

Yeah, I wasn't sure if I should include an S.o.B without explicit
acknowledgement from you and Prathamesh.

>> This is part of a series of changes that will result in all of =
'submodule add'
>> being converted to C, which is a more familiar language for Git =
developers, and
>> paves the way to improve performance and portability.
>>=20
>> I have made this patch based on Shourya's patch[1]. I have decided to =
send the
>> changes in smaller, more reviewable parts. The add-clone subcommand =
of
>> submodule--helper is an intermediate change, while I work on =
translating all of
>> the code.
>>=20
>> Another subcommand called 'add-config' will also be added in a =
separate patch
>> that handles the configuration on adding the module.
>>=20
>> After those two changes look good enough, I will be converting =
whatever is left
>> of 'git submodule add' in the git-submodule.sh past the flag parsing =
into C code
>> by having one helper subcommand called 'git submodule--helper add' =
that will
>> incorporate the functionality of the other two helpers, as well. In =
that patch,
>> the 'add-clone' and 'add-config' subcommands will be removed from the =
commands
>> array, as they will be called from within the C code itself.
>=20
> Seems like a good approach! BTW, if this "extra" message is a bit long
> like the one above, then
> you can put it in a cover letter instead. If people really want to
> read this extra information
> they will read it in a cover letter as well.
>=20
> Just supply the '--cover-letter' option when executing the 'git
> format-patch' command.

Not too familiar with the convention here on how long a description
warrants a cover letter. Generally in the mailing list I found
[PATCH 0/1] labels far more uncommon than [PATCH] for single patch
changes, so I went with the common case.

>> Changes since v1:
>> * Fixed typos, and made commit message more explicit
>> * Fixed incorrect usage string
>> * Some style changes were made
>=20
> To save yourself the trouble of sieving the "top" or "noteworthy" =
changes from
> the new version, you could instead just print the 'range-diff' between
> the two versions.
>=20
> You can do:
> 'git range-diff b1~n1..b1 b2~n2..b2'
>=20
> Where:
>=20
> - 'b1' is the first branch; 'n1' is the number of top commits you are
> taking from 'b1' for
>  comparison.
>=20
> - 'b2' is the second branch; 'n2' is the number of top commits you are
> taking from 'b2' for
>  comparison.
>=20
> It will print a very detailed output showing what differences were
> there commit-wise
> amongst the two branches. This can be put at the end of the cover
> letter. Though, this
> isn't necessary if your way seems better to you.

Thanks for the tip. I felt since this change was mostly about code
style and naming, a range diff for it felt a little extra.

I liked it more when you used it in a previous v2 of your patch,
where the changes were more significant.

> BTW, it would be helpful if you could send mails addressed to me on my
> other email <periperidip@gmail.com>.

Got it.

