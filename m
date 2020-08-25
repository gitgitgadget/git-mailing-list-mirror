Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CBDC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0B42075E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 12:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXT5IBSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgHYMSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgHYMSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 08:18:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E527C061755
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 05:18:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so13504920ljo.12
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0XQXkGuSqf4gLj1JQSzHjM9pv61PaDOrrJu0jFNLnp8=;
        b=VXT5IBSl79LqYcNI95CMMJO8Xac++0M6xXMs3EtsCoVsra2rHWGyTarl05n/FTWYBj
         gXnzK6DX3Pi8fBKz1SO/djxUgykIX0C2zpQZIuyRZehhGk6qrLSYE2zP33zYFAmjB6Sl
         TCua8NzK1cdrZd3ZUhVceXGf9a7SMxSBDVQSizw6e4+hLQX/BvXLs9JPwc2b151co0Tg
         yWpCiL36io0CZHI4Ap9PrJmXJEexARk0kvVsTdY/7YFZ3DCxlP0i03hMFKOpTYe25n78
         UQsq4vUNk/rjvVgsXfIBrXV896eUJSeGokBsZIvMy1xlddbb9vuSGpQ3Tbty9ZgiZUT1
         TzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0XQXkGuSqf4gLj1JQSzHjM9pv61PaDOrrJu0jFNLnp8=;
        b=IIbtrbW2QZwXRLztYb/WzxlS5rtcf+gklg+fPf0lAuYmPHct3ocGrWrf5U1S2bVBOl
         Um25BO6nIXQ70F4qOjQFFVzIfyYG4OS/mE2kSxbfWXmWsq+vgRjBEYiDzf0vxtFlfNM1
         vX1kJ18zCvkXUP1t0Yhv5VEOt8i4q32dNjPvZWaYjtavZK+M0UljLs54yDEVLoG/HJFS
         6z3vx41Ut5d6dJFXrVShg0x730uUa91VAPncQIe/yuEUNnI4kLuQs9EuCfh3W4iSZ5qp
         ey5FXBLyQTQWpRkqUovfMK5rHcbB5NIIDH/GXtcvnMF13Cz8KAEBOBJNP3G1oeqPt03n
         aG8Q==
X-Gm-Message-State: AOAM530XvTVdul63ZPVYeaVun7VtXjKC5wVO1WBm9jhlIpgSzkJzaTZB
        8Z7UGOmHxUsTqsCkw9chf0GTWRDgn+9iKQ==
X-Google-Smtp-Source: ABdhPJzGf+9mri75D4O/PRGWisVq0tRim59tC/LtNE6NDq7y1JKqf0e5MfeZ0POg+LaQHOvLrvFX7g==
X-Received: by 2002:a2e:90e:: with SMTP id 14mr4966535ljj.293.1598357906449;
        Tue, 25 Aug 2020 05:18:26 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id j17sm2964328lfr.32.2020.08.25.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:18:25 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     85d03km98l.fsf@gmail.com, git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
        <85d03km98l.fsf@gmail.com> <20200825050448.GA21012@Abhishek-Arch>
Date:   Tue, 25 Aug 2020 14:18:24 +0200
In-Reply-To: <20200825050448.GA21012@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 25 Aug 2020 10:34:48 +0530")
Message-ID: <85ft8adilr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Fri, Aug 21, 2020 at 03:14:34PM +0200, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>>
>>> In a preparatory step, let's return timestamp_t values from
>>> commit_graph_generation(), use timestamp_t for local variables
>>
>> All right, this is all good.
>>
>>> and define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.
>>
>> This needs more detailed examination.  There are two similar constants,
>> GENERATION_NUMBER_INFINITY and GENERATION_NUMBER_MAX.  The former is
>> used for newest commits outside the commit-graph, while the latter is
>> maximum number that commits in the commit-graph can have (because of the
>> storage limitations).  We therefore need GENERATION_NUMBER_INFINITY
>> to be larger than GENERATION_NUMBER_MAX, and it is (and was).
>>
>> The GENERATION_NUMBER_INFINITY is because of the above requirement
>> traditionally taken as maximum value that can be represented in the data
>> type used to store commit's generation number _in memory_, but it can be
>> less.  For timestamp_t the maximum value that can be represented
>> is (2 ^ 63 - 1).
>>
>> All right then.
>
> Related to this, by the end of this series we are using
> GENERATION_NUMBER_MAX in just one place - compute_generation_numbers()
> to make sure the topological levels fit within 30 bits.
>
> Would it be more appropriate to rename GENERATION_NUMBER_MAX to
> GENERATION_NUMBER_V1_MAX (along the lines of
> GENERATION_NUMBER_V2_OFFSET_MAX)  to correctly describe that is a
> limit on topological levels, rather than generation number value?

Yes, I think that at the end of this patch series we should be using
GENERATION_NUMBER_V1_MAX and GENERATION_NUMBER_V2_OFFSET_MAX to describe
storage limits, and GENERATION_NUMBER_INFINITY (the latter as generation
number value for commits not in graph).

We need to ensure that both GENERATION_NUMBER_V1_MAX and
GENERATION_NUMBER_V2_OFFSET_MAX are smaller than
GENERATION_NUMBER_INFINITY.


However, as I wrote, handling GENERATION_NUMBER_V2_OFFSET_MAX is
difficult.  As far as I can see, we can choose one of the *three*
solutions (the third one is _new_):

a. store 64-bit corrected commit date in the GDAT chunk
   all possible values are able to be stored, no need for
   GENERATION_NUMBER_V2_MAX,

b. store 32-bit corrected commit date offset in the GDAT chunk,
   if its value is larger than GENERATION_NUMBER_V2_OFFSET_MAX,
   do not write GDAT chunk at all (like for backward compatibility
   with mixed-version chains of split commit-graph layers),

c. store 32-bit corrected commit date offset in the GDAT chunk,
   using some kind of overflow handling scheme; for example if
   the most significant bit of 32-bit value is 1, then the
   rest 31-bits are position in GDOV chunk, which uses 64-bit
   to store those corrected commit date offsets that do not
   fit in 32 bits.

This type of schema is used in other places in Git code, if I remember
it correctly.

>> The commit message says nothing about the new symbolic constant
>> GENERATION_NUMBER_V1_INFINITY, though.
>>
>> I'm not sure it is even needed (see comments below).
>
> Yes, you are correct. I tried it out with your suggestions and it wasn't
> really needed.
>
> Thanks for catching this!

Mistakes can happen when changig how the series is split into commits.

Best,
--=20
Jakub Nar=C4=99bski
