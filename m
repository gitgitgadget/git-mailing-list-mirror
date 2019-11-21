Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5177AC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F2C20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQQxDyHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKUISF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:18:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKUISE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 03:18:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2639836wmb.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 00:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jgaEzQcmL541LVfshRC8azUvZBLJ3YfJc8+FPiiuPKk=;
        b=cQQxDyHLk7z/MZcx6FY4f15Nd7CDIBvWyd3/w9D6yrGiVZ4zzT8AeiVuW8wQlw7epH
         voQMWkn18SYKE8tF0L9q7khY+APgd7ykSovaiDRteTcf5VTQm65kSe1EcBOcfFn5vAmy
         K+IYRdYG8U0R1jWZWPHIrH9m+1qn597Fw5Ag5W7SqRqXPtdqZoDs2Pa+wNajw9hbbf3D
         Re+eNCTBa/xWlmrISKiVlkthmsIlpwWZ8B+HVN0rTlu+/Rh9iWSvxPEzlc6fGIY5BNEE
         shZ9s/0W65N8eC3fPD6L6r6Qoj0wJB3ecUw6fNLjsFxCR0M1fNQWHbYR/ZYkMbFrq5Iw
         /evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jgaEzQcmL541LVfshRC8azUvZBLJ3YfJc8+FPiiuPKk=;
        b=FFzeIBJ/VrIG/qXUF/NC4U/tQBogVyqRY9uGIHsqLVCeMN05Obl0kva9RBUGJuHq3y
         OBUnZHJ8tdgJtFTosiyaiFXacGaF8io3HQyJ+ojYyJ/zh3XR6VXhkWqvlR5mMshY+Jvg
         aZJ03Sx6mJcqvws3NEFsMO9hrnMORzKKMJ8MPDweVf0iOw2f5gesbNDTd+zbIE/slq3z
         jDLzH61PTZsv+53LF+iUXA8Jopr6t/VDCKdh10wJUCYvv1JN2gDo6sQUaI5WGv33iVOP
         4XAgZ0Es+dZHx0o1f04Xx+ke1M3vynMM4bfAE8m6MRrxNM0N9TBggpZIjec51cdVtmZ3
         cgog==
X-Gm-Message-State: APjAAAWyU8J6Trm95x/VxbNGb6AtLOkNwn26Sd75RkRrQXEr4IJ8Avqr
        dtrj/tkDw2IJ3qrBt+iCWB/mJXnK
X-Google-Smtp-Source: APXvYqzuY5c7j1FWtZgyV/Mhb3skF6j1MMcG0YGVNhnHqaxY3I9hLiplwIoygnbdRFEUITsUUSwu0Q==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr8173083wme.155.1574324281945;
        Thu, 21 Nov 2019 00:18:01 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.gmail.com with ESMTPSA id w13sm2323679wrm.8.2019.11.21.00.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:18:01 -0800 (PST)
Subject: Re: ag/sequencer-todo-updates , was Re: What's cooking in git.git
 (Nov 2019, #03; Tue, 19)
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
References: <3e616116-2f6f-acff-91b3-4aefc7e62653@gmail.com>
 <20191119204146.168001-1-jonathantanmy@google.com>
 <xmqqv9rfckq0.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <6489e9f6-2d9f-33fe-cc44-fff80732c138@gmail.com>
Date:   Thu, 21 Nov 2019 09:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9rfckq0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan & Junio,

Le 20/11/2019 à 04:03, Junio C Hamano a écrit :
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>>>> * ag/sequencer-todo-updates (2019-10-28) 6 commits
>>>>  - SQUASH??? tentative leakfix
>>>>  - sequencer: directly call pick_commits() from complete_action()
>>>>  - rebase: fill `squash_onto' in get_replay_opts()
>>>>  - sequencer: move the code writing total_nr on the disk to a new function
>>>>  - sequencer: update `done_nr' when skipping commands in a todo list
>>>>  - sequencer: update `total_nr' when adding an item to a todo list
>>>>
>>>>  Reduce unnecessary reading of state variables back from the disk
>>>>  during sequener operation.
>>>>
>>>>  Is the leakfix patch at the tip the only thing that needs to
>>>>  prepare the topic ready for 'next'?
>>>>
>>>
>>> Yes, it is.
>>
>> I took a look at this. Some comments:

Thank you for the feedback.

> 
> I took a look at your comments and re-read the patches and I do
> agree with many of your points.
> 
> Let me not merge this round to 'next' and wait for a reroll.
> 
> Thanks for stopping me.
> 

I’ll send a reroll in the next few days.

Cheers,
Alban

