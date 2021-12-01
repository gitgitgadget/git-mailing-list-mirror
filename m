Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C84C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhLAV21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhLAV2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:28:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835BFC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 13:24:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so107368473eda.12
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LWDvuB2I2llQfC6WGCTUaCSwuMzw4t8WEDrxO1QfIcA=;
        b=Qg8lSPlTO/uPttnwZ56m0WopQ9hX/llxA9ZvAplQo6xa6mV389dKyZmij2i4WunAnx
         Lvc9jLqEkvyDejo2CrMIRG2yCqz4ky9bmesGfoxEj15OpocvOpXlgec+f/RelCtje4m+
         oKqh6i7hoMnSkfSKBDMS/Rdfgn++1rrMyvC6RZwkXG2nGjAnDqoeGrsUVXK1LK29SQcr
         f3dkDrseOTyVfOPMuhw1vl6un4IXyQzrjI0cQjhQw5yKxX7hL2tdOH1o5QC4CS6XDxS2
         mA6kA0AGmIjdo53DgfKxyWCR9qsMWWyr3SujgQ1Fp9lIo1X4cvqwyTEkgFUcCp+JxBxC
         P1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LWDvuB2I2llQfC6WGCTUaCSwuMzw4t8WEDrxO1QfIcA=;
        b=VBeow9Hcy3/7hk20HG97TbVt18TXiV6Ef+kzFpouYL5Krhgs0IRKMGnbF3c6dUNqk1
         9uyA6Yo5l87NUdnXx/tT++/jWLCRWrNAWlR6mUjYND3PI2ox4QMeWv8Dehmiiii+ckSY
         Uo4b4XbQ+zCY8XUur5QN0jbJnX0VNRPOcbCqq7+nTS/mDAkXlGAyTv6Y74pRrnm5IeBv
         FiPmXb9ddwvshEDL/XcXo9FHs0bcSUEG3pie3Q3nJkdBoKFNp+dyoaDQdh2AEMXJXTPn
         2peWSXyaBC+SgPkGVqKuRT5XRwfARMOlz6J22MO/kfTAlip9C6nM11wVACSsLHxpaWta
         bQ7w==
X-Gm-Message-State: AOAM531JA/pWEdAdL7Cu+sZ4WqdyGG7xqBGVO3r4rzYYm0Mq4DxavjQg
        t4sp7e9tBAcWBSVaEXK4LH1e9rXIGWX71g==
X-Google-Smtp-Source: ABdhPJy3U0FJrpZhgxB6FMTWuwbromAfezJzKJd8QmjstWr1oLsdlvNttYZuR3oxmU1FuIhspmClhw==
X-Received: by 2002:a17:907:6287:: with SMTP id nd7mr10326483ejc.152.1638393896986;
        Wed, 01 Dec 2021 13:24:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p13sm559553eds.38.2021.12.01.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:24:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msX5z-001Pvu-O7;
        Wed, 01 Dec 2021 22:24:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Date:   Wed, 01 Dec 2021 22:20:11 +0100
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
 <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
 <YaaN0pibKWgjcVk3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YaaN0pibKWgjcVk3@coredump.intra.peff.net>
Message-ID: <211201.86mtlk9fx4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Jeff King wrote:

> On Tue, Nov 30, 2021 at 09:05:54AM -0500, Eric Sunshine wrote:
>
>> >   - shouldn't status messages like this go to stderr anyway? I know some
>> >     people follow the "unless it is an error, it should not to go
>> >     stderr" philosophy. But I think in general our approach in Git is
>> >     more "if it is the main output of the program, it goes to stdout; if
>> >     it is chatter or progress for the user, it goes to stderr".
>> 
>> I considered this as well and agree that it would be a nicer localized
>> fix, but...
>> 
>> (1) I don't think the practice is documented anywhere, so people --
>> including me when I wrote builtin/worktree.c -- might not know about
>> it. Indeed, we don't seem to be entirely consistent about doing it
>> this way. Randomly picking submodule-helper.c, for instance, I see
>> status-like messages going to stdout:
>> 
>>     printf(_("Entering '%s'\n"), displaypath);
>>     printf(_("Synchronizing submodule url for '%s'\n"), ...);
>> 
>>     if (...)
>>         format = _("Cleared directory '%s'\n");
>>     else
>>         format = _("Could not remove submodule work tree '%s'\n");
>>     printf(format, displaypath);
>
> Yeah, we've definitely not been consistent here. There's no silver
> bullet for this aside from vigilance during review, but probably laying
> out guidelines could help.
>
> Here's a past discussion (that actually goes the other way: somebody
> complaining that stderr should be on stdout!) where I laid out my mental
> model:
>
>   https://lore.kernel.org/git/20110907215716.GJ13364@sigill.intra.peff.net/

...and a third way (which git doesn't conform to at all), which is that
std*err* is really what we should be using for errors only.

You shouldn't write anything that isn't an error there, or at least
that's what I've seen some software in the wild assume.

I've run into occasional problems with git over the years because it
writes to stderr routinely for non-errors, which flies in the face
assumptions made by various third-party software that assumes the
"that's for errors" model of the world.

E.g. look at the (very useful) "chronic" utility, which is in
"moreutils" in Debian. From its manpage:

   -e  Stderr triggering. Triggers output when stderr output length is non-zero.
       Without -e chronic needs non-zero return value to trigger output.

       In this mode, chronic's return value will be 2 if the command's
       return value is 0 but the command printed to stderr.

Right now I'm failing to recall what, but I remember dealing with that
behavior from git in some other contexts.
