Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DCFC4332B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 09:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A641D651E3
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 09:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhCHJQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 04:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCHJQn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 04:16:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21270C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 01:16:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bd6so13489123edb.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jvv1Il63pqr+o8Mt1wsoo+DLVGyebTBoMBLmuaM2+hU=;
        b=gkGDRQ8RhHhSUqmSozDqLcx/7JCAERz+f0Pkbn8J/q7rwWrF2Mpzczc2se08ZNDESp
         PNRhPvNyThNtyENqYi6J8z79ze3YDRNdaNRKegYdOyiLJJit/x0WCh1SerY7sq/VRcsD
         nzHYhREYDBathE3q+RxNVWJqrvU3YJlavuQLH/NDDcH4ahoJbEpdVZ9Jhhr3FIK1BFNJ
         du5faBitP3m/VmY6ck9Y+Lz4Ss80QuKmqMOqZ0hEyHxGuLTYITZGcRuaevdRsx995ef5
         dEr8eK3yAlvt00XwG1rV7K1JRtXkQSh+9mM6o/vEVofRSIluu6DlwWjv6x0SRnPkpfT0
         wAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jvv1Il63pqr+o8Mt1wsoo+DLVGyebTBoMBLmuaM2+hU=;
        b=LhYepqMahw2ee35y11sk1tj2ewAwuGXDB6vZv5Tj76hyc7WDWG4Xc1lOnld+q8pavT
         yQBFUg44fOAw4huAXWdrGgD3kpGN56L/JiU2gteSkjx6by5MG0BN6CGDKQZS9/MmINaO
         2JCxS8XKy8DYeA55SfGVzDDXN/uBAi7FALgNtPB25nrFzEmi7l03qky7b8bwTE4PNKga
         1ENWzdHpasqIMWM0Ke8usKho0UoODfzYTYlW5b0cix30HhMp/CbF0rflU2IAWdKLIKEA
         A6vyqVlh0k60cLs8U1uRk7DB8wkPB700tHjt6hgjjaJa1CqTnMGX916AQkV0KSKJsh9Q
         WI6g==
X-Gm-Message-State: AOAM530LES8eZpw5rFpf64Q8XjX9JhTUgwRVS8hbKyQtXLmGwDuTCxvR
        izDSg9aFRrXen8qJsdUV3X/Na+kUSD6reQ==
X-Google-Smtp-Source: ABdhPJw0rIRtFdqRWHW5UxfzlD5y2JSxVtmpF4318qaxNemMexW2y7Zdd9/y+XYorsOSWEA2B5HSgw==
X-Received: by 2002:a05:6402:57:: with SMTP id f23mr5015350edu.323.1615195001742;
        Mon, 08 Mar 2021 01:16:41 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mc2sm6151603ejb.115.2021.03.08.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:16:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 00/22] fsck: API improvements
References: <20210218105840.11989-1-avarab@gmail.com>
 <20210306110439.27694-1-avarab@gmail.com>
 <xmqqtupm7ehd.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqtupm7ehd.fsf@gitster.c.googlers.com>
Date:   Mon, 08 Mar 2021 10:16:40 +0100
Message-ID: <87im62j98n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Now that jt/transfer-fsck-across-packs has been merged to master
>> here's a re-roll of v1[1]+v2[2] of this series.
>
> It unfortunately is not a good time to review or helping any work on
> this series, as the base topic introduced an unpleasant regression
> and needs to either probably gain a band-aid (or reverted in the
> worst case); of course, it would be appreciated to help resolve the
> issues on that topic ;-)

I should have mentioned: I saw the bug & proposed fix thread for that.
I see that 2aec3bc4b64 (fetch-pack: do not mix --pack_header and
packfile uri, 2021-03-04) down into next is now merged down to next.

My reading of that thread is that the reported bug is solved, but
perhaps we're not 100% happy with the solution?

In any case, that patch does not conflict with this series, and all
tests pass with/without the two merged together.

I don't forese an issue with the two stepping on each other's toes,
since I'm just modifying the rather low-level fsck interface of spewing
out .gitmodules entries, not touching the logic of what's then done with
that information...


