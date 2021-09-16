Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C2C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 09:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B080611C4
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 09:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhIPJvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbhIPJv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 05:51:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F65C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 02:50:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b18so14949440lfb.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JndR8XQqjTLqmEDS1ou8TAEknGTh/PoTmczPo6z0bj0=;
        b=WO0tHDZLgIJ0WEZXEwjBT/KkTyN3iMXuVlgw4FF66ClxPnRjw5IJGKleTqO9XYpiVu
         /B5yQ0bzto4HAAM7I1L4al3CSDFwCeornEExN79uOxdLn7/X80j4pb32Wt/mLYUHEG8H
         BEFc761hoLV5vvtGNSNBUgQzxSqiuI1cE/CZcZA33T5m/fbLepSqTghbngSwgkllB2H9
         yhAeeBLhTphk0YoIyQwkbKm+Pu2/VxLykmNk1cattsoYupPgKf7ubs5HjLGfAeSC9drZ
         qTAEivv1QjddqAoWzdi5JkXURmFIBH+qoKKwU4SQlk819D6Lg47OlJHcn+oIe8b4CYma
         R4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=JndR8XQqjTLqmEDS1ou8TAEknGTh/PoTmczPo6z0bj0=;
        b=rGljfIWR8Xm/MQIDEcKCpj3vzxopEtmgwAYZ6CgyjOmmMj1ZZVbkpf9lfXHBcZZOWi
         pspRheVDWKmCo8h08JCyP1bVMQH2VbsKzAvMKnqqpN6GBKI0dmfb1rh0G4n3M+wlieuG
         N9Womrfl0DfFzqL5mCqaGjUnqVpUTxGFuso52gmgNULTtA4k+JNtWKGqMUUL4E0D2X0P
         VrokJglj0TTHABVAulDoL0oIoP0QJEJM+G7ctB7vDvmetwJ3TZ6mKBwpNyPHWbgqJjIx
         mpbiodvgrZLXZ4es6qWe1W5WKUyAQQ+d52QS+yeg9iMz5jpCd8A9dq5VzreI1AdtLXQD
         cvaQ==
X-Gm-Message-State: AOAM53380eJGyfNsHEdwBNJDPOFU5oUCwvY5Mtv7dGpekGq0Yd0pILU0
        bCsZbJc9N/4yVcTgVo0pOO+tj6ccbo4=
X-Google-Smtp-Source: ABdhPJyVlYBk9zdn45w8vY2RWxxqdO43xtjqKmFxpuKedkWDR3N/vI6Ek6M5EF8EQvwjK0mTG/B7zg==
X-Received: by 2002:a05:6512:16a9:: with SMTP id bu41mr3432412lfb.41.1631785803839;
        Thu, 16 Sep 2021 02:50:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b17sm298505ljj.35.2021.09.16.02.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 02:50:03 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru>
Date:   Thu, 16 Sep 2021 12:50:02 +0300
In-Reply-To: <87pmtjkwsj.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        08 Sep 2021 16:43:24 +0300")
Message-ID: <87sfy497ed.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Here is a patch that fixes diff-index to accept --cc again:
>>
>> Sorry for the delay; I did not notice there was a patch buried in a
>> discussion thread.
>>
>> We might later need to do this suppression in more codepaths if we
>> find more regressions, but let's have one fix at a time.
>
> I'm pretty positive there should be nothing left. This commit was
> diff-index specific, and doesn't affect anything else. Nowhere in entire
> series the semantics of --cc itself has been changed, it has been only
> disabled as particular option in diff-index command-line parsing.
> Overall, this is pretty local change.

I'm afraid this issue is left up in the air after application of the
fix-up patch, as usage of --cc in the diff-index is still undocumented.
I.e., the fix-up just restores the historical status quo that has a
problem by itself.

As current documentation of --cc elsewhere does not seem to be even
suitable for diff-index, I don't feel like providing corresponding patch
for the documentation, even less so as I still have no idea if current
behavior is intended or accidental, and if it's the latter, do we need
to keep or somehow fix it? Anybody?

Thanks,
-- Sergey Organov
