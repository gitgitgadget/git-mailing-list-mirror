Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E78C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 04:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31358246BC
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 04:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o00XZ4zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgKSEQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 23:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKSEQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 23:16:52 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F50C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 20:16:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t8so3193555pfg.8
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 20:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxFEJO35R7eA2gdjtYOLprXdB33nEK1DufpgP4QV0pY=;
        b=o00XZ4zgno2FJl4RFmduQ5ad0PXY2Aj6/zt2DAKBXeDOsJeatTZ08YafF5gSzqZLfU
         DrlFjfpeixyVfGCfL/zCcelAgDPZsXyiBDSmdQzMvThrpmCeUEvrk1CX9Dg0vsg/tQyf
         07MRnJsGUrArtXE/FKWb8Je6gKD9mMSHSilJAUfuAxS4oGaRFpTrWvFt6cbJ9SLna1JS
         ovgrAa+9e7jBMSEmQ0EBNMYjhhS9P3IZ3/A3KUQnxZVZ94GofYkqnCAoTEEKNyyS1RAd
         HikD2W6j8Y5YTwEvuWvkZCb6mDYUCyeEC3lUXDBAGKi0UNccnEYTC5F7C1/LlQZVwkjk
         erLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxFEJO35R7eA2gdjtYOLprXdB33nEK1DufpgP4QV0pY=;
        b=HpXCCyHKfBR6B6vCeUnX5ocgiBBY4tAQSEe4j5QQ3ZSOLt1MJP9qMpAvtRQUwgMx3G
         O5oNfVU9dzb3np9Ho3NsnLdy1+PAjdQVYmf3ZvP9tVEgREK8IOJqvA3Qv0sFJsZrMJkz
         EFijWE3W3qE0pB4ueoD4CrSwrrlzLV3C4/zOBCn52LJplD62uCBM3sN6c/mUKFELRdjJ
         rswjBufc1DvI2Iq/aHDLC1U+PYZT2bHvBNFetoH/uZHi8x+BAobGzuVO8gq85/jcgReH
         TTudTRlFL+4fc+6pkbxekIzt5n9kNu/Q5lw1Am9t1T1dSFzbSYdF5GQTmOiGDHtfTGkt
         1c2w==
X-Gm-Message-State: AOAM530iXXM1xupj/3fTV86wTbZb5ds3kMpYqrsHQGhrkG9F6NxzhPMy
        YRjmfSODQBXNOGFHxI/n5wZl7daKe2kWrimCHAE=
X-Google-Smtp-Source: ABdhPJyaSfHSgMQBY27oowGcaQp1ClrQuFn1zXZZHbga06867teA9yae/zToI/YedXdY+UxSg1w8yTAZ9yERRjpLvls=
X-Received: by 2002:a17:90a:2c09:: with SMTP id m9mr2175969pjd.205.1605759411329;
 Wed, 18 Nov 2020 20:16:51 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu> <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu> <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
In-Reply-To: <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
From:   Peter Hadlaw <hadlawp@gmail.com>
Date:   Wed, 18 Nov 2020 22:16:25 -0600
Message-ID: <CABrPy+GXpV4F_j6nChEG4cEM=N3GSUmeJ_cK+6+JcNHMsY-T0Q@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     Brandon Casey <drafnel@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reposting a bit from a side thread, so excuse me. Felt that this is
more of a relevant place to leave these thoughts.

***
If some people or teams would prefer _their_ default branches to be
anything other than `master`, I'm all for giving them the tools to
live out their dreams. That's what `git config` and the new
`defaultBranch` flag are for. There is no need to force these desires
onto _all_ users.
***

It's worth noting that the word "slave" comes from the en_slav_ement
of Slavs (the Slavic people of Eastern Europe). Check "Slav Twitter"
if you must, you'll find nothing but a chuckle at this situation.

I encourage everyone to really think about the changes you are making.

It was just reported to me that a professional friend of mine had
confusion as to why, after initializing a new repository, they
couldn't navigate to the `master` branch of their repository.

I understand this is back-of-the-napkin type math but stay with me for
one moment. I also understand GitHub is not all of git users, but I
just pulled the number to help me out here.

If GitHub has 40 million users but let's say half of them aren't
active, so now we are at 20 million.

(Replace this number with how many actual users of git are out there.)

Let's even say half of them are on board and aware of this "harmless"
change to a more "sensitive" doublespeak representation of the
"master" copy/branch of the repo. That leaves us with 10 million users
of git that are either unaware or are not on board. Let's say it takes
3 minutes for a user to search on the web why exactly they can't
navigate to their "master" branch. That's 30 million minutes wasted,
or about 57 man-YEARs of time wasted.... for what? Oh but you'll ask
them what their default is? Do the same math... better yet realize
this is just a power exercise of one very tiny group over another.

When do we put our foot down and say enough is enough, and not
everything is offensive?

Again, please reconsider making this change towards
doublespeak/Newspeak and consider the ramifications of how much actual
human life & time will be wasted. Ignoring adding on the new
reputation of the git project to kowtow to "current year" politics.

Besides just the annoyance to users in their day to day, yes there is
mention of "just update the tutorials!" but what a way to dishonor the
millions of hours people have put into welcoming other individuals to
the git community. There is no reason to outdate their tutorials and
documentation so prematurely (and yet again exercise power over them
by making them update their content for no real reason).

--
Peter
