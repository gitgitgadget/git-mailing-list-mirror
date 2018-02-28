Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56F21F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeB1VG5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:06:57 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55501 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932651AbeB1VG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:06:56 -0500
Received: by mail-wm0-f66.google.com with SMTP id q83so7668839wme.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vurrKIggyKRBR+jpL5dpFKjKYkntvUF9erbFFNErBek=;
        b=b8PGulOAxSf6/bNYay2XBeWS2WpCzR3Jgx6k+KoeatMn0xzWPqP3cop1pwj3U49UJf
         XHyhMNN3kcQ+v3alfeSIp03dLxsNC6IRQQUhehfAYSGOinBQHLyBHIf35borjaFyoPVH
         2xT6TOtVM0u14CRMJ465khHqHCM9ptRrlk6BhiIKReTkC15qEekMUv89QoLpNj9vxh02
         /EvtGOCVOLgk8z+xpVgtSYEEo6TYvPToXEOJ3g+o12x2qye8TKJJoPW/ph1RTTeJH0+s
         3hHSu0EIbvnEYDyP0xKY3LREPXk3UQDHkOP6RDGIhCNVrqOEM7r8ZjoEgP1kEGNqJDsY
         1syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vurrKIggyKRBR+jpL5dpFKjKYkntvUF9erbFFNErBek=;
        b=JoafcnJ4iajyXUH3JG/L6bI+ru/IScU3lh1LGPbRLD1W4FhbXIC+u30tfCKJkIUB/8
         gLT7ROpN0o7OoKvxWl4PFpD8QcKgzelvFp9Oo4lTI5LSISTUuOG7wi+Gf5g9vg2dG8T4
         k6p1ufpXJghUZhAa07ByIVHJVHDMGqBPQrX175Mbr6ad3V5LV59pJT0rCEPwuLWB3Ziq
         Yi4DkfaYgsxi94VkwVCWZ1KRa4ShN2LQipwg450PT3efDW0HWLGwp+0qxMpSRyPSuiVh
         0x6v3lrx+0kUJPImxVyy+1N+rILva1uS2ICesaVhy7y8ZR4zBEPTxot62onFM4Ky4JIF
         dWhQ==
X-Gm-Message-State: APf1xPCMayjJgzTfnTuPx/m2BfDlUvfDzhGk6VArGojjFQzAdHnQu7rw
        A94mK76fLOZcD0rwXsEH0Vg=
X-Google-Smtp-Source: AG47ELv9XJ03IXLDQQkPi71KFun/SQVcQgl7RdBt+VPxFkCw5VwyK76FauwQbeOyX7YeSWa2YCb0xw==
X-Received: by 10.28.13.136 with SMTP id 130mr8822069wmn.123.1519852015287;
        Wed, 28 Feb 2018 13:06:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c56sm4687198wrc.82.2018.02.28.13.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 13:06:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        peff@peff.net, christian.couder@gmail.com
Subject: Re: [PATCH v2] sha1_name: fix uninitialized memory errors
References: <20180226204151.GA12598@sigill.intra.peff.net>
        <20180227114704.193145-1-dstolee@microsoft.com>
        <xmqqy3jckfe3.fsf@gitster-ct.c.googlers.com>
        <ce8421bb-4519-c4e5-ff0a-98ae532d764b@gmail.com>
Date:   Wed, 28 Feb 2018 13:06:54 -0800
In-Reply-To: <ce8421bb-4519-c4e5-ff0a-98ae532d764b@gmail.com> (Derrick
        Stolee's message of "Wed, 28 Feb 2018 15:57:26 -0500")
Message-ID: <xmqqr2p4kemp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> I do not think they are wrong, but aren't the latter two somewhat
>> redundant?  "num" is p->num_objects, and we call (first+1)th element
>> only after we see (first < num - 1), i.e. first+1 < num, and the
>> access to (first-1)th is done only when first > 0.  The first one,
>> i.e. when first points at where we _would_ find it if it existed,
>> can access "first" that could be p->num_objects, so the change there
>> makes sense, though.
>
> Yes. But I'd rather keep the blocks consistent and use the return
> value of nth_packed_object_oid() when possible.

Sure, I do not think anybody minds; I just wanted a sanity check.

Thansk.
