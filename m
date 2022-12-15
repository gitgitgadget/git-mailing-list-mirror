Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9A2C001B2
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 00:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLOANF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLOAMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 19:12:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37831C5D
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:07:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n3so5605121pfq.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIUWbM3MA79R7Se+tvb4F9Nh6wML6IMfT0fYTKhJxDE=;
        b=o5RCgtiiAdfDxJ1V0H+2Oq5vaw2ZbzbQnA9o+COaF0VelhP5mOxSq4f6S0Gu5cQ3Bv
         IpaChRC//BKU6/HhVEPBpudOTiE8b1TXM3E8mdt6nfncSqt6bqEOt2IeO0IpiNrAmI/n
         jfM9EeE+7v2rz42KnH4S0bDRLmotvuZLARrjPcL63HjyuhXOuMFZW7y0rcpep206ywAV
         K/j2vtt3zMT28gQsKkblkUAFxlMi6ALBWzh1s2MGePDbfJuYa0TEUHqgcxsEV06HYuoC
         PHFRDrarHDrcTsTPPtrfEkj07YwViF5hTssOI6rC4VABIoRC+CJtwXYxcG/67LrzUwZ2
         lxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jIUWbM3MA79R7Se+tvb4F9Nh6wML6IMfT0fYTKhJxDE=;
        b=vf4dk9G+O/Xf9zbsU23tJqv4oZn297BOF0ND0t4rEgqMb25O+JzVr7o11fisVlhe9u
         +2waO/pgL0CA0IZVQwtofV3NUWuRiVo+RAuvgPga2x7Zann5ZAU2FtZ6Lnws0li5qh+U
         ma/dbRqzlE+pkxHcpIvv5L28P7hIwmKosM3eqt6LVkiersu/EFIlUY7BP2qaLcO2GoWl
         L9543wPgOwbGRxkXDACczI5wFWoj+En0cC6qCQzZG6tU3rkyKuPau7bYjeQwP21dUp7K
         nYYvRnWr+5gdp0W40sn7hHPrYR2qEBu9ZpG90Vxi9koVjlLH8XwFvF/pXBLcQnK+TqQS
         i/sA==
X-Gm-Message-State: ANoB5pmNX3enqzRToiBlqjEBthxy2xrRuCnOPKu7TKLaBjhMKxr1X3gc
        IJBI/7znWM4C6+ykAs+oV1E=
X-Google-Smtp-Source: AA0mqf6324GyaPxxmRG9r1qbB7ENQrVf7tDNevBOrQN/a3K35PAEUuRjOx+xGKjrJluw/jrarDRySQ==
X-Received: by 2002:a05:6a00:a93:b0:56b:6c05:3da6 with SMTP id b19-20020a056a000a9300b0056b6c053da6mr34398989pfl.8.1671062847612;
        Wed, 14 Dec 2022 16:07:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d13-20020aa797ad000000b005742ee445fdsm415800pfq.70.2022.12.14.16.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:07:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Don't lazy-fetch commits when parsing them
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1671045259.git.jonathantanmy@google.com>
        <Y5o1d6f2cepf7Vp6@coredump.intra.peff.net>
Date:   Thu, 15 Dec 2022 09:07:26 +0900
In-Reply-To: <Y5o1d6f2cepf7Vp6@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 14 Dec 2022 15:43:35 -0500")
Message-ID: <xmqqy1r9ttq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Dec 14, 2022 at 11:17:39AM -0800, Jonathan Tan wrote:
>
>> Thanks everyone once again and sorry for the churn. Hopefully I got it
>> right this time.
>> 
>> open_loose_object() is documented to return the path of the object
>> we found, so I think we already have that covered (if we detect that
>> an object is corrupt, it follows that we would already have found the
>> object in the first place).
>
> This version looks good to me. Thanks for your persistence. :) I think
> the end result is very nicely done.

Yeah, this looks good.  Nothing added to or removed from the
previous round other than what I found questionable during the
review of that round.

Thanks, both.
