Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78AC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87CC22B4E
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcI4p3LM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHCSUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgHCSUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:20:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B2FC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:20:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j21so1721661pgi.9
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z37/DB9/GzwizXn0Ny5Fj4MPnWPjarY61NmLy1u2v1c=;
        b=fcI4p3LMSoWz5nYAtm/78F/xJi13nIaVfGT18kzEOW4C5XHnf4P03re1/+s+32NxVr
         XtnEQteBjTSZPdV2HQhWicb61nflCG2DRMm+XHvSpfjdVA0PinbM4CbMXvgN6Oiugq2+
         srZnKPBkNABy/lgJPj9VzuSQmCntpeGkOY8iC+UTjPOIW1qTERimxAeKT+gI86ac0zYm
         /zB16vB/NH+erMKhsmeJF5vCcWdf+mSargQp12hh6cRB5UQc6NfaL7gfvg6qzmRUTmeB
         6y4yJFBUhNzVpooq7gAKhduLmZDxHn2M3ddxH/8EFpnxUgRzkaac3XL/rlSackyje05m
         Pzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z37/DB9/GzwizXn0Ny5Fj4MPnWPjarY61NmLy1u2v1c=;
        b=S8LOTvqRZ2x4OycgJoPgq0rDBYq3h6P8bervsgn8fl8TtrGA1ws2Abnt6AF5MmkVRz
         xVpEXWW+xJe1nO5Ghx3nC9TrOUPzVubqp1JCReRbX+5ldncflVS+/E0Fh2ZNZag5GniR
         jXrSPgJXjo7RDXU4pcVDSB2/ercJjCHAU6l5P6AqhsqV4FgmzqaCpgqTvxJCP8bO/eFk
         OFokoMueHA1Ozaz9QbzcEnZjMIOg4mtQra2QP/Z8FXUWNaiMskH6CRveHSEaNkMEZ5mA
         PULLTcuVUwwky0NIskRf7wtopdXP97yvyZl7cZAajjufdROh4Kq9xpCxhoBHZVvu5DrD
         YI4w==
X-Gm-Message-State: AOAM533MS2XT6VMa5GF/MZ/GpOyJMM9Ip8RIX6/RJcbHI6RZsP7KbkO6
        CQxaGN7Ahj8HL+pE35kxwji2LdF4
X-Google-Smtp-Source: ABdhPJyz/2QKSbU4ZvfroE7nXWWewuUceAMoIA5IGvQ/BMaXxXdr/Mf6i5GvXQePatVnmLcGGbNdIA==
X-Received: by 2002:a62:be02:: with SMTP id l2mr16437163pff.163.1596478832511;
        Mon, 03 Aug 2020 11:20:32 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.129.72])
        by smtp.gmail.com with ESMTPSA id x9sm20262578pff.145.2020.08.03.11.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 11:20:32 -0700 (PDT)
Subject: Re: Renaming the "master" branch without breaking existing clones
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
 <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <c014fe87-9663-3ff4-9527-bf60ff30d0d9@gmail.com>
Date:   Mon, 3 Aug 2020 23:50:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03-08-2020 21:44, Junio C Hamano wrote:
> 
> If we wanted to do this properly, I'd imagine we'd need to add a
> mechanism for repositories to convey "this branch that used to exist
> got renamed to this other name", not specifically for any "special"
> branch name (like 'master').  If we plan to never allow reusing the
> old and banned name, it probably is enough to turn the old name into
> a symbolic ref that points at the new name, e.g. in my repository
> 
>     $ git update-ref refs/heads/seen refs/heads/pu
>     $ git update-ref -d refs/heads/pu
>     $ git symbolic-ref refs/heads/pu refs/heads/seen
> 
> which would create a symbolic reference 'pu' that points at 'seen'
> to say "pu used to exist but it is now seen".
> 
> But that would not work well, as we must allow reusing the old name,
> as the primary point of renaming 'pu' to 'seen' in this project was
> so that we can accept topics from contributors whose anglicized name
> has 'p' and 'u' in capital letters as pu/$topicname branches.  Having
> a symbolic ref 'pu' would defeat that plan.
> 

Of course. Though, having a symbolic ref of 'pu/seen' to 'seen' would
hopefully not defeat the plan while being a little helpful ;)

Sharing a thing that just crossed my mind while reading this.

-- 
Sivaraam
