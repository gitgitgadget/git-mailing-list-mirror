Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765EC3F68F
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EB520880
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZi1Flmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgAKOoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:44:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgAKOoR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 09:44:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so4930641wmj.4
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TMi0FXzDROIS+t0AYMM61Wh6XDZdIOLc9/RrjT7Xx9U=;
        b=FZi1FlmrKZRSnwRYfJdPHOnQXEwtFDdlsoJ2R6EloPAUXtRBNhzqiO+trHWQ5tsnk2
         6rlyfYizxSaJsLeT2pOr22AWcZwzQQXOZprkmThESjrWsw3xJGguzpjmZgMZcM5zfy8s
         UXhI0jiSk63ylvpHIyZXCNuvKkJ3RsdIsajNq/CPL7xfv1jMBXCU9P/RRuCJx6z62O8w
         UZ74gFQGR6No+2EKQYsfgIL6F/z10BXRWtip1Cb2bJq7TrKtu4TqxTlxXiZGFphZRRDM
         3ERjHiLPKL9fFWV1RKXgYR2BnBmItXeIrMuFQpmnD0ycx0B0yCEQftXNNbjGwlL+Xcmy
         lwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TMi0FXzDROIS+t0AYMM61Wh6XDZdIOLc9/RrjT7Xx9U=;
        b=f1oH+gS3UeY6bzsR7jESh4tawzgYjryIkhwAXvb5xwB1sE6/F48MygUGcCBXKWx8mE
         AmGHkm/XdpsJrtPvKh5t2mJqmSdPthTxHsJn6YgEUZxSp/BxGzEgFOKnii1T60Sb0h8j
         6imtQfs3AtHoob92GqIiYbec70NmZ9Zw2D60SBC7raEY38GQtY3yvHTFDgII5FRv6UPQ
         iifx9ARBfxZLFaZTJFt8JIBwa4ufysfiZBNrYXM3JjWVbvoW3UGbfbcop6GBx6nJ+Do4
         nnCkw72bjCmcf9BrKr3KjZTwYyPOWglz/KUfPwnLUu7TazYKRPLg4j4tB8nGpBK7Zdrj
         2QnQ==
X-Gm-Message-State: APjAAAXstm8oguEDl7v4gl41qbIbicmsgR/W4NV3sMuk9SnhLU0pKcob
        n3p5QsHNTEmjijkTNAROJFg=
X-Google-Smtp-Source: APXvYqyLZ9vQPBsvsowPF/9xljSjhPyeAoOikIvdI110/zStHY9+sd+6IJykWhws5VVOiS6yYBwBMA==
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr10107770wmm.132.1578753856400;
        Sat, 11 Jan 2020 06:44:16 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id n3sm6547865wmc.27.2020.01.11.06.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 06:44:14 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with
 `rebase --edit-todo'
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <20191202234759.26201-3-alban.gruin@gmail.com>
 <xmqqk17b5263.fsf@gitster-ct.c.googlers.com>
 <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>
 <0bf602bb-eff0-12f1-fa6c-c670a12f2cee@gmail.com>
 <79ad2e01-2fc3-cd52-7879-5a81370628ef@gmail.com>
 <85e3d40a-9829-0f50-8d91-7e8e8fa319f1@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1e72a306-3421-f4e7-4330-280f2a3fc821@gmail.com>
Date:   Sat, 11 Jan 2020 14:44:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <85e3d40a-9829-0f50-8d91-7e8e8fa319f1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 10/01/2020 21:31, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 10/01/2020 à 18:13, Phillip Wood a écrit :
>> Hi Alban
>>
>> On 09/01/2020 21:13, Alban Gruin wrote:
>>> Hi Phillip,
>>> [...]
>>>
>>> In which case, if the check did not pass at the previous edit, the new
>>> todo list should be compared to the backup.  As sequencer_continue()
>>> already does this, extract this to its own function in
>>> rebase-interactive.c.  To keep track of this, a file is created on the
>>> disk (as you suggested in your other email.)  At the next edit, if this
>>> file exists and no errors were found, it is deleted.  The backup is only
>>> created if there is no errors in `todo_list' and in `new_todo'.
>>>
>>> This would guarantee that there is no errors in the backup, and that the
>>> edited list is always compared to a list exempt of errors.
>>>
>>> This approach also has the benefit to detect if a commit part of a
>>> badcmd was dropped.
>>>
>>> After some tweaks (ie. `expect' now lists 2 commits instead of one),
>>> this passes the test with the change you suggested, and the one you sent
>>> in your other email.
>>
>> That sounds good. I'm not sure how it passes the test in my other email
>> though, if sequencer_continue() compares the todo list to the backup
>> wont it still fail when continuing after conflicts as the backup is out
>> of date?
>>
> 
> I changed sequencer_continue() to check the todo list only if the file
> indicating an error exists.

That makes sense

> I still have to rewrite the commit message, then I’ll re-send this series.

Excellent, I look forward to reading them

Best Wishes

Phillip

> Cheers,
> Alban
> 
>> Best Wishes
>>
>> Phillip
>>
