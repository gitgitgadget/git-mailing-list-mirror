Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9872C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 08:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBGINB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 03:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGINA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 03:13:00 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D71274A1
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 00:12:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so5419726edb.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLlzg9VA1y9WzxqHNmyCVCRjeSNslIpLmTL2GK7Ma9E=;
        b=HeWzyjgg9cRbXc90f14v01ZSVv62cJ/RPPAf9YpaeQUTV8YJvt2DEPNRX3qSh7mQOP
         AZN0w+JPyASxU6zk3MoSRMztW0kg67g9Pi00/OOm7u7Aj6CnjpdGND1RZo1Jnj6vd4pt
         Ox+0PPYxhZ9yp872/8WB6b9XSCibr5dwgK3UyTMxaDWuNq6bS1ILGd+xgTIFErFNW4QZ
         rX857D20CaArYKtd39lUbAP1w6RMWvBRUEixm15oiH5Y1i8XnC+9qldRpRLSvN7eFDvZ
         I0ZTcVhWJaYIUCp+m509HqzyeGK+AU23huYoWwKrqjDo/ptLMMdPW0N1hFO7/nmXSGu4
         i7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLlzg9VA1y9WzxqHNmyCVCRjeSNslIpLmTL2GK7Ma9E=;
        b=TMmD99J+0gmwnB+kxfLxywL/4v5o3mwRM1UQ+DHwjC7mMyIh6pImYTETa2DYY2SgLu
         6hJ45gu2r0F/RkgHD2cwJREcofBZ7XVsQaDglqH+k48FoVjmL6e+NvsTJ5tNH6GQuQED
         v4vtHlJM2nMRHYyviaYcdts/GYc8VhpPnV2T+4Oi9YYkTHajfNuipX6Jmieox8pDsKnO
         n+CbDTEBalVuBuDFfTCU0wNMX5myH8SX3wyZlgQjFKQ7gXg/gwCfOKiIHIHbcO4MTbB2
         x9DqGqi8ilPS783C4qRXws4sfkGqG0Cnd7pSkX/Yz7H6B5lkL69DdtFgbk1gKNnW/DNT
         resQ==
X-Gm-Message-State: AO0yUKUebtjnzX14cM93Why8JVTemKvYzd09sS6p0128WPMQIOKj/M6J
        BJvaZO6G5ZMy7KmEbREy5b4b1gDLBJ3QR3Hr
X-Google-Smtp-Source: AK7set9k1TKnqUwpGGivmbI9ZTkF798VI4gb0hOOqaCjVROHfST6Bc09E+JDSVuK3ASiRwKB6BhLIA==
X-Received: by 2002:a50:cd88:0:b0:4aa:a1d4:bbd4 with SMTP id p8-20020a50cd88000000b004aaa1d4bbd4mr2540275edi.42.1675757577921;
        Tue, 07 Feb 2023 00:12:57 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id f28-20020a50a6dc000000b004aaa6a948fcsm3414558edc.37.2023.02.07.00.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:12:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPJ60-000ctE-2s;
        Tue, 07 Feb 2023 09:12:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
Date:   Tue, 07 Feb 2023 09:05:34 +0100
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com>
Message-ID: <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Shuqi Liang wrote:

> On Mon, Feb 6, 2023 at 5:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> Have you run the resulting test?
>
> My apologies for not testing after V1. That was a major oversight on
> my part.  I'll make sure to thoroughly test before each submission to
> avoid any issues with the code in the future.
>
>
>> This creates a "test-patch" file with lines 'a' and 'b' that are
>> common context lines without any whitespace before them, no?  The
>> original left the necessary single space in front of them (see the
>> line removed above).
>
> I try to change the code to(left the necessary single space in front
> of 'a' and 'b':
>
> diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
> index ab5ecaab7f..ef61a3187c 100755
> --- a/t/t4113-apply-ending.sh
> +++ b/t/t4113-apply-ending.sh
> @@ -14,8 +14,8 @@ test_expect_success setup '
> --- a/file
> +++ b/file
> @@ -1,2 +1,3 @@
> - a
> - b
> + a
> + b
> +c
> EOF
>
> Here I only show one part ,but I fix two same issue in the V4 patch
> and it still can not pass the test .
> It say :
>
> Test Summary Report
>
> -------------------
>
> t4113-apply-ending.sh (Wstat: 256 Tests: 0 Failed: 0)
>
>   Non-zero exit status: 1
>
>   Parse errors: No plan found in TAP output
>
> Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.05 cusr
> 0.02 csys =  0.09 CPU)
>
> Result: FAIL.
>
> I'm stumped as to why it's still failing. I've tried searching for
> answers on StackOverflow, but I still can't figure it out.
> ----------------
> Thanks,
> Shuqi

The error doesn't tell us much, instead of "make prove" or "prove
<name>" running e.g.:

	./t4113-apply-ending.sh -vixd

Gives you better output.

But this is almost certainly that you're trying to insert leading
whitespace into a line that's in a <<-EOF here-doc, the "-" part of that
means that your leading whitespace is being stripped.

A typical idiom for that is have a marker for the start of line, and
strip the whitespace with "sed". See this for existing examples:

	git grep 'sed.*\^.*>.*EOF'
