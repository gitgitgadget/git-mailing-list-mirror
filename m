Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D1C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36302073B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2BlBcP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLJO0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:26:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42671 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJO0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 09:26:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so2902882qtq.9
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3CzKzMxyhoeTtwtqj+I1x1M/sgiI5aFasOuxpTD3zik=;
        b=q2BlBcP5Q2VQvTVKiQtoDVIpL14n7A/+AVOxZvqC1dttWGA/1oNKhv6ow3mF+PDoms
         KZoeBRxIwhoT2BgyXEzVjwIMpqa+TsKeuKkzE789COO6I6L8gC+O6kJwCvhLgeVEaMJj
         OrafrQeiMdou22l++Ar95GjLyOuoz43On1k9609q9PIg50a5yS7zU3/2jU7gRQl3Yum3
         k7DtMTVr1E7BJtNK77N9JL/tTEj0Sd4wRptmypoJN6PlQQ//EI++JpaLGrBCaCkH9hzT
         ak1XG2kFKle+gMCu1Cy3kN7qHDBwxBjYpA3uiPNWPXo+RSVY8lwUoeTFw7D+m2XRTnJR
         5C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3CzKzMxyhoeTtwtqj+I1x1M/sgiI5aFasOuxpTD3zik=;
        b=dherVJInQJeQoVzVuu1NVHOUkIBzeLcRfZjTJ8UZKgXVAx2endHXJB0HyFR8eeLkWZ
         3jk/tmOiOP7u3Kv3a7Fk9bbHD96SQ1CaYRBuVz2gVSXffHa6KVw0g8WHpgxpcNGrmo02
         TbHTacOQxxS3eppeR20tf7lTUHYPYl6NcChkf8w5zBjoStTp/YECbCDflvLrNASEeZuJ
         iP8wf0KUYrw7EQGH4KjgDqCKbWXNnN3kIeEd32VnpPXoKu8c0x77x8DVTdhI3mZFWA4q
         WC6jvgxBX2Ztq+fG9SCD15gbw6ogWPp0gJQzSySvO2F9ocp7fnZzDQ14GljnGH4dtBTD
         4X/g==
X-Gm-Message-State: APjAAAVW0ufhHyZWs431uMQmIvHAFoiBpF2XXBstrLOAsxDIIIfn6Eqb
        lZUhAMgrGHat7dfSb8PD28KhqWjJPSs=
X-Google-Smtp-Source: APXvYqze4GXhFuhhVShoqgxrtl+AaR+z/TBMEsu4AdydKRztAknV5xeK90DW400waSoBSzhmVApPAw==
X-Received: by 2002:ac8:6b59:: with SMTP id x25mr5657335qts.299.1575987984257;
        Tue, 10 Dec 2019 06:26:24 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id z12sm935227qki.64.2019.12.10.06.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 06:26:23 -0800 (PST)
Subject: Re: [PATCH 1/3] git-p4: [usability] yes/no prompts should sanitize
 user text
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
 <e721cdaa008263b896c1d162e411c4e7a04c5710.1575901009.git.gitgitgadget@gmail.com>
 <xmqqimmptazs.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <179dd921-d9d0-d26d-33e9-3664bf97fcc2@gmail.com>
Date:   Tue, 10 Dec 2019 09:26:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqimmptazs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/9/2019 5:00 PM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> When prompting the user interactively for direction, the tests are
>> not forgiving of user input format.
>>
>> For example, the first query asks for a yes/no response. If the user
>> enters the full word "yes" or "no" or enters a capital "Y" the test
>> will fail.
>>
>> Create a new function, prompt(prompt_text, choices) where
>>    * promt_text is the text prompt for the user
>>    * is a list of lower-case, single letter choices.
>> This new function must  prompt the user for input and sanitize it by
>> converting the response to a lower case string, trimming leading and
>> trailing spaces, and checking if the first character is in the list
>> of choices. If it is, return the first letter.
>>
>> Change the current references to raw_input() to use this new function.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> ---
>>
>> +def prompt(prompt_text, choices = []):
>> +    """ Prompt the user to choose one of the choices
>> +    """
>> +    while True:
>> +        response = raw_input(prompt_text).strip().lower()
>> +        if len(response) == 0:
>> +            continue
>> +        response = response[0]
>> +        if response in choices:
>> +            return response
> I think this is a strict improvement compared to the original, but
> the new loop makes me wonder if we need to worry more about getting
> EOF while calling raw_input() here.  I am assuming that we would get
> EOFError either way so this is no worse/better than the status quo,
> and we can keep it outside the topic (even though it may be a good
> candidate for a low-hanging fruit for newbies).
That is a good catch.  What should we expect the default behavior
to be in these two questions if the EOFError occurs?  I would think
that we should extend this to an abort of the process?
> response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])
> response = prompt("[s]kip this commit but apply the rest, or [q]uit? ", ["s", "q"])

Should a quit be added to the first prompt and have those be the 
defaults on EOFError?

