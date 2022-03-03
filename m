Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E2C433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiCCPsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiCCPsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 10:48:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650961965CE
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 07:47:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so11547638ejc.7
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kZsaTZY1uS4Rgov/nlWCQi+4ake4TDnyde353FWfzA4=;
        b=ezOGEXfZZZFzeBVY1m1wo9ZEdRfUhcrTdaBOw2mdTRT2kH9PRqMq1LsvBtr6QaYSmm
         tVSB9/evlxhMIG5dL/Be9YsLzN4ReMUi32AEw/9DWAQa6eESC3okDcz+0qdNT02FmsFY
         dz5RoYa0SgqacRL+tV3jdlhqEGbBA/zsE2fot6NZIAQ1RRf06nSgoxaCO3oR8pRHIqyC
         HfFvb+eJ6JS0U3gCMibVIR6DVnceNaWgV2S53AfKSxSKkMPc8vhNr8wjTVR0f7L+Eb2n
         OpXtOxhyjsMvAwRx8CuZh3J2oH5Rngw0H8r9TQdurQ9+JiFY3GGxcDEgx9cR+iJKrEuj
         DA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kZsaTZY1uS4Rgov/nlWCQi+4ake4TDnyde353FWfzA4=;
        b=ybec7sH9bJgdLrLkR2acTN39fTjxTET4nIGxFhg39y5M7Mtiqu/h+3U/38GIvfZrJc
         bm36vMZH3cLvYJJ6XILfVsX/ih8GztQpITT+uNOiN140Wv4f2T2dRGJV9h1ls29DpFqw
         P+PqmideoagTyVMO6CcKCGVHJsIK+dTGwb1V7VLHk3xG9Je4VVtqe5eCsEj9De6gPT9H
         KnFHMum2NA9aBYIkkCcBMQX4mPlrhG9jGVAMByDPdW0HEoG6LGGER6OedJh4x9rs2B96
         7B6jQ8gFFxHw85odT6VU4u4EfF8Lc7NcDfJvN4qwuIqOUKRuk0wVNhUUjBlouuCxuq7W
         3Ufw==
X-Gm-Message-State: AOAM533N20cJMAyAmnO4QIzX35ILzc4x/NrHRzPaAGOOZYCY/CI9xZwy
        DRXeLTpwkIw/AT+71FDh1LY=
X-Google-Smtp-Source: ABdhPJxPdDxntwy3t7z7mEshDQk1qb0rVlLUMmMgazW+lrsfZgUXZhbHcoR48v/Y7Yy6lA+3LqwL5g==
X-Received: by 2002:a17:907:7618:b0:6cf:5756:26c4 with SMTP id jx24-20020a170907761800b006cf575626c4mr27524706ejc.492.1646322433692;
        Thu, 03 Mar 2022 07:47:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gj7-20020a170907740700b006cf57a6648esm804743ejc.90.2022.03.03.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:47:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPnfc-000bkL-KC;
        Thu, 03 Mar 2022 16:47:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 12/15] gettext tests: don't ignore "test-tool regex"
 exit code
Date:   Thu, 03 Mar 2022 16:46:22 +0100
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <patch-12.15-f3cc5bc7eb9-20220302T171755Z-avarab@gmail.com>
 <xmqq5yowgcvg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq5yowgcvg.fsf@gitster.g>
Message-ID: <220303.86zgm72g3j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -test_have_prereq GETTEXT_LOCALE &&
>> -test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE &&
>> -test_set_prereq REGEX_LOCALE
>> +test_expect_success GETTEXT_LOCALE 'setup REGEX_LOCALE prerequisite' '
>> +	if test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE
>> +	then
>> +		test_set_prereq REGEX_LOCALE
>
> This looks sensible but
>
>> +	else
>> +		test_must_fail test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE
>
> this side looks puzzling.  I think this way to avoid counting abort
> etc as passing "must fail" test would be the least bad that we can
> do.
>
> Nicely done.

Thanks. For the purposes of a re-roll I'll note this as a "nothing to
change", since the commit message explains why we're doing this, unless
you have comments on that explanation (the last paragraph of the commit
message).
