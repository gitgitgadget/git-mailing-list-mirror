Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C510C433E0
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624A6619FC
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCZPh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhCZPg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:36:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5AC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:36:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g20so5635063qkk.1
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mDS9ghpEW1f/4w66qEMni/xJOcM1KHWYLHsSp4DjMSY=;
        b=Y6H0mQ+1OCRmZQelMn/D5QAbZ5gVLQDj4cYKjobdJ69DqrLrATtiNzSFYGJy4jOQ1r
         BYkKB0TuEPYsV4cjh/IAQTuSlDIG5hCPAboNxFXNbPemFs1A7NGABlp2qj/EpndRQ4xz
         fx4U3VsIfn8RtmkhUg01nMGifkYhWdpAhUTTDg4PKgfZZbO1RuukJUr1eakB9/V6Hqae
         +6RR/mYOvA5iB6Z9cTj4Xp3NDXcr19cLnLiNID7mJsyzyLOIP2tIy1Ji0bQZPBGrDgWE
         S5/cbugU8IglgC/6D8QL4QZqu2eZmjdL5I2EMCBlIVcGWv26bzcWATXPcrfw0t9F8FmS
         Vp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mDS9ghpEW1f/4w66qEMni/xJOcM1KHWYLHsSp4DjMSY=;
        b=BZPQVTp5vGz/8O7vaUxxjSb6xVpFVGuWZKCqD/v8KQzYjSNRiv20tNmaBqzP8cKGzZ
         ck5OTqmhqdt1UjpcjkCWgRe2UIcMFNNwZwx7VH8+n4fH9wDA15dAKQtmksgF+4cGWuQq
         Y+85b/stymWIpwZzfgkToDhos9YfVIR+xi+szAkQZOTNFjaNVH3gHprfN81EeQtimVKL
         GWR63c6QAjpOrUQ6uFgY4UKHssYLImMZ5SQ6RAxiVO35Sf7w+FlsQD8NvdmDKdPZraYe
         uzAwFgLlv9Y+NeKVIjTdyf3HlLNaxNkblEXOyq/KBrogmwB32MHrwG1IfIyGKszcC3oz
         uGJA==
X-Gm-Message-State: AOAM532Lxb1vQ8T4Wq2OhYSoP212wXxQ9eQHmtQxY5Pi0kcNW4bK0ZOc
        GgCi55JMAVLGnvAoFFE5aYF8Wpyum34=
X-Google-Smtp-Source: ABdhPJwlHkTDAXAbNm2qpvRkoqnbhGfqvHEmxJUDqy53+JNm04lQTEzkz2hCo0uY46OYE81xdwbjMQ==
X-Received: by 2002:a37:a08e:: with SMTP id j136mr13609307qke.266.1616773018104;
        Fri, 26 Mar 2021 08:36:58 -0700 (PDT)
Received: from mbp.home (dynamic-177-53-82-16.telecominternet.net.br. [177.53.82.16])
        by smtp.gmail.com with ESMTPSA id b198sm6952187qkg.10.2021.03.26.08.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:36:57 -0700 (PDT)
Sender: Renato Botelho <garga.bsd@gmail.com>
Subject: Re: --no-edit not respected after conflict
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
 <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net>
 <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
 <CABPp-BGZebutsk5c4kf9gAuu0zgSEptxRmbEBFFwNPE03D4R1g@mail.gmail.com>
 <CABPp-BEGEcws69sg6Z2=B1nihFG227mAsSx=boU3uSx2xDUEjg@mail.gmail.com>
 <xmqqzgytz6h4.fsf@gitster.g>
 <CABPp-BEmKfZUHjRECWy96Y2BrhqxQPedYC4_WvXaTXShE=B5HA@mail.gmail.com>
From:   Renato Botelho <garga@FreeBSD.org>
Organization: FreeBSD
Message-ID: <8818df56-027a-a113-ab02-b91cf18c710e@FreeBSD.org>
Date:   Fri, 26 Mar 2021 12:36:54 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEmKfZUHjRECWy96Y2BrhqxQPedYC4_WvXaTXShE=B5HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/03/21 04:19, Elijah Newren wrote:
> On Tue, Mar 23, 2021 at 6:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> === Current behavior ===
>>>                     Non-conflict commits    Right after Conflict
>>> revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>>> cherry-pick        No edit                 See above
>>> Specify --edit     Edit (ignore isatty(0)) See above
>>> Specify --no-edit  (*)                     See above
>>>
>>> (*) Before stopping for conflicts, No edit is the behavior.  After
>>>      stopping for conflicts, the --no-edit flag is not saved so see the
>>>      first two rows.
>>>
>>> === Expected behavior ===
>>>
>>>                     Non-conflict commits    Right after Conflict
>>> revert             Edit iff isatty(0)      Edit (regardless of isatty(0)?)
>>> cherry-pick        No edit                 Edit (regardless of isatty(0)?)
>>> Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>>> Specify --no-edit  No edit                 No edit
>>>
>>> The thing I'm unsure on is the !isatty(0) handling for revert &
>>> cherry-pick right after a conflict when neither --edit nor --no-edit
>>> are specified.
>>
>> I read the intention behind existing "edit if isatty" as "this is an
>> operation the human reader deserves a chance to explain what was
>> done and why by default".  For example, I read the first entry in
>> your table as: Even if there is no conflict, there should be a
>> convincing explanation when you revert.  On the other hand, if you
>> are cherry-picking without any conflict, the intention should be
>> clear enough in the original commit log message, which ought to be
>> written why applying that change is a good idea, so it would make
>> sense not to invoke editor in that case.
>>
>> If an operation deserves a chance to be explained even in a cleanly
>> auto resolved case, it does deserve the chance even more if hand
>> resolution was required---in addition to the original "what and
>> why", the resolution of the conflict is an additional reason why the
>> human should be given a chance to explain.
>>
>> But if it is an automated process, there is no reason to fail the
>> operation merely because the process is run unattended.  So my
>> recommendation for "regardless of isatty" part is "do not force
>> editing".  The same is true for a human user who declines the chance
>> to explain him/herself with an explicit "--no-edit".
> 
> Thanks.
> 
> Renato: potential fix over here:
> https://lore.kernel.org/git/pull.988.git.git.1616742969145.gitgitgadget@gmail.com/T/#u.
> Could you give it a try?

It worked! Thanks!

-- 
Renato Botelho
