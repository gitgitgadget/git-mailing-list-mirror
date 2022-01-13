Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68169C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 12:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiAMM0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiAMM0h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 07:26:37 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575CC061757
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:26:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id k15so22261747edk.13
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 04:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pljxj+lDXo/QGviWls3e++lvUJ0pNXA5gkiHbHnuQwE=;
        b=kQChgwDQpu5vNmDPjhrx8X8KCnbUViZZqVwAL7PGc3Xobhdt1rDuymwWr/p/Qg4kqV
         re8jgyIjZjIFjWekr+TIIzqdC5mmntIJBjOW5y0yFnVdTuqusXihqxvVMYBpKkjDaku5
         tE1lebzvCB/9PCJyegJ2eLjl/vHp00G3cF25wr46wqw5rSwWMhqXh+IAgKAxAHGsoEXK
         rAdlCLvXABUBpjTUA7bKf8Mp36sPbQATGBccu2fJBu5Ev2LV92HK60G9ZzIC9UXCaimO
         bsWdHejvk4LWADxxSRYqhqceW1f1JGP6sTWemijqiM7Ko50TrQ2yq9OU3q8UPYbhwNMU
         jOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pljxj+lDXo/QGviWls3e++lvUJ0pNXA5gkiHbHnuQwE=;
        b=JUgaxSbgPySgD43Ox2aTAqbp4stxuDFY4b4wAR5i4U9hC6vhactj4CK0/R4Brkpvmi
         Or0athJwesmg9wttwd2qeJM+KfaKPaUDjJ9rXD32lN3vwCNxnDWDGNNaoneJpXxsPfN1
         GJUWqs12H47tq4VHMHrxaNBFE2GlwfaOyXhH9Z6M32PR9Z/4y0+VAcxk9UV1NTX8DY7K
         MC2+OdyKxLzXihW5Pxonxl3OPD8LY+kYR9dhTQNKUXQDt2Pc2A3NItcthn2xx+tH3jI2
         oJ0WzFYkAlXpShVVx6lag6nEhmFk4LkPKzM3MpBOpuq8ke/U+/Djgw/nACIyjDMyx+SJ
         ALQw==
X-Gm-Message-State: AOAM530Xh0jq1odVsOtlcmRPq/vi1KDJ2Z5ojAIynxTx/llVC4ORI9SC
        oL7S4QE8QhYR2o2FI3kUCpE=
X-Google-Smtp-Source: ABdhPJxXoFitik8FEtGb36UfCqhE4F9rp+AUIN4VZQQPohOF+wIH4+V2wCcE2MCQgD33lgckaCfI7w==
X-Received: by 2002:a17:907:d8e:: with SMTP id go14mr3386218ejc.694.1642076795805;
        Thu, 13 Jan 2022 04:26:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ga7sm826203ejc.50.2022.01.13.04.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 04:26:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7zBa-000uaa-TU;
        Thu, 13 Jan 2022 13:26:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 0/3] For v2.35.0: refs: ab/refs-errno-cleanup fixup +
 remove "failure_errno"
Date:   Thu, 13 Jan 2022 13:22:55 +0100
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
 <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
 <xmqqo84gu4sb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqo84gu4sb.fsf@gitster.g>
Message-ID: <220113.86lezjvn2d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This is a follow-up to the recently landed ab/refs-errno-cleanup
>> topic, I missed a spot and left some meaningless use of "errno" in the
>> refs (file) backend.
>
> Is it a fix "oops the ones we merged to 'master' were buggy and
> needs these on top to be correct"?
>
> If it is merely a follow-up "I am doing more of the same thing as we
> aimed to do in that topic", I'd rather leave it to the next cycle.
>
> I'll come back to the topic to find it out from the patches
> themselves, but after I dealt with other patches that are more
> clearly fix-ups first.

3/3 isn't needed for v2.35.0, but I figured if you were queuing this
that obvious cleanup after the also-not-strictly-needed 2/3 made sense.

But I can leave both of those until after the release if you'd like.

I think we should have 1/3 for 2.35.0 as rationalized in its commit
message. I.e. I haven't found a way for that omission in my ef18119dec8
to break things in practice, but I'm also not confident that I thought
through all the potential cases. Changing that code to be obviously
correct in terms of the current API is an easy enough fix.

So just let me know how you'd like to proceed. I.e. I can re-roll a v2
with just 1/3, but I think this v1 is also good-to-go as-is. Thanks!
