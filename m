Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A31C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F5A2220B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 15:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLWPw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLWPw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 10:52:27 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33873C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 07:51:47 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q25so15357117otn.10
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=M7rLR3I7sGZXF+Rrtb5WKZTsEui/wsWHVx978QSSfv4=;
        b=d54/RbI0Jw7nAf7bJd7w4i6zoo0mKEzTt5yNxnX8s1ksNIl7kDBLCT7aD+g3lJ7UMB
         gMb2kcBCISez1AQAFIMIRi2Qur1XsZXhTkr+4JKwykkpDvmaENO/cidiohsQQueOcUjP
         1PJ441z0PREHBo8ZOlRdyZjQQYUvjBuaRSHOMFBlC6LnWCEmOWt4Nj4Ut6k3vF7nOMOT
         8QGVsCyqZ/KWO+OBahuiYDHEKky1VexnHJZjf8F6u+rKLWiLCTaAFnuyFsXZoGY9gwsY
         wOkGJ63ZK12ibx4XfXRqla3RrBjlCEqUtymM7fmUdoJHbySi6Em/NAHqY9tZBe9DFJ0Q
         sZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=M7rLR3I7sGZXF+Rrtb5WKZTsEui/wsWHVx978QSSfv4=;
        b=BtUAg1CzDdnJ7Zgpyi5SXv7l492fDXVtYbxuSlROme3cGoscG9VVyzD8m0TRmkt28C
         5gsVwnxSHQ4YNGItVvORcMW3+y9imJVFf0nxkR6nf5I4kwr7jCj4wwDJ/MDnrjZKW5Zn
         ZUGNbF0QZ/N2Ok6en7s6XPNl6h1XG7AhuGKU5J0QKcE6cGEIT97SKgYv5JLxb4w6CZTm
         2F8D3+RGM7SifLrHCeeSGplk2cLPVE0rKP2dtSWwBIEGY0aNWvmrtLazPNH/8LZNYy7d
         i1Anh9qrzHeXtcxVDdvpwLGnIrSIr/JJxAnxVjFEUBaZczzV/UiyZUYjLDygXPxwD5c+
         785w==
X-Gm-Message-State: AOAM532QVqlf+SS1OM3f8AsQE5jCk8MnvxCWV4BdYZFySW+0HMul1geH
        RS69veUt91n4M8bfWZMO1dg=
X-Google-Smtp-Source: ABdhPJw30KbQobm41Jwhvbo16x+GFtDDpkFTPn2jhOST8TZjsIXGiO2zeTX9wr5W+L4inBBm3IddNA==
X-Received: by 2002:a05:6830:8c:: with SMTP id a12mr19621914oto.167.1608738706544;
        Wed, 23 Dec 2020 07:51:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t25sm3445207oic.15.2020.12.23.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 07:51:45 -0800 (PST)
Date:   Wed, 23 Dec 2020 09:51:44 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe36790793ae_2354120839@natae.notmuch>
In-Reply-To: <xmqqzh248sy0.fsf@gitster.c.googlers.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
 <5fe2d89c212e8_18dc12083e@natae.notmuch>
 <xmqqzh248sy0.fsf@gitster.c.googlers.com>
Subject: RE: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> > But I'm not going to pretend I'm fine with a change I disagree with; I'm
> >> > not. Especially when nobody is paying me to do this.
> >> ...
> >> >> The community needs to do its part in making you and everyone else
> >> >> feel welcome. At the same time you need to do your part in making
> >> >> contributors, especially the new ones, feel welcome and appreciated.
> >> >> Being overly critical can turn developers away from the project.
> >> >
> >> > Who are you talking about? I'm the one who made the contribution.
> >> 
> >> What does the "change you disagree with" you mention above refer to?
> >> Changes suggested by reviewers to add per-tool knob?
> >
> > Yes.
> 
> If so, please realize that this is a team effort.

Yes, but different people in a team have different roles. There's the
maintainers, the contributors, the reviewers, the translators, etc.

> You are not THE one making contribution.

When I'm sending a patch, I have the role of "contributor".

That doesn't mean the people revieweing the patch aren't making a
contribution as well, but traditionally they are not the ones being
assigned the role of "contributor".

In your own release notes [1] you say:

  New contributors whose contributions weren't in v2.29.0 are as
  follows.

Presumably these are the people who contributed patches, not reviews.

> If you are not fine with a change others will make on top of what
> you did, well, tough.

Yes, I know.

I don't know why you feel the need to explain that to me. I have been
contributing to open source projects for more than 20 years.

> It's not like by sending a patch you lick a corner of the cake and
> make it untouchable by others.

No, but just because others have an opinion that doesn't mean I must
have the same opinion as others.

Take judicial panels as an analogy. A group of judges must arrive at an
opinion [2], and sometimes they do without problems; all of them agree,
which is called an "unanimous opinion". Sometimes not everyone agrees,
in which case it's called a "majority opinion". When not everyone
agrees, a judge is perfectly entitled to write his or her "dissenting
opinion", which is a disagreement with the "majority opinion".

When there's a dissenting opinion, the court still moves forward with
the majority opinion, the dissenting opinion is written down for the
record.

When I express my dissenting opinion I'm not saying nobody should write
a patch on top of mine. Of course they can. Anybody can take my code and
do whatever they want with it (as long as they don't violate the license
of the project).

What they cannot do is add my Signed-off-by line to code I don't agree
with.

> Just as you said, you can agree to disagree and move on.

Yes, with my disagreement stated for the record. Just like dissenting
opinions in judicial panels.

> Once a rough concensus is reached that the work on top of what you did
> is a good direction to go, it would not get us anywhere to repeat the
> same opinion over and over again to block it.

I am not repeating the same opinion over and over, I am responding to
the comments of others, with an argument they fail to address.

If person A doesn't address my argument, and person B doesn't address my
argument, and person C comes along with comments that warrant the repeat
of the argument; I'm going to repeat the argument.

Nobody has addressed the argument.

It is the fault of person A that didn't address my argument that I had
to repeat it to person B, and so on. Not mine.

Cheers.

[1] https://lore.kernel.org/git/xmqqsg82qur4.fsf@gitster.c.googlers.com/
[2] https://en.wikipedia.org/wiki/Judicial_opinion#Kinds_of_judicial_opinions

-- 
Felipe Contreras
