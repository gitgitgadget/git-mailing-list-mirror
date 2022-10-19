Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4067AC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJSBWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJSBWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:22:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D909E070E
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:22:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m16so23081230edc.4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4dVLTuxdpLrwrTg4vbUxiTSILByWAgL3nBzYjlkfjQ=;
        b=RCWJxdLdBf+qHL74Z08VS+g6DRz4wMJSQBA28nC03fiDYZ6IGo1N1na0kjUpsh5fcB
         cqEvvAtF1HP05FyrIeVNE+s14C9BZoCRB6ZK/syjgWByca29VPC0c4ij3PdvSAVgJoaM
         cYDShex43tKN3EwW/p0Baq5zSw9e7QgEZqwDyhfF6LsS0sovAsepp6hm0CPhO70i/YH5
         Y5043GBHNvBa7zJ7A6dgVRRZCkZP+r0liOHeu1hhE8zJ2c/8ScT7MZbu3mjbtnHewhO+
         J/qXZlMuWgODzcWHxIWmot9hCt7sQjX/dC0I5D9S3WXwOxTuCc6f9fZ1aC0Y3yrJPpv7
         ZVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4dVLTuxdpLrwrTg4vbUxiTSILByWAgL3nBzYjlkfjQ=;
        b=MMYKZNVMkiJVWNrMaWPq2WARsD7By+taKLIMWI8gp7+xLZrdAK62DiWtY18YUFHtkF
         AbqS0VxFgcww+GIG4vKosOt2DBSrcqRLbYzXW7OdsB3lfgiaDtYRbpZ5iNiPhdvBg90Z
         AWXv5ZdKfKDircfLO8TheQUC0qsuPxZQbX27QiYjI7BNy7wxJSugKZTK6PPxAzFXgQCW
         WIqqSn49pZa8h7xH/2MIruSnka/AkxCxygzQaCx+YVxPMrJHIsQOXghMlrCVOpxf/Yx4
         cu5ZAxpI+z84E2lV497rSKEsqloTJD5EDg5T9P934Gw3XVHEqdlmfRPe4bGHfHO10xYO
         IAiw==
X-Gm-Message-State: ACrzQf3XMHK1ZMevwY+b+8AOjgFTeZSyCR2JiqFVMs2701EaO0k58UlZ
        F9jnXwGSh097zx3o9uf0io4=
X-Google-Smtp-Source: AMsMyM7yAmKaYipxwqNWafIXi0/9W57fqIm7Hv1BbQzx96ABNlvB1UFXIOz4A1YAx8WKH2NjZ9mdJQ==
X-Received: by 2002:aa7:cfc4:0:b0:459:7fa7:ee29 with SMTP id r4-20020aa7cfc4000000b004597fa7ee29mr4960194edy.414.1666142531898;
        Tue, 18 Oct 2022 18:22:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056402399a00b0044dbecdcd29sm9571828edb.12.2022.10.18.18.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:22:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okxmc-005xFx-0J;
        Wed, 19 Oct 2022 03:22:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
Date:   Wed, 19 Oct 2022 03:19:15 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g>
 <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221019.86bkq8hake.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Glen Choo wrote:

> Cc-ed Johannes, who would know a lot more about CI than I do.
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1dc:
>>
>> Thanks for a report.
>>
>> How dissapointing.  The thing is that the topic has been in 'next'
>> since the 11th (i.e. early last week), and I know that you guys rely
>> on the tip of 'next' in working order to cut your internal releases,
>> but we did not hear about this until now.
>
> Yes. Unfortunately, we (Google's Git team) release on a weekly cadence;
> we merge on Fridays and build on Mondays (PST), which makes this timing
> extremely unfortunate.
>
>> Possible action items:
>>
>>  * See what configurations our two macOS jobs are using.  If neither
>>    is using sha1dc, I would say that is criminal [*] and at least
>>    one of them should be updated to do so right away.
>
> I'm not too familiar with the CI, but I took a quick peek at ci/lib.sh
> and noticed that none of the jobs build with sha1dc, not even the Linux
> or Windows ones, so..

All of our jobs except the OSX one build with SHA1_DC, because it's the
default.

Per my just-sent
https://lore.kernel.org/git/cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com/
the blind spot has been lack fo SHA1_DC on OSX, for others it's the
reverse, we don't test e.g. BLK_SHA1.

In practice we've been catching SHA-implementation specific code early
because the OSX implementation was different, but in this case it's
OSX-only code, so it only supported the Apple Common Crypto backend.

>>  * The "two macOS CI jobs sharing too many configuration knobs" may
>>    not be limited to just SHA-1 implementation, but unlike Linux
>>    builds and tests, we may have similar "monoculture" issue in our
>>    macOS CI builds.  Those users, who depend on macOS port being
>>    healthy, should help identify unnecessary overlaps between the
>>    two, and more importantly, make sure we have CI builds with
>>    configuration similar to what they actually use.
>
> I don't think this is a macOS-specific issue; our CI just doesn't do a
> good job with testing various build configurations.

Yes, definitely.

>>  * Adding a few build-only-without-tests CI jobs also might help.
>
> This sounds like the way to go IMO. It might be too expensive to run the
> full test suite on every build configuration, but build-without-test
> might be ok.

Yes, there's not much point in running the full tests for some of these
variants.

A lot of it we can also get for free, e.g. we run some linux jobs with
clang, some with gcc etc., we could also run one with BLK_SHA1, one with
OPENSSL_SHA1 etc.
