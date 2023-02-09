Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F5FC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 19:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBITnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 14:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBITnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 14:43:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898601B547
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 11:43:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id o8so1694916pls.11
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckNHYIyRd4yL+hGLZhIGlXkVLCVHiUhW+MMTAUePBlc=;
        b=j1Oi2Sq3AwuVHBs/7iVE3ijZ3tK6kMlC13eOU1MmoZBmgULMz6DYJqwiBObLkj/8cJ
         BGhXsbjPFz0+kD6bjdGB8G9hehs5Ggemaa3sF3lmY5luk0GQUMcu7RUJCky4iizainaV
         9dfk1BGJJUmFwu28wlwdRwlXWwX7bBbNjLgimeSnExWNWG4VwY6pQZQfEegPutRNdhjw
         pjrPEtImTxi1k8YWLjdJoMNemRVuQ1F0ITnatb1fskYVEI8nSVuVP9CDD76XiF3TAZR1
         FwVp3W6XtnIyC7eLE1GM+dqOMwKHE2UtEM60gl+NuSZ1SDgknW4idLDK4i2eeQYXSFdc
         zkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckNHYIyRd4yL+hGLZhIGlXkVLCVHiUhW+MMTAUePBlc=;
        b=GBC1/SCtBitpFvH8stBbpG/KA8hPLPo1uPezAF2oO8GgsR0SZZTZmFifHtnRGVIlMi
         0LgFm9USo5mWtnF6ThjjYeKyY6AMLMFUlVAG0YbjmiQBcF18dX2tzszdRAwKLBHkOmpA
         /DGPLzU7riOniLfDMey6NN1ZqtXrMrZ1n6uLnPrEGitEdtbDtauxqtydVaerzyBSP0Bi
         u+Z07OjZQMx6wS5BnIdq/3Ou/fYArYM/4spB/3F+rLXNJeIRthgipQwlw4pMN+N8CCJQ
         AwukQfGhqnWS1Qg3qIqyU2McElO9+m3/c6NgCB1btCPPOzmNRnowNDAeELTeSt3fcsxl
         yiOg==
X-Gm-Message-State: AO0yUKVnkTwAPrmQmYyVoAySADYQgJRe4vUxB6/QotBUYavg3PC9+E2t
        ICoIdBWCetBck+BoCSpNhc0yOYFmOFQ=
X-Google-Smtp-Source: AK7set8YrTDjAXbqfcqXG/A1UeERCvHQgxpaD21FYCYjl8x5fv8pXZmkpvcSEOnl1NgIZGEqdiOF4g==
X-Received: by 2002:a17:90b:4b43:b0:232:d2c5:2fd2 with SMTP id mi3-20020a17090b4b4300b00232d2c52fd2mr3490555pjb.2.1675971783912;
        Thu, 09 Feb 2023 11:43:03 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a4d8200b00230b8402760sm3666466pjh.38.2023.02.09.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:43:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
        <xmqqedr0vd1l.fsf@gitster.g>
        <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
        <Y+POCxHMzrZj2bwz@coredump.intra.peff.net>
        <xmqq357gt5s9.fsf@gitster.g>
        <Y+Tx3Z45SlMJqDfh@coredump.intra.peff.net>
Date:   Thu, 09 Feb 2023 11:43:02 -0800
In-Reply-To: <Y+Tx3Z45SlMJqDfh@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Feb 2023 08:15:09 -0500")
Message-ID: <xmqq357eocah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I would not recommend sending over regex as protocol capability the
>> same way as ref-prefix works, unless we adopt something that can
>> match linear-time like re2 and use it everywhere, as you can send a
>> pattern that is deliberately made inefficient to inconvenience the
>> other side.
>
> Yeah, I should not even have mentioned regex. It was really meant as "if
> you really wanted to go wild, you could do something as crazy as
> regexes".

The cautionary comment wasn't meant for you (you know I know you
better than that by now) but was primarily to deter those who are
reading from sidelines from going wild for "low hanging fruit".

Unlike normal desktop features, a feature that can easily be abused
for DoS cannot be initially built in a way that is inefficient, with
a hope that we will iterate and improve over time, until which time
we ship it labeled as "experimental".

> But I would hold off on all of that until somebody has a concrete case
> that shows why their preferred matching scheme is useful.

True, too.

Thanks.
