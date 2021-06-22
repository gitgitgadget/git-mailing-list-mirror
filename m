Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A35C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A1C60FEB
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFVPc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhFVPb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 11:31:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E105C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:29:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq39so8126737ejc.5
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sVW5TgLnOL0I+Egas4JlOrUQW+KXsq4HPrmJaFh0PMc=;
        b=Rb8Dq7CJP7JKppBWvpC3I2EJUUjo8ivngCQLUuCY4s0q6BVAek8JTyZO+bfeR1jo/J
         FAqoffviZVfJweGjgr7/wWkJq1Ge0GPr36vxTwVGjDviQzk33ILTVTv3aWbuE6VmyzTo
         HaJ43vbPBHIZedjNu+c8hlbCpJQLUfRYOQxGigz3ISxHlEWH7LfzU0HFpujMpMKH0fkQ
         rcBCiiDE4Eq+am82X3NSLeqZkjKvQ6fxL9a6GPRH5tOJUMNz0Zp8F+re3c3fVI3HQCgT
         74A970aomXkf6hZJcMcjyIIxXNJ+wZ1jenPvbfhbdISIBZf31Vhk2hd9ouOBcHYJY//3
         jXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sVW5TgLnOL0I+Egas4JlOrUQW+KXsq4HPrmJaFh0PMc=;
        b=Eu/QYANUs1Bsd1wqR4MWP6q8FxNPc7Z2WBEgWoJTc60+IW0G9zgQAq/5I7Q0GnCFqw
         LbKRj2xtnk/0NdhouSqeM+68scceEi4EdDaHMSCjuw0M1H5r2i+EEqHwy0lq3IUyrl1U
         WbO87Q4FS6+MPHutNxZeyJLON3I+29ST6REk2gXwQQuMnQa6p/pwXGcNyYLV83y2VwUR
         yea7pk3Kko4OYaBNJP26Wfj3n1TpXtkL5jcZE3waA9HSkDunjOvcKOP6CaDRipE7rQGk
         9tJ9grhZZTU9LEbSHbRE640fMOzhIrGekaQcKH0tlyXym0mU8EA24fcYiSgRkzxzle1N
         GzIA==
X-Gm-Message-State: AOAM530RvIKuHbdVGENgpzFQ8bn0k3bX7E7vb2hQVqOUPiRiM7dL8vxZ
        On/lP0V3Op4A5IWjCM45hFM=
X-Google-Smtp-Source: ABdhPJwEIzTtM0CkNv1c/z/N/c2jAPidTJoc9qY2nXkz1KwoULEf70aIt9zfSX/kAWLLwC/fmqEALg==
X-Received: by 2002:a17:907:6f6:: with SMTP id yh22mr4487183ejb.257.1624375781435;
        Tue, 22 Jun 2021 08:29:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g16sm6092579ejh.92.2021.06.22.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:29:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Date:   Tue, 22 Jun 2021 17:27:27 +0200
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <877dio3vg5.fsf@evledraar.gmail.com>
 <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
 <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
 <20210621093310.eqt3ajic64pgag44@pengutronix.de>
 <87sg1b2xhl.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <87sg1b2xhl.fsf@evledraar.gmail.com>
Message-ID: <87bl7x3okc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jun 21 2021, Roland Hieber wrote:
>
>> On Sun, Jun 20, 2021 at 10:10:10PM -0400, Eric Sunshine wrote:
>>> On Sun, Jun 20, 2021 at 10:00 PM brian m. carlson
>>> <sandals@crustytoothpaste.net> wrote:
>>> > On 2021-06-21 at 00:35:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wro=
te:
>>> > > On Sun, Jun 20 2021, Roland Hieber wrote:
>>> > > > Currently, calling 'git bisect' from a directory other than the t=
op
>>> > > > level of a repository only comes up with an error message:
>>> > > >
>>> > > >     You need to run this command from the toplevel of the working=
 tree.
>>> > >
>>> > > How does this affect out-of-tree scripts that will be run with "git
>>> > > bisect run", is the cwd set to the root as they now might expect gi=
t to
>>> > > check, or whatever subdirectory you ran the "run" from?
>>> >
>>> > As for the idea itself, I think it's a good one assuming everything
>>> > continues to work.  It will certainly be more convenient for a lot of
>>> > people.
>>>=20
>>> There have been multiple patches sent to the project over the years
>>> with the same purpose. One problem, I believe, which has never been
>>> fully addressed is what happens when the subdirectory from which
>>> git-bisect is run gets deleted as part of the bisection.
>>>=20
>>> Here are a couple recent threads triggered by previous such patches
>>> (but there are probably several more):
>>>=20
>>> https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gma=
il.com/
>>> https://lore.kernel.org/git/pull.736.git.git.1584868547682.gitgitgadget=
@gmail.com/
>>
>> Ah, thanks for explaining the problem. Would a patch that adds a short
>> explanatory comment in git-bisect.sh on the matter help to prevent
>> people sending such patches?
>
> Having skimmed the linked discussions I don't think the consensus is
> that this shouldn't exist, but that someone who wants it should do some
> research on the relevant edge cases, come up with test cases for them,
> discuss the trade-offs in a commit message etc.
>
> I for one would welcome such a feature, it's often annoyed me, it should
> just work like "rebase exec" in that a "run" script should cd to the
> root, but (as discussed in the linked threads) I don't see why we'd
> prevent it any more than several other commands that already have this
> edge case, but don't explicitly prevent this.

There's also a related issue: It's not just "git bisect start" etc. that
have this problem, but also "git bisect log". No matter what we do with
run etc.

I see no reason for why "log" should not locate the relevant log in the
.git directory, same for "view", also "good", "bad" etc. E.g. one might
start a bisect session in one terminal, and be cd'd into the 't/'
directory in another, and then couldn't run "good/bad" there.

