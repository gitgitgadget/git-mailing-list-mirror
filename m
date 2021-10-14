Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E0C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3961152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhJNRa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbhJNRa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:30:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90414C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:28:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so21771067wrg.5
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Rh5ZZVgIekExaab6Bbz/bsQ/RcRy38EPfxw5o67KZOs=;
        b=V7YwqQv/sXdS10guB23ME/aZvYgfBuWfQ6gPqEhWxzcnR2E9Nz9kyUmsHIBqPgxheO
         VWtfqKQm7HGRVfWkFrSaqh3e1jHH3jhggFZcz9dIv4O58M0vkZNyMIhLWmLU/4hmjynG
         Pgx3zk+D3rIsbhutpWZuMX+NHbxQVmMShjXXq0YKfkgYU8wxAgqjN+KF74pBsEiE0R3y
         KMFtHDPRRTKmoPS4ni2BGQCxGYAfGzfPB7EHJ4ARQIExcwvTLVCUDayLFuxfqnMKFSOr
         cfa1gm27saExzfrWfq5WsH9lm51SzKBFvj0aevyrqaa4Vvyh8S0jRuXGDbZWrpAL/ULS
         aG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Rh5ZZVgIekExaab6Bbz/bsQ/RcRy38EPfxw5o67KZOs=;
        b=Jp9kzW3KLe+M1WX/dRxi7zapSnGfjKbOYmvTRqZGfPtdrYnZM091do6XAtIWf82tAJ
         jo9h9JM63DoB4InY+dSKodvzRqsmc87ChZBOlRHOAhHIXV4ANXm3G5aa4lBkYWf0kS8N
         r9HtPXgWajRD7ZpvNbnSF5H2IhcA9Iz8TpOT9MBCqra9x+0RPSSjQ2vGxa76nzFeW2hu
         7kdFRpjg7EocIaWD5UYVFJ0iVv5/8F53FVg6KvVlcykJ2wXq9UfnYTEuNa6QFrldqM+u
         tQt49DzB4o7AejGE2ARKum47+kKqTF+NRDK7cy57yq+erhie8ccrSwMUWtoL3OTXGn1W
         ZFTg==
X-Gm-Message-State: AOAM532Isj969EOnMbr/aj3A1y1uSN4ovH9qnc0qJ1aHw3F/I4NVz+kN
        JgmCO6o0UZJoq0371y9jmAc=
X-Google-Smtp-Source: ABdhPJwLVC7N5uq+KJxLrkoOf4etQD5YNEzQ2WhH4q9jZDhTajM7SKYdtrvB1sGi0Ye5P4Ly7AcrdA==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr8205631wrq.300.1634232502067;
        Thu, 14 Oct 2021 10:28:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j16sm2840878wms.16.2021.10.14.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:28:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] test-lib.sh: use "Bail out!" syntax on bad
 SANITIZE=leak use
Date:   Thu, 14 Oct 2021 19:25:30 +0200
References: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
 <patch-2.2-6fd2a64bcfa-20211014T004542Z-avarab@gmail.com>
 <xmqqsfx3d0i3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqsfx3d0i3.fsf@gitster.g>
Message-ID: <87v91zfrd7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 14 2021, Junio C Hamano wrote:

>> +BAIL_OUT () {
>> +	test $# -ne 1 && BUG "1 param"
>> +
>> +	# Do not change "Bail out! " string. It's part of TAP syntax:
>> +	# https://testanything.org/tap-specification.html
>> +	local bail_out="Bail out! "
>> +	local message="$1"
>> +
>> +	say_color error $bail_out "$message"
>> +	_error_exit
>> +}
>
> This looks like a good addition that can be used in similar cases
> later.  I'd assume that "Bail out!" early of a test sequence will
> mark the test suite as a failure as a whole, but I wonder if there
> is a similar "early abort" mechanism that would cause a success?  In
> some tests we do
>
> 	if .. some condition ..
> 	then
> 		test_done ;# because we cannot test the remainder
> 	fi
>
>         .. more tests ...
>
> and I've always thought the "done" an ugly hack.
>
> But that has nothing to do with the value of this change.
>
> Thanks.

That's:

    skip_all="reason"
    test_done

Which we could spell as:

    skip_all "reason"

Or whatever, if we wanted such a self-documenting helper.

There's no facility in TAP syntax to indicate in some special way that
you'd like to skip all remaining things once your test is already
running, the best you can do is just exit at that point.

I.e. the (very light amount of) special-ness (such as it is) is that if
the very first line of the output is "1..0 skip [...]" progarms like
"prove" will emit the skip summary as part of the output. See DIRECTIVES
at https://testanything.org/tap-specification.html
